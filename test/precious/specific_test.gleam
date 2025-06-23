import gleeunit/should

import precious/profile

pub fn nickname_test() {
  let profile = profile.nickname()
  should.equal(profile.enforce("\u{0308}", profile), Ok("\u{0308}"))
}
