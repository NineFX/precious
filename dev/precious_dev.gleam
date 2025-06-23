import gleam/bool
import gleam/list
import gleam/option.{Some}
import gleam/regexp.{type Match, Options}
import gleam/string
import gleam/string_tree.{type StringTree}
import simplifile

const unicode_path = "./dev/unicode_spec/Unicode 16.0.0/"

const unicode_full_base_module = "./dev/module_templates/unicode_full_base.gleam.txt"

const unicode_base_module = "./dev/module_templates/unicode_base.gleam.txt"

const unicode_module = "./src/precious/unicode.gleam"

const unicode_full_module = "./test/unicode_full.gleam"

const derived_module = "./src/precious/derived.gleam"

const derived_categories_table = "./dev/precis_i18n/derived-props-16.0.txt"

// const unicode_data_table = unicode_path <> "UnicodeData.txt"

// is_categories parse unicode spec files and generates a function
// to see if a codepoint _is_ a member of that range.
// for example:
// '''gleam
//   pub fn is_uncategorized(cp: Int) -> Bool { todo }
// '''
const unicode_light_categories = [
  #("left_to_right_first", "DerivedBidiClass.txt", "L"),
  #("left_to_right_last", "DerivedBidiClass.txt", "(L|EN)"),
  #("right_to_left_first", "DerivedBidiClass.txt", "(R|AL)"),
  #(
    "right_to_left_allowed",
    "DerivedBidiClass.txt",
    "(R|AL|AN|EN|ES|CS|ET|ON|BN|NSM)",
  ),
  #("right_to_left_last", "DerivedBidiClass.txt", "(R|AL|EN|AN)"),
  #("non_spacing_mark", "DerivedBidiClass.txt", "NSM"),
  #("english_number", "DerivedBidiClass.txt", "EN"),
  #("arabic_number", "DerivedBidiClass.txt", "AN"),
  #(
    "left_to_right_allowed",
    "DerivedBidiClass.txt",
    "(L|EN|ES|CS|ET|ON|BN|NSM)",
  ),
  #("right_to_left_any", "DerivedBidiClass.txt", "(R|AL|AN)"),
  #("combining_virama", "DerivedCombiningClass.txt", "9"),
  #("greek_script", "Scripts.txt", "Greek"),
  #("hebrew_script", "Scripts.txt", "Hebrew"),
  #("dual_joining", "DerivedJoiningType.txt", "D"),
  #("right_joining", "DerivedJoiningType.txt", "R"),
  #("left_joining", "DerivedJoiningType.txt", "L"),
  #("transparent_joining", "DerivedJoiningType.txt", "T"),
  #("hiragana_katakana_han_script", "Scripts.txt", "(Hiragana|Katakana|Han)"),
  //#("case_ignorable", "DerivedCoreProperties.txt", "Case_Ignorable"),
//#("combining_class_0_or_230", "DerivedCombiningClass.txt", "(0|230)"),
//#("cased", "DerivedCoreProperties.txt", "Cased"),
]

const unicode_full_categories = [
  #("uncategorized", "DerivedGeneralCategory.txt", "Cn"),
  #("join_type_dual_joining", "DerivedJoiningType.txt", "D"),
  #("join_type_right_joining", "DerivedJoiningType.txt", "R"),
  #(
    "default_ignorable",
    "DerivedCoreProperties.txt",
    "Default_Ignorable_Code_Point",
  ),
  #("old_hangul_jamo", "HangulSyllableType.txt", "(L|V|T)"),
  #("letter_digit", "DerivedGeneralCategory.txt", "(Ll|Lu|Lo|Nd|Lm|Mn|Mc)"),
  #("other_letter_digit", "DerivedGeneralCategory.txt", "(Lt|Nl|No|Me)"),
  #("punctuation", "DerivedGeneralCategory.txt", "(Pc|Pd|Ps|Pe|Pi|Pf|Po)"),
  #("symbol", "DerivedGeneralCategory.txt", "(Sm|Sc|Sk|So)"),
  #("space", "DerivedGeneralCategory.txt", "Zs"),
  #("unassigned", "DerivedGeneralCategory.txt", "Cn"),
  #("control", "DerivedGeneralCategory.txt", "Cc"),
  #("noncharacter", "PropList.txt", "Noncharacter_Code_Point"),
]

pub fn main() {
  let Nil = generate_derived(derived_categories_table)
  let unicode_all_categories =
    list.append(unicode_light_categories, unicode_full_categories)
  let assert Ok(Nil) =
    generate_unicode(
      unicode_full_base_module,
      unicode_full_module,
      unicode_all_categories,
    )
  let assert Ok(Nil) =
    generate_unicode(
      unicode_base_module,
      unicode_module,
      unicode_light_categories,
    )
}

