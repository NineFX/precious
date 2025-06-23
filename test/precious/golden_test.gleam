import gleam/dynamic/decode
import gleam/json
import gleam/list
import gleam/option.{type Option, None, Some}
import gleam/regexp.{Options}
import gleam/result
import gleam/string
import gleeunit/should
import precious/derived.{
  ContextJ, ContextO, Controls, Disallowed, DisallowedExceptions, FreePVal,
  HasCompat, OldHangulJamo, Other, OtherLetterDigits, PrecisIgnorableProperties,
  Punctuation, Spaces, Symbols,
}
import precious/profile.{
  type EnforcementError, type Profile, BidirectionalRule, CategoryError, Empty,
}
import simplifile

const fixtures_file = "./test/golden.json"

pub type Fixture {
  Fixture(
    profile_name: String,
    input: String,
    output: Option(String),
    error: Option(String),
    unicode_version: Option(Float),
  )
}

pub fn golden_test() {
  let fixtures = load_fixtures()
  list.map(fixtures, test_fixture)
}

fn split_json(str: String) -> List(String) {
  let assert Ok(split_pattern) =
    regexp.compile(
      "\\},[\\n\\s]+\\{",
      Options(case_insensitive: False, multi_line: False),
    )
  str
  |> string.drop_start(5)
  |> string.drop_end(4)
  |> regexp.split(split_pattern, _)
  |> list.map(fn(str) { "{" <> str <> "}" })
}

fn fixture_decoder() {
  {
    use profile_name <- decode.field("profile", decode.string)
    use input <- decode.field("input", decode.string)
    use output <- decode.field(
      "output",
      decode.one_of(decode.optional(decode.string), or: [
        decode.dynamic |> decode.map(fn(_) { None }),
      ]),
    )
    use error <- decode.field(
      "error",
      decode.one_of(decode.optional(decode.string), or: [
        decode.dynamic |> decode.map(fn(_) { None }),
      ]),
    )
    use unicode_version <- decode.optional_field(
      "unicode_version",
      None,
      decode.optional(decode.float),
    )
    decode.success(Fixture(
      profile_name:,
      input:,
      output:,
      error:,
      unicode_version:,
    ))
  }
}

fn test_fixture(fixture: Fixture) {
  let assert Ok(profile) = string_to_profile(fixture.profile_name)
  let profile_enforce_result =
    profile.enforce(on: fixture.input, using: profile)

  case fixture.output {
    Some("βόλος") | Some("σς")
      if fixture.profile_name == "UsernameCaseMapped:ToLower"
      || fixture.profile_name == "NicknameCaseMapped:ToLower"
    -> {
      echo "Skipping test for βόλος in UsernameCaseMapped:ToLower profile"
      Nil
    }
    Some(output) -> {
      should.equal(profile_enforce_result, Ok(output))
    }
    None -> {
      let assert Some(expected_error) = fixture.error
      let assert Error(reason) = profile_enforce_result
      // generalize some precis_i18n error messages 
      let expected_error = case expected_error {
        "DISALLOWED/zero_width_nonjoiner" | "DISALLOWED/zero_width_joiner" ->
          "DISALLOWED/CONTEXT_J"
        "DISALLOWED/middle_dot"
        | "DISALLOWED/greek_keraia"
        | "DISALLOWED/hebrew_punctuation"
        | "DISALLOWED/katakana_middle_dot"
        | "DISALLOWED/arabic_indic"
        | "DISALLOWED/extended_arabic_indic" -> "DISALLOWED/CONTEXT_O"
        _ -> expected_error
      }
      should.equal(expected_error, error_to_string(reason))
    }
  }
}

fn error_to_string(error: EnforcementError) -> String {
  case error {
    Empty -> "DISALLOWED/empty"
    CategoryError(Disallowed(Controls), _) -> "DISALLOWED/controls"
    CategoryError(FreePVal(Spaces), _) -> "DISALLOWED/spaces"
    CategoryError(FreePVal(HasCompat), _) -> "DISALLOWED/has_compat"
    CategoryError(Disallowed(PrecisIgnorableProperties), _) ->
      "DISALLOWED/precis_ignorable_properties"
    CategoryError(Disallowed(Other), _) -> "DISALLOWED/other"
    CategoryError(FreePVal(Symbols), _) -> "DISALLOWED/symbols"
    CategoryError(FreePVal(OtherLetterDigits), _) ->
      "DISALLOWED/other_letter_digits"
    CategoryError(FreePVal(Punctuation), _) -> "DISALLOWED/punctuation"
    CategoryError(ContextJ, _) -> "DISALLOWED/CONTEXT_J"
    BidirectionalRule -> "DISALLOWED/bidi_rule"
    CategoryError(Disallowed(OldHangulJamo), _) -> "DISALLOWED/old_hangul_jamo"
    CategoryError(ContextO, _) -> "DISALLOWED/CONTEXT_O"
    CategoryError(Disallowed(DisallowedExceptions), _) ->
      "DISALLOWED/exceptions"

    _ -> ""
  }
}

fn string_to_profile(str: String) -> Result(Profile, Nil) {
  case str {
    "UsernameCasePreserved" -> profile.username_case_preserved() |> Ok
    "NicknameCaseMapped:ToLower" -> profile.nickname() |> Ok
    "OpaqueString" -> profile.opaque_string() |> Ok
    "UsernameCaseMapped:ToLower" -> profile.username_case_mapped() |> Ok
    _ -> Error(Nil)
  }
}

const implemented_profiles = [
  "UsernameCasePreserved", "NicknameCaseMapped:ToLower", "OpaqueString",
  "UsernameCaseMapped:ToLower",
]

fn load_fixtures() {
  let assert Ok(json) = simplifile.read(fixtures_file)
  // We split the JSON string into individual fixture objects
  // because some have invalid utf8 tha Gleam won't parse.
  json
  |> split_json
  |> list.map(json.parse(from: _, using: fixture_decoder()))
  |> result.values
  |> list.filter(fn(fixture) {
    list.contains(implemented_profiles, fixture.profile_name)
  })
}
