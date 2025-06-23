import gleam/bit_array
import gleam/bool
import gleam/function
import gleam/list
import gleam/result
import gleam/string
import iv.{type Array}
import precious/bidi
import precious/context
import precious/derived.{
  type Category, Ascii7, ContextJ, ContextO, FreePVal, HasCompat, LetterDigits,
  OtherLetterDigits, PValid, PValidExceptions, Punctuation, Spaces, Symbols,
}
import precious/unicode

pub type EnforcementError {
  CategoryError(category: Category, index: Int)
  BidirectionalRule
  Empty
  NotIdempotent
}

pub type Profile {
  Profile(
    name: String,
    allowed: List(Category),
    width_map: fn(String) -> String,
    additional_mapping: fn(String) -> String,
    case_map: fn(String) -> String,
    normalization: fn(String) -> String,
    directionality: fn(Array(Int)) -> Bool,
    idempotence_check: fn(String, Profile) ->
      Result(#(String, Array(Int)), EnforcementError),
  )
}

pub const identifer_class_allowed = [
  PValid(Ascii7),
  PValid(LetterDigits),
  PValid(PValidExceptions),
]

pub const freeform_class_allowed = [
  PValid(Ascii7),
  PValid(LetterDigits),
  PValid(PValidExceptions),
  FreePVal(HasCompat),
  FreePVal(OtherLetterDigits),
  FreePVal(Spaces),
  FreePVal(Symbols),
  FreePVal(Punctuation),
]

pub fn username_case_mapped() {
  Profile(
    name: "UsernameCaseMapped",
    width_map: unicode.width_map,
    additional_mapping: function.identity,
    case_map: string.lowercase,
    normalization: unicode.nfc,
    directionality: bidi_rule_if_contains_rtl,
    allowed: identifer_class_allowed,
    idempotence_check: standard_idempotence_check,
  )
}

pub fn username_case_preserved() {
  Profile(
    name: "UsernameCasePreserved",
    width_map: unicode.width_map,
    additional_mapping: function.identity,
    case_map: function.identity,
    normalization: unicode.nfc,
    directionality: bidi_rule_if_contains_rtl,
    allowed: identifer_class_allowed,
    idempotence_check: standard_idempotence_check,
  )
}

pub fn opaque_string() {
  Profile(
    name: "OpaqueString",
    width_map: function.identity,
    additional_mapping: unicode.map_nonascii_space_to_ascii,
    case_map: function.identity,
    normalization: unicode.nfc,
    directionality: fn(_) { True },
    allowed: freeform_class_allowed,
    idempotence_check: standard_idempotence_check,
  )
}

pub fn nickname() {
  Profile(
    name: "Nickname",
    width_map: function.identity,
    additional_mapping: nickname_additional_mapping,
    case_map: string.lowercase,
    normalization: unicode.nfkc,
    directionality: fn(_) { True },
    allowed: freeform_class_allowed,
    idempotence_check: nickname_idempotence_check,
  )
}

fn nickname_additional_mapping(str: String) -> String {
  str
  |> unicode.map_nonascii_space_to_ascii
  |> trim_spaces
}

fn trim_spaces(str: String) -> String {
  do_trim_spaces(<<str:utf8>>, True, False, <<>>)
}

fn do_trim_spaces(
  str: BitArray,
  in_leading_spaces: Bool,
  holding_a_space: Bool,
  acc: BitArray,
) -> String {
  case str, in_leading_spaces, holding_a_space {
    <<" ":utf8, rest:bits>>, True, _ -> {
      do_trim_spaces(rest, True, False, acc)
    }
    <<" ":utf8, rest:bits>>, False, _ -> {
      do_trim_spaces(rest, False, True, acc)
    }
    <<cp:utf8_codepoint, rest:bits>>, _, True ->
      do_trim_spaces(rest, False, False, <<
        acc:bits,
        " ":utf8,
        cp:utf8_codepoint,
      >>)
    <<cp:utf8_codepoint, rest:bits>>, _, False ->
      do_trim_spaces(rest, False, False, <<acc:bits, cp:utf8_codepoint>>)
    <<>>, _, _ -> {
      let assert Ok(result) = bit_array.to_string(acc)
      result
    }
    _, _, _ -> panic as "Unexpected case in do_trim_spaces"
  }
}

pub fn bidi_rule_if_contains_rtl(codepoints: Array(Int)) -> Bool {
  use <- bool.guard(when: !bidi.has_right_to_left(codepoints), return: True)
  bidi.bidi_rule(codepoints)
}

pub fn enforce(
  on str: String,
  using profile: Profile,
) -> Result(String, EnforcementError) {
  use #(str, _) <- result.try(apply_five_rules(on: str, using: profile))
  use #(_, codepoints) <- result.try(profile.idempotence_check(str, profile))
  use <- bool.guard(when: iv.is_empty(codepoints), return: Error(Empty))
  use Nil <- result.try(enforce_class(on: codepoints, allowing: profile.allowed))
  codepoints |> codepoints_to_string |> Ok
}

fn apply_five_rules(
  on str: String,
  using profile: Profile,
) -> Result(#(String, Array(Int)), EnforcementError) {
  let width_mapped = profile.width_map(str)
  let additional_mapped = profile.additional_mapping(width_mapped)
  let case_mapped = profile.case_map(additional_mapped)
  let normalized = profile.normalization(case_mapped)
  let codepoints = string_to_codepoints(normalized)
  case profile.directionality(codepoints) {
    True -> {
      Ok(#(normalized, codepoints))
    }
    False -> Error(BidirectionalRule)
  }
}

fn string_to_codepoints(str: String) -> Array(Int) {
  str
  |> string.to_utf_codepoints
  |> list.map(string.utf_codepoint_to_int)
  |> iv.from_list
}

fn nickname_idempotence_check(
  on str: String,
  using profile: Profile,
) -> Result(#(String, Array(Int)), EnforcementError) {
  apply_five_rules(str, profile)
}

fn standard_idempotence_check(
  on str: String,
  using profile: Profile,
) -> Result(#(String, Array(Int)), EnforcementError) {
  case apply_five_rules(str, profile) {
    Ok(#(new_str, codepoints)) if new_str == str -> Ok(#(new_str, codepoints))
    _ -> Error(NotIdempotent)
  }
}

pub fn enforce_class(
  on codepoints: Array(Int),
  allowing categories: List(derived.Category),
) -> Result(Nil, EnforcementError) {
  enforce_class_(0, iv.length(codepoints), codepoints, categories)
}

fn enforce_class_(
  index: Int,
  length: Int,
  codepoints: Array(Int),
  allowed: List(Category),
) -> Result(Nil, EnforcementError) {
  case index == length {
    True -> Ok(Nil)
    False -> {
      let assert Ok(codepoint) = iv.get(from: codepoints, at: index)
      let category = derived.derived_property(codepoint)
      case category, list.contains(allowed, category) {
        ContextJ, False | ContextO, False ->
          case context.context_rule_error(codepoints, index) {
            True -> enforce_class_(index + 1, length, codepoints, allowed)
            False -> Error(CategoryError(category, index))
          }
        _, True -> enforce_class_(index + 1, length, codepoints, allowed)
        _, False -> Error(CategoryError(category, index))
      }
    }
  }
}

fn codepoints_to_string(codepoints: Array(Int)) -> String {
  codepoints
  |> iv.to_list
  |> list.map(fn(cp_int) {
    let assert Ok(cp) = string.utf_codepoint(cp_int)
    cp
  })
  |> string.from_utf_codepoints
}