fn generate_unicode(
  template: String,
  filename: String,
  categories: List(#(String, String, String)),
) -> Result(Nil, simplifile.FileError) {
  let _ = simplifile.delete(filename)
  let assert Ok(Nil) = simplifile.copy_file(at: template, to: filename)
  categories
  |> list.map(fn(category) {
    generate_in_category_function(category.0, category.1, category.2)
  })
  |> string.join("\n")
  //|> string.append("\n")
  //|> string.append(generate_simple_lowercase_function())
  |> simplifile.append(to: filename, contents: _)
}

fn generate_in_category_function(
  category_name: String,
  file: String,
  value: String,
) {
  let path = unicode_path <> file
  let assert Ok(file_contents) = simplifile.read(path)
  let pattern = "^([0-9A-F]+(\\.\\.[0-9A-F]+)?)\\s+;\\s" <> value <> "\\s"
  let assert Ok(regex) =
    regexp.compile(pattern, Options(case_insensitive: False, multi_line: True))
  let case_clauses =
    regex
    |> regexp.scan(file_contents)
    |> list.map(fn(match: Match) {
      case match.submatches {
        [Some(range), ..] -> unicode_range_to_guard(range) <> " -> True"
        _ -> panic as "no regex submatches"
      }
    })

  "pub fn in_"
  <> category_name
  <> "(codepoint: Int) -> Bool {\n"
  <> "  case codepoint {\n"
  <> string.join(case_clauses, with: "\n")
  <> "\n    _ -> False\n"
  <> "  }\n"
  <> "}\n"
}

fn unicode_range_to_guard(unicode_range: String) -> String {
  let split = string.split(unicode_range, on: "..")
  case split {
    [actual] -> "    cp if cp == 0x" <> actual
    [start, end] -> "    cp if cp >= 0x" <> start <> " && cp <= 0x" <> end
    _ -> panic as "a range list must have 1 or 2 elements"
  }
}

fn generate_derived(file: String) -> Nil {
  let assert Ok(file_contents) = simplifile.read(file)
  let lines =
    file_contents
    |> string.split(on: "\n")
    |> list.flat_map(string.split(_, on: "-"))
    |> list.flat_map(string.split(_, on: " "))
    |> list.flat_map(string.split(_, on: "/"))
    |> process_generate_derived_tokens()
  let _ = simplifile.delete(derived_module)
  let assert Ok(Nil) = simplifile.append(derived_module, "
    pub type Category {
      PValid(PValidReason)
      ContextO
      ContextJ
      Disallowed(DisallowedReason)
      Unassigned
      FreePVal(FreePValReason)
    }

    pub type PValidReason {
      Ascii7
      LetterDigits
      PValidExceptions
    }

    pub type DisallowedReason {
      PrecisIgnorableProperties
      Controls
      Other
      OldHangulJamo
      DisallowedExceptions
    }

    pub type FreePValReason {
      HasCompat
      OtherLetterDigits
      Spaces
      Symbols
      Punctuation
}

pub fn derived_property(codepoint: Int) -> Category {
   case codepoint {
" <> lines <> "    _ -> panic
  }
}")
  Nil
}

fn process_generate_derived_tokens(tokens: List(String)) -> String {
  process_generate_derived_tokens_(tokens, True, string_tree.new())
}

fn process_generate_derived_tokens_(
  tokens: List(String),
  first: Bool,
  acc: StringTree,
) -> String {
  case tokens {
    [start, end, category, reason, ..rest] -> {
      let new_acc =
        [
          "    cp if ",
          bool.guard(first, "cp >= 0x" <> start <> " && ", fn() { "" }),
          "cp <= 0x",
          end,
          " -> ",
          string_to_derived_category(category),
          string_to_reason(category, reason),
          "\n",
        ]
        |> string_tree.from_strings
        |> string_tree.append_tree(acc, _)
      process_generate_derived_tokens_(rest, False, new_acc)
    }
    [""] -> string_tree.to_string(acc)
    _ -> {
      panic as "should never happen"
    }
  }
}

fn string_to_reason(category: String, reason: String) -> String {
  case category, reason {
    "CONTEXTO", _ | "CONTEXTJ", _ | "UNASSIGNED", _ -> ""
    "DISALLOWED", "exceptions" -> "(DisallowedExceptions)"
    "PVALID", "exceptions" -> "(PValidExceptions)"

    _, _ -> {
      let reason_str =
        reason
        |> string.split("_")
        |> list.map(string.capitalise)
        |> string.join("")
      "(" <> reason_str <> ")"
    }
  }
}

fn string_to_derived_category(str: String) -> String {
  case str {
    "FREE_PVAL" -> "FreePVal"
    "PVALID" -> "PValid"
    "CONTEXTO" -> "ContextO"
    "CONTEXTJ" -> "ContextJ"
    "DISALLOWED" -> "Disallowed"
    "UNASSIGNED" -> "Unassigned"
    _ -> panic as "unknown derived category"
  }
}
// fn generate_simple_lowercase_function() -> String {
//   let assert Ok(unicode_data) = simplifile.read(unicode_data_table)
//   let pattern = "^([0-9A-Z]{4,6});(?:.*?;){12}([0-9A-Z]{4,6});"
//   let assert Ok(regex) =
//     regexp.compile(pattern, Options(case_insensitive: False, multi_line: True))
//   let result = regexp.scan(regex, unicode_data)
//   let case_clauses =
//     result
//     |> list.map(fn(match: Match) {
//       case match.submatches {
//         [Some(codepoint), Some(lowercase)] ->
//           "    0x" <> codepoint <> " -> Ok(0x" <> lowercase <> ")\n"
//         _ -> panic as "no regex submatches"
//       }
//     })
//     |> string.join(with: "")
//   "pub fn simple_lower_transform(codepoint: Int) -> Result(Int, Nil) {\n"
//   <> "  case codepoint {\n"
//   <> case_clauses
//   <> "    _ -> Error(Nil)\n"
//   <> "  }\n"
//   <> "}\n"
// }
