import gleam/bool
import iv.{type Array}
import precious/unicode

// Implements the BiDi Rule. Returns `True` if the codepoints satisfy the
// BiDi rule.
//
// (Source: RFC 5893, Section 2)
// The following rule, consisting of six conditions, applies to labels
// in Bidi domain names.  The requirements that this rule satisfies are
// described in Section 3.  All of the conditions must be satisfied for
// the rule to be satisfied.
// 1. The first character must be a character with Bidi property L, R,
//    or AL.  If it has the R or AL property, it is an RTL label; if it
//    has the L property, it is an LTR label.
// 2. In an RTL label, only characters with the Bidi properties R, AL,
//    AN, EN, ES, CS, ET, ON, BN, or NSM are allowed.
// 3. In an RTL label, the end of the label must be a character with
//    Bidi property R, AL, EN, or AN, followed by zero or more
//    characters with Bidi property NSM.
// 4. In an RTL label, if an EN is present, no AN may be present, and
//    vice versa.
// 5. In an LTR label, only characters with the Bidi properties L, EN,
//    ES, CS, ET, ON, BN, or NSM are allowed.
// 6. In an LTR label, the end of the label must be a character with
//    Bidi property L or EN, followed by zero or more characters with
//    Bidi property NSM.
pub fn bidi_rule(codepoints: Array(Int)) -> Bool {
  case first_rest(codepoints) {
    Ok(#(first_cp, rest)) -> {
      use <- bool.guard(
        unicode.in_left_to_right_first(first_cp),
        bidi_rule_(
          rest,
          unicode.in_left_to_right_last,
          left_to_right_remaining_allowed,
        ),
      )
      use <- bool.guard(
        unicode.in_right_to_left_first(first_cp),
        bidi_rule_(
          rest,
          unicode.in_right_to_left_last,
          right_to_left_remaining_allowed,
        ),
      )
      False
    }
    // empty string is valid 
    Error(Nil) -> True
  }
}

fn bidi_rule_(
  codepoints: Array(Int),
  last: fn(Int) -> Bool,
  remaining_allowed: fn(Array(Int)) -> Bool,
) {
  let dropped_trailing_nonspacing_marks =
    codepoints
    |> iv.reverse()
    |> drop_while(satisfying: unicode.in_non_spacing_mark)
  case first_rest(dropped_trailing_nonspacing_marks) {
    Ok(#(last_cp, _rest)) -> {
      use <- bool.guard(when: !last(last_cp), return: False)
      remaining_allowed(dropped_trailing_nonspacing_marks)
    }
    Error(Nil) -> True
  }
}

fn right_to_left_remaining_allowed(codepoints: Array(Int)) -> Bool {
  right_to_left_remaining_allowed_(
    arabic_numeral_seen: False,
    english_numeral_seen: False,
    codepoints: codepoints,
  )
}

fn right_to_left_remaining_allowed_(
  arabic_numeral_seen ans: Bool,
  english_numeral_seen ens: Bool,
  codepoints cps: Array(Int),
) -> Bool {
  case first_rest(cps) {
    Ok(#(cp, rest)) -> {
      use <- bool.guard(
        when: !unicode.in_right_to_left_allowed(cp),
        return: False,
      )
      let arabic_numeral_seen = ans || unicode.in_arabic_number(cp)
      let english_numeral_seen = ens || unicode.in_english_number(cp)

      use <- bool.guard(
        when: arabic_numeral_seen && english_numeral_seen,
        return: False,
      )
      right_to_left_remaining_allowed_(
        arabic_numeral_seen:,
        english_numeral_seen:,
        codepoints: rest,
      )
    }
    Error(Nil) -> True
  }
}

fn left_to_right_remaining_allowed(codepoints: Array(Int)) -> Bool {
  iv.all(codepoints, unicode.in_left_to_right_allowed)
}

// Check if value contains any RTL characters.
pub fn has_right_to_left(codepoints: Array(Int)) -> Bool {
  iv.any(codepoints, unicode.in_right_to_left_any)
}

fn drop_while(
  in array: Array(a),
  satisfying predicate: fn(a) -> Bool,
) -> Array(a) {
  case iv.first(from: array) {
    Ok(first) ->
      case predicate(first) {
        True -> {
          let assert Ok(rest) = iv.rest(array)
          drop_while(in: rest, satisfying: predicate)
        }
        False -> array
      }
    Error(Nil) -> array
  }
}

fn first_rest(array: Array(a)) -> Result(#(a, Array(a)), Nil) {
  case iv.first(array), iv.rest(array) {
    Ok(first), Ok(rest) -> Ok(#(first, rest))
    _, _ -> Error(Nil)
  }
}
