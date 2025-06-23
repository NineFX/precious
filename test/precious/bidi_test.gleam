import gleam/string
import gleeunit/should
import iv.{type Array}
import precious/bidi

const l = "A"

const r = "\u{05d0}"

const al = "\u{0621}"

const en = "0"

const an = "\u{0666}"

const nsm = "\u{0300}"

const p = "*"

pub fn bidi_rule_ltr_test() {
  should.be_true(bidi_rule(l))
  should.be_true(bidi_rule(l <> p <> l))
  should.be_false(bidi_rule(p <> l))
  should.be_false(bidi_rule(l <> p))
  should.be_false(bidi_rule(l <> r <> l))
}

pub fn bidi_rule_rtl_test() {
  should.be_true(bidi_rule(r))
  should.be_true(bidi_rule(r <> r))
  should.be_true(bidi_rule(al <> r))
  should.be_true(bidi_rule(al <> en <> r))
  should.be_true(bidi_rule(al <> r <> en))
  should.be_true(bidi_rule(r <> p <> r))
  should.be_true(bidi_rule(r <> p <> r <> nsm <> nsm))
  should.be_true(bidi_rule(r <> an <> nsm <> an <> r))
  should.be_false(bidi_rule(p <> r))
  should.be_false(bidi_rule(r <> p))
  should.be_false(bidi_rule(r <> l <> r))
  should.be_false(bidi_rule(en <> r))
  should.be_false(bidi_rule(r <> an <> en))
  should.be_false(bidi_rule(r <> en <> an <> r))
}

pub fn has_rtl_test() {
  should.be_false(bidi.has_right_to_left(string_to_codepoints("Juliet+")))
  should.be_true(bidi.has_right_to_left(string_to_codepoints("\u{05d0}+")))
}

fn string_to_codepoints(str: String) -> Array(Int) {
  str
  |> string.to_utf_codepoints
  |> iv.from_list
  |> iv.map(string.utf_codepoint_to_int)
}

fn bidi_rule(str: String) -> Bool {
  str
  |> string.to_utf_codepoints
  |> iv.from_list
  |> iv.map(string.utf_codepoint_to_int)
  |> bidi.bidi_rule
}
