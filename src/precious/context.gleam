import gleam/bool
import iv.{type Array}
import precious/unicode

// Apply the PRECIS context rules to the codepoint at index.
pub fn context_rule_error(codepoints: Array(Int), index: Int) -> Bool {
  let assert Ok(cp) = iv.get(codepoints, index)
  let rule = case
    unicode.in_arabic_indic(cp),
    unicode.in_extended_arabic_indic(cp)
  {
    True, _ -> rule_arabic_indic
    False, True -> rule_extended_arabic_indic
    False, False -> rules(cp)
  }
  rule(codepoints, index)
}

fn rules(codepoint: Int) -> fn(Array(Int), Int) -> Bool {
  case codepoint {
    0x200c -> rule_zero_width_nonjoiner
    0x200d -> rule_zero_width_joiner
    0x00b7 -> rule_middle_dot
    0x0375 -> rule_greek_keraia
    0x05f3 | 0x05f4 -> rule_hebrew_punctuation
    0x30fb -> rule_katakana_middle_dot
    _ -> panic as "no rule for this codepoint"
  }
}

// Return true if context permits a ZERO WIDTH NON-JOINER (U+200C).
//     From https://tools.ietf.org/html/rfc5892#appendix-A.1:
//       "This may occur in a formally cursive script (such as Arabic) in a
//       context where it breaks a cursive connection as required for
//       orthographic rules, as in the Persian language, for example.  It
//       also may occur in Indic scripts in a consonant-conjunct context
//       (immediately following a virama), to control required display of
//       such conjuncts."
fn rule_zero_width_nonjoiner(cps: Array(Int), index: Int) -> Bool {
  case before(cps, index) {
    Ok(before_cp) ->
      case unicode.in_combining_virama(before_cp) {
        True -> True
        False -> valid_jointype(cps, index)
      }
    Error(Nil) -> False
  }
}

// Return true if context permits a ZERO WIDTH JOINER (U+200D).
//     From https://tools.ietf.org/html/rfc5892#appendix-A.2:
//       "This may occur in Indic scripts in a consonant-conjunct context
//       (immediately following a virama), to control required display of
//       such conjuncts."
fn rule_zero_width_joiner(cps: Array(Int), index: Int) -> Bool {
  case after(cps, index) {
    Ok(cp) -> unicode.in_combining_virama(cp)
    Error(Nil) -> False
  }
}

// Return true if context permits a MIDDLE DOT (U+00B7).
//     From https://tools.ietf.org/html/rfc5892#appendix-A.3:
//       "Between 'l' (U+006C) characters only, used to permit the Catalan
//       character ela geminada to be expressed."
fn rule_middle_dot(cps: Array(Int), index: Int) -> Bool {
  case before(cps, index), after(cps, index) {
    Ok(0x06C), Ok(0x06C) -> True
    _, _ -> False
  }
}

// Return true if context permits GREEK LOWER NUMERAL SIGN (U+0375).
//     From https://tools.ietf.org/html/rfc5892#appendix-A.4:
//       "The script of the following character MUST be Greek."
fn rule_greek_keraia(cps: Array(Int), index: Int) -> Bool {
  case after(cps, index) {
    Ok(cp) -> unicode.in_greek_script(cp)
    Error(Nil) -> False
  }
}

// Return true if context permits HEBREW PUNCTUATION GERESH or GERSHAYIM
//     (U+05F3, U+05F4).
//     From https://tools.ietf.org/html/rfc5892#appendix-A.5,
//          https://tools.ietf.org/html/rfc5892#appendix-A.6:
//       "The script of the preceding character MUST be Hebrew."
fn rule_hebrew_punctuation(cps: Array(Int), index: Int) -> Bool {
  case before(cps, index) {
    Ok(cp) -> unicode.in_hebrew_script(cp)
    Error(Nil) -> False
  }
}

// These rules ignore the offset argument; they test the entire string. A string
// only needs to be tested once, irrespective of the number of times the rule is
// triggered.

// Return true if context permits KATAKANA MIDDLE DOT (U+30FB).
//     From https://tools.ietf.org/html/rfc5892#appendix-A.7:
//       "Note that the Script of Katakana Middle Dot is not any of
//       "Hiragana", "Katakana", or "Han".  The effect of this rule is to
//       require at least one character in the label to be in one of those
//       scripts."
fn rule_katakana_middle_dot(cps: Array(Int), _index: Int) -> Bool {
  iv.any(in: cps, satisfying: unicode.in_hiragana_katakana_han_script)
}

// Return true if context permits ARABIC-INDIC DIGITS (U+0660..U+0669).
//     From https://tools.ietf.org/html/rfc5892#appendix-A.8:
//       "Can not be mixed with Extended Arabic-Indic Digits."
fn rule_arabic_indic(cps: Array(Int), _index: Int) -> Bool {
  !iv.any(in: cps, satisfying: unicode.in_extended_arabic_indic)
}

// Return true if context permits EXTENDED ARABIC-INDIC DIGITS
//     (U+06F0..U+06F9).
//     From https://tools.ietf.org/html/rfc5892#appendix-A.9:
//       "Can not be mixed with Arabic-Indic Digits."
fn rule_extended_arabic_indic(cps: Array(Int), _index: Int) -> Bool {
  !iv.any(in: cps, satisfying: unicode.in_arabic_indic)
}

fn after(cps: Array(Int), index: Int) -> Result(Int, Nil) {
  iv.get(cps, index + 1)
}

fn before(cps: Array(Int), index: Int) -> Result(Int, Nil) {
  iv.get(cps, index - 1)
}

type JoinType {
  Dual
  Right
  Left
  Transparent
  None
}

fn valid_jointype(codepoints: Array(Int), index: Int) -> Bool {
  let #(left_segment, rest) = iv.split(codepoints, index)
  let #(_, right_segment) = iv.split(rest, 1)
  let left_result = left_segment |> iv.reverse |> scan_join(Left)
  let right_result = right_segment |> scan_join(Right)
  left_result && right_result
}

// return self._scan_join(reversed(value[:offset]), "L") and self._scan_join(
//     value[offset + 1 :], "R"
// )}

fn scan_join(cps: Array(Int), expected_join_type: JoinType) -> Bool {
  case iv.first(cps), iv.rest(cps) {
    Ok(cp), Ok(rest) ->
      case join_type(cp) {
        jt if jt == expected_join_type -> True
        Dual -> True
        Transparent -> scan_join(rest, expected_join_type)
        _ -> False
      }
    _, _ -> False
  }
}

fn join_type(cp: Int) {
  use <- bool.guard(when: unicode.in_dual_joining(cp), return: Dual)
  use <- bool.guard(when: unicode.in_right_joining(cp), return: Right)
  use <- bool.guard(when: unicode.in_left_joining(cp), return: Left)
  use <- bool.guard(
    when: unicode.in_transparent_joining(cp),
    return: Transparent,
  )
  None
}
