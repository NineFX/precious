import gleam/string
import gleeunit/should
import iv
import precious/derived.{
  type Category, Disallowed, FreePVal, HasCompat, OldHangulJamo,
  PrecisIgnorableProperties, Spaces,
}
import precious/profile.{BidirectionalRule, CategoryError, Empty}

pub fn username_case_preserved_enforce_test() {
  let profile = profile.username_case_preserved()
  should.equal(profile.enforce("Juliet", profile), Ok("Juliet"))
  should.equal(profile.enforce("J*", profile), Ok("J*"))
  should.equal(
    profile.enforce("E\u{0301}\u{0301}\u{0301}", profile),
    Ok("\u{00C9}\u{0301}\u{0301}"),
  )
  should.equal(profile.enforce("", profile), Error(Empty))
  should.equal(
    profile.enforce(" J", profile),
    Error(CategoryError(FreePVal(Spaces), 0)),
  )
  should.equal(profile.enforce("\u{05D0}*", profile), Error(BidirectionalRule))
}

pub fn username_case_mapped_enforce_test() {
  let profile = profile.username_case_mapped()
  should.equal(profile.enforce("Juliet", profile), Ok("juliet"))
  should.equal(
    profile.enforce("E\u{0301}\u{0301}\u{0301}", profile),
    Ok("\u{00E9}\u{0301}\u{0301}"),
  )
  should.equal(profile.enforce("Fu\u{00DF}ball", profile), Ok("fu\u{00DF}ball"))
}

pub fn nickname_enforce_test() {
  let profile = profile.nickname()
  should.equal(profile.enforce("Juliet", profile), Ok("juliet"))
  should.equal(
    profile.enforce("E\u{0301}\u{0301}\u{0301}", profile),
    Ok("\u{00E9}\u{0301}\u{0301}"),
  )
  should.equal(profile.enforce("\u{03D4}", profile), Ok("\u{03CB}"))
}

pub fn valid_identifier_test() {
  let identifier_class = profile.identifer_class_allowed
  should.be_ok(enforce_class("abc", identifier_class))
  should.be_ok(enforce_class("123", identifier_class))
  should.be_ok(enforce_class(
    "\u{0660}\u{0661}\u{0662}\u{0669}",
    identifier_class,
  ))
  should.be_ok(enforce_class("\u{0370}\u{0371}", identifier_class))
}

pub fn invalid_identifier_test() {
  let identifier_class = profile.identifer_class_allowed
  should.equal(
    enforce_class(" ", identifier_class),
    Error(CategoryError(FreePVal(Spaces), 0)),
  )
  should.equal(
    enforce_class("\u{00AD}", identifier_class),
    Error(CategoryError(Disallowed(PrecisIgnorableProperties), 0)),
  )
  should.equal(
    enforce_class("\u{1100}", identifier_class),
    Error(CategoryError(Disallowed(OldHangulJamo), 0)),
  )
  should.equal(
    enforce_class("\u{1FBF}", identifier_class),
    Error(CategoryError(FreePVal(HasCompat), 0)),
  )
}

fn enforce_class(str: String, profile: List(Category)) {
  str
  |> string.to_utf_codepoints
  |> iv.from_list
  |> iv.map(string.utf_codepoint_to_int)
  |> profile.enforce_class(profile)
}
// pub fn identifier_oddities_test() {
//   let username_case_preserved_profile = profile.username_case_preserved()
//   let codepoints = list.range(from: 0, to: 10_000)
//   let #(username_case_preserved_allowed, _) =
//     codepoints
//     |> list.map(fn(cp_int) {
//       let assert Ok(cp) = string.utf_codepoint(cp_int)
//       [cp]
//       |> string.from_utf_codepoints
//       |> profile.enforce(using: username_case_preserved_profile)
//       |> result.map(fn(_) { cp_int })
//     })
//     |> result.partition
//   let #(identifer_class_allowed, _) =
//     codepoints
//     |> list.map(fn(cp_int) {
//       iv.from_list([cp_int])
//       |> profile.enforce_codepoint_categories(profile.identifer_class_allowed)
//       |> result.map(fn(_) { cp_int })
//     })
//     |> result.partition
// }

//     def test_identifier_oddities(self):
//         # Make a list of all codepoints < 10,000 which are allowed in the
//         # UsernameCasePreserved profile even though they are not allowed in
//         # IdentifierClass.
//         profile = get_profile("UsernameCasePreserved")
//         allowed = []
//         for cp in range(0, 10000):
//             try:
//                 profile.enforce(chr(cp))
//                 try:
//                     profile.base.enforce(chr(cp))
//                 except UnicodeEncodeError:
//                     allowed.append(cp)
//             except UnicodeEncodeError:
//                 pass
//         self.assertEqual(
//             allowed,
//             [
//                 832,
//                 833,
//                 835,
//                 836,
//                 884,
//                 894,
//                 2392,
//                 2393,
//                 2394,
//                 2395,
//                 2396,
//                 2397,
//                 2398,
//                 2399,
//                 2524,
//                 2525,
//                 2527,
//                 2611,
//                 2614,
//                 2649,
//                 2650,
//                 2651,
//                 2654,
//                 2908,
//                 2909,
//                 3907,
//                 3917,
//                 3922,
//                 3927,
//                 3932,
//                 3945,
//                 3955,
//                 3957,
//                 3958,
//                 3960,
//                 3969,
//                 3987,
//                 3997,
//                 4002,
//                 4007,
//                 4012,
//                 4025,
//                 8049,
//                 8051,
//                 8053,
//                 8055,
//                 8057,
//                 8059,
//                 8061,
//                 8123,
//                 8126,
//                 8137,
//                 8139,
//                 8147,
//                 8155,
//                 8163,
//                 8171,
//                 8175,
//                 8185,
//                 8187,
//                 8486,
//                 8490,
//                 8491,
//             ],
//         )
