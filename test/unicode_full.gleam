import gleam/list
import gleam/regexp.{type Match, Options}
import gleam/string

const halfwidth_chars = "[\\x{FF01}-\\x{FFEF}]"

const space_chars = "[\\x{00A0}\\x{1680}\\x{2000}-\\x{200A}\\x{202F}\\x{205F}\\x{3000}]"

pub fn width_map(s: String) -> String {
  let assert Ok(pattern) =
    regexp.compile(halfwidth_chars, with: Options(False, True))
  regexp.match_map(each: pattern, in: s, with: decompose)
}

pub fn map_nonascii_space_to_ascii(s: String) -> String {
  let assert Ok(pattern) =
    regexp.compile(space_chars, with: Options(False, True))
  regexp.replace(each: pattern, in: s, with: " ")
}

pub fn in_halfwidth_cp(codepoint: Int) -> Bool {
  case codepoint {
    cp if cp >= 0xFF01 && cp <= 0xFFEF -> True
    _ -> False
  }
}

pub fn in_space_char(codepoint: Int) -> Bool {
  case codepoint {
    0x00A0 | 0x1680 | 0x202F | 0x205F | 0x3000 -> True
    cp if cp >= 0x2000 && cp <= 0x200A -> True
    _ -> False
  }
}

fn decompose(match: Match) -> String {
  let normalized = nfkc(match.content)
  let normalized_lenth = list.length(string.to_utf_codepoints(normalized))
  case normalized_lenth {
    1 -> normalized
    _ -> match.content
  }
}

pub fn in_arabic_indic(codepoint: Int) -> Bool {
  0x0660 <= codepoint && codepoint <= 0x0669
}

pub fn in_ascii7(codepoint: Int) -> Bool {
  0x21 <= codepoint && codepoint <= 0x7E
}

// Code points for Join Control characters required under some circumstances. (CONTEXTJ)
pub fn in_join_control(codepoint: Int) -> Bool {
  0x200C <= codepoint && codepoint <= 0x200D
}

pub fn in_extended_arabic_indic(codepoint: Int) -> Bool {
  0x06F0 <= codepoint && codepoint <= 0x06F9
}

@external(erlang, "unicode", "characters_to_nfkc_binary")
@external(javascript, "../precious_ffi.mjs", "nkfcnfkc")
pub fn nfkc(s: String) -> String
pub fn in_left_to_right_first(codepoint: Int) -> Bool {
  case codepoint {
    cp if cp >= 0x0041 && cp <= 0x005A -> True
    cp if cp >= 0x0061 && cp <= 0x007A -> True
    cp if cp == 0x00AA -> True
    cp if cp == 0x00B5 -> True
    cp if cp == 0x00BA -> True
    cp if cp >= 0x00C0 && cp <= 0x00D6 -> True
    cp if cp >= 0x00D8 && cp <= 0x00F6 -> True
    cp if cp >= 0x00F8 && cp <= 0x01BA -> True
    cp if cp == 0x01BB -> True
    cp if cp >= 0x01BC && cp <= 0x01BF -> True
    cp if cp >= 0x01C0 && cp <= 0x01C3 -> True
    cp if cp >= 0x01C4 && cp <= 0x0293 -> True
    cp if cp == 0x0294 -> True
    cp if cp >= 0x0295 && cp <= 0x02AF -> True
    cp if cp >= 0x02B0 && cp <= 0x02B8 -> True
    cp if cp >= 0x02BB && cp <= 0x02C1 -> True
    cp if cp >= 0x02D0 && cp <= 0x02D1 -> True
    cp if cp >= 0x02E0 && cp <= 0x02E4 -> True
    cp if cp == 0x02EE -> True
    cp if cp >= 0x0370 && cp <= 0x0373 -> True
    cp if cp >= 0x0376 && cp <= 0x0377 -> True
    cp if cp == 0x037A -> True
    cp if cp >= 0x037B && cp <= 0x037D -> True
    cp if cp == 0x037F -> True
    cp if cp == 0x0386 -> True
    cp if cp >= 0x0388 && cp <= 0x038A -> True
    cp if cp == 0x038C -> True
    cp if cp >= 0x038E && cp <= 0x03A1 -> True
    cp if cp >= 0x03A3 && cp <= 0x03F5 -> True
    cp if cp >= 0x03F7 && cp <= 0x0481 -> True
    cp if cp == 0x0482 -> True
    cp if cp >= 0x048A && cp <= 0x052F -> True
    cp if cp >= 0x0531 && cp <= 0x0556 -> True
    cp if cp == 0x0559 -> True
    cp if cp >= 0x055A && cp <= 0x055F -> True
    cp if cp >= 0x0560 && cp <= 0x0588 -> True
    cp if cp == 0x0589 -> True
    cp if cp == 0x0903 -> True
    cp if cp >= 0x0904 && cp <= 0x0939 -> True
    cp if cp == 0x093B -> True
    cp if cp == 0x093D -> True
    cp if cp >= 0x093E && cp <= 0x0940 -> True
    cp if cp >= 0x0949 && cp <= 0x094C -> True
    cp if cp >= 0x094E && cp <= 0x094F -> True
    cp if cp == 0x0950 -> True
    cp if cp >= 0x0958 && cp <= 0x0961 -> True
    cp if cp >= 0x0964 && cp <= 0x0965 -> True
    cp if cp >= 0x0966 && cp <= 0x096F -> True
    cp if cp == 0x0970 -> True
    cp if cp == 0x0971 -> True
    cp if cp >= 0x0972 && cp <= 0x0980 -> True
    cp if cp >= 0x0982 && cp <= 0x0983 -> True
    cp if cp >= 0x0985 && cp <= 0x098C -> True
    cp if cp >= 0x098F && cp <= 0x0990 -> True
    cp if cp >= 0x0993 && cp <= 0x09A8 -> True
    cp if cp >= 0x09AA && cp <= 0x09B0 -> True
    cp if cp == 0x09B2 -> True
    cp if cp >= 0x09B6 && cp <= 0x09B9 -> True
    cp if cp == 0x09BD -> True
    cp if cp >= 0x09BE && cp <= 0x09C0 -> True
    cp if cp >= 0x09C7 && cp <= 0x09C8 -> True
    cp if cp >= 0x09CB && cp <= 0x09CC -> True
    cp if cp == 0x09CE -> True
    cp if cp == 0x09D7 -> True
    cp if cp >= 0x09DC && cp <= 0x09DD -> True
    cp if cp >= 0x09DF && cp <= 0x09E1 -> True
    cp if cp >= 0x09E6 && cp <= 0x09EF -> True
    cp if cp >= 0x09F0 && cp <= 0x09F1 -> True
    cp if cp >= 0x09F4 && cp <= 0x09F9 -> True
    cp if cp == 0x09FA -> True
    cp if cp == 0x09FC -> True
    cp if cp == 0x09FD -> True
    cp if cp == 0x0A03 -> True
    cp if cp >= 0x0A05 && cp <= 0x0A0A -> True
    cp if cp >= 0x0A0F && cp <= 0x0A10 -> True
    cp if cp >= 0x0A13 && cp <= 0x0A28 -> True
    cp if cp >= 0x0A2A && cp <= 0x0A30 -> True
    cp if cp >= 0x0A32 && cp <= 0x0A33 -> True
    cp if cp >= 0x0A35 && cp <= 0x0A36 -> True
    cp if cp >= 0x0A38 && cp <= 0x0A39 -> True
    cp if cp >= 0x0A3E && cp <= 0x0A40 -> True
    cp if cp >= 0x0A59 && cp <= 0x0A5C -> True
    cp if cp == 0x0A5E -> True
    cp if cp >= 0x0A66 && cp <= 0x0A6F -> True
    cp if cp >= 0x0A72 && cp <= 0x0A74 -> True
    cp if cp == 0x0A76 -> True
    cp if cp == 0x0A83 -> True
    cp if cp >= 0x0A85 && cp <= 0x0A8D -> True
    cp if cp >= 0x0A8F && cp <= 0x0A91 -> True
    cp if cp >= 0x0A93 && cp <= 0x0AA8 -> True
    cp if cp >= 0x0AAA && cp <= 0x0AB0 -> True
    cp if cp >= 0x0AB2 && cp <= 0x0AB3 -> True
    cp if cp >= 0x0AB5 && cp <= 0x0AB9 -> True
    cp if cp == 0x0ABD -> True
    cp if cp >= 0x0ABE && cp <= 0x0AC0 -> True
    cp if cp == 0x0AC9 -> True
    cp if cp >= 0x0ACB && cp <= 0x0ACC -> True
    cp if cp == 0x0AD0 -> True
    cp if cp >= 0x0AE0 && cp <= 0x0AE1 -> True
    cp if cp >= 0x0AE6 && cp <= 0x0AEF -> True
    cp if cp == 0x0AF0 -> True
    cp if cp == 0x0AF9 -> True
    cp if cp >= 0x0B02 && cp <= 0x0B03 -> True
    cp if cp >= 0x0B05 && cp <= 0x0B0C -> True
    cp if cp >= 0x0B0F && cp <= 0x0B10 -> True
    cp if cp >= 0x0B13 && cp <= 0x0B28 -> True
    cp if cp >= 0x0B2A && cp <= 0x0B30 -> True
    cp if cp >= 0x0B32 && cp <= 0x0B33 -> True
    cp if cp >= 0x0B35 && cp <= 0x0B39 -> True
    cp if cp == 0x0B3D -> True
    cp if cp == 0x0B3E -> True
    cp if cp == 0x0B40 -> True
    cp if cp >= 0x0B47 && cp <= 0x0B48 -> True
    cp if cp >= 0x0B4B && cp <= 0x0B4C -> True
    cp if cp == 0x0B57 -> True
    cp if cp >= 0x0B5C && cp <= 0x0B5D -> True
    cp if cp >= 0x0B5F && cp <= 0x0B61 -> True
    cp if cp >= 0x0B66 && cp <= 0x0B6F -> True
    cp if cp == 0x0B70 -> True
    cp if cp == 0x0B71 -> True
    cp if cp >= 0x0B72 && cp <= 0x0B77 -> True
    cp if cp == 0x0B83 -> True
    cp if cp >= 0x0B85 && cp <= 0x0B8A -> True
    cp if cp >= 0x0B8E && cp <= 0x0B90 -> True
    cp if cp >= 0x0B92 && cp <= 0x0B95 -> True
    cp if cp >= 0x0B99 && cp <= 0x0B9A -> True
    cp if cp == 0x0B9C -> True
    cp if cp >= 0x0B9E && cp <= 0x0B9F -> True
    cp if cp >= 0x0BA3 && cp <= 0x0BA4 -> True
    cp if cp >= 0x0BA8 && cp <= 0x0BAA -> True
    cp if cp >= 0x0BAE && cp <= 0x0BB9 -> True
    cp if cp >= 0x0BBE && cp <= 0x0BBF -> True
    cp if cp >= 0x0BC1 && cp <= 0x0BC2 -> True
    cp if cp >= 0x0BC6 && cp <= 0x0BC8 -> True
    cp if cp >= 0x0BCA && cp <= 0x0BCC -> True
    cp if cp == 0x0BD0 -> True
    cp if cp == 0x0BD7 -> True
    cp if cp >= 0x0BE6 && cp <= 0x0BEF -> True
    cp if cp >= 0x0BF0 && cp <= 0x0BF2 -> True
    cp if cp >= 0x0C01 && cp <= 0x0C03 -> True
    cp if cp >= 0x0C05 && cp <= 0x0C0C -> True
    cp if cp >= 0x0C0E && cp <= 0x0C10 -> True
    cp if cp >= 0x0C12 && cp <= 0x0C28 -> True
    cp if cp >= 0x0C2A && cp <= 0x0C39 -> True
    cp if cp == 0x0C3D -> True
    cp if cp >= 0x0C41 && cp <= 0x0C44 -> True
    cp if cp >= 0x0C58 && cp <= 0x0C5A -> True
    cp if cp == 0x0C5D -> True
    cp if cp >= 0x0C60 && cp <= 0x0C61 -> True
    cp if cp >= 0x0C66 && cp <= 0x0C6F -> True
    cp if cp == 0x0C77 -> True
    cp if cp == 0x0C7F -> True
    cp if cp == 0x0C80 -> True
    cp if cp >= 0x0C82 && cp <= 0x0C83 -> True
    cp if cp == 0x0C84 -> True
    cp if cp >= 0x0C85 && cp <= 0x0C8C -> True
    cp if cp >= 0x0C8E && cp <= 0x0C90 -> True
    cp if cp >= 0x0C92 && cp <= 0x0CA8 -> True
    cp if cp >= 0x0CAA && cp <= 0x0CB3 -> True
    cp if cp >= 0x0CB5 && cp <= 0x0CB9 -> True
    cp if cp == 0x0CBD -> True
    cp if cp == 0x0CBE -> True
    cp if cp == 0x0CBF -> True
    cp if cp >= 0x0CC0 && cp <= 0x0CC4 -> True
    cp if cp == 0x0CC6 -> True
    cp if cp >= 0x0CC7 && cp <= 0x0CC8 -> True
    cp if cp >= 0x0CCA && cp <= 0x0CCB -> True
    cp if cp >= 0x0CD5 && cp <= 0x0CD6 -> True
    cp if cp >= 0x0CDD && cp <= 0x0CDE -> True
    cp if cp >= 0x0CE0 && cp <= 0x0CE1 -> True
    cp if cp >= 0x0CE6 && cp <= 0x0CEF -> True
    cp if cp >= 0x0CF1 && cp <= 0x0CF2 -> True
    cp if cp == 0x0CF3 -> True
    cp if cp >= 0x0D02 && cp <= 0x0D03 -> True
    cp if cp >= 0x0D04 && cp <= 0x0D0C -> True
    cp if cp >= 0x0D0E && cp <= 0x0D10 -> True
    cp if cp >= 0x0D12 && cp <= 0x0D3A -> True
    cp if cp == 0x0D3D -> True
    cp if cp >= 0x0D3E && cp <= 0x0D40 -> True
    cp if cp >= 0x0D46 && cp <= 0x0D48 -> True
    cp if cp >= 0x0D4A && cp <= 0x0D4C -> True
    cp if cp == 0x0D4E -> True
    cp if cp == 0x0D4F -> True
    cp if cp >= 0x0D54 && cp <= 0x0D56 -> True
    cp if cp == 0x0D57 -> True
    cp if cp >= 0x0D58 && cp <= 0x0D5E -> True
    cp if cp >= 0x0D5F && cp <= 0x0D61 -> True
    cp if cp >= 0x0D66 && cp <= 0x0D6F -> True
    cp if cp >= 0x0D70 && cp <= 0x0D78 -> True
    cp if cp == 0x0D79 -> True
    cp if cp >= 0x0D7A && cp <= 0x0D7F -> True
    cp if cp >= 0x0D82 && cp <= 0x0D83 -> True
    cp if cp >= 0x0D85 && cp <= 0x0D96 -> True
    cp if cp >= 0x0D9A && cp <= 0x0DB1 -> True
    cp if cp >= 0x0DB3 && cp <= 0x0DBB -> True
    cp if cp == 0x0DBD -> True
    cp if cp >= 0x0DC0 && cp <= 0x0DC6 -> True
    cp if cp >= 0x0DCF && cp <= 0x0DD1 -> True
    cp if cp >= 0x0DD8 && cp <= 0x0DDF -> True
    cp if cp >= 0x0DE6 && cp <= 0x0DEF -> True
    cp if cp >= 0x0DF2 && cp <= 0x0DF3 -> True
    cp if cp == 0x0DF4 -> True
    cp if cp >= 0x0E01 && cp <= 0x0E30 -> True
    cp if cp >= 0x0E32 && cp <= 0x0E33 -> True
    cp if cp >= 0x0E40 && cp <= 0x0E45 -> True
    cp if cp == 0x0E46 -> True
    cp if cp == 0x0E4F -> True
    cp if cp >= 0x0E50 && cp <= 0x0E59 -> True
    cp if cp >= 0x0E5A && cp <= 0x0E5B -> True
    cp if cp >= 0x0E81 && cp <= 0x0E82 -> True
    cp if cp == 0x0E84 -> True
    cp if cp >= 0x0E86 && cp <= 0x0E8A -> True
    cp if cp >= 0x0E8C && cp <= 0x0EA3 -> True
    cp if cp == 0x0EA5 -> True
    cp if cp >= 0x0EA7 && cp <= 0x0EB0 -> True
    cp if cp >= 0x0EB2 && cp <= 0x0EB3 -> True
    cp if cp == 0x0EBD -> True
    cp if cp >= 0x0EC0 && cp <= 0x0EC4 -> True
    cp if cp == 0x0EC6 -> True
    cp if cp >= 0x0ED0 && cp <= 0x0ED9 -> True
    cp if cp >= 0x0EDC && cp <= 0x0EDF -> True
    cp if cp == 0x0F00 -> True
    cp if cp >= 0x0F01 && cp <= 0x0F03 -> True
    cp if cp >= 0x0F04 && cp <= 0x0F12 -> True
    cp if cp == 0x0F13 -> True
    cp if cp == 0x0F14 -> True
    cp if cp >= 0x0F15 && cp <= 0x0F17 -> True
    cp if cp >= 0x0F1A && cp <= 0x0F1F -> True
    cp if cp >= 0x0F20 && cp <= 0x0F29 -> True
    cp if cp >= 0x0F2A && cp <= 0x0F33 -> True
    cp if cp == 0x0F34 -> True
    cp if cp == 0x0F36 -> True
    cp if cp == 0x0F38 -> True
    cp if cp >= 0x0F3E && cp <= 0x0F3F -> True
    cp if cp >= 0x0F40 && cp <= 0x0F47 -> True
    cp if cp >= 0x0F49 && cp <= 0x0F6C -> True
    cp if cp == 0x0F7F -> True
    cp if cp == 0x0F85 -> True
    cp if cp >= 0x0F88 && cp <= 0x0F8C -> True
    cp if cp >= 0x0FBE && cp <= 0x0FC5 -> True
    cp if cp >= 0x0FC7 && cp <= 0x0FCC -> True
    cp if cp >= 0x0FCE && cp <= 0x0FCF -> True
    cp if cp >= 0x0FD0 && cp <= 0x0FD4 -> True
    cp if cp >= 0x0FD5 && cp <= 0x0FD8 -> True
    cp if cp >= 0x0FD9 && cp <= 0x0FDA -> True
    cp if cp >= 0x1000 && cp <= 0x102A -> True
    cp if cp >= 0x102B && cp <= 0x102C -> True
    cp if cp == 0x1031 -> True
    cp if cp == 0x1038 -> True
    cp if cp >= 0x103B && cp <= 0x103C -> True
    cp if cp == 0x103F -> True
    cp if cp >= 0x1040 && cp <= 0x1049 -> True
    cp if cp >= 0x104A && cp <= 0x104F -> True
    cp if cp >= 0x1050 && cp <= 0x1055 -> True
    cp if cp >= 0x1056 && cp <= 0x1057 -> True
    cp if cp >= 0x105A && cp <= 0x105D -> True
    cp if cp == 0x1061 -> True
    cp if cp >= 0x1062 && cp <= 0x1064 -> True
    cp if cp >= 0x1065 && cp <= 0x1066 -> True
    cp if cp >= 0x1067 && cp <= 0x106D -> True
    cp if cp >= 0x106E && cp <= 0x1070 -> True
    cp if cp >= 0x1075 && cp <= 0x1081 -> True
    cp if cp >= 0x1083 && cp <= 0x1084 -> True
    cp if cp >= 0x1087 && cp <= 0x108C -> True
    cp if cp == 0x108E -> True
    cp if cp == 0x108F -> True
    cp if cp >= 0x1090 && cp <= 0x1099 -> True
    cp if cp >= 0x109A && cp <= 0x109C -> True
    cp if cp >= 0x109E && cp <= 0x109F -> True
    cp if cp >= 0x10A0 && cp <= 0x10C5 -> True
    cp if cp == 0x10C7 -> True
    cp if cp == 0x10CD -> True
    cp if cp >= 0x10D0 && cp <= 0x10FA -> True
    cp if cp == 0x10FB -> True
    cp if cp == 0x10FC -> True
    cp if cp >= 0x10FD && cp <= 0x10FF -> True
    cp if cp >= 0x1100 && cp <= 0x1248 -> True
    cp if cp >= 0x124A && cp <= 0x124D -> True
    cp if cp >= 0x1250 && cp <= 0x1256 -> True
    cp if cp == 0x1258 -> True
    cp if cp >= 0x125A && cp <= 0x125D -> True
    cp if cp >= 0x1260 && cp <= 0x1288 -> True
    cp if cp >= 0x128A && cp <= 0x128D -> True
    cp if cp >= 0x1290 && cp <= 0x12B0 -> True
    cp if cp >= 0x12B2 && cp <= 0x12B5 -> True
    cp if cp >= 0x12B8 && cp <= 0x12BE -> True
    cp if cp == 0x12C0 -> True
    cp if cp >= 0x12C2 && cp <= 0x12C5 -> True
    cp if cp >= 0x12C8 && cp <= 0x12D6 -> True
    cp if cp >= 0x12D8 && cp <= 0x1310 -> True
    cp if cp >= 0x1312 && cp <= 0x1315 -> True
    cp if cp >= 0x1318 && cp <= 0x135A -> True
    cp if cp >= 0x1360 && cp <= 0x1368 -> True
    cp if cp >= 0x1369 && cp <= 0x137C -> True
    cp if cp >= 0x1380 && cp <= 0x138F -> True
    cp if cp >= 0x13A0 && cp <= 0x13F5 -> True
    cp if cp >= 0x13F8 && cp <= 0x13FD -> True
    cp if cp >= 0x1401 && cp <= 0x166C -> True
    cp if cp == 0x166D -> True
    cp if cp == 0x166E -> True
    cp if cp >= 0x166F && cp <= 0x167F -> True
    cp if cp >= 0x1681 && cp <= 0x169A -> True
    cp if cp >= 0x16A0 && cp <= 0x16EA -> True
    cp if cp >= 0x16EB && cp <= 0x16ED -> True
    cp if cp >= 0x16EE && cp <= 0x16F0 -> True
    cp if cp >= 0x16F1 && cp <= 0x16F8 -> True
    cp if cp >= 0x1700 && cp <= 0x1711 -> True
    cp if cp == 0x1715 -> True
    cp if cp >= 0x171F && cp <= 0x1731 -> True
    cp if cp == 0x1734 -> True
    cp if cp >= 0x1735 && cp <= 0x1736 -> True
    cp if cp >= 0x1740 && cp <= 0x1751 -> True
    cp if cp >= 0x1760 && cp <= 0x176C -> True
    cp if cp >= 0x176E && cp <= 0x1770 -> True
    cp if cp >= 0x1780 && cp <= 0x17B3 -> True
    cp if cp == 0x17B6 -> True
    cp if cp >= 0x17BE && cp <= 0x17C5 -> True
    cp if cp >= 0x17C7 && cp <= 0x17C8 -> True
    cp if cp >= 0x17D4 && cp <= 0x17D6 -> True
    cp if cp == 0x17D7 -> True
    cp if cp >= 0x17D8 && cp <= 0x17DA -> True
    cp if cp == 0x17DC -> True
    cp if cp >= 0x17E0 && cp <= 0x17E9 -> True
    cp if cp >= 0x1810 && cp <= 0x1819 -> True
    cp if cp >= 0x1820 && cp <= 0x1842 -> True
    cp if cp == 0x1843 -> True
    cp if cp >= 0x1844 && cp <= 0x1878 -> True
    cp if cp >= 0x1880 && cp <= 0x1884 -> True
    cp if cp >= 0x1887 && cp <= 0x18A8 -> True
    cp if cp == 0x18AA -> True
    cp if cp >= 0x18B0 && cp <= 0x18F5 -> True
    cp if cp >= 0x1900 && cp <= 0x191E -> True
    cp if cp >= 0x1923 && cp <= 0x1926 -> True
    cp if cp >= 0x1929 && cp <= 0x192B -> True
    cp if cp >= 0x1930 && cp <= 0x1931 -> True
    cp if cp >= 0x1933 && cp <= 0x1938 -> True
    cp if cp >= 0x1946 && cp <= 0x194F -> True
    cp if cp >= 0x1950 && cp <= 0x196D -> True
    cp if cp >= 0x1970 && cp <= 0x1974 -> True
    cp if cp >= 0x1980 && cp <= 0x19AB -> True
    cp if cp >= 0x19B0 && cp <= 0x19C9 -> True
    cp if cp >= 0x19D0 && cp <= 0x19D9 -> True
    cp if cp == 0x19DA -> True
    cp if cp >= 0x1A00 && cp <= 0x1A16 -> True
    cp if cp >= 0x1A19 && cp <= 0x1A1A -> True
    cp if cp >= 0x1A1E && cp <= 0x1A1F -> True
    cp if cp >= 0x1A20 && cp <= 0x1A54 -> True
    cp if cp == 0x1A55 -> True
    cp if cp == 0x1A57 -> True
    cp if cp == 0x1A61 -> True
    cp if cp >= 0x1A63 && cp <= 0x1A64 -> True
    cp if cp >= 0x1A6D && cp <= 0x1A72 -> True
    cp if cp >= 0x1A80 && cp <= 0x1A89 -> True
    cp if cp >= 0x1A90 && cp <= 0x1A99 -> True
    cp if cp >= 0x1AA0 && cp <= 0x1AA6 -> True
    cp if cp == 0x1AA7 -> True
    cp if cp >= 0x1AA8 && cp <= 0x1AAD -> True
    cp if cp == 0x1B04 -> True
    cp if cp >= 0x1B05 && cp <= 0x1B33 -> True
    cp if cp == 0x1B35 -> True
    cp if cp == 0x1B3B -> True
    cp if cp >= 0x1B3D && cp <= 0x1B41 -> True
    cp if cp >= 0x1B43 && cp <= 0x1B44 -> True
    cp if cp >= 0x1B45 && cp <= 0x1B4C -> True
    cp if cp >= 0x1B4E && cp <= 0x1B4F -> True
    cp if cp >= 0x1B50 && cp <= 0x1B59 -> True
    cp if cp >= 0x1B5A && cp <= 0x1B60 -> True
    cp if cp >= 0x1B61 && cp <= 0x1B6A -> True
    cp if cp >= 0x1B74 && cp <= 0x1B7C -> True
    cp if cp >= 0x1B7D && cp <= 0x1B7F -> True
    cp if cp == 0x1B82 -> True
    cp if cp >= 0x1B83 && cp <= 0x1BA0 -> True
    cp if cp == 0x1BA1 -> True
    cp if cp >= 0x1BA6 && cp <= 0x1BA7 -> True
    cp if cp == 0x1BAA -> True
    cp if cp >= 0x1BAE && cp <= 0x1BAF -> True
    cp if cp >= 0x1BB0 && cp <= 0x1BB9 -> True
    cp if cp >= 0x1BBA && cp <= 0x1BE5 -> True
    cp if cp == 0x1BE7 -> True
    cp if cp >= 0x1BEA && cp <= 0x1BEC -> True
    cp if cp == 0x1BEE -> True
    cp if cp >= 0x1BF2 && cp <= 0x1BF3 -> True
    cp if cp >= 0x1BFC && cp <= 0x1BFF -> True
    cp if cp >= 0x1C00 && cp <= 0x1C23 -> True
    cp if cp >= 0x1C24 && cp <= 0x1C2B -> True
    cp if cp >= 0x1C34 && cp <= 0x1C35 -> True
    cp if cp >= 0x1C3B && cp <= 0x1C3F -> True
    cp if cp >= 0x1C40 && cp <= 0x1C49 -> True
    cp if cp >= 0x1C4D && cp <= 0x1C4F -> True
    cp if cp >= 0x1C50 && cp <= 0x1C59 -> True
    cp if cp >= 0x1C5A && cp <= 0x1C77 -> True
    cp if cp >= 0x1C78 && cp <= 0x1C7D -> True
    cp if cp >= 0x1C7E && cp <= 0x1C7F -> True
    cp if cp >= 0x1C80 && cp <= 0x1C8A -> True
    cp if cp >= 0x1C90 && cp <= 0x1CBA -> True
    cp if cp >= 0x1CBD && cp <= 0x1CBF -> True
    cp if cp >= 0x1CC0 && cp <= 0x1CC7 -> True
    cp if cp == 0x1CD3 -> True
    cp if cp == 0x1CE1 -> True
    cp if cp >= 0x1CE9 && cp <= 0x1CEC -> True
    cp if cp >= 0x1CEE && cp <= 0x1CF3 -> True
    cp if cp >= 0x1CF5 && cp <= 0x1CF6 -> True
    cp if cp == 0x1CF7 -> True
    cp if cp == 0x1CFA -> True
    cp if cp >= 0x1D00 && cp <= 0x1D2B -> True
    cp if cp >= 0x1D2C && cp <= 0x1D6A -> True
    cp if cp >= 0x1D6B && cp <= 0x1D77 -> True
    cp if cp == 0x1D78 -> True
    cp if cp >= 0x1D79 && cp <= 0x1D9A -> True
    cp if cp >= 0x1D9B && cp <= 0x1DBF -> True
    cp if cp >= 0x1E00 && cp <= 0x1F15 -> True
    cp if cp >= 0x1F18 && cp <= 0x1F1D -> True
    cp if cp >= 0x1F20 && cp <= 0x1F45 -> True
    cp if cp >= 0x1F48 && cp <= 0x1F4D -> True
    cp if cp >= 0x1F50 && cp <= 0x1F57 -> True
    cp if cp == 0x1F59 -> True
    cp if cp == 0x1F5B -> True
    cp if cp == 0x1F5D -> True
    cp if cp >= 0x1F5F && cp <= 0x1F7D -> True
    cp if cp >= 0x1F80 && cp <= 0x1FB4 -> True
    cp if cp >= 0x1FB6 && cp <= 0x1FBC -> True
    cp if cp == 0x1FBE -> True
    cp if cp >= 0x1FC2 && cp <= 0x1FC4 -> True
    cp if cp >= 0x1FC6 && cp <= 0x1FCC -> True
    cp if cp >= 0x1FD0 && cp <= 0x1FD3 -> True
    cp if cp >= 0x1FD6 && cp <= 0x1FDB -> True
    cp if cp >= 0x1FE0 && cp <= 0x1FEC -> True
    cp if cp >= 0x1FF2 && cp <= 0x1FF4 -> True
    cp if cp >= 0x1FF6 && cp <= 0x1FFC -> True
    cp if cp == 0x200E -> True
    cp if cp == 0x2071 -> True
    cp if cp == 0x207F -> True
    cp if cp >= 0x2090 && cp <= 0x209C -> True
    cp if cp == 0x2102 -> True
    cp if cp == 0x2107 -> True
    cp if cp >= 0x210A && cp <= 0x2113 -> True
    cp if cp == 0x2115 -> True
    cp if cp >= 0x2119 && cp <= 0x211D -> True
    cp if cp == 0x2124 -> True
    cp if cp == 0x2126 -> True
    cp if cp == 0x2128 -> True
    cp if cp >= 0x212A && cp <= 0x212D -> True
    cp if cp >= 0x212F && cp <= 0x2134 -> True
    cp if cp >= 0x2135 && cp <= 0x2138 -> True
    cp if cp == 0x2139 -> True
    cp if cp >= 0x213C && cp <= 0x213F -> True
    cp if cp >= 0x2145 && cp <= 0x2149 -> True
    cp if cp == 0x214E -> True
    cp if cp == 0x214F -> True
    cp if cp >= 0x2160 && cp <= 0x2182 -> True
    cp if cp >= 0x2183 && cp <= 0x2184 -> True
    cp if cp >= 0x2185 && cp <= 0x2188 -> True
    cp if cp >= 0x2336 && cp <= 0x237A -> True
    cp if cp == 0x2395 -> True
    cp if cp >= 0x249C && cp <= 0x24E9 -> True
    cp if cp == 0x26AC -> True
    cp if cp >= 0x2800 && cp <= 0x28FF -> True
    cp if cp >= 0x2C00 && cp <= 0x2C7B -> True
    cp if cp >= 0x2C7C && cp <= 0x2C7D -> True
    cp if cp >= 0x2C7E && cp <= 0x2CE4 -> True
    cp if cp >= 0x2CEB && cp <= 0x2CEE -> True
    cp if cp >= 0x2CF2 && cp <= 0x2CF3 -> True
    cp if cp >= 0x2D00 && cp <= 0x2D25 -> True
    cp if cp == 0x2D27 -> True
    cp if cp == 0x2D2D -> True
    cp if cp >= 0x2D30 && cp <= 0x2D67 -> True
    cp if cp == 0x2D6F -> True
    cp if cp == 0x2D70 -> True
    cp if cp >= 0x2D80 && cp <= 0x2D96 -> True
    cp if cp >= 0x2DA0 && cp <= 0x2DA6 -> True
    cp if cp >= 0x2DA8 && cp <= 0x2DAE -> True
    cp if cp >= 0x2DB0 && cp <= 0x2DB6 -> True
    cp if cp >= 0x2DB8 && cp <= 0x2DBE -> True
    cp if cp >= 0x2DC0 && cp <= 0x2DC6 -> True
    cp if cp >= 0x2DC8 && cp <= 0x2DCE -> True
    cp if cp >= 0x2DD0 && cp <= 0x2DD6 -> True
    cp if cp >= 0x2DD8 && cp <= 0x2DDE -> True
    cp if cp == 0x3005 -> True
    cp if cp == 0x3006 -> True
    cp if cp == 0x3007 -> True
    cp if cp >= 0x3021 && cp <= 0x3029 -> True
    cp if cp >= 0x302E && cp <= 0x302F -> True
    cp if cp >= 0x3031 && cp <= 0x3035 -> True
    cp if cp >= 0x3038 && cp <= 0x303A -> True
    cp if cp == 0x303B -> True
    cp if cp == 0x303C -> True
    cp if cp >= 0x3041 && cp <= 0x3096 -> True
    cp if cp >= 0x309D && cp <= 0x309E -> True
    cp if cp == 0x309F -> True
    cp if cp >= 0x30A1 && cp <= 0x30FA -> True
    cp if cp >= 0x30FC && cp <= 0x30FE -> True
    cp if cp == 0x30FF -> True
    cp if cp >= 0x3105 && cp <= 0x312F -> True
    cp if cp >= 0x3131 && cp <= 0x318E -> True
    cp if cp >= 0x3190 && cp <= 0x3191 -> True
    cp if cp >= 0x3192 && cp <= 0x3195 -> True
    cp if cp >= 0x3196 && cp <= 0x319F -> True
    cp if cp >= 0x31A0 && cp <= 0x31BF -> True
    cp if cp >= 0x31F0 && cp <= 0x31FF -> True
    cp if cp >= 0x3200 && cp <= 0x321C -> True
    cp if cp >= 0x3220 && cp <= 0x3229 -> True
    cp if cp >= 0x322A && cp <= 0x3247 -> True
    cp if cp >= 0x3248 && cp <= 0x324F -> True
    cp if cp >= 0x3260 && cp <= 0x327B -> True
    cp if cp == 0x327F -> True
    cp if cp >= 0x3280 && cp <= 0x3289 -> True
    cp if cp >= 0x328A && cp <= 0x32B0 -> True
    cp if cp >= 0x32C0 && cp <= 0x32CB -> True
    cp if cp >= 0x32D0 && cp <= 0x3376 -> True
    cp if cp >= 0x337B && cp <= 0x33DD -> True
    cp if cp >= 0x33E0 && cp <= 0x33FE -> True
    cp if cp >= 0x3400 && cp <= 0x4DBF -> True
    cp if cp >= 0x4E00 && cp <= 0xA014 -> True
    cp if cp == 0xA015 -> True
    cp if cp >= 0xA016 && cp <= 0xA48C -> True
    cp if cp >= 0xA4D0 && cp <= 0xA4F7 -> True
    cp if cp >= 0xA4F8 && cp <= 0xA4FD -> True
    cp if cp >= 0xA4FE && cp <= 0xA4FF -> True
    cp if cp >= 0xA500 && cp <= 0xA60B -> True
    cp if cp == 0xA60C -> True
    cp if cp >= 0xA610 && cp <= 0xA61F -> True
    cp if cp >= 0xA620 && cp <= 0xA629 -> True
    cp if cp >= 0xA62A && cp <= 0xA62B -> True
    cp if cp >= 0xA640 && cp <= 0xA66D -> True
    cp if cp == 0xA66E -> True
    cp if cp >= 0xA680 && cp <= 0xA69B -> True
    cp if cp >= 0xA69C && cp <= 0xA69D -> True
    cp if cp >= 0xA6A0 && cp <= 0xA6E5 -> True
    cp if cp >= 0xA6E6 && cp <= 0xA6EF -> True
    cp if cp >= 0xA6F2 && cp <= 0xA6F7 -> True
    cp if cp >= 0xA722 && cp <= 0xA76F -> True
    cp if cp == 0xA770 -> True
    cp if cp >= 0xA771 && cp <= 0xA787 -> True
    cp if cp >= 0xA789 && cp <= 0xA78A -> True
    cp if cp >= 0xA78B && cp <= 0xA78E -> True
    cp if cp == 0xA78F -> True
    cp if cp >= 0xA790 && cp <= 0xA7CD -> True
    cp if cp >= 0xA7D0 && cp <= 0xA7D1 -> True
    cp if cp == 0xA7D3 -> True
    cp if cp >= 0xA7D5 && cp <= 0xA7DC -> True
    cp if cp >= 0xA7F2 && cp <= 0xA7F4 -> True
    cp if cp >= 0xA7F5 && cp <= 0xA7F6 -> True
    cp if cp == 0xA7F7 -> True
    cp if cp >= 0xA7F8 && cp <= 0xA7F9 -> True
    cp if cp == 0xA7FA -> True
    cp if cp >= 0xA7FB && cp <= 0xA801 -> True
    cp if cp >= 0xA803 && cp <= 0xA805 -> True
    cp if cp >= 0xA807 && cp <= 0xA80A -> True
    cp if cp >= 0xA80C && cp <= 0xA822 -> True
    cp if cp >= 0xA823 && cp <= 0xA824 -> True
    cp if cp == 0xA827 -> True
    cp if cp >= 0xA830 && cp <= 0xA835 -> True
    cp if cp >= 0xA836 && cp <= 0xA837 -> True
    cp if cp >= 0xA840 && cp <= 0xA873 -> True
    cp if cp >= 0xA880 && cp <= 0xA881 -> True
    cp if cp >= 0xA882 && cp <= 0xA8B3 -> True
    cp if cp >= 0xA8B4 && cp <= 0xA8C3 -> True
    cp if cp >= 0xA8CE && cp <= 0xA8CF -> True
    cp if cp >= 0xA8D0 && cp <= 0xA8D9 -> True
    cp if cp >= 0xA8F2 && cp <= 0xA8F7 -> True
    cp if cp >= 0xA8F8 && cp <= 0xA8FA -> True
    cp if cp == 0xA8FB -> True
    cp if cp == 0xA8FC -> True
    cp if cp >= 0xA8FD && cp <= 0xA8FE -> True
    cp if cp >= 0xA900 && cp <= 0xA909 -> True
    cp if cp >= 0xA90A && cp <= 0xA925 -> True
    cp if cp >= 0xA92E && cp <= 0xA92F -> True
    cp if cp >= 0xA930 && cp <= 0xA946 -> True
    cp if cp >= 0xA952 && cp <= 0xA953 -> True
    cp if cp == 0xA95F -> True
    cp if cp >= 0xA960 && cp <= 0xA97C -> True
    cp if cp == 0xA983 -> True
    cp if cp >= 0xA984 && cp <= 0xA9B2 -> True
    cp if cp >= 0xA9B4 && cp <= 0xA9B5 -> True
    cp if cp >= 0xA9BA && cp <= 0xA9BB -> True
    cp if cp >= 0xA9BE && cp <= 0xA9C0 -> True
    cp if cp >= 0xA9C1 && cp <= 0xA9CD -> True
    cp if cp == 0xA9CF -> True
    cp if cp >= 0xA9D0 && cp <= 0xA9D9 -> True
    cp if cp >= 0xA9DE && cp <= 0xA9DF -> True
    cp if cp >= 0xA9E0 && cp <= 0xA9E4 -> True
    cp if cp == 0xA9E6 -> True
    cp if cp >= 0xA9E7 && cp <= 0xA9EF -> True
    cp if cp >= 0xA9F0 && cp <= 0xA9F9 -> True
    cp if cp >= 0xA9FA && cp <= 0xA9FE -> True
    cp if cp >= 0xAA00 && cp <= 0xAA28 -> True
    cp if cp >= 0xAA2F && cp <= 0xAA30 -> True
    cp if cp >= 0xAA33 && cp <= 0xAA34 -> True
    cp if cp >= 0xAA40 && cp <= 0xAA42 -> True
    cp if cp >= 0xAA44 && cp <= 0xAA4B -> True
    cp if cp == 0xAA4D -> True
    cp if cp >= 0xAA50 && cp <= 0xAA59 -> True
    cp if cp >= 0xAA5C && cp <= 0xAA5F -> True
    cp if cp >= 0xAA60 && cp <= 0xAA6F -> True
    cp if cp == 0xAA70 -> True
    cp if cp >= 0xAA71 && cp <= 0xAA76 -> True
    cp if cp >= 0xAA77 && cp <= 0xAA79 -> True
    cp if cp == 0xAA7A -> True
    cp if cp == 0xAA7B -> True
    cp if cp == 0xAA7D -> True
    cp if cp >= 0xAA7E && cp <= 0xAAAF -> True
    cp if cp == 0xAAB1 -> True
    cp if cp >= 0xAAB5 && cp <= 0xAAB6 -> True
    cp if cp >= 0xAAB9 && cp <= 0xAABD -> True
    cp if cp == 0xAAC0 -> True
    cp if cp == 0xAAC2 -> True
    cp if cp >= 0xAADB && cp <= 0xAADC -> True
    cp if cp == 0xAADD -> True
    cp if cp >= 0xAADE && cp <= 0xAADF -> True
    cp if cp >= 0xAAE0 && cp <= 0xAAEA -> True
    cp if cp == 0xAAEB -> True
    cp if cp >= 0xAAEE && cp <= 0xAAEF -> True
    cp if cp >= 0xAAF0 && cp <= 0xAAF1 -> True
    cp if cp == 0xAAF2 -> True
    cp if cp >= 0xAAF3 && cp <= 0xAAF4 -> True
    cp if cp == 0xAAF5 -> True
    cp if cp >= 0xAB01 && cp <= 0xAB06 -> True
    cp if cp >= 0xAB09 && cp <= 0xAB0E -> True
    cp if cp >= 0xAB11 && cp <= 0xAB16 -> True
    cp if cp >= 0xAB20 && cp <= 0xAB26 -> True
    cp if cp >= 0xAB28 && cp <= 0xAB2E -> True
    cp if cp >= 0xAB30 && cp <= 0xAB5A -> True
    cp if cp == 0xAB5B -> True
    cp if cp >= 0xAB5C && cp <= 0xAB5F -> True
    cp if cp >= 0xAB60 && cp <= 0xAB68 -> True
    cp if cp == 0xAB69 -> True
    cp if cp >= 0xAB70 && cp <= 0xABBF -> True
    cp if cp >= 0xABC0 && cp <= 0xABE2 -> True
    cp if cp >= 0xABE3 && cp <= 0xABE4 -> True
    cp if cp >= 0xABE6 && cp <= 0xABE7 -> True
    cp if cp >= 0xABE9 && cp <= 0xABEA -> True
    cp if cp == 0xABEB -> True
    cp if cp == 0xABEC -> True
    cp if cp >= 0xABF0 && cp <= 0xABF9 -> True
    cp if cp >= 0xAC00 && cp <= 0xD7A3 -> True
    cp if cp >= 0xD7B0 && cp <= 0xD7C6 -> True
    cp if cp >= 0xD7CB && cp <= 0xD7FB -> True
    cp if cp >= 0xE000 && cp <= 0xF8FF -> True
    cp if cp >= 0xF900 && cp <= 0xFA6D -> True
    cp if cp >= 0xFA70 && cp <= 0xFAD9 -> True
    cp if cp >= 0xFB00 && cp <= 0xFB06 -> True
    cp if cp >= 0xFB13 && cp <= 0xFB17 -> True
    cp if cp >= 0xFF21 && cp <= 0xFF3A -> True
    cp if cp >= 0xFF41 && cp <= 0xFF5A -> True
    cp if cp >= 0xFF66 && cp <= 0xFF6F -> True
    cp if cp == 0xFF70 -> True
    cp if cp >= 0xFF71 && cp <= 0xFF9D -> True
    cp if cp >= 0xFF9E && cp <= 0xFF9F -> True
    cp if cp >= 0xFFA0 && cp <= 0xFFBE -> True
    cp if cp >= 0xFFC2 && cp <= 0xFFC7 -> True
    cp if cp >= 0xFFCA && cp <= 0xFFCF -> True
    cp if cp >= 0xFFD2 && cp <= 0xFFD7 -> True
    cp if cp >= 0xFFDA && cp <= 0xFFDC -> True
    cp if cp >= 0x10000 && cp <= 0x1000B -> True
    cp if cp >= 0x1000D && cp <= 0x10026 -> True
    cp if cp >= 0x10028 && cp <= 0x1003A -> True
    cp if cp >= 0x1003C && cp <= 0x1003D -> True
    cp if cp >= 0x1003F && cp <= 0x1004D -> True
    cp if cp >= 0x10050 && cp <= 0x1005D -> True
    cp if cp >= 0x10080 && cp <= 0x100FA -> True
    cp if cp == 0x10100 -> True
    cp if cp == 0x10102 -> True
    cp if cp >= 0x10107 && cp <= 0x10133 -> True
    cp if cp >= 0x10137 && cp <= 0x1013F -> True
    cp if cp >= 0x1018D && cp <= 0x1018E -> True
    cp if cp >= 0x101D0 && cp <= 0x101FC -> True
    cp if cp >= 0x10280 && cp <= 0x1029C -> True
    cp if cp >= 0x102A0 && cp <= 0x102D0 -> True
    cp if cp >= 0x10300 && cp <= 0x1031F -> True
    cp if cp >= 0x10320 && cp <= 0x10323 -> True
    cp if cp >= 0x1032D && cp <= 0x10340 -> True
    cp if cp == 0x10341 -> True
    cp if cp >= 0x10342 && cp <= 0x10349 -> True
    cp if cp == 0x1034A -> True
    cp if cp >= 0x10350 && cp <= 0x10375 -> True
    cp if cp >= 0x10380 && cp <= 0x1039D -> True
    cp if cp == 0x1039F -> True
    cp if cp >= 0x103A0 && cp <= 0x103C3 -> True
    cp if cp >= 0x103C8 && cp <= 0x103CF -> True
    cp if cp == 0x103D0 -> True
    cp if cp >= 0x103D1 && cp <= 0x103D5 -> True
    cp if cp >= 0x10400 && cp <= 0x1044F -> True
    cp if cp >= 0x10450 && cp <= 0x1049D -> True
    cp if cp >= 0x104A0 && cp <= 0x104A9 -> True
    cp if cp >= 0x104B0 && cp <= 0x104D3 -> True
    cp if cp >= 0x104D8 && cp <= 0x104FB -> True
    cp if cp >= 0x10500 && cp <= 0x10527 -> True
    cp if cp >= 0x10530 && cp <= 0x10563 -> True
    cp if cp == 0x1056F -> True
    cp if cp >= 0x10570 && cp <= 0x1057A -> True
    cp if cp >= 0x1057C && cp <= 0x1058A -> True
    cp if cp >= 0x1058C && cp <= 0x10592 -> True
    cp if cp >= 0x10594 && cp <= 0x10595 -> True
    cp if cp >= 0x10597 && cp <= 0x105A1 -> True
    cp if cp >= 0x105A3 && cp <= 0x105B1 -> True
    cp if cp >= 0x105B3 && cp <= 0x105B9 -> True
    cp if cp >= 0x105BB && cp <= 0x105BC -> True
    cp if cp >= 0x105C0 && cp <= 0x105F3 -> True
    cp if cp >= 0x10600 && cp <= 0x10736 -> True
    cp if cp >= 0x10740 && cp <= 0x10755 -> True
    cp if cp >= 0x10760 && cp <= 0x10767 -> True
    cp if cp >= 0x10780 && cp <= 0x10785 -> True
    cp if cp >= 0x10787 && cp <= 0x107B0 -> True
    cp if cp >= 0x107B2 && cp <= 0x107BA -> True
    cp if cp == 0x11000 -> True
    cp if cp == 0x11002 -> True
    cp if cp >= 0x11003 && cp <= 0x11037 -> True
    cp if cp >= 0x11047 && cp <= 0x1104D -> True
    cp if cp >= 0x11066 && cp <= 0x1106F -> True
    cp if cp >= 0x11071 && cp <= 0x11072 -> True
    cp if cp == 0x11075 -> True
    cp if cp == 0x11082 -> True
    cp if cp >= 0x11083 && cp <= 0x110AF -> True
    cp if cp >= 0x110B0 && cp <= 0x110B2 -> True
    cp if cp >= 0x110B7 && cp <= 0x110B8 -> True
    cp if cp >= 0x110BB && cp <= 0x110BC -> True
    cp if cp == 0x110BD -> True
    cp if cp >= 0x110BE && cp <= 0x110C1 -> True
    cp if cp == 0x110CD -> True
    cp if cp >= 0x110D0 && cp <= 0x110E8 -> True
    cp if cp >= 0x110F0 && cp <= 0x110F9 -> True
    cp if cp >= 0x11103 && cp <= 0x11126 -> True
    cp if cp == 0x1112C -> True
    cp if cp >= 0x11136 && cp <= 0x1113F -> True
    cp if cp >= 0x11140 && cp <= 0x11143 -> True
    cp if cp == 0x11144 -> True
    cp if cp >= 0x11145 && cp <= 0x11146 -> True
    cp if cp == 0x11147 -> True
    cp if cp >= 0x11150 && cp <= 0x11172 -> True
    cp if cp >= 0x11174 && cp <= 0x11175 -> True
    cp if cp == 0x11176 -> True
    cp if cp == 0x11182 -> True
    cp if cp >= 0x11183 && cp <= 0x111B2 -> True
    cp if cp >= 0x111B3 && cp <= 0x111B5 -> True
    cp if cp >= 0x111BF && cp <= 0x111C0 -> True
    cp if cp >= 0x111C1 && cp <= 0x111C4 -> True
    cp if cp >= 0x111C5 && cp <= 0x111C8 -> True
    cp if cp == 0x111CD -> True
    cp if cp == 0x111CE -> True
    cp if cp >= 0x111D0 && cp <= 0x111D9 -> True
    cp if cp == 0x111DA -> True
    cp if cp == 0x111DB -> True
    cp if cp == 0x111DC -> True
    cp if cp >= 0x111DD && cp <= 0x111DF -> True
    cp if cp >= 0x111E1 && cp <= 0x111F4 -> True
    cp if cp >= 0x11200 && cp <= 0x11211 -> True
    cp if cp >= 0x11213 && cp <= 0x1122B -> True
    cp if cp >= 0x1122C && cp <= 0x1122E -> True
    cp if cp >= 0x11232 && cp <= 0x11233 -> True
    cp if cp == 0x11235 -> True
    cp if cp >= 0x11238 && cp <= 0x1123D -> True
    cp if cp >= 0x1123F && cp <= 0x11240 -> True
    cp if cp >= 0x11280 && cp <= 0x11286 -> True
    cp if cp == 0x11288 -> True
    cp if cp >= 0x1128A && cp <= 0x1128D -> True
    cp if cp >= 0x1128F && cp <= 0x1129D -> True
    cp if cp >= 0x1129F && cp <= 0x112A8 -> True
    cp if cp == 0x112A9 -> True
    cp if cp >= 0x112B0 && cp <= 0x112DE -> True
    cp if cp >= 0x112E0 && cp <= 0x112E2 -> True
    cp if cp >= 0x112F0 && cp <= 0x112F9 -> True
    cp if cp >= 0x11302 && cp <= 0x11303 -> True
    cp if cp >= 0x11305 && cp <= 0x1130C -> True
    cp if cp >= 0x1130F && cp <= 0x11310 -> True
    cp if cp >= 0x11313 && cp <= 0x11328 -> True
    cp if cp >= 0x1132A && cp <= 0x11330 -> True
    cp if cp >= 0x11332 && cp <= 0x11333 -> True
    cp if cp >= 0x11335 && cp <= 0x11339 -> True
    cp if cp == 0x1133D -> True
    cp if cp >= 0x1133E && cp <= 0x1133F -> True
    cp if cp >= 0x11341 && cp <= 0x11344 -> True
    cp if cp >= 0x11347 && cp <= 0x11348 -> True
    cp if cp >= 0x1134B && cp <= 0x1134D -> True
    cp if cp == 0x11350 -> True
    cp if cp == 0x11357 -> True
    cp if cp >= 0x1135D && cp <= 0x11361 -> True
    cp if cp >= 0x11362 && cp <= 0x11363 -> True
    cp if cp >= 0x11380 && cp <= 0x11389 -> True
    cp if cp == 0x1138B -> True
    cp if cp == 0x1138E -> True
    cp if cp >= 0x11390 && cp <= 0x113B5 -> True
    cp if cp == 0x113B7 -> True
    cp if cp >= 0x113B8 && cp <= 0x113BA -> True
    cp if cp == 0x113C2 -> True
    cp if cp == 0x113C5 -> True
    cp if cp >= 0x113C7 && cp <= 0x113CA -> True
    cp if cp >= 0x113CC && cp <= 0x113CD -> True
    cp if cp == 0x113CF -> True
    cp if cp == 0x113D1 -> True
    cp if cp == 0x113D3 -> True
    cp if cp >= 0x113D4 && cp <= 0x113D5 -> True
    cp if cp >= 0x113D7 && cp <= 0x113D8 -> True
    cp if cp >= 0x11400 && cp <= 0x11434 -> True
    cp if cp >= 0x11435 && cp <= 0x11437 -> True
    cp if cp >= 0x11440 && cp <= 0x11441 -> True
    cp if cp == 0x11445 -> True
    cp if cp >= 0x11447 && cp <= 0x1144A -> True
    cp if cp >= 0x1144B && cp <= 0x1144F -> True
    cp if cp >= 0x11450 && cp <= 0x11459 -> True
    cp if cp >= 0x1145A && cp <= 0x1145B -> True
    cp if cp == 0x1145D -> True
    cp if cp >= 0x1145F && cp <= 0x11461 -> True
    cp if cp >= 0x11480 && cp <= 0x114AF -> True
    cp if cp >= 0x114B0 && cp <= 0x114B2 -> True
    cp if cp == 0x114B9 -> True
    cp if cp >= 0x114BB && cp <= 0x114BE -> True
    cp if cp == 0x114C1 -> True
    cp if cp >= 0x114C4 && cp <= 0x114C5 -> True
    cp if cp == 0x114C6 -> True
    cp if cp == 0x114C7 -> True
    cp if cp >= 0x114D0 && cp <= 0x114D9 -> True
    cp if cp >= 0x11580 && cp <= 0x115AE -> True
    cp if cp >= 0x115AF && cp <= 0x115B1 -> True
    cp if cp >= 0x115B8 && cp <= 0x115BB -> True
    cp if cp == 0x115BE -> True
    cp if cp >= 0x115C1 && cp <= 0x115D7 -> True
    cp if cp >= 0x115D8 && cp <= 0x115DB -> True
    cp if cp >= 0x11600 && cp <= 0x1162F -> True
    cp if cp >= 0x11630 && cp <= 0x11632 -> True
    cp if cp >= 0x1163B && cp <= 0x1163C -> True
    cp if cp == 0x1163E -> True
    cp if cp >= 0x11641 && cp <= 0x11643 -> True
    cp if cp == 0x11644 -> True
    cp if cp >= 0x11650 && cp <= 0x11659 -> True
    cp if cp >= 0x11680 && cp <= 0x116AA -> True
    cp if cp == 0x116AC -> True
    cp if cp >= 0x116AE && cp <= 0x116AF -> True
    cp if cp == 0x116B6 -> True
    cp if cp == 0x116B8 -> True
    cp if cp == 0x116B9 -> True
    cp if cp >= 0x116C0 && cp <= 0x116C9 -> True
    cp if cp >= 0x116D0 && cp <= 0x116E3 -> True
    cp if cp >= 0x11700 && cp <= 0x1171A -> True
    cp if cp == 0x1171E -> True
    cp if cp >= 0x11720 && cp <= 0x11721 -> True
    cp if cp == 0x11726 -> True
    cp if cp >= 0x11730 && cp <= 0x11739 -> True
    cp if cp >= 0x1173A && cp <= 0x1173B -> True
    cp if cp >= 0x1173C && cp <= 0x1173E -> True
    cp if cp == 0x1173F -> True
    cp if cp >= 0x11740 && cp <= 0x11746 -> True
    cp if cp >= 0x11800 && cp <= 0x1182B -> True
    cp if cp >= 0x1182C && cp <= 0x1182E -> True
    cp if cp == 0x11838 -> True
    cp if cp == 0x1183B -> True
    cp if cp >= 0x118A0 && cp <= 0x118DF -> True
    cp if cp >= 0x118E0 && cp <= 0x118E9 -> True
    cp if cp >= 0x118EA && cp <= 0x118F2 -> True
    cp if cp >= 0x118FF && cp <= 0x11906 -> True
    cp if cp == 0x11909 -> True
    cp if cp >= 0x1190C && cp <= 0x11913 -> True
    cp if cp >= 0x11915 && cp <= 0x11916 -> True
    cp if cp >= 0x11918 && cp <= 0x1192F -> True
    cp if cp >= 0x11930 && cp <= 0x11935 -> True
    cp if cp >= 0x11937 && cp <= 0x11938 -> True
    cp if cp == 0x1193D -> True
    cp if cp == 0x1193F -> True
    cp if cp == 0x11940 -> True
    cp if cp == 0x11941 -> True
    cp if cp == 0x11942 -> True
    cp if cp >= 0x11944 && cp <= 0x11946 -> True
    cp if cp >= 0x11950 && cp <= 0x11959 -> True
    cp if cp >= 0x119A0 && cp <= 0x119A7 -> True
    cp if cp >= 0x119AA && cp <= 0x119D0 -> True
    cp if cp >= 0x119D1 && cp <= 0x119D3 -> True
    cp if cp >= 0x119DC && cp <= 0x119DF -> True
    cp if cp == 0x119E1 -> True
    cp if cp == 0x119E2 -> True
    cp if cp == 0x119E3 -> True
    cp if cp == 0x119E4 -> True
    cp if cp == 0x11A00 -> True
    cp if cp >= 0x11A07 && cp <= 0x11A08 -> True
    cp if cp >= 0x11A0B && cp <= 0x11A32 -> True
    cp if cp == 0x11A39 -> True
    cp if cp == 0x11A3A -> True
    cp if cp >= 0x11A3F && cp <= 0x11A46 -> True
    cp if cp == 0x11A50 -> True
    cp if cp >= 0x11A57 && cp <= 0x11A58 -> True
    cp if cp >= 0x11A5C && cp <= 0x11A89 -> True
    cp if cp == 0x11A97 -> True
    cp if cp >= 0x11A9A && cp <= 0x11A9C -> True
    cp if cp == 0x11A9D -> True
    cp if cp >= 0x11A9E && cp <= 0x11AA2 -> True
    cp if cp >= 0x11AB0 && cp <= 0x11AF8 -> True
    cp if cp >= 0x11B00 && cp <= 0x11B09 -> True
    cp if cp >= 0x11BC0 && cp <= 0x11BE0 -> True
    cp if cp == 0x11BE1 -> True
    cp if cp >= 0x11BF0 && cp <= 0x11BF9 -> True
    cp if cp >= 0x11C00 && cp <= 0x11C08 -> True
    cp if cp >= 0x11C0A && cp <= 0x11C2E -> True
    cp if cp == 0x11C2F -> True
    cp if cp == 0x11C3E -> True
    cp if cp == 0x11C3F -> True
    cp if cp == 0x11C40 -> True
    cp if cp >= 0x11C41 && cp <= 0x11C45 -> True
    cp if cp >= 0x11C50 && cp <= 0x11C59 -> True
    cp if cp >= 0x11C5A && cp <= 0x11C6C -> True
    cp if cp >= 0x11C70 && cp <= 0x11C71 -> True
    cp if cp >= 0x11C72 && cp <= 0x11C8F -> True
    cp if cp == 0x11CA9 -> True
    cp if cp == 0x11CB1 -> True
    cp if cp == 0x11CB4 -> True
    cp if cp >= 0x11D00 && cp <= 0x11D06 -> True
    cp if cp >= 0x11D08 && cp <= 0x11D09 -> True
    cp if cp >= 0x11D0B && cp <= 0x11D30 -> True
    cp if cp == 0x11D46 -> True
    cp if cp >= 0x11D50 && cp <= 0x11D59 -> True
    cp if cp >= 0x11D60 && cp <= 0x11D65 -> True
    cp if cp >= 0x11D67 && cp <= 0x11D68 -> True
    cp if cp >= 0x11D6A && cp <= 0x11D89 -> True
    cp if cp >= 0x11D8A && cp <= 0x11D8E -> True
    cp if cp >= 0x11D93 && cp <= 0x11D94 -> True
    cp if cp == 0x11D96 -> True
    cp if cp == 0x11D98 -> True
    cp if cp >= 0x11DA0 && cp <= 0x11DA9 -> True
    cp if cp >= 0x11EE0 && cp <= 0x11EF2 -> True
    cp if cp >= 0x11EF5 && cp <= 0x11EF6 -> True
    cp if cp >= 0x11EF7 && cp <= 0x11EF8 -> True
    cp if cp == 0x11F02 -> True
    cp if cp == 0x11F03 -> True
    cp if cp >= 0x11F04 && cp <= 0x11F10 -> True
    cp if cp >= 0x11F12 && cp <= 0x11F33 -> True
    cp if cp >= 0x11F34 && cp <= 0x11F35 -> True
    cp if cp >= 0x11F3E && cp <= 0x11F3F -> True
    cp if cp == 0x11F41 -> True
    cp if cp >= 0x11F43 && cp <= 0x11F4F -> True
    cp if cp >= 0x11F50 && cp <= 0x11F59 -> True
    cp if cp == 0x11FB0 -> True
    cp if cp >= 0x11FC0 && cp <= 0x11FD4 -> True
    cp if cp == 0x11FFF -> True
    cp if cp >= 0x12000 && cp <= 0x12399 -> True
    cp if cp >= 0x12400 && cp <= 0x1246E -> True
    cp if cp >= 0x12470 && cp <= 0x12474 -> True
    cp if cp >= 0x12480 && cp <= 0x12543 -> True
    cp if cp >= 0x12F90 && cp <= 0x12FF0 -> True
    cp if cp >= 0x12FF1 && cp <= 0x12FF2 -> True
    cp if cp >= 0x13000 && cp <= 0x1342F -> True
    cp if cp >= 0x13430 && cp <= 0x1343F -> True
    cp if cp >= 0x13441 && cp <= 0x13446 -> True
    cp if cp >= 0x13460 && cp <= 0x143FA -> True
    cp if cp >= 0x14400 && cp <= 0x14646 -> True
    cp if cp >= 0x16100 && cp <= 0x1611D -> True
    cp if cp >= 0x1612A && cp <= 0x1612C -> True
    cp if cp >= 0x16130 && cp <= 0x16139 -> True
    cp if cp >= 0x16800 && cp <= 0x16A38 -> True
    cp if cp >= 0x16A40 && cp <= 0x16A5E -> True
    cp if cp >= 0x16A60 && cp <= 0x16A69 -> True
    cp if cp >= 0x16A6E && cp <= 0x16A6F -> True
    cp if cp >= 0x16A70 && cp <= 0x16ABE -> True
    cp if cp >= 0x16AC0 && cp <= 0x16AC9 -> True
    cp if cp >= 0x16AD0 && cp <= 0x16AED -> True
    cp if cp == 0x16AF5 -> True
    cp if cp >= 0x16B00 && cp <= 0x16B2F -> True
    cp if cp >= 0x16B37 && cp <= 0x16B3B -> True
    cp if cp >= 0x16B3C && cp <= 0x16B3F -> True
    cp if cp >= 0x16B40 && cp <= 0x16B43 -> True
    cp if cp == 0x16B44 -> True
    cp if cp == 0x16B45 -> True
    cp if cp >= 0x16B50 && cp <= 0x16B59 -> True
    cp if cp >= 0x16B5B && cp <= 0x16B61 -> True
    cp if cp >= 0x16B63 && cp <= 0x16B77 -> True
    cp if cp >= 0x16B7D && cp <= 0x16B8F -> True
    cp if cp >= 0x16D40 && cp <= 0x16D42 -> True
    cp if cp >= 0x16D43 && cp <= 0x16D6A -> True
    cp if cp >= 0x16D6B && cp <= 0x16D6C -> True
    cp if cp >= 0x16D6D && cp <= 0x16D6F -> True
    cp if cp >= 0x16D70 && cp <= 0x16D79 -> True
    cp if cp >= 0x16E40 && cp <= 0x16E7F -> True
    cp if cp >= 0x16E80 && cp <= 0x16E96 -> True
    cp if cp >= 0x16E97 && cp <= 0x16E9A -> True
    cp if cp >= 0x16F00 && cp <= 0x16F4A -> True
    cp if cp == 0x16F50 -> True
    cp if cp >= 0x16F51 && cp <= 0x16F87 -> True
    cp if cp >= 0x16F93 && cp <= 0x16F9F -> True
    cp if cp >= 0x16FE0 && cp <= 0x16FE1 -> True
    cp if cp == 0x16FE3 -> True
    cp if cp >= 0x16FF0 && cp <= 0x16FF1 -> True
    cp if cp >= 0x17000 && cp <= 0x187F7 -> True
    cp if cp >= 0x18800 && cp <= 0x18CD5 -> True
    cp if cp >= 0x18CFF && cp <= 0x18D08 -> True
    cp if cp >= 0x1AFF0 && cp <= 0x1AFF3 -> True
    cp if cp >= 0x1AFF5 && cp <= 0x1AFFB -> True
    cp if cp >= 0x1AFFD && cp <= 0x1AFFE -> True
    cp if cp >= 0x1B000 && cp <= 0x1B122 -> True
    cp if cp == 0x1B132 -> True
    cp if cp >= 0x1B150 && cp <= 0x1B152 -> True
    cp if cp == 0x1B155 -> True
    cp if cp >= 0x1B164 && cp <= 0x1B167 -> True
    cp if cp >= 0x1B170 && cp <= 0x1B2FB -> True
    cp if cp >= 0x1BC00 && cp <= 0x1BC6A -> True
    cp if cp >= 0x1BC70 && cp <= 0x1BC7C -> True
    cp if cp >= 0x1BC80 && cp <= 0x1BC88 -> True
    cp if cp >= 0x1BC90 && cp <= 0x1BC99 -> True
    cp if cp == 0x1BC9C -> True
    cp if cp == 0x1BC9F -> True
    cp if cp >= 0x1CCD6 && cp <= 0x1CCEF -> True
    cp if cp >= 0x1CF50 && cp <= 0x1CFC3 -> True
    cp if cp >= 0x1D000 && cp <= 0x1D0F5 -> True
    cp if cp >= 0x1D100 && cp <= 0x1D126 -> True
    cp if cp >= 0x1D129 && cp <= 0x1D164 -> True
    cp if cp >= 0x1D165 && cp <= 0x1D166 -> True
    cp if cp >= 0x1D16A && cp <= 0x1D16C -> True
    cp if cp >= 0x1D16D && cp <= 0x1D172 -> True
    cp if cp >= 0x1D183 && cp <= 0x1D184 -> True
    cp if cp >= 0x1D18C && cp <= 0x1D1A9 -> True
    cp if cp >= 0x1D1AE && cp <= 0x1D1E8 -> True
    cp if cp >= 0x1D2C0 && cp <= 0x1D2D3 -> True
    cp if cp >= 0x1D2E0 && cp <= 0x1D2F3 -> True
    cp if cp >= 0x1D360 && cp <= 0x1D378 -> True
    cp if cp >= 0x1D400 && cp <= 0x1D454 -> True
    cp if cp >= 0x1D456 && cp <= 0x1D49C -> True
    cp if cp >= 0x1D49E && cp <= 0x1D49F -> True
    cp if cp == 0x1D4A2 -> True
    cp if cp >= 0x1D4A5 && cp <= 0x1D4A6 -> True
    cp if cp >= 0x1D4A9 && cp <= 0x1D4AC -> True
    cp if cp >= 0x1D4AE && cp <= 0x1D4B9 -> True
    cp if cp == 0x1D4BB -> True
    cp if cp >= 0x1D4BD && cp <= 0x1D4C3 -> True
    cp if cp >= 0x1D4C5 && cp <= 0x1D505 -> True
    cp if cp >= 0x1D507 && cp <= 0x1D50A -> True
    cp if cp >= 0x1D50D && cp <= 0x1D514 -> True
    cp if cp >= 0x1D516 && cp <= 0x1D51C -> True
    cp if cp >= 0x1D51E && cp <= 0x1D539 -> True
    cp if cp >= 0x1D53B && cp <= 0x1D53E -> True
    cp if cp >= 0x1D540 && cp <= 0x1D544 -> True
    cp if cp == 0x1D546 -> True
    cp if cp >= 0x1D54A && cp <= 0x1D550 -> True
    cp if cp >= 0x1D552 && cp <= 0x1D6A5 -> True
    cp if cp >= 0x1D6A8 && cp <= 0x1D6C0 -> True
    cp if cp >= 0x1D6C2 && cp <= 0x1D6DA -> True
    cp if cp >= 0x1D6DC && cp <= 0x1D6FA -> True
    cp if cp >= 0x1D6FC && cp <= 0x1D714 -> True
    cp if cp >= 0x1D716 && cp <= 0x1D734 -> True
    cp if cp >= 0x1D736 && cp <= 0x1D74E -> True
    cp if cp >= 0x1D750 && cp <= 0x1D76E -> True
    cp if cp >= 0x1D770 && cp <= 0x1D788 -> True
    cp if cp >= 0x1D78A && cp <= 0x1D7A8 -> True
    cp if cp >= 0x1D7AA && cp <= 0x1D7C2 -> True
    cp if cp >= 0x1D7C4 && cp <= 0x1D7CB -> True
    cp if cp >= 0x1D800 && cp <= 0x1D9FF -> True
    cp if cp >= 0x1DA37 && cp <= 0x1DA3A -> True
    cp if cp >= 0x1DA6D && cp <= 0x1DA74 -> True
    cp if cp >= 0x1DA76 && cp <= 0x1DA83 -> True
    cp if cp >= 0x1DA85 && cp <= 0x1DA86 -> True
    cp if cp >= 0x1DA87 && cp <= 0x1DA8B -> True
    cp if cp >= 0x1DF00 && cp <= 0x1DF09 -> True
    cp if cp == 0x1DF0A -> True
    cp if cp >= 0x1DF0B && cp <= 0x1DF1E -> True
    cp if cp >= 0x1DF25 && cp <= 0x1DF2A -> True
    cp if cp >= 0x1E030 && cp <= 0x1E06D -> True
    cp if cp >= 0x1E100 && cp <= 0x1E12C -> True
    cp if cp >= 0x1E137 && cp <= 0x1E13D -> True
    cp if cp >= 0x1E140 && cp <= 0x1E149 -> True
    cp if cp == 0x1E14E -> True
    cp if cp == 0x1E14F -> True
    cp if cp >= 0x1E290 && cp <= 0x1E2AD -> True
    cp if cp >= 0x1E2C0 && cp <= 0x1E2EB -> True
    cp if cp >= 0x1E2F0 && cp <= 0x1E2F9 -> True
    cp if cp >= 0x1E4D0 && cp <= 0x1E4EA -> True
    cp if cp == 0x1E4EB -> True
    cp if cp >= 0x1E4F0 && cp <= 0x1E4F9 -> True
    cp if cp >= 0x1E5D0 && cp <= 0x1E5ED -> True
    cp if cp == 0x1E5F0 -> True
    cp if cp >= 0x1E5F1 && cp <= 0x1E5FA -> True
    cp if cp == 0x1E5FF -> True
    cp if cp >= 0x1E7E0 && cp <= 0x1E7E6 -> True
    cp if cp >= 0x1E7E8 && cp <= 0x1E7EB -> True
    cp if cp >= 0x1E7ED && cp <= 0x1E7EE -> True
    cp if cp >= 0x1E7F0 && cp <= 0x1E7FE -> True
    cp if cp >= 0x1F110 && cp <= 0x1F12E -> True
    cp if cp >= 0x1F130 && cp <= 0x1F169 -> True
    cp if cp >= 0x1F170 && cp <= 0x1F1AC -> True
    cp if cp >= 0x1F1E6 && cp <= 0x1F202 -> True
    cp if cp >= 0x1F210 && cp <= 0x1F23B -> True
    cp if cp >= 0x1F240 && cp <= 0x1F248 -> True
    cp if cp >= 0x1F250 && cp <= 0x1F251 -> True
    cp if cp >= 0x20000 && cp <= 0x2A6DF -> True
    cp if cp >= 0x2A700 && cp <= 0x2B739 -> True
    cp if cp >= 0x2B740 && cp <= 0x2B81D -> True
    cp if cp >= 0x2B820 && cp <= 0x2CEA1 -> True
    cp if cp >= 0x2CEB0 && cp <= 0x2EBE0 -> True
    cp if cp >= 0x2EBF0 && cp <= 0x2EE5D -> True
    cp if cp >= 0x2F800 && cp <= 0x2FA1D -> True
    cp if cp >= 0x30000 && cp <= 0x3134A -> True
    cp if cp >= 0x31350 && cp <= 0x323AF -> True
    cp if cp >= 0xF0000 && cp <= 0xFFFFD -> True
    _ -> False
  }
}

pub fn in_left_to_right_last(codepoint: Int) -> Bool {
  case codepoint {
    cp if cp >= 0x0041 && cp <= 0x005A -> True
    cp if cp >= 0x0061 && cp <= 0x007A -> True
    cp if cp == 0x00AA -> True
    cp if cp == 0x00B5 -> True
    cp if cp == 0x00BA -> True
    cp if cp >= 0x00C0 && cp <= 0x00D6 -> True
    cp if cp >= 0x00D8 && cp <= 0x00F6 -> True
    cp if cp >= 0x00F8 && cp <= 0x01BA -> True
    cp if cp == 0x01BB -> True
    cp if cp >= 0x01BC && cp <= 0x01BF -> True
    cp if cp >= 0x01C0 && cp <= 0x01C3 -> True
    cp if cp >= 0x01C4 && cp <= 0x0293 -> True
    cp if cp == 0x0294 -> True
    cp if cp >= 0x0295 && cp <= 0x02AF -> True
    cp if cp >= 0x02B0 && cp <= 0x02B8 -> True
    cp if cp >= 0x02BB && cp <= 0x02C1 -> True
    cp if cp >= 0x02D0 && cp <= 0x02D1 -> True
    cp if cp >= 0x02E0 && cp <= 0x02E4 -> True
    cp if cp == 0x02EE -> True
    cp if cp >= 0x0370 && cp <= 0x0373 -> True
    cp if cp >= 0x0376 && cp <= 0x0377 -> True
    cp if cp == 0x037A -> True
    cp if cp >= 0x037B && cp <= 0x037D -> True
    cp if cp == 0x037F -> True
    cp if cp == 0x0386 -> True
    cp if cp >= 0x0388 && cp <= 0x038A -> True
    cp if cp == 0x038C -> True
    cp if cp >= 0x038E && cp <= 0x03A1 -> True
    cp if cp >= 0x03A3 && cp <= 0x03F5 -> True
    cp if cp >= 0x03F7 && cp <= 0x0481 -> True
    cp if cp == 0x0482 -> True
    cp if cp >= 0x048A && cp <= 0x052F -> True
    cp if cp >= 0x0531 && cp <= 0x0556 -> True
    cp if cp == 0x0559 -> True
    cp if cp >= 0x055A && cp <= 0x055F -> True
    cp if cp >= 0x0560 && cp <= 0x0588 -> True
    cp if cp == 0x0589 -> True
    cp if cp == 0x0903 -> True
    cp if cp >= 0x0904 && cp <= 0x0939 -> True
    cp if cp == 0x093B -> True
    cp if cp == 0x093D -> True
    cp if cp >= 0x093E && cp <= 0x0940 -> True
    cp if cp >= 0x0949 && cp <= 0x094C -> True
    cp if cp >= 0x094E && cp <= 0x094F -> True
    cp if cp == 0x0950 -> True
    cp if cp >= 0x0958 && cp <= 0x0961 -> True
    cp if cp >= 0x0964 && cp <= 0x0965 -> True
    cp if cp >= 0x0966 && cp <= 0x096F -> True
    cp if cp == 0x0970 -> True
    cp if cp == 0x0971 -> True
    cp if cp >= 0x0972 && cp <= 0x0980 -> True
    cp if cp >= 0x0982 && cp <= 0x0983 -> True
    cp if cp >= 0x0985 && cp <= 0x098C -> True
    cp if cp >= 0x098F && cp <= 0x0990 -> True
    cp if cp >= 0x0993 && cp <= 0x09A8 -> True
    cp if cp >= 0x09AA && cp <= 0x09B0 -> True
    cp if cp == 0x09B2 -> True
    cp if cp >= 0x09B6 && cp <= 0x09B9 -> True
    cp if cp == 0x09BD -> True
    cp if cp >= 0x09BE && cp <= 0x09C0 -> True
    cp if cp >= 0x09C7 && cp <= 0x09C8 -> True
    cp if cp >= 0x09CB && cp <= 0x09CC -> True
    cp if cp == 0x09CE -> True
    cp if cp == 0x09D7 -> True
    cp if cp >= 0x09DC && cp <= 0x09DD -> True
    cp if cp >= 0x09DF && cp <= 0x09E1 -> True
    cp if cp >= 0x09E6 && cp <= 0x09EF -> True
    cp if cp >= 0x09F0 && cp <= 0x09F1 -> True
    cp if cp >= 0x09F4 && cp <= 0x09F9 -> True
    cp if cp == 0x09FA -> True
    cp if cp == 0x09FC -> True
    cp if cp == 0x09FD -> True
    cp if cp == 0x0A03 -> True
    cp if cp >= 0x0A05 && cp <= 0x0A0A -> True
    cp if cp >= 0x0A0F && cp <= 0x0A10 -> True
    cp if cp >= 0x0A13 && cp <= 0x0A28 -> True
    cp if cp >= 0x0A2A && cp <= 0x0A30 -> True
    cp if cp >= 0x0A32 && cp <= 0x0A33 -> True
    cp if cp >= 0x0A35 && cp <= 0x0A36 -> True
    cp if cp >= 0x0A38 && cp <= 0x0A39 -> True
    cp if cp >= 0x0A3E && cp <= 0x0A40 -> True
    cp if cp >= 0x0A59 && cp <= 0x0A5C -> True
    cp if cp == 0x0A5E -> True
    cp if cp >= 0x0A66 && cp <= 0x0A6F -> True
    cp if cp >= 0x0A72 && cp <= 0x0A74 -> True
    cp if cp == 0x0A76 -> True
    cp if cp == 0x0A83 -> True
    cp if cp >= 0x0A85 && cp <= 0x0A8D -> True
    cp if cp >= 0x0A8F && cp <= 0x0A91 -> True
    cp if cp >= 0x0A93 && cp <= 0x0AA8 -> True
    cp if cp >= 0x0AAA && cp <= 0x0AB0 -> True
    cp if cp >= 0x0AB2 && cp <= 0x0AB3 -> True
    cp if cp >= 0x0AB5 && cp <= 0x0AB9 -> True
    cp if cp == 0x0ABD -> True
    cp if cp >= 0x0ABE && cp <= 0x0AC0 -> True
    cp if cp == 0x0AC9 -> True
    cp if cp >= 0x0ACB && cp <= 0x0ACC -> True
    cp if cp == 0x0AD0 -> True
    cp if cp >= 0x0AE0 && cp <= 0x0AE1 -> True
    cp if cp >= 0x0AE6 && cp <= 0x0AEF -> True
    cp if cp == 0x0AF0 -> True
    cp if cp == 0x0AF9 -> True
    cp if cp >= 0x0B02 && cp <= 0x0B03 -> True
    cp if cp >= 0x0B05 && cp <= 0x0B0C -> True
    cp if cp >= 0x0B0F && cp <= 0x0B10 -> True
    cp if cp >= 0x0B13 && cp <= 0x0B28 -> True
    cp if cp >= 0x0B2A && cp <= 0x0B30 -> True
    cp if cp >= 0x0B32 && cp <= 0x0B33 -> True
    cp if cp >= 0x0B35 && cp <= 0x0B39 -> True
    cp if cp == 0x0B3D -> True
    cp if cp == 0x0B3E -> True
    cp if cp == 0x0B40 -> True
    cp if cp >= 0x0B47 && cp <= 0x0B48 -> True
    cp if cp >= 0x0B4B && cp <= 0x0B4C -> True
    cp if cp == 0x0B57 -> True
    cp if cp >= 0x0B5C && cp <= 0x0B5D -> True
    cp if cp >= 0x0B5F && cp <= 0x0B61 -> True
    cp if cp >= 0x0B66 && cp <= 0x0B6F -> True
    cp if cp == 0x0B70 -> True
    cp if cp == 0x0B71 -> True
    cp if cp >= 0x0B72 && cp <= 0x0B77 -> True
    cp if cp == 0x0B83 -> True
    cp if cp >= 0x0B85 && cp <= 0x0B8A -> True
    cp if cp >= 0x0B8E && cp <= 0x0B90 -> True
    cp if cp >= 0x0B92 && cp <= 0x0B95 -> True
    cp if cp >= 0x0B99 && cp <= 0x0B9A -> True
    cp if cp == 0x0B9C -> True
    cp if cp >= 0x0B9E && cp <= 0x0B9F -> True
    cp if cp >= 0x0BA3 && cp <= 0x0BA4 -> True
    cp if cp >= 0x0BA8 && cp <= 0x0BAA -> True
    cp if cp >= 0x0BAE && cp <= 0x0BB9 -> True
    cp if cp >= 0x0BBE && cp <= 0x0BBF -> True
    cp if cp >= 0x0BC1 && cp <= 0x0BC2 -> True
    cp if cp >= 0x0BC6 && cp <= 0x0BC8 -> True
    cp if cp >= 0x0BCA && cp <= 0x0BCC -> True
    cp if cp == 0x0BD0 -> True
    cp if cp == 0x0BD7 -> True
    cp if cp >= 0x0BE6 && cp <= 0x0BEF -> True
    cp if cp >= 0x0BF0 && cp <= 0x0BF2 -> True
    cp if cp >= 0x0C01 && cp <= 0x0C03 -> True
    cp if cp >= 0x0C05 && cp <= 0x0C0C -> True
    cp if cp >= 0x0C0E && cp <= 0x0C10 -> True
    cp if cp >= 0x0C12 && cp <= 0x0C28 -> True
    cp if cp >= 0x0C2A && cp <= 0x0C39 -> True
    cp if cp == 0x0C3D -> True
    cp if cp >= 0x0C41 && cp <= 0x0C44 -> True
    cp if cp >= 0x0C58 && cp <= 0x0C5A -> True
    cp if cp == 0x0C5D -> True
    cp if cp >= 0x0C60 && cp <= 0x0C61 -> True
    cp if cp >= 0x0C66 && cp <= 0x0C6F -> True
    cp if cp == 0x0C77 -> True
    cp if cp == 0x0C7F -> True
    cp if cp == 0x0C80 -> True
    cp if cp >= 0x0C82 && cp <= 0x0C83 -> True
    cp if cp == 0x0C84 -> True
    cp if cp >= 0x0C85 && cp <= 0x0C8C -> True
    cp if cp >= 0x0C8E && cp <= 0x0C90 -> True
    cp if cp >= 0x0C92 && cp <= 0x0CA8 -> True
    cp if cp >= 0x0CAA && cp <= 0x0CB3 -> True
    cp if cp >= 0x0CB5 && cp <= 0x0CB9 -> True
    cp if cp == 0x0CBD -> True
    cp if cp == 0x0CBE -> True
    cp if cp == 0x0CBF -> True
    cp if cp >= 0x0CC0 && cp <= 0x0CC4 -> True
    cp if cp == 0x0CC6 -> True
    cp if cp >= 0x0CC7 && cp <= 0x0CC8 -> True
    cp if cp >= 0x0CCA && cp <= 0x0CCB -> True
    cp if cp >= 0x0CD5 && cp <= 0x0CD6 -> True
    cp if cp >= 0x0CDD && cp <= 0x0CDE -> True
    cp if cp >= 0x0CE0 && cp <= 0x0CE1 -> True
    cp if cp >= 0x0CE6 && cp <= 0x0CEF -> True
    cp if cp >= 0x0CF1 && cp <= 0x0CF2 -> True
    cp if cp == 0x0CF3 -> True
    cp if cp >= 0x0D02 && cp <= 0x0D03 -> True
    cp if cp >= 0x0D04 && cp <= 0x0D0C -> True
    cp if cp >= 0x0D0E && cp <= 0x0D10 -> True
    cp if cp >= 0x0D12 && cp <= 0x0D3A -> True
    cp if cp == 0x0D3D -> True
    cp if cp >= 0x0D3E && cp <= 0x0D40 -> True
    cp if cp >= 0x0D46 && cp <= 0x0D48 -> True
    cp if cp >= 0x0D4A && cp <= 0x0D4C -> True
    cp if cp == 0x0D4E -> True
    cp if cp == 0x0D4F -> True
    cp if cp >= 0x0D54 && cp <= 0x0D56 -> True
    cp if cp == 0x0D57 -> True
    cp if cp >= 0x0D58 && cp <= 0x0D5E -> True
    cp if cp >= 0x0D5F && cp <= 0x0D61 -> True
    cp if cp >= 0x0D66 && cp <= 0x0D6F -> True
    cp if cp >= 0x0D70 && cp <= 0x0D78 -> True
    cp if cp == 0x0D79 -> True
    cp if cp >= 0x0D7A && cp <= 0x0D7F -> True
    cp if cp >= 0x0D82 && cp <= 0x0D83 -> True
    cp if cp >= 0x0D85 && cp <= 0x0D96 -> True
    cp if cp >= 0x0D9A && cp <= 0x0DB1 -> True
    cp if cp >= 0x0DB3 && cp <= 0x0DBB -> True
    cp if cp == 0x0DBD -> True
    cp if cp >= 0x0DC0 && cp <= 0x0DC6 -> True
    cp if cp >= 0x0DCF && cp <= 0x0DD1 -> True
    cp if cp >= 0x0DD8 && cp <= 0x0DDF -> True
    cp if cp >= 0x0DE6 && cp <= 0x0DEF -> True
    cp if cp >= 0x0DF2 && cp <= 0x0DF3 -> True
    cp if cp == 0x0DF4 -> True
    cp if cp >= 0x0E01 && cp <= 0x0E30 -> True
    cp if cp >= 0x0E32 && cp <= 0x0E33 -> True
    cp if cp >= 0x0E40 && cp <= 0x0E45 -> True
    cp if cp == 0x0E46 -> True
    cp if cp == 0x0E4F -> True
    cp if cp >= 0x0E50 && cp <= 0x0E59 -> True
    cp if cp >= 0x0E5A && cp <= 0x0E5B -> True
    cp if cp >= 0x0E81 && cp <= 0x0E82 -> True
    cp if cp == 0x0E84 -> True
    cp if cp >= 0x0E86 && cp <= 0x0E8A -> True
    cp if cp >= 0x0E8C && cp <= 0x0EA3 -> True
    cp if cp == 0x0EA5 -> True
    cp if cp >= 0x0EA7 && cp <= 0x0EB0 -> True
    cp if cp >= 0x0EB2 && cp <= 0x0EB3 -> True
    cp if cp == 0x0EBD -> True
    cp if cp >= 0x0EC0 && cp <= 0x0EC4 -> True
    cp if cp == 0x0EC6 -> True
    cp if cp >= 0x0ED0 && cp <= 0x0ED9 -> True
    cp if cp >= 0x0EDC && cp <= 0x0EDF -> True
    cp if cp == 0x0F00 -> True
    cp if cp >= 0x0F01 && cp <= 0x0F03 -> True
    cp if cp >= 0x0F04 && cp <= 0x0F12 -> True
    cp if cp == 0x0F13 -> True
    cp if cp == 0x0F14 -> True
    cp if cp >= 0x0F15 && cp <= 0x0F17 -> True
    cp if cp >= 0x0F1A && cp <= 0x0F1F -> True
    cp if cp >= 0x0F20 && cp <= 0x0F29 -> True
    cp if cp >= 0x0F2A && cp <= 0x0F33 -> True
    cp if cp == 0x0F34 -> True
    cp if cp == 0x0F36 -> True
    cp if cp == 0x0F38 -> True
    cp if cp >= 0x0F3E && cp <= 0x0F3F -> True
    cp if cp >= 0x0F40 && cp <= 0x0F47 -> True
    cp if cp >= 0x0F49 && cp <= 0x0F6C -> True
    cp if cp == 0x0F7F -> True
    cp if cp == 0x0F85 -> True
    cp if cp >= 0x0F88 && cp <= 0x0F8C -> True
    cp if cp >= 0x0FBE && cp <= 0x0FC5 -> True
    cp if cp >= 0x0FC7 && cp <= 0x0FCC -> True
    cp if cp >= 0x0FCE && cp <= 0x0FCF -> True
    cp if cp >= 0x0FD0 && cp <= 0x0FD4 -> True
    cp if cp >= 0x0FD5 && cp <= 0x0FD8 -> True
    cp if cp >= 0x0FD9 && cp <= 0x0FDA -> True
    cp if cp >= 0x1000 && cp <= 0x102A -> True
    cp if cp >= 0x102B && cp <= 0x102C -> True
    cp if cp == 0x1031 -> True
    cp if cp == 0x1038 -> True
    cp if cp >= 0x103B && cp <= 0x103C -> True
    cp if cp == 0x103F -> True
    cp if cp >= 0x1040 && cp <= 0x1049 -> True
    cp if cp >= 0x104A && cp <= 0x104F -> True
    cp if cp >= 0x1050 && cp <= 0x1055 -> True
    cp if cp >= 0x1056 && cp <= 0x1057 -> True
    cp if cp >= 0x105A && cp <= 0x105D -> True
    cp if cp == 0x1061 -> True
    cp if cp >= 0x1062 && cp <= 0x1064 -> True
    cp if cp >= 0x1065 && cp <= 0x1066 -> True
    cp if cp >= 0x1067 && cp <= 0x106D -> True
    cp if cp >= 0x106E && cp <= 0x1070 -> True
    cp if cp >= 0x1075 && cp <= 0x1081 -> True
    cp if cp >= 0x1083 && cp <= 0x1084 -> True
    cp if cp >= 0x1087 && cp <= 0x108C -> True
    cp if cp == 0x108E -> True
    cp if cp == 0x108F -> True
    cp if cp >= 0x1090 && cp <= 0x1099 -> True
    cp if cp >= 0x109A && cp <= 0x109C -> True
    cp if cp >= 0x109E && cp <= 0x109F -> True
    cp if cp >= 0x10A0 && cp <= 0x10C5 -> True
    cp if cp == 0x10C7 -> True
    cp if cp == 0x10CD -> True
    cp if cp >= 0x10D0 && cp <= 0x10FA -> True
    cp if cp == 0x10FB -> True
    cp if cp == 0x10FC -> True
    cp if cp >= 0x10FD && cp <= 0x10FF -> True
    cp if cp >= 0x1100 && cp <= 0x1248 -> True
    cp if cp >= 0x124A && cp <= 0x124D -> True
    cp if cp >= 0x1250 && cp <= 0x1256 -> True
    cp if cp == 0x1258 -> True
    cp if cp >= 0x125A && cp <= 0x125D -> True
    cp if cp >= 0x1260 && cp <= 0x1288 -> True
    cp if cp >= 0x128A && cp <= 0x128D -> True
    cp if cp >= 0x1290 && cp <= 0x12B0 -> True
    cp if cp >= 0x12B2 && cp <= 0x12B5 -> True
    cp if cp >= 0x12B8 && cp <= 0x12BE -> True
    cp if cp == 0x12C0 -> True
    cp if cp >= 0x12C2 && cp <= 0x12C5 -> True
    cp if cp >= 0x12C8 && cp <= 0x12D6 -> True
    cp if cp >= 0x12D8 && cp <= 0x1310 -> True
    cp if cp >= 0x1312 && cp <= 0x1315 -> True
    cp if cp >= 0x1318 && cp <= 0x135A -> True
    cp if cp >= 0x1360 && cp <= 0x1368 -> True
    cp if cp >= 0x1369 && cp <= 0x137C -> True
    cp if cp >= 0x1380 && cp <= 0x138F -> True
    cp if cp >= 0x13A0 && cp <= 0x13F5 -> True
    cp if cp >= 0x13F8 && cp <= 0x13FD -> True
    cp if cp >= 0x1401 && cp <= 0x166C -> True
    cp if cp == 0x166D -> True
    cp if cp == 0x166E -> True
    cp if cp >= 0x166F && cp <= 0x167F -> True
    cp if cp >= 0x1681 && cp <= 0x169A -> True
    cp if cp >= 0x16A0 && cp <= 0x16EA -> True
    cp if cp >= 0x16EB && cp <= 0x16ED -> True
    cp if cp >= 0x16EE && cp <= 0x16F0 -> True
    cp if cp >= 0x16F1 && cp <= 0x16F8 -> True
    cp if cp >= 0x1700 && cp <= 0x1711 -> True
    cp if cp == 0x1715 -> True
    cp if cp >= 0x171F && cp <= 0x1731 -> True
    cp if cp == 0x1734 -> True
    cp if cp >= 0x1735 && cp <= 0x1736 -> True
    cp if cp >= 0x1740 && cp <= 0x1751 -> True
    cp if cp >= 0x1760 && cp <= 0x176C -> True
    cp if cp >= 0x176E && cp <= 0x1770 -> True
    cp if cp >= 0x1780 && cp <= 0x17B3 -> True
    cp if cp == 0x17B6 -> True
    cp if cp >= 0x17BE && cp <= 0x17C5 -> True
    cp if cp >= 0x17C7 && cp <= 0x17C8 -> True
    cp if cp >= 0x17D4 && cp <= 0x17D6 -> True
    cp if cp == 0x17D7 -> True
    cp if cp >= 0x17D8 && cp <= 0x17DA -> True
    cp if cp == 0x17DC -> True
    cp if cp >= 0x17E0 && cp <= 0x17E9 -> True
    cp if cp >= 0x1810 && cp <= 0x1819 -> True
    cp if cp >= 0x1820 && cp <= 0x1842 -> True
    cp if cp == 0x1843 -> True
    cp if cp >= 0x1844 && cp <= 0x1878 -> True
    cp if cp >= 0x1880 && cp <= 0x1884 -> True
    cp if cp >= 0x1887 && cp <= 0x18A8 -> True
    cp if cp == 0x18AA -> True
    cp if cp >= 0x18B0 && cp <= 0x18F5 -> True
    cp if cp >= 0x1900 && cp <= 0x191E -> True
    cp if cp >= 0x1923 && cp <= 0x1926 -> True
    cp if cp >= 0x1929 && cp <= 0x192B -> True
    cp if cp >= 0x1930 && cp <= 0x1931 -> True
    cp if cp >= 0x1933 && cp <= 0x1938 -> True
    cp if cp >= 0x1946 && cp <= 0x194F -> True
    cp if cp >= 0x1950 && cp <= 0x196D -> True
    cp if cp >= 0x1970 && cp <= 0x1974 -> True
    cp if cp >= 0x1980 && cp <= 0x19AB -> True
    cp if cp >= 0x19B0 && cp <= 0x19C9 -> True
    cp if cp >= 0x19D0 && cp <= 0x19D9 -> True
    cp if cp == 0x19DA -> True
    cp if cp >= 0x1A00 && cp <= 0x1A16 -> True
    cp if cp >= 0x1A19 && cp <= 0x1A1A -> True
    cp if cp >= 0x1A1E && cp <= 0x1A1F -> True
    cp if cp >= 0x1A20 && cp <= 0x1A54 -> True
    cp if cp == 0x1A55 -> True
    cp if cp == 0x1A57 -> True
    cp if cp == 0x1A61 -> True
    cp if cp >= 0x1A63 && cp <= 0x1A64 -> True
    cp if cp >= 0x1A6D && cp <= 0x1A72 -> True
    cp if cp >= 0x1A80 && cp <= 0x1A89 -> True
    cp if cp >= 0x1A90 && cp <= 0x1A99 -> True
    cp if cp >= 0x1AA0 && cp <= 0x1AA6 -> True
    cp if cp == 0x1AA7 -> True
    cp if cp >= 0x1AA8 && cp <= 0x1AAD -> True
    cp if cp == 0x1B04 -> True
    cp if cp >= 0x1B05 && cp <= 0x1B33 -> True
    cp if cp == 0x1B35 -> True
    cp if cp == 0x1B3B -> True
    cp if cp >= 0x1B3D && cp <= 0x1B41 -> True
    cp if cp >= 0x1B43 && cp <= 0x1B44 -> True
    cp if cp >= 0x1B45 && cp <= 0x1B4C -> True
    cp if cp >= 0x1B4E && cp <= 0x1B4F -> True
    cp if cp >= 0x1B50 && cp <= 0x1B59 -> True
    cp if cp >= 0x1B5A && cp <= 0x1B60 -> True
    cp if cp >= 0x1B61 && cp <= 0x1B6A -> True
    cp if cp >= 0x1B74 && cp <= 0x1B7C -> True
    cp if cp >= 0x1B7D && cp <= 0x1B7F -> True
    cp if cp == 0x1B82 -> True
    cp if cp >= 0x1B83 && cp <= 0x1BA0 -> True
    cp if cp == 0x1BA1 -> True
    cp if cp >= 0x1BA6 && cp <= 0x1BA7 -> True
    cp if cp == 0x1BAA -> True
    cp if cp >= 0x1BAE && cp <= 0x1BAF -> True
    cp if cp >= 0x1BB0 && cp <= 0x1BB9 -> True
    cp if cp >= 0x1BBA && cp <= 0x1BE5 -> True
    cp if cp == 0x1BE7 -> True
    cp if cp >= 0x1BEA && cp <= 0x1BEC -> True
    cp if cp == 0x1BEE -> True
    cp if cp >= 0x1BF2 && cp <= 0x1BF3 -> True
    cp if cp >= 0x1BFC && cp <= 0x1BFF -> True
    cp if cp >= 0x1C00 && cp <= 0x1C23 -> True
    cp if cp >= 0x1C24 && cp <= 0x1C2B -> True
    cp if cp >= 0x1C34 && cp <= 0x1C35 -> True
    cp if cp >= 0x1C3B && cp <= 0x1C3F -> True
    cp if cp >= 0x1C40 && cp <= 0x1C49 -> True
    cp if cp >= 0x1C4D && cp <= 0x1C4F -> True
    cp if cp >= 0x1C50 && cp <= 0x1C59 -> True
    cp if cp >= 0x1C5A && cp <= 0x1C77 -> True
    cp if cp >= 0x1C78 && cp <= 0x1C7D -> True
    cp if cp >= 0x1C7E && cp <= 0x1C7F -> True
    cp if cp >= 0x1C80 && cp <= 0x1C8A -> True
    cp if cp >= 0x1C90 && cp <= 0x1CBA -> True
    cp if cp >= 0x1CBD && cp <= 0x1CBF -> True
    cp if cp >= 0x1CC0 && cp <= 0x1CC7 -> True
    cp if cp == 0x1CD3 -> True
    cp if cp == 0x1CE1 -> True
    cp if cp >= 0x1CE9 && cp <= 0x1CEC -> True
    cp if cp >= 0x1CEE && cp <= 0x1CF3 -> True
    cp if cp >= 0x1CF5 && cp <= 0x1CF6 -> True
    cp if cp == 0x1CF7 -> True
    cp if cp == 0x1CFA -> True
    cp if cp >= 0x1D00 && cp <= 0x1D2B -> True
    cp if cp >= 0x1D2C && cp <= 0x1D6A -> True
    cp if cp >= 0x1D6B && cp <= 0x1D77 -> True
    cp if cp == 0x1D78 -> True
    cp if cp >= 0x1D79 && cp <= 0x1D9A -> True
    cp if cp >= 0x1D9B && cp <= 0x1DBF -> True
    cp if cp >= 0x1E00 && cp <= 0x1F15 -> True
    cp if cp >= 0x1F18 && cp <= 0x1F1D -> True
    cp if cp >= 0x1F20 && cp <= 0x1F45 -> True
    cp if cp >= 0x1F48 && cp <= 0x1F4D -> True
    cp if cp >= 0x1F50 && cp <= 0x1F57 -> True
    cp if cp == 0x1F59 -> True
    cp if cp == 0x1F5B -> True
    cp if cp == 0x1F5D -> True
    cp if cp >= 0x1F5F && cp <= 0x1F7D -> True
    cp if cp >= 0x1F80 && cp <= 0x1FB4 -> True
    cp if cp >= 0x1FB6 && cp <= 0x1FBC -> True
    cp if cp == 0x1FBE -> True
    cp if cp >= 0x1FC2 && cp <= 0x1FC4 -> True
    cp if cp >= 0x1FC6 && cp <= 0x1FCC -> True
    cp if cp >= 0x1FD0 && cp <= 0x1FD3 -> True
    cp if cp >= 0x1FD6 && cp <= 0x1FDB -> True
    cp if cp >= 0x1FE0 && cp <= 0x1FEC -> True
    cp if cp >= 0x1FF2 && cp <= 0x1FF4 -> True
    cp if cp >= 0x1FF6 && cp <= 0x1FFC -> True
    cp if cp == 0x200E -> True
    cp if cp == 0x2071 -> True
    cp if cp == 0x207F -> True
    cp if cp >= 0x2090 && cp <= 0x209C -> True
    cp if cp == 0x2102 -> True
    cp if cp == 0x2107 -> True
    cp if cp >= 0x210A && cp <= 0x2113 -> True
    cp if cp == 0x2115 -> True
    cp if cp >= 0x2119 && cp <= 0x211D -> True
    cp if cp == 0x2124 -> True
    cp if cp == 0x2126 -> True
    cp if cp == 0x2128 -> True
    cp if cp >= 0x212A && cp <= 0x212D -> True
    cp if cp >= 0x212F && cp <= 0x2134 -> True
    cp if cp >= 0x2135 && cp <= 0x2138 -> True
    cp if cp == 0x2139 -> True
    cp if cp >= 0x213C && cp <= 0x213F -> True
    cp if cp >= 0x2145 && cp <= 0x2149 -> True
    cp if cp == 0x214E -> True
    cp if cp == 0x214F -> True
    cp if cp >= 0x2160 && cp <= 0x2182 -> True
    cp if cp >= 0x2183 && cp <= 0x2184 -> True
    cp if cp >= 0x2185 && cp <= 0x2188 -> True
    cp if cp >= 0x2336 && cp <= 0x237A -> True
    cp if cp == 0x2395 -> True
    cp if cp >= 0x249C && cp <= 0x24E9 -> True
    cp if cp == 0x26AC -> True
    cp if cp >= 0x2800 && cp <= 0x28FF -> True
    cp if cp >= 0x2C00 && cp <= 0x2C7B -> True
    cp if cp >= 0x2C7C && cp <= 0x2C7D -> True
    cp if cp >= 0x2C7E && cp <= 0x2CE4 -> True
    cp if cp >= 0x2CEB && cp <= 0x2CEE -> True
    cp if cp >= 0x2CF2 && cp <= 0x2CF3 -> True
    cp if cp >= 0x2D00 && cp <= 0x2D25 -> True
    cp if cp == 0x2D27 -> True
    cp if cp == 0x2D2D -> True
    cp if cp >= 0x2D30 && cp <= 0x2D67 -> True
    cp if cp == 0x2D6F -> True
    cp if cp == 0x2D70 -> True
    cp if cp >= 0x2D80 && cp <= 0x2D96 -> True
    cp if cp >= 0x2DA0 && cp <= 0x2DA6 -> True
    cp if cp >= 0x2DA8 && cp <= 0x2DAE -> True
    cp if cp >= 0x2DB0 && cp <= 0x2DB6 -> True
    cp if cp >= 0x2DB8 && cp <= 0x2DBE -> True
    cp if cp >= 0x2DC0 && cp <= 0x2DC6 -> True
    cp if cp >= 0x2DC8 && cp <= 0x2DCE -> True
    cp if cp >= 0x2DD0 && cp <= 0x2DD6 -> True
    cp if cp >= 0x2DD8 && cp <= 0x2DDE -> True
    cp if cp == 0x3005 -> True
    cp if cp == 0x3006 -> True
    cp if cp == 0x3007 -> True
    cp if cp >= 0x3021 && cp <= 0x3029 -> True
    cp if cp >= 0x302E && cp <= 0x302F -> True
    cp if cp >= 0x3031 && cp <= 0x3035 -> True
    cp if cp >= 0x3038 && cp <= 0x303A -> True
    cp if cp == 0x303B -> True
    cp if cp == 0x303C -> True
    cp if cp >= 0x3041 && cp <= 0x3096 -> True
    cp if cp >= 0x309D && cp <= 0x309E -> True
    cp if cp == 0x309F -> True
    cp if cp >= 0x30A1 && cp <= 0x30FA -> True
    cp if cp >= 0x30FC && cp <= 0x30FE -> True
    cp if cp == 0x30FF -> True
    cp if cp >= 0x3105 && cp <= 0x312F -> True
    cp if cp >= 0x3131 && cp <= 0x318E -> True
    cp if cp >= 0x3190 && cp <= 0x3191 -> True
    cp if cp >= 0x3192 && cp <= 0x3195 -> True
    cp if cp >= 0x3196 && cp <= 0x319F -> True
    cp if cp >= 0x31A0 && cp <= 0x31BF -> True
    cp if cp >= 0x31F0 && cp <= 0x31FF -> True
    cp if cp >= 0x3200 && cp <= 0x321C -> True
    cp if cp >= 0x3220 && cp <= 0x3229 -> True
    cp if cp >= 0x322A && cp <= 0x3247 -> True
    cp if cp >= 0x3248 && cp <= 0x324F -> True
    cp if cp >= 0x3260 && cp <= 0x327B -> True
    cp if cp == 0x327F -> True
    cp if cp >= 0x3280 && cp <= 0x3289 -> True
    cp if cp >= 0x328A && cp <= 0x32B0 -> True
    cp if cp >= 0x32C0 && cp <= 0x32CB -> True
    cp if cp >= 0x32D0 && cp <= 0x3376 -> True
    cp if cp >= 0x337B && cp <= 0x33DD -> True
    cp if cp >= 0x33E0 && cp <= 0x33FE -> True
    cp if cp >= 0x3400 && cp <= 0x4DBF -> True
    cp if cp >= 0x4E00 && cp <= 0xA014 -> True
    cp if cp == 0xA015 -> True
    cp if cp >= 0xA016 && cp <= 0xA48C -> True
    cp if cp >= 0xA4D0 && cp <= 0xA4F7 -> True
    cp if cp >= 0xA4F8 && cp <= 0xA4FD -> True
    cp if cp >= 0xA4FE && cp <= 0xA4FF -> True
    cp if cp >= 0xA500 && cp <= 0xA60B -> True
    cp if cp == 0xA60C -> True
    cp if cp >= 0xA610 && cp <= 0xA61F -> True
    cp if cp >= 0xA620 && cp <= 0xA629 -> True
    cp if cp >= 0xA62A && cp <= 0xA62B -> True
    cp if cp >= 0xA640 && cp <= 0xA66D -> True
    cp if cp == 0xA66E -> True
    cp if cp >= 0xA680 && cp <= 0xA69B -> True
    cp if cp >= 0xA69C && cp <= 0xA69D -> True
    cp if cp >= 0xA6A0 && cp <= 0xA6E5 -> True
    cp if cp >= 0xA6E6 && cp <= 0xA6EF -> True
    cp if cp >= 0xA6F2 && cp <= 0xA6F7 -> True
    cp if cp >= 0xA722 && cp <= 0xA76F -> True
    cp if cp == 0xA770 -> True
    cp if cp >= 0xA771 && cp <= 0xA787 -> True
    cp if cp >= 0xA789 && cp <= 0xA78A -> True
    cp if cp >= 0xA78B && cp <= 0xA78E -> True
    cp if cp == 0xA78F -> True
    cp if cp >= 0xA790 && cp <= 0xA7CD -> True
    cp if cp >= 0xA7D0 && cp <= 0xA7D1 -> True
    cp if cp == 0xA7D3 -> True
    cp if cp >= 0xA7D5 && cp <= 0xA7DC -> True
    cp if cp >= 0xA7F2 && cp <= 0xA7F4 -> True
    cp if cp >= 0xA7F5 && cp <= 0xA7F6 -> True
    cp if cp == 0xA7F7 -> True
    cp if cp >= 0xA7F8 && cp <= 0xA7F9 -> True
    cp if cp == 0xA7FA -> True
    cp if cp >= 0xA7FB && cp <= 0xA801 -> True
    cp if cp >= 0xA803 && cp <= 0xA805 -> True
    cp if cp >= 0xA807 && cp <= 0xA80A -> True
    cp if cp >= 0xA80C && cp <= 0xA822 -> True
    cp if cp >= 0xA823 && cp <= 0xA824 -> True
    cp if cp == 0xA827 -> True
    cp if cp >= 0xA830 && cp <= 0xA835 -> True
    cp if cp >= 0xA836 && cp <= 0xA837 -> True
    cp if cp >= 0xA840 && cp <= 0xA873 -> True
    cp if cp >= 0xA880 && cp <= 0xA881 -> True
    cp if cp >= 0xA882 && cp <= 0xA8B3 -> True
    cp if cp >= 0xA8B4 && cp <= 0xA8C3 -> True
    cp if cp >= 0xA8CE && cp <= 0xA8CF -> True
    cp if cp >= 0xA8D0 && cp <= 0xA8D9 -> True
    cp if cp >= 0xA8F2 && cp <= 0xA8F7 -> True
    cp if cp >= 0xA8F8 && cp <= 0xA8FA -> True
    cp if cp == 0xA8FB -> True
    cp if cp == 0xA8FC -> True
    cp if cp >= 0xA8FD && cp <= 0xA8FE -> True
    cp if cp >= 0xA900 && cp <= 0xA909 -> True
    cp if cp >= 0xA90A && cp <= 0xA925 -> True
    cp if cp >= 0xA92E && cp <= 0xA92F -> True
    cp if cp >= 0xA930 && cp <= 0xA946 -> True
    cp if cp >= 0xA952 && cp <= 0xA953 -> True
    cp if cp == 0xA95F -> True
    cp if cp >= 0xA960 && cp <= 0xA97C -> True
    cp if cp == 0xA983 -> True
    cp if cp >= 0xA984 && cp <= 0xA9B2 -> True
    cp if cp >= 0xA9B4 && cp <= 0xA9B5 -> True
    cp if cp >= 0xA9BA && cp <= 0xA9BB -> True
    cp if cp >= 0xA9BE && cp <= 0xA9C0 -> True
    cp if cp >= 0xA9C1 && cp <= 0xA9CD -> True
    cp if cp == 0xA9CF -> True
    cp if cp >= 0xA9D0 && cp <= 0xA9D9 -> True
    cp if cp >= 0xA9DE && cp <= 0xA9DF -> True
    cp if cp >= 0xA9E0 && cp <= 0xA9E4 -> True
    cp if cp == 0xA9E6 -> True
    cp if cp >= 0xA9E7 && cp <= 0xA9EF -> True
    cp if cp >= 0xA9F0 && cp <= 0xA9F9 -> True
    cp if cp >= 0xA9FA && cp <= 0xA9FE -> True
    cp if cp >= 0xAA00 && cp <= 0xAA28 -> True
    cp if cp >= 0xAA2F && cp <= 0xAA30 -> True
    cp if cp >= 0xAA33 && cp <= 0xAA34 -> True
    cp if cp >= 0xAA40 && cp <= 0xAA42 -> True
    cp if cp >= 0xAA44 && cp <= 0xAA4B -> True
    cp if cp == 0xAA4D -> True
    cp if cp >= 0xAA50 && cp <= 0xAA59 -> True
    cp if cp >= 0xAA5C && cp <= 0xAA5F -> True
    cp if cp >= 0xAA60 && cp <= 0xAA6F -> True
    cp if cp == 0xAA70 -> True
    cp if cp >= 0xAA71 && cp <= 0xAA76 -> True
    cp if cp >= 0xAA77 && cp <= 0xAA79 -> True
    cp if cp == 0xAA7A -> True
    cp if cp == 0xAA7B -> True
    cp if cp == 0xAA7D -> True
    cp if cp >= 0xAA7E && cp <= 0xAAAF -> True
    cp if cp == 0xAAB1 -> True
    cp if cp >= 0xAAB5 && cp <= 0xAAB6 -> True
    cp if cp >= 0xAAB9 && cp <= 0xAABD -> True
    cp if cp == 0xAAC0 -> True
    cp if cp == 0xAAC2 -> True
    cp if cp >= 0xAADB && cp <= 0xAADC -> True
    cp if cp == 0xAADD -> True
    cp if cp >= 0xAADE && cp <= 0xAADF -> True
    cp if cp >= 0xAAE0 && cp <= 0xAAEA -> True
    cp if cp == 0xAAEB -> True
    cp if cp >= 0xAAEE && cp <= 0xAAEF -> True
    cp if cp >= 0xAAF0 && cp <= 0xAAF1 -> True
    cp if cp == 0xAAF2 -> True
    cp if cp >= 0xAAF3 && cp <= 0xAAF4 -> True
    cp if cp == 0xAAF5 -> True
    cp if cp >= 0xAB01 && cp <= 0xAB06 -> True
    cp if cp >= 0xAB09 && cp <= 0xAB0E -> True
    cp if cp >= 0xAB11 && cp <= 0xAB16 -> True
    cp if cp >= 0xAB20 && cp <= 0xAB26 -> True
    cp if cp >= 0xAB28 && cp <= 0xAB2E -> True
    cp if cp >= 0xAB30 && cp <= 0xAB5A -> True
    cp if cp == 0xAB5B -> True
    cp if cp >= 0xAB5C && cp <= 0xAB5F -> True
    cp if cp >= 0xAB60 && cp <= 0xAB68 -> True
    cp if cp == 0xAB69 -> True
    cp if cp >= 0xAB70 && cp <= 0xABBF -> True
    cp if cp >= 0xABC0 && cp <= 0xABE2 -> True
    cp if cp >= 0xABE3 && cp <= 0xABE4 -> True
    cp if cp >= 0xABE6 && cp <= 0xABE7 -> True
    cp if cp >= 0xABE9 && cp <= 0xABEA -> True
    cp if cp == 0xABEB -> True
    cp if cp == 0xABEC -> True
    cp if cp >= 0xABF0 && cp <= 0xABF9 -> True
    cp if cp >= 0xAC00 && cp <= 0xD7A3 -> True
    cp if cp >= 0xD7B0 && cp <= 0xD7C6 -> True
    cp if cp >= 0xD7CB && cp <= 0xD7FB -> True
    cp if cp >= 0xE000 && cp <= 0xF8FF -> True
    cp if cp >= 0xF900 && cp <= 0xFA6D -> True
    cp if cp >= 0xFA70 && cp <= 0xFAD9 -> True
    cp if cp >= 0xFB00 && cp <= 0xFB06 -> True
    cp if cp >= 0xFB13 && cp <= 0xFB17 -> True
    cp if cp >= 0xFF21 && cp <= 0xFF3A -> True
    cp if cp >= 0xFF41 && cp <= 0xFF5A -> True
    cp if cp >= 0xFF66 && cp <= 0xFF6F -> True
    cp if cp == 0xFF70 -> True
    cp if cp >= 0xFF71 && cp <= 0xFF9D -> True
    cp if cp >= 0xFF9E && cp <= 0xFF9F -> True
    cp if cp >= 0xFFA0 && cp <= 0xFFBE -> True
    cp if cp >= 0xFFC2 && cp <= 0xFFC7 -> True
    cp if cp >= 0xFFCA && cp <= 0xFFCF -> True
    cp if cp >= 0xFFD2 && cp <= 0xFFD7 -> True
    cp if cp >= 0xFFDA && cp <= 0xFFDC -> True
    cp if cp >= 0x10000 && cp <= 0x1000B -> True
    cp if cp >= 0x1000D && cp <= 0x10026 -> True
    cp if cp >= 0x10028 && cp <= 0x1003A -> True
    cp if cp >= 0x1003C && cp <= 0x1003D -> True
    cp if cp >= 0x1003F && cp <= 0x1004D -> True
    cp if cp >= 0x10050 && cp <= 0x1005D -> True
    cp if cp >= 0x10080 && cp <= 0x100FA -> True
    cp if cp == 0x10100 -> True
    cp if cp == 0x10102 -> True
    cp if cp >= 0x10107 && cp <= 0x10133 -> True
    cp if cp >= 0x10137 && cp <= 0x1013F -> True
    cp if cp >= 0x1018D && cp <= 0x1018E -> True
    cp if cp >= 0x101D0 && cp <= 0x101FC -> True
    cp if cp >= 0x10280 && cp <= 0x1029C -> True
    cp if cp >= 0x102A0 && cp <= 0x102D0 -> True
    cp if cp >= 0x10300 && cp <= 0x1031F -> True
    cp if cp >= 0x10320 && cp <= 0x10323 -> True
    cp if cp >= 0x1032D && cp <= 0x10340 -> True
    cp if cp == 0x10341 -> True
    cp if cp >= 0x10342 && cp <= 0x10349 -> True
    cp if cp == 0x1034A -> True
    cp if cp >= 0x10350 && cp <= 0x10375 -> True
    cp if cp >= 0x10380 && cp <= 0x1039D -> True
    cp if cp == 0x1039F -> True
    cp if cp >= 0x103A0 && cp <= 0x103C3 -> True
    cp if cp >= 0x103C8 && cp <= 0x103CF -> True
    cp if cp == 0x103D0 -> True
    cp if cp >= 0x103D1 && cp <= 0x103D5 -> True
    cp if cp >= 0x10400 && cp <= 0x1044F -> True
    cp if cp >= 0x10450 && cp <= 0x1049D -> True
    cp if cp >= 0x104A0 && cp <= 0x104A9 -> True
    cp if cp >= 0x104B0 && cp <= 0x104D3 -> True
    cp if cp >= 0x104D8 && cp <= 0x104FB -> True
    cp if cp >= 0x10500 && cp <= 0x10527 -> True
    cp if cp >= 0x10530 && cp <= 0x10563 -> True
    cp if cp == 0x1056F -> True
    cp if cp >= 0x10570 && cp <= 0x1057A -> True
    cp if cp >= 0x1057C && cp <= 0x1058A -> True
    cp if cp >= 0x1058C && cp <= 0x10592 -> True
    cp if cp >= 0x10594 && cp <= 0x10595 -> True
    cp if cp >= 0x10597 && cp <= 0x105A1 -> True
    cp if cp >= 0x105A3 && cp <= 0x105B1 -> True
    cp if cp >= 0x105B3 && cp <= 0x105B9 -> True
    cp if cp >= 0x105BB && cp <= 0x105BC -> True
    cp if cp >= 0x105C0 && cp <= 0x105F3 -> True
    cp if cp >= 0x10600 && cp <= 0x10736 -> True
    cp if cp >= 0x10740 && cp <= 0x10755 -> True
    cp if cp >= 0x10760 && cp <= 0x10767 -> True
    cp if cp >= 0x10780 && cp <= 0x10785 -> True
    cp if cp >= 0x10787 && cp <= 0x107B0 -> True
    cp if cp >= 0x107B2 && cp <= 0x107BA -> True
    cp if cp == 0x11000 -> True
    cp if cp == 0x11002 -> True
    cp if cp >= 0x11003 && cp <= 0x11037 -> True
    cp if cp >= 0x11047 && cp <= 0x1104D -> True
    cp if cp >= 0x11066 && cp <= 0x1106F -> True
    cp if cp >= 0x11071 && cp <= 0x11072 -> True
    cp if cp == 0x11075 -> True
    cp if cp == 0x11082 -> True
    cp if cp >= 0x11083 && cp <= 0x110AF -> True
    cp if cp >= 0x110B0 && cp <= 0x110B2 -> True
    cp if cp >= 0x110B7 && cp <= 0x110B8 -> True
    cp if cp >= 0x110BB && cp <= 0x110BC -> True
    cp if cp == 0x110BD -> True
    cp if cp >= 0x110BE && cp <= 0x110C1 -> True
    cp if cp == 0x110CD -> True
    cp if cp >= 0x110D0 && cp <= 0x110E8 -> True
    cp if cp >= 0x110F0 && cp <= 0x110F9 -> True
    cp if cp >= 0x11103 && cp <= 0x11126 -> True
    cp if cp == 0x1112C -> True
    cp if cp >= 0x11136 && cp <= 0x1113F -> True
    cp if cp >= 0x11140 && cp <= 0x11143 -> True
    cp if cp == 0x11144 -> True
    cp if cp >= 0x11145 && cp <= 0x11146 -> True
    cp if cp == 0x11147 -> True
    cp if cp >= 0x11150 && cp <= 0x11172 -> True
    cp if cp >= 0x11174 && cp <= 0x11175 -> True
    cp if cp == 0x11176 -> True
    cp if cp == 0x11182 -> True
    cp if cp >= 0x11183 && cp <= 0x111B2 -> True
    cp if cp >= 0x111B3 && cp <= 0x111B5 -> True
    cp if cp >= 0x111BF && cp <= 0x111C0 -> True
    cp if cp >= 0x111C1 && cp <= 0x111C4 -> True
    cp if cp >= 0x111C5 && cp <= 0x111C8 -> True
    cp if cp == 0x111CD -> True
    cp if cp == 0x111CE -> True
    cp if cp >= 0x111D0 && cp <= 0x111D9 -> True
    cp if cp == 0x111DA -> True
    cp if cp == 0x111DB -> True
    cp if cp == 0x111DC -> True
    cp if cp >= 0x111DD && cp <= 0x111DF -> True
    cp if cp >= 0x111E1 && cp <= 0x111F4 -> True
    cp if cp >= 0x11200 && cp <= 0x11211 -> True
    cp if cp >= 0x11213 && cp <= 0x1122B -> True
    cp if cp >= 0x1122C && cp <= 0x1122E -> True
    cp if cp >= 0x11232 && cp <= 0x11233 -> True
    cp if cp == 0x11235 -> True
    cp if cp >= 0x11238 && cp <= 0x1123D -> True
    cp if cp >= 0x1123F && cp <= 0x11240 -> True
    cp if cp >= 0x11280 && cp <= 0x11286 -> True
    cp if cp == 0x11288 -> True
    cp if cp >= 0x1128A && cp <= 0x1128D -> True
    cp if cp >= 0x1128F && cp <= 0x1129D -> True
    cp if cp >= 0x1129F && cp <= 0x112A8 -> True
    cp if cp == 0x112A9 -> True
    cp if cp >= 0x112B0 && cp <= 0x112DE -> True
    cp if cp >= 0x112E0 && cp <= 0x112E2 -> True
    cp if cp >= 0x112F0 && cp <= 0x112F9 -> True
    cp if cp >= 0x11302 && cp <= 0x11303 -> True
    cp if cp >= 0x11305 && cp <= 0x1130C -> True
    cp if cp >= 0x1130F && cp <= 0x11310 -> True
    cp if cp >= 0x11313 && cp <= 0x11328 -> True
    cp if cp >= 0x1132A && cp <= 0x11330 -> True
    cp if cp >= 0x11332 && cp <= 0x11333 -> True
    cp if cp >= 0x11335 && cp <= 0x11339 -> True
    cp if cp == 0x1133D -> True
    cp if cp >= 0x1133E && cp <= 0x1133F -> True
    cp if cp >= 0x11341 && cp <= 0x11344 -> True
    cp if cp >= 0x11347 && cp <= 0x11348 -> True
    cp if cp >= 0x1134B && cp <= 0x1134D -> True
    cp if cp == 0x11350 -> True
    cp if cp == 0x11357 -> True
    cp if cp >= 0x1135D && cp <= 0x11361 -> True
    cp if cp >= 0x11362 && cp <= 0x11363 -> True
    cp if cp >= 0x11380 && cp <= 0x11389 -> True
    cp if cp == 0x1138B -> True
    cp if cp == 0x1138E -> True
    cp if cp >= 0x11390 && cp <= 0x113B5 -> True
    cp if cp == 0x113B7 -> True
    cp if cp >= 0x113B8 && cp <= 0x113BA -> True
    cp if cp == 0x113C2 -> True
    cp if cp == 0x113C5 -> True
    cp if cp >= 0x113C7 && cp <= 0x113CA -> True
    cp if cp >= 0x113CC && cp <= 0x113CD -> True
    cp if cp == 0x113CF -> True
    cp if cp == 0x113D1 -> True
    cp if cp == 0x113D3 -> True
    cp if cp >= 0x113D4 && cp <= 0x113D5 -> True
    cp if cp >= 0x113D7 && cp <= 0x113D8 -> True
    cp if cp >= 0x11400 && cp <= 0x11434 -> True
    cp if cp >= 0x11435 && cp <= 0x11437 -> True
    cp if cp >= 0x11440 && cp <= 0x11441 -> True
    cp if cp == 0x11445 -> True
    cp if cp >= 0x11447 && cp <= 0x1144A -> True
    cp if cp >= 0x1144B && cp <= 0x1144F -> True
    cp if cp >= 0x11450 && cp <= 0x11459 -> True
    cp if cp >= 0x1145A && cp <= 0x1145B -> True
    cp if cp == 0x1145D -> True
    cp if cp >= 0x1145F && cp <= 0x11461 -> True
    cp if cp >= 0x11480 && cp <= 0x114AF -> True
    cp if cp >= 0x114B0 && cp <= 0x114B2 -> True
    cp if cp == 0x114B9 -> True
    cp if cp >= 0x114BB && cp <= 0x114BE -> True
    cp if cp == 0x114C1 -> True
    cp if cp >= 0x114C4 && cp <= 0x114C5 -> True
    cp if cp == 0x114C6 -> True
    cp if cp == 0x114C7 -> True
    cp if cp >= 0x114D0 && cp <= 0x114D9 -> True
    cp if cp >= 0x11580 && cp <= 0x115AE -> True
    cp if cp >= 0x115AF && cp <= 0x115B1 -> True
    cp if cp >= 0x115B8 && cp <= 0x115BB -> True
    cp if cp == 0x115BE -> True
    cp if cp >= 0x115C1 && cp <= 0x115D7 -> True
    cp if cp >= 0x115D8 && cp <= 0x115DB -> True
    cp if cp >= 0x11600 && cp <= 0x1162F -> True
    cp if cp >= 0x11630 && cp <= 0x11632 -> True
    cp if cp >= 0x1163B && cp <= 0x1163C -> True
    cp if cp == 0x1163E -> True
    cp if cp >= 0x11641 && cp <= 0x11643 -> True
    cp if cp == 0x11644 -> True
    cp if cp >= 0x11650 && cp <= 0x11659 -> True
    cp if cp >= 0x11680 && cp <= 0x116AA -> True
    cp if cp == 0x116AC -> True
    cp if cp >= 0x116AE && cp <= 0x116AF -> True
    cp if cp == 0x116B6 -> True
    cp if cp == 0x116B8 -> True
    cp if cp == 0x116B9 -> True
    cp if cp >= 0x116C0 && cp <= 0x116C9 -> True
    cp if cp >= 0x116D0 && cp <= 0x116E3 -> True
    cp if cp >= 0x11700 && cp <= 0x1171A -> True
    cp if cp == 0x1171E -> True
    cp if cp >= 0x11720 && cp <= 0x11721 -> True
    cp if cp == 0x11726 -> True
    cp if cp >= 0x11730 && cp <= 0x11739 -> True
    cp if cp >= 0x1173A && cp <= 0x1173B -> True
    cp if cp >= 0x1173C && cp <= 0x1173E -> True
    cp if cp == 0x1173F -> True
    cp if cp >= 0x11740 && cp <= 0x11746 -> True
    cp if cp >= 0x11800 && cp <= 0x1182B -> True
    cp if cp >= 0x1182C && cp <= 0x1182E -> True
    cp if cp == 0x11838 -> True
    cp if cp == 0x1183B -> True
    cp if cp >= 0x118A0 && cp <= 0x118DF -> True
    cp if cp >= 0x118E0 && cp <= 0x118E9 -> True
    cp if cp >= 0x118EA && cp <= 0x118F2 -> True
    cp if cp >= 0x118FF && cp <= 0x11906 -> True
    cp if cp == 0x11909 -> True
    cp if cp >= 0x1190C && cp <= 0x11913 -> True
    cp if cp >= 0x11915 && cp <= 0x11916 -> True
    cp if cp >= 0x11918 && cp <= 0x1192F -> True
    cp if cp >= 0x11930 && cp <= 0x11935 -> True
    cp if cp >= 0x11937 && cp <= 0x11938 -> True
    cp if cp == 0x1193D -> True
    cp if cp == 0x1193F -> True
    cp if cp == 0x11940 -> True
    cp if cp == 0x11941 -> True
    cp if cp == 0x11942 -> True
    cp if cp >= 0x11944 && cp <= 0x11946 -> True
    cp if cp >= 0x11950 && cp <= 0x11959 -> True
    cp if cp >= 0x119A0 && cp <= 0x119A7 -> True
    cp if cp >= 0x119AA && cp <= 0x119D0 -> True
    cp if cp >= 0x119D1 && cp <= 0x119D3 -> True
    cp if cp >= 0x119DC && cp <= 0x119DF -> True
    cp if cp == 0x119E1 -> True
    cp if cp == 0x119E2 -> True
    cp if cp == 0x119E3 -> True
    cp if cp == 0x119E4 -> True
    cp if cp == 0x11A00 -> True
    cp if cp >= 0x11A07 && cp <= 0x11A08 -> True
    cp if cp >= 0x11A0B && cp <= 0x11A32 -> True
    cp if cp == 0x11A39 -> True
    cp if cp == 0x11A3A -> True
    cp if cp >= 0x11A3F && cp <= 0x11A46 -> True
    cp if cp == 0x11A50 -> True
    cp if cp >= 0x11A57 && cp <= 0x11A58 -> True
    cp if cp >= 0x11A5C && cp <= 0x11A89 -> True
    cp if cp == 0x11A97 -> True
    cp if cp >= 0x11A9A && cp <= 0x11A9C -> True
    cp if cp == 0x11A9D -> True
    cp if cp >= 0x11A9E && cp <= 0x11AA2 -> True
    cp if cp >= 0x11AB0 && cp <= 0x11AF8 -> True
    cp if cp >= 0x11B00 && cp <= 0x11B09 -> True
    cp if cp >= 0x11BC0 && cp <= 0x11BE0 -> True
    cp if cp == 0x11BE1 -> True
    cp if cp >= 0x11BF0 && cp <= 0x11BF9 -> True
    cp if cp >= 0x11C00 && cp <= 0x11C08 -> True
    cp if cp >= 0x11C0A && cp <= 0x11C2E -> True
    cp if cp == 0x11C2F -> True
    cp if cp == 0x11C3E -> True
    cp if cp == 0x11C3F -> True
    cp if cp == 0x11C40 -> True
    cp if cp >= 0x11C41 && cp <= 0x11C45 -> True
    cp if cp >= 0x11C50 && cp <= 0x11C59 -> True
    cp if cp >= 0x11C5A && cp <= 0x11C6C -> True
    cp if cp >= 0x11C70 && cp <= 0x11C71 -> True
    cp if cp >= 0x11C72 && cp <= 0x11C8F -> True
    cp if cp == 0x11CA9 -> True
    cp if cp == 0x11CB1 -> True
    cp if cp == 0x11CB4 -> True
    cp if cp >= 0x11D00 && cp <= 0x11D06 -> True
    cp if cp >= 0x11D08 && cp <= 0x11D09 -> True
    cp if cp >= 0x11D0B && cp <= 0x11D30 -> True
    cp if cp == 0x11D46 -> True
    cp if cp >= 0x11D50 && cp <= 0x11D59 -> True
    cp if cp >= 0x11D60 && cp <= 0x11D65 -> True
    cp if cp >= 0x11D67 && cp <= 0x11D68 -> True
    cp if cp >= 0x11D6A && cp <= 0x11D89 -> True
    cp if cp >= 0x11D8A && cp <= 0x11D8E -> True
    cp if cp >= 0x11D93 && cp <= 0x11D94 -> True
    cp if cp == 0x11D96 -> True
    cp if cp == 0x11D98 -> True
    cp if cp >= 0x11DA0 && cp <= 0x11DA9 -> True
    cp if cp >= 0x11EE0 && cp <= 0x11EF2 -> True
    cp if cp >= 0x11EF5 && cp <= 0x11EF6 -> True
    cp if cp >= 0x11EF7 && cp <= 0x11EF8 -> True
    cp if cp == 0x11F02 -> True
    cp if cp == 0x11F03 -> True
    cp if cp >= 0x11F04 && cp <= 0x11F10 -> True
    cp if cp >= 0x11F12 && cp <= 0x11F33 -> True
    cp if cp >= 0x11F34 && cp <= 0x11F35 -> True
    cp if cp >= 0x11F3E && cp <= 0x11F3F -> True
    cp if cp == 0x11F41 -> True
    cp if cp >= 0x11F43 && cp <= 0x11F4F -> True
    cp if cp >= 0x11F50 && cp <= 0x11F59 -> True
    cp if cp == 0x11FB0 -> True
    cp if cp >= 0x11FC0 && cp <= 0x11FD4 -> True
    cp if cp == 0x11FFF -> True
    cp if cp >= 0x12000 && cp <= 0x12399 -> True
    cp if cp >= 0x12400 && cp <= 0x1246E -> True
    cp if cp >= 0x12470 && cp <= 0x12474 -> True
    cp if cp >= 0x12480 && cp <= 0x12543 -> True
    cp if cp >= 0x12F90 && cp <= 0x12FF0 -> True
    cp if cp >= 0x12FF1 && cp <= 0x12FF2 -> True
    cp if cp >= 0x13000 && cp <= 0x1342F -> True
    cp if cp >= 0x13430 && cp <= 0x1343F -> True
    cp if cp >= 0x13441 && cp <= 0x13446 -> True
    cp if cp >= 0x13460 && cp <= 0x143FA -> True
    cp if cp >= 0x14400 && cp <= 0x14646 -> True
    cp if cp >= 0x16100 && cp <= 0x1611D -> True
    cp if cp >= 0x1612A && cp <= 0x1612C -> True
    cp if cp >= 0x16130 && cp <= 0x16139 -> True
    cp if cp >= 0x16800 && cp <= 0x16A38 -> True
    cp if cp >= 0x16A40 && cp <= 0x16A5E -> True
    cp if cp >= 0x16A60 && cp <= 0x16A69 -> True
    cp if cp >= 0x16A6E && cp <= 0x16A6F -> True
    cp if cp >= 0x16A70 && cp <= 0x16ABE -> True
    cp if cp >= 0x16AC0 && cp <= 0x16AC9 -> True
    cp if cp >= 0x16AD0 && cp <= 0x16AED -> True
    cp if cp == 0x16AF5 -> True
    cp if cp >= 0x16B00 && cp <= 0x16B2F -> True
    cp if cp >= 0x16B37 && cp <= 0x16B3B -> True
    cp if cp >= 0x16B3C && cp <= 0x16B3F -> True
    cp if cp >= 0x16B40 && cp <= 0x16B43 -> True
    cp if cp == 0x16B44 -> True
    cp if cp == 0x16B45 -> True
    cp if cp >= 0x16B50 && cp <= 0x16B59 -> True
    cp if cp >= 0x16B5B && cp <= 0x16B61 -> True
    cp if cp >= 0x16B63 && cp <= 0x16B77 -> True
    cp if cp >= 0x16B7D && cp <= 0x16B8F -> True
    cp if cp >= 0x16D40 && cp <= 0x16D42 -> True
    cp if cp >= 0x16D43 && cp <= 0x16D6A -> True
    cp if cp >= 0x16D6B && cp <= 0x16D6C -> True
    cp if cp >= 0x16D6D && cp <= 0x16D6F -> True
    cp if cp >= 0x16D70 && cp <= 0x16D79 -> True
    cp if cp >= 0x16E40 && cp <= 0x16E7F -> True
    cp if cp >= 0x16E80 && cp <= 0x16E96 -> True
    cp if cp >= 0x16E97 && cp <= 0x16E9A -> True
    cp if cp >= 0x16F00 && cp <= 0x16F4A -> True
    cp if cp == 0x16F50 -> True
    cp if cp >= 0x16F51 && cp <= 0x16F87 -> True
    cp if cp >= 0x16F93 && cp <= 0x16F9F -> True
    cp if cp >= 0x16FE0 && cp <= 0x16FE1 -> True
    cp if cp == 0x16FE3 -> True
    cp if cp >= 0x16FF0 && cp <= 0x16FF1 -> True
    cp if cp >= 0x17000 && cp <= 0x187F7 -> True
    cp if cp >= 0x18800 && cp <= 0x18CD5 -> True
    cp if cp >= 0x18CFF && cp <= 0x18D08 -> True
    cp if cp >= 0x1AFF0 && cp <= 0x1AFF3 -> True
    cp if cp >= 0x1AFF5 && cp <= 0x1AFFB -> True
    cp if cp >= 0x1AFFD && cp <= 0x1AFFE -> True
    cp if cp >= 0x1B000 && cp <= 0x1B122 -> True
    cp if cp == 0x1B132 -> True
    cp if cp >= 0x1B150 && cp <= 0x1B152 -> True
    cp if cp == 0x1B155 -> True
    cp if cp >= 0x1B164 && cp <= 0x1B167 -> True
    cp if cp >= 0x1B170 && cp <= 0x1B2FB -> True
    cp if cp >= 0x1BC00 && cp <= 0x1BC6A -> True
    cp if cp >= 0x1BC70 && cp <= 0x1BC7C -> True
    cp if cp >= 0x1BC80 && cp <= 0x1BC88 -> True
    cp if cp >= 0x1BC90 && cp <= 0x1BC99 -> True
    cp if cp == 0x1BC9C -> True
    cp if cp == 0x1BC9F -> True
    cp if cp >= 0x1CCD6 && cp <= 0x1CCEF -> True
    cp if cp >= 0x1CF50 && cp <= 0x1CFC3 -> True
    cp if cp >= 0x1D000 && cp <= 0x1D0F5 -> True
    cp if cp >= 0x1D100 && cp <= 0x1D126 -> True
    cp if cp >= 0x1D129 && cp <= 0x1D164 -> True
    cp if cp >= 0x1D165 && cp <= 0x1D166 -> True
    cp if cp >= 0x1D16A && cp <= 0x1D16C -> True
    cp if cp >= 0x1D16D && cp <= 0x1D172 -> True
    cp if cp >= 0x1D183 && cp <= 0x1D184 -> True
    cp if cp >= 0x1D18C && cp <= 0x1D1A9 -> True
    cp if cp >= 0x1D1AE && cp <= 0x1D1E8 -> True
    cp if cp >= 0x1D2C0 && cp <= 0x1D2D3 -> True
    cp if cp >= 0x1D2E0 && cp <= 0x1D2F3 -> True
    cp if cp >= 0x1D360 && cp <= 0x1D378 -> True
    cp if cp >= 0x1D400 && cp <= 0x1D454 -> True
    cp if cp >= 0x1D456 && cp <= 0x1D49C -> True
    cp if cp >= 0x1D49E && cp <= 0x1D49F -> True
    cp if cp == 0x1D4A2 -> True
    cp if cp >= 0x1D4A5 && cp <= 0x1D4A6 -> True
    cp if cp >= 0x1D4A9 && cp <= 0x1D4AC -> True
    cp if cp >= 0x1D4AE && cp <= 0x1D4B9 -> True
    cp if cp == 0x1D4BB -> True
    cp if cp >= 0x1D4BD && cp <= 0x1D4C3 -> True
    cp if cp >= 0x1D4C5 && cp <= 0x1D505 -> True
    cp if cp >= 0x1D507 && cp <= 0x1D50A -> True
    cp if cp >= 0x1D50D && cp <= 0x1D514 -> True
    cp if cp >= 0x1D516 && cp <= 0x1D51C -> True
    cp if cp >= 0x1D51E && cp <= 0x1D539 -> True
    cp if cp >= 0x1D53B && cp <= 0x1D53E -> True
    cp if cp >= 0x1D540 && cp <= 0x1D544 -> True
    cp if cp == 0x1D546 -> True
    cp if cp >= 0x1D54A && cp <= 0x1D550 -> True
    cp if cp >= 0x1D552 && cp <= 0x1D6A5 -> True
    cp if cp >= 0x1D6A8 && cp <= 0x1D6C0 -> True
    cp if cp >= 0x1D6C2 && cp <= 0x1D6DA -> True
    cp if cp >= 0x1D6DC && cp <= 0x1D6FA -> True
    cp if cp >= 0x1D6FC && cp <= 0x1D714 -> True
    cp if cp >= 0x1D716 && cp <= 0x1D734 -> True
    cp if cp >= 0x1D736 && cp <= 0x1D74E -> True
    cp if cp >= 0x1D750 && cp <= 0x1D76E -> True
    cp if cp >= 0x1D770 && cp <= 0x1D788 -> True
    cp if cp >= 0x1D78A && cp <= 0x1D7A8 -> True
    cp if cp >= 0x1D7AA && cp <= 0x1D7C2 -> True
    cp if cp >= 0x1D7C4 && cp <= 0x1D7CB -> True
    cp if cp >= 0x1D800 && cp <= 0x1D9FF -> True
    cp if cp >= 0x1DA37 && cp <= 0x1DA3A -> True
    cp if cp >= 0x1DA6D && cp <= 0x1DA74 -> True
    cp if cp >= 0x1DA76 && cp <= 0x1DA83 -> True
    cp if cp >= 0x1DA85 && cp <= 0x1DA86 -> True
    cp if cp >= 0x1DA87 && cp <= 0x1DA8B -> True
    cp if cp >= 0x1DF00 && cp <= 0x1DF09 -> True
    cp if cp == 0x1DF0A -> True
    cp if cp >= 0x1DF0B && cp <= 0x1DF1E -> True
    cp if cp >= 0x1DF25 && cp <= 0x1DF2A -> True
    cp if cp >= 0x1E030 && cp <= 0x1E06D -> True
    cp if cp >= 0x1E100 && cp <= 0x1E12C -> True
    cp if cp >= 0x1E137 && cp <= 0x1E13D -> True
    cp if cp >= 0x1E140 && cp <= 0x1E149 -> True
    cp if cp == 0x1E14E -> True
    cp if cp == 0x1E14F -> True
    cp if cp >= 0x1E290 && cp <= 0x1E2AD -> True
    cp if cp >= 0x1E2C0 && cp <= 0x1E2EB -> True
    cp if cp >= 0x1E2F0 && cp <= 0x1E2F9 -> True
    cp if cp >= 0x1E4D0 && cp <= 0x1E4EA -> True
    cp if cp == 0x1E4EB -> True
    cp if cp >= 0x1E4F0 && cp <= 0x1E4F9 -> True
    cp if cp >= 0x1E5D0 && cp <= 0x1E5ED -> True
    cp if cp == 0x1E5F0 -> True
    cp if cp >= 0x1E5F1 && cp <= 0x1E5FA -> True
    cp if cp == 0x1E5FF -> True
    cp if cp >= 0x1E7E0 && cp <= 0x1E7E6 -> True
    cp if cp >= 0x1E7E8 && cp <= 0x1E7EB -> True
    cp if cp >= 0x1E7ED && cp <= 0x1E7EE -> True
    cp if cp >= 0x1E7F0 && cp <= 0x1E7FE -> True
    cp if cp >= 0x1F110 && cp <= 0x1F12E -> True
    cp if cp >= 0x1F130 && cp <= 0x1F169 -> True
    cp if cp >= 0x1F170 && cp <= 0x1F1AC -> True
    cp if cp >= 0x1F1E6 && cp <= 0x1F202 -> True
    cp if cp >= 0x1F210 && cp <= 0x1F23B -> True
    cp if cp >= 0x1F240 && cp <= 0x1F248 -> True
    cp if cp >= 0x1F250 && cp <= 0x1F251 -> True
    cp if cp >= 0x20000 && cp <= 0x2A6DF -> True
    cp if cp >= 0x2A700 && cp <= 0x2B739 -> True
    cp if cp >= 0x2B740 && cp <= 0x2B81D -> True
    cp if cp >= 0x2B820 && cp <= 0x2CEA1 -> True
    cp if cp >= 0x2CEB0 && cp <= 0x2EBE0 -> True
    cp if cp >= 0x2EBF0 && cp <= 0x2EE5D -> True
    cp if cp >= 0x2F800 && cp <= 0x2FA1D -> True
    cp if cp >= 0x30000 && cp <= 0x3134A -> True
    cp if cp >= 0x31350 && cp <= 0x323AF -> True
    cp if cp >= 0xF0000 && cp <= 0xFFFFD -> True
    cp if cp >= 0x0030 && cp <= 0x0039 -> True
    cp if cp >= 0x00B2 && cp <= 0x00B3 -> True
    cp if cp == 0x00B9 -> True
    cp if cp >= 0x06F0 && cp <= 0x06F9 -> True
    cp if cp == 0x2070 -> True
    cp if cp >= 0x2074 && cp <= 0x2079 -> True
    cp if cp >= 0x2080 && cp <= 0x2089 -> True
    cp if cp >= 0x2488 && cp <= 0x249B -> True
    cp if cp >= 0xFF10 && cp <= 0xFF19 -> True
    cp if cp >= 0x102E1 && cp <= 0x102FB -> True
    cp if cp >= 0x1CCF0 && cp <= 0x1CCF9 -> True
    cp if cp >= 0x1D7CE && cp <= 0x1D7FF -> True
    cp if cp >= 0x1F100 && cp <= 0x1F10A -> True
    cp if cp >= 0x1FBF0 && cp <= 0x1FBF9 -> True
    _ -> False
  }
}

pub fn in_right_to_left_first(codepoint: Int) -> Bool {
  case codepoint {
    cp if cp == 0x05BE -> True
    cp if cp == 0x05C0 -> True
    cp if cp == 0x05C3 -> True
    cp if cp == 0x05C6 -> True
    cp if cp >= 0x05D0 && cp <= 0x05EA -> True
    cp if cp >= 0x05EF && cp <= 0x05F2 -> True
    cp if cp >= 0x05F3 && cp <= 0x05F4 -> True
    cp if cp >= 0x07C0 && cp <= 0x07C9 -> True
    cp if cp >= 0x07CA && cp <= 0x07EA -> True
    cp if cp >= 0x07F4 && cp <= 0x07F5 -> True
    cp if cp == 0x07FA -> True
    cp if cp >= 0x07FE && cp <= 0x07FF -> True
    cp if cp >= 0x0800 && cp <= 0x0815 -> True
    cp if cp == 0x081A -> True
    cp if cp == 0x0824 -> True
    cp if cp == 0x0828 -> True
    cp if cp >= 0x0830 && cp <= 0x083E -> True
    cp if cp >= 0x0840 && cp <= 0x0858 -> True
    cp if cp == 0x085E -> True
    cp if cp == 0x200F -> True
    cp if cp == 0xFB1D -> True
    cp if cp >= 0xFB1F && cp <= 0xFB28 -> True
    cp if cp >= 0xFB2A && cp <= 0xFB36 -> True
    cp if cp >= 0xFB38 && cp <= 0xFB3C -> True
    cp if cp == 0xFB3E -> True
    cp if cp >= 0xFB40 && cp <= 0xFB41 -> True
    cp if cp >= 0xFB43 && cp <= 0xFB44 -> True
    cp if cp >= 0xFB46 && cp <= 0xFB4F -> True
    cp if cp >= 0x10800 && cp <= 0x10805 -> True
    cp if cp == 0x10808 -> True
    cp if cp >= 0x1080A && cp <= 0x10835 -> True
    cp if cp >= 0x10837 && cp <= 0x10838 -> True
    cp if cp == 0x1083C -> True
    cp if cp >= 0x1083F && cp <= 0x10855 -> True
    cp if cp == 0x10857 -> True
    cp if cp >= 0x10858 && cp <= 0x1085F -> True
    cp if cp >= 0x10860 && cp <= 0x10876 -> True
    cp if cp >= 0x10877 && cp <= 0x10878 -> True
    cp if cp >= 0x10879 && cp <= 0x1087F -> True
    cp if cp >= 0x10880 && cp <= 0x1089E -> True
    cp if cp >= 0x108A7 && cp <= 0x108AF -> True
    cp if cp >= 0x108E0 && cp <= 0x108F2 -> True
    cp if cp >= 0x108F4 && cp <= 0x108F5 -> True
    cp if cp >= 0x108FB && cp <= 0x108FF -> True
    cp if cp >= 0x10900 && cp <= 0x10915 -> True
    cp if cp >= 0x10916 && cp <= 0x1091B -> True
    cp if cp >= 0x10920 && cp <= 0x10939 -> True
    cp if cp == 0x1093F -> True
    cp if cp >= 0x10980 && cp <= 0x109B7 -> True
    cp if cp >= 0x109BC && cp <= 0x109BD -> True
    cp if cp >= 0x109BE && cp <= 0x109BF -> True
    cp if cp >= 0x109C0 && cp <= 0x109CF -> True
    cp if cp >= 0x109D2 && cp <= 0x109FF -> True
    cp if cp == 0x10A00 -> True
    cp if cp >= 0x10A10 && cp <= 0x10A13 -> True
    cp if cp >= 0x10A15 && cp <= 0x10A17 -> True
    cp if cp >= 0x10A19 && cp <= 0x10A35 -> True
    cp if cp >= 0x10A40 && cp <= 0x10A48 -> True
    cp if cp >= 0x10A50 && cp <= 0x10A58 -> True
    cp if cp >= 0x10A60 && cp <= 0x10A7C -> True
    cp if cp >= 0x10A7D && cp <= 0x10A7E -> True
    cp if cp == 0x10A7F -> True
    cp if cp >= 0x10A80 && cp <= 0x10A9C -> True
    cp if cp >= 0x10A9D && cp <= 0x10A9F -> True
    cp if cp >= 0x10AC0 && cp <= 0x10AC7 -> True
    cp if cp == 0x10AC8 -> True
    cp if cp >= 0x10AC9 && cp <= 0x10AE4 -> True
    cp if cp >= 0x10AEB && cp <= 0x10AEF -> True
    cp if cp >= 0x10AF0 && cp <= 0x10AF6 -> True
    cp if cp >= 0x10B00 && cp <= 0x10B35 -> True
    cp if cp >= 0x10B40 && cp <= 0x10B55 -> True
    cp if cp >= 0x10B58 && cp <= 0x10B5F -> True
    cp if cp >= 0x10B60 && cp <= 0x10B72 -> True
    cp if cp >= 0x10B78 && cp <= 0x10B7F -> True
    cp if cp >= 0x10B80 && cp <= 0x10B91 -> True
    cp if cp >= 0x10B99 && cp <= 0x10B9C -> True
    cp if cp >= 0x10BA9 && cp <= 0x10BAF -> True
    cp if cp >= 0x10C00 && cp <= 0x10C48 -> True
    cp if cp >= 0x10C80 && cp <= 0x10CB2 -> True
    cp if cp >= 0x10CC0 && cp <= 0x10CF2 -> True
    cp if cp >= 0x10CFA && cp <= 0x10CFF -> True
    cp if cp >= 0x10D4A && cp <= 0x10D4D -> True
    cp if cp == 0x10D4E -> True
    cp if cp == 0x10D4F -> True
    cp if cp >= 0x10D50 && cp <= 0x10D65 -> True
    cp if cp == 0x10D6F -> True
    cp if cp >= 0x10D70 && cp <= 0x10D85 -> True
    cp if cp >= 0x10D8E && cp <= 0x10D8F -> True
    cp if cp >= 0x10E80 && cp <= 0x10EA9 -> True
    cp if cp == 0x10EAD -> True
    cp if cp >= 0x10EB0 && cp <= 0x10EB1 -> True
    cp if cp >= 0x10F00 && cp <= 0x10F1C -> True
    cp if cp >= 0x10F1D && cp <= 0x10F26 -> True
    cp if cp == 0x10F27 -> True
    cp if cp >= 0x10F70 && cp <= 0x10F81 -> True
    cp if cp >= 0x10F86 && cp <= 0x10F89 -> True
    cp if cp >= 0x10FB0 && cp <= 0x10FC4 -> True
    cp if cp >= 0x10FC5 && cp <= 0x10FCB -> True
    cp if cp >= 0x10FE0 && cp <= 0x10FF6 -> True
    cp if cp >= 0x1E800 && cp <= 0x1E8C4 -> True
    cp if cp >= 0x1E8C7 && cp <= 0x1E8CF -> True
    cp if cp >= 0x1E900 && cp <= 0x1E943 -> True
    cp if cp == 0x1E94B -> True
    cp if cp >= 0x1E950 && cp <= 0x1E959 -> True
    cp if cp >= 0x1E95E && cp <= 0x1E95F -> True
    cp if cp == 0x0608 -> True
    cp if cp == 0x060B -> True
    cp if cp == 0x060D -> True
    cp if cp == 0x061B -> True
    cp if cp == 0x061C -> True
    cp if cp >= 0x061D && cp <= 0x061F -> True
    cp if cp >= 0x0620 && cp <= 0x063F -> True
    cp if cp == 0x0640 -> True
    cp if cp >= 0x0641 && cp <= 0x064A -> True
    cp if cp == 0x066D -> True
    cp if cp >= 0x066E && cp <= 0x066F -> True
    cp if cp >= 0x0671 && cp <= 0x06D3 -> True
    cp if cp == 0x06D4 -> True
    cp if cp == 0x06D5 -> True
    cp if cp >= 0x06E5 && cp <= 0x06E6 -> True
    cp if cp >= 0x06EE && cp <= 0x06EF -> True
    cp if cp >= 0x06FA && cp <= 0x06FC -> True
    cp if cp >= 0x06FD && cp <= 0x06FE -> True
    cp if cp == 0x06FF -> True
    cp if cp >= 0x0700 && cp <= 0x070D -> True
    cp if cp == 0x070F -> True
    cp if cp == 0x0710 -> True
    cp if cp >= 0x0712 && cp <= 0x072F -> True
    cp if cp >= 0x074D && cp <= 0x07A5 -> True
    cp if cp == 0x07B1 -> True
    cp if cp >= 0x0860 && cp <= 0x086A -> True
    cp if cp >= 0x0870 && cp <= 0x0887 -> True
    cp if cp == 0x0888 -> True
    cp if cp >= 0x0889 && cp <= 0x088E -> True
    cp if cp >= 0x08A0 && cp <= 0x08C8 -> True
    cp if cp == 0x08C9 -> True
    cp if cp >= 0xFB50 && cp <= 0xFBB1 -> True
    cp if cp >= 0xFBB2 && cp <= 0xFBC2 -> True
    cp if cp >= 0xFBD3 && cp <= 0xFD3D -> True
    cp if cp >= 0xFD50 && cp <= 0xFD8F -> True
    cp if cp >= 0xFD92 && cp <= 0xFDC7 -> True
    cp if cp >= 0xFDF0 && cp <= 0xFDFB -> True
    cp if cp == 0xFDFC -> True
    cp if cp >= 0xFE70 && cp <= 0xFE74 -> True
    cp if cp >= 0xFE76 && cp <= 0xFEFC -> True
    cp if cp >= 0x10D00 && cp <= 0x10D23 -> True
    cp if cp >= 0x10EC2 && cp <= 0x10EC4 -> True
    cp if cp >= 0x10F30 && cp <= 0x10F45 -> True
    cp if cp >= 0x10F51 && cp <= 0x10F54 -> True
    cp if cp >= 0x10F55 && cp <= 0x10F59 -> True
    cp if cp >= 0x1EC71 && cp <= 0x1ECAB -> True
    cp if cp == 0x1ECAC -> True
    cp if cp >= 0x1ECAD && cp <= 0x1ECAF -> True
    cp if cp == 0x1ECB0 -> True
    cp if cp >= 0x1ECB1 && cp <= 0x1ECB4 -> True
    cp if cp >= 0x1ED01 && cp <= 0x1ED2D -> True
    cp if cp == 0x1ED2E -> True
    cp if cp >= 0x1ED2F && cp <= 0x1ED3D -> True
    cp if cp >= 0x1EE00 && cp <= 0x1EE03 -> True
    cp if cp >= 0x1EE05 && cp <= 0x1EE1F -> True
    cp if cp >= 0x1EE21 && cp <= 0x1EE22 -> True
    cp if cp == 0x1EE24 -> True
    cp if cp == 0x1EE27 -> True
    cp if cp >= 0x1EE29 && cp <= 0x1EE32 -> True
    cp if cp >= 0x1EE34 && cp <= 0x1EE37 -> True
    cp if cp == 0x1EE39 -> True
    cp if cp == 0x1EE3B -> True
    cp if cp == 0x1EE42 -> True
    cp if cp == 0x1EE47 -> True
    cp if cp == 0x1EE49 -> True
    cp if cp == 0x1EE4B -> True
    cp if cp >= 0x1EE4D && cp <= 0x1EE4F -> True
    cp if cp >= 0x1EE51 && cp <= 0x1EE52 -> True
    cp if cp == 0x1EE54 -> True
    cp if cp == 0x1EE57 -> True
    cp if cp == 0x1EE59 -> True
    cp if cp == 0x1EE5B -> True
    cp if cp == 0x1EE5D -> True
    cp if cp == 0x1EE5F -> True
    cp if cp >= 0x1EE61 && cp <= 0x1EE62 -> True
    cp if cp == 0x1EE64 -> True
    cp if cp >= 0x1EE67 && cp <= 0x1EE6A -> True
    cp if cp >= 0x1EE6C && cp <= 0x1EE72 -> True
    cp if cp >= 0x1EE74 && cp <= 0x1EE77 -> True
    cp if cp >= 0x1EE79 && cp <= 0x1EE7C -> True
    cp if cp == 0x1EE7E -> True
    cp if cp >= 0x1EE80 && cp <= 0x1EE89 -> True
    cp if cp >= 0x1EE8B && cp <= 0x1EE9B -> True
    cp if cp >= 0x1EEA1 && cp <= 0x1EEA3 -> True
    cp if cp >= 0x1EEA5 && cp <= 0x1EEA9 -> True
    cp if cp >= 0x1EEAB && cp <= 0x1EEBB -> True
    _ -> False
  }
}

pub fn in_right_to_left_allowed(codepoint: Int) -> Bool {
  case codepoint {
    cp if cp == 0x05BE -> True
    cp if cp == 0x05C0 -> True
    cp if cp == 0x05C3 -> True
    cp if cp == 0x05C6 -> True
    cp if cp >= 0x05D0 && cp <= 0x05EA -> True
    cp if cp >= 0x05EF && cp <= 0x05F2 -> True
    cp if cp >= 0x05F3 && cp <= 0x05F4 -> True
    cp if cp >= 0x07C0 && cp <= 0x07C9 -> True
    cp if cp >= 0x07CA && cp <= 0x07EA -> True
    cp if cp >= 0x07F4 && cp <= 0x07F5 -> True
    cp if cp == 0x07FA -> True
    cp if cp >= 0x07FE && cp <= 0x07FF -> True
    cp if cp >= 0x0800 && cp <= 0x0815 -> True
    cp if cp == 0x081A -> True
    cp if cp == 0x0824 -> True
    cp if cp == 0x0828 -> True
    cp if cp >= 0x0830 && cp <= 0x083E -> True
    cp if cp >= 0x0840 && cp <= 0x0858 -> True
    cp if cp == 0x085E -> True
    cp if cp == 0x200F -> True
    cp if cp == 0xFB1D -> True
    cp if cp >= 0xFB1F && cp <= 0xFB28 -> True
    cp if cp >= 0xFB2A && cp <= 0xFB36 -> True
    cp if cp >= 0xFB38 && cp <= 0xFB3C -> True
    cp if cp == 0xFB3E -> True
    cp if cp >= 0xFB40 && cp <= 0xFB41 -> True
    cp if cp >= 0xFB43 && cp <= 0xFB44 -> True
    cp if cp >= 0xFB46 && cp <= 0xFB4F -> True
    cp if cp >= 0x10800 && cp <= 0x10805 -> True
    cp if cp == 0x10808 -> True
    cp if cp >= 0x1080A && cp <= 0x10835 -> True
    cp if cp >= 0x10837 && cp <= 0x10838 -> True
    cp if cp == 0x1083C -> True
    cp if cp >= 0x1083F && cp <= 0x10855 -> True
    cp if cp == 0x10857 -> True
    cp if cp >= 0x10858 && cp <= 0x1085F -> True
    cp if cp >= 0x10860 && cp <= 0x10876 -> True
    cp if cp >= 0x10877 && cp <= 0x10878 -> True
    cp if cp >= 0x10879 && cp <= 0x1087F -> True
    cp if cp >= 0x10880 && cp <= 0x1089E -> True
    cp if cp >= 0x108A7 && cp <= 0x108AF -> True
    cp if cp >= 0x108E0 && cp <= 0x108F2 -> True
    cp if cp >= 0x108F4 && cp <= 0x108F5 -> True
    cp if cp >= 0x108FB && cp <= 0x108FF -> True
    cp if cp >= 0x10900 && cp <= 0x10915 -> True
    cp if cp >= 0x10916 && cp <= 0x1091B -> True
    cp if cp >= 0x10920 && cp <= 0x10939 -> True
    cp if cp == 0x1093F -> True
    cp if cp >= 0x10980 && cp <= 0x109B7 -> True
    cp if cp >= 0x109BC && cp <= 0x109BD -> True
    cp if cp >= 0x109BE && cp <= 0x109BF -> True
    cp if cp >= 0x109C0 && cp <= 0x109CF -> True
    cp if cp >= 0x109D2 && cp <= 0x109FF -> True
    cp if cp == 0x10A00 -> True
    cp if cp >= 0x10A10 && cp <= 0x10A13 -> True
    cp if cp >= 0x10A15 && cp <= 0x10A17 -> True
    cp if cp >= 0x10A19 && cp <= 0x10A35 -> True
    cp if cp >= 0x10A40 && cp <= 0x10A48 -> True
    cp if cp >= 0x10A50 && cp <= 0x10A58 -> True
    cp if cp >= 0x10A60 && cp <= 0x10A7C -> True
    cp if cp >= 0x10A7D && cp <= 0x10A7E -> True
    cp if cp == 0x10A7F -> True
    cp if cp >= 0x10A80 && cp <= 0x10A9C -> True
    cp if cp >= 0x10A9D && cp <= 0x10A9F -> True
    cp if cp >= 0x10AC0 && cp <= 0x10AC7 -> True
    cp if cp == 0x10AC8 -> True
    cp if cp >= 0x10AC9 && cp <= 0x10AE4 -> True
    cp if cp >= 0x10AEB && cp <= 0x10AEF -> True
    cp if cp >= 0x10AF0 && cp <= 0x10AF6 -> True
    cp if cp >= 0x10B00 && cp <= 0x10B35 -> True
    cp if cp >= 0x10B40 && cp <= 0x10B55 -> True
    cp if cp >= 0x10B58 && cp <= 0x10B5F -> True
    cp if cp >= 0x10B60 && cp <= 0x10B72 -> True
    cp if cp >= 0x10B78 && cp <= 0x10B7F -> True
    cp if cp >= 0x10B80 && cp <= 0x10B91 -> True
    cp if cp >= 0x10B99 && cp <= 0x10B9C -> True
    cp if cp >= 0x10BA9 && cp <= 0x10BAF -> True
    cp if cp >= 0x10C00 && cp <= 0x10C48 -> True
    cp if cp >= 0x10C80 && cp <= 0x10CB2 -> True
    cp if cp >= 0x10CC0 && cp <= 0x10CF2 -> True
    cp if cp >= 0x10CFA && cp <= 0x10CFF -> True
    cp if cp >= 0x10D4A && cp <= 0x10D4D -> True
    cp if cp == 0x10D4E -> True
    cp if cp == 0x10D4F -> True
    cp if cp >= 0x10D50 && cp <= 0x10D65 -> True
    cp if cp == 0x10D6F -> True
    cp if cp >= 0x10D70 && cp <= 0x10D85 -> True
    cp if cp >= 0x10D8E && cp <= 0x10D8F -> True
    cp if cp >= 0x10E80 && cp <= 0x10EA9 -> True
    cp if cp == 0x10EAD -> True
    cp if cp >= 0x10EB0 && cp <= 0x10EB1 -> True
    cp if cp >= 0x10F00 && cp <= 0x10F1C -> True
    cp if cp >= 0x10F1D && cp <= 0x10F26 -> True
    cp if cp == 0x10F27 -> True
    cp if cp >= 0x10F70 && cp <= 0x10F81 -> True
    cp if cp >= 0x10F86 && cp <= 0x10F89 -> True
    cp if cp >= 0x10FB0 && cp <= 0x10FC4 -> True
    cp if cp >= 0x10FC5 && cp <= 0x10FCB -> True
    cp if cp >= 0x10FE0 && cp <= 0x10FF6 -> True
    cp if cp >= 0x1E800 && cp <= 0x1E8C4 -> True
    cp if cp >= 0x1E8C7 && cp <= 0x1E8CF -> True
    cp if cp >= 0x1E900 && cp <= 0x1E943 -> True
    cp if cp == 0x1E94B -> True
    cp if cp >= 0x1E950 && cp <= 0x1E959 -> True
    cp if cp >= 0x1E95E && cp <= 0x1E95F -> True
    cp if cp >= 0x0030 && cp <= 0x0039 -> True
    cp if cp >= 0x00B2 && cp <= 0x00B3 -> True
    cp if cp == 0x00B9 -> True
    cp if cp >= 0x06F0 && cp <= 0x06F9 -> True
    cp if cp == 0x2070 -> True
    cp if cp >= 0x2074 && cp <= 0x2079 -> True
    cp if cp >= 0x2080 && cp <= 0x2089 -> True
    cp if cp >= 0x2488 && cp <= 0x249B -> True
    cp if cp >= 0xFF10 && cp <= 0xFF19 -> True
    cp if cp >= 0x102E1 && cp <= 0x102FB -> True
    cp if cp >= 0x1CCF0 && cp <= 0x1CCF9 -> True
    cp if cp >= 0x1D7CE && cp <= 0x1D7FF -> True
    cp if cp >= 0x1F100 && cp <= 0x1F10A -> True
    cp if cp >= 0x1FBF0 && cp <= 0x1FBF9 -> True
    cp if cp == 0x002B -> True
    cp if cp == 0x002D -> True
    cp if cp >= 0x207A && cp <= 0x207B -> True
    cp if cp >= 0x208A && cp <= 0x208B -> True
    cp if cp == 0x2212 -> True
    cp if cp == 0xFB29 -> True
    cp if cp == 0xFE62 -> True
    cp if cp == 0xFE63 -> True
    cp if cp == 0xFF0B -> True
    cp if cp == 0xFF0D -> True
    cp if cp == 0x0023 -> True
    cp if cp == 0x0024 -> True
    cp if cp == 0x0025 -> True
    cp if cp >= 0x00A2 && cp <= 0x00A5 -> True
    cp if cp == 0x00B0 -> True
    cp if cp == 0x00B1 -> True
    cp if cp == 0x058F -> True
    cp if cp >= 0x0609 && cp <= 0x060A -> True
    cp if cp == 0x066A -> True
    cp if cp >= 0x09F2 && cp <= 0x09F3 -> True
    cp if cp == 0x09FB -> True
    cp if cp == 0x0AF1 -> True
    cp if cp == 0x0BF9 -> True
    cp if cp == 0x0E3F -> True
    cp if cp == 0x17DB -> True
    cp if cp >= 0x2030 && cp <= 0x2034 -> True
    cp if cp >= 0x20A0 && cp <= 0x20C0 -> True
    cp if cp == 0x212E -> True
    cp if cp == 0x2213 -> True
    cp if cp == 0xA838 -> True
    cp if cp == 0xA839 -> True
    cp if cp == 0xFE5F -> True
    cp if cp == 0xFE69 -> True
    cp if cp == 0xFE6A -> True
    cp if cp == 0xFF03 -> True
    cp if cp == 0xFF04 -> True
    cp if cp == 0xFF05 -> True
    cp if cp >= 0xFFE0 && cp <= 0xFFE1 -> True
    cp if cp >= 0xFFE5 && cp <= 0xFFE6 -> True
    cp if cp >= 0x11FDD && cp <= 0x11FE0 -> True
    cp if cp == 0x1E2FF -> True
    cp if cp >= 0x0600 && cp <= 0x0605 -> True
    cp if cp >= 0x0660 && cp <= 0x0669 -> True
    cp if cp >= 0x066B && cp <= 0x066C -> True
    cp if cp == 0x06DD -> True
    cp if cp >= 0x0890 && cp <= 0x0891 -> True
    cp if cp == 0x08E2 -> True
    cp if cp >= 0x10D30 && cp <= 0x10D39 -> True
    cp if cp >= 0x10D40 && cp <= 0x10D49 -> True
    cp if cp >= 0x10E60 && cp <= 0x10E7E -> True
    cp if cp == 0x002C -> True
    cp if cp >= 0x002E && cp <= 0x002F -> True
    cp if cp == 0x003A -> True
    cp if cp == 0x00A0 -> True
    cp if cp == 0x060C -> True
    cp if cp == 0x202F -> True
    cp if cp == 0x2044 -> True
    cp if cp == 0xFE50 -> True
    cp if cp == 0xFE52 -> True
    cp if cp == 0xFE55 -> True
    cp if cp == 0xFF0C -> True
    cp if cp >= 0xFF0E && cp <= 0xFF0F -> True
    cp if cp == 0xFF1A -> True
    cp if cp >= 0x0021 && cp <= 0x0022 -> True
    cp if cp >= 0x0026 && cp <= 0x0027 -> True
    cp if cp == 0x0028 -> True
    cp if cp == 0x0029 -> True
    cp if cp == 0x002A -> True
    cp if cp == 0x003B -> True
    cp if cp >= 0x003C && cp <= 0x003E -> True
    cp if cp >= 0x003F && cp <= 0x0040 -> True
    cp if cp == 0x005B -> True
    cp if cp == 0x005C -> True
    cp if cp == 0x005D -> True
    cp if cp == 0x005E -> True
    cp if cp == 0x005F -> True
    cp if cp == 0x0060 -> True
    cp if cp == 0x007B -> True
    cp if cp == 0x007C -> True
    cp if cp == 0x007D -> True
    cp if cp == 0x007E -> True
    cp if cp == 0x00A1 -> True
    cp if cp == 0x00A6 -> True
    cp if cp == 0x00A7 -> True
    cp if cp == 0x00A8 -> True
    cp if cp == 0x00A9 -> True
    cp if cp == 0x00AB -> True
    cp if cp == 0x00AC -> True
    cp if cp == 0x00AE -> True
    cp if cp == 0x00AF -> True
    cp if cp == 0x00B4 -> True
    cp if cp >= 0x00B6 && cp <= 0x00B7 -> True
    cp if cp == 0x00B8 -> True
    cp if cp == 0x00BB -> True
    cp if cp >= 0x00BC && cp <= 0x00BE -> True
    cp if cp == 0x00BF -> True
    cp if cp == 0x00D7 -> True
    cp if cp == 0x00F7 -> True
    cp if cp >= 0x02B9 && cp <= 0x02BA -> True
    cp if cp >= 0x02C2 && cp <= 0x02C5 -> True
    cp if cp >= 0x02C6 && cp <= 0x02CF -> True
    cp if cp >= 0x02D2 && cp <= 0x02DF -> True
    cp if cp >= 0x02E5 && cp <= 0x02EB -> True
    cp if cp == 0x02EC -> True
    cp if cp == 0x02ED -> True
    cp if cp >= 0x02EF && cp <= 0x02FF -> True
    cp if cp == 0x0374 -> True
    cp if cp == 0x0375 -> True
    cp if cp == 0x037E -> True
    cp if cp >= 0x0384 && cp <= 0x0385 -> True
    cp if cp == 0x0387 -> True
    cp if cp == 0x03F6 -> True
    cp if cp == 0x058A -> True
    cp if cp >= 0x058D && cp <= 0x058E -> True
    cp if cp >= 0x0606 && cp <= 0x0607 -> True
    cp if cp >= 0x060E && cp <= 0x060F -> True
    cp if cp == 0x06DE -> True
    cp if cp == 0x06E9 -> True
    cp if cp == 0x07F6 -> True
    cp if cp >= 0x07F7 && cp <= 0x07F9 -> True
    cp if cp >= 0x0BF3 && cp <= 0x0BF8 -> True
    cp if cp == 0x0BFA -> True
    cp if cp >= 0x0C78 && cp <= 0x0C7E -> True
    cp if cp == 0x0F3A -> True
    cp if cp == 0x0F3B -> True
    cp if cp == 0x0F3C -> True
    cp if cp == 0x0F3D -> True
    cp if cp >= 0x1390 && cp <= 0x1399 -> True
    cp if cp == 0x1400 -> True
    cp if cp == 0x169B -> True
    cp if cp == 0x169C -> True
    cp if cp >= 0x17F0 && cp <= 0x17F9 -> True
    cp if cp >= 0x1800 && cp <= 0x1805 -> True
    cp if cp == 0x1806 -> True
    cp if cp >= 0x1807 && cp <= 0x180A -> True
    cp if cp == 0x1940 -> True
    cp if cp >= 0x1944 && cp <= 0x1945 -> True
    cp if cp >= 0x19DE && cp <= 0x19FF -> True
    cp if cp == 0x1FBD -> True
    cp if cp >= 0x1FBF && cp <= 0x1FC1 -> True
    cp if cp >= 0x1FCD && cp <= 0x1FCF -> True
    cp if cp >= 0x1FDD && cp <= 0x1FDF -> True
    cp if cp >= 0x1FED && cp <= 0x1FEF -> True
    cp if cp >= 0x1FFD && cp <= 0x1FFE -> True
    cp if cp >= 0x2010 && cp <= 0x2015 -> True
    cp if cp >= 0x2016 && cp <= 0x2017 -> True
    cp if cp == 0x2018 -> True
    cp if cp == 0x2019 -> True
    cp if cp == 0x201A -> True
    cp if cp >= 0x201B && cp <= 0x201C -> True
    cp if cp == 0x201D -> True
    cp if cp == 0x201E -> True
    cp if cp == 0x201F -> True
    cp if cp >= 0x2020 && cp <= 0x2027 -> True
    cp if cp >= 0x2035 && cp <= 0x2038 -> True
    cp if cp == 0x2039 -> True
    cp if cp == 0x203A -> True
    cp if cp >= 0x203B && cp <= 0x203E -> True
    cp if cp >= 0x203F && cp <= 0x2040 -> True
    cp if cp >= 0x2041 && cp <= 0x2043 -> True
    cp if cp == 0x2045 -> True
    cp if cp == 0x2046 -> True
    cp if cp >= 0x2047 && cp <= 0x2051 -> True
    cp if cp == 0x2052 -> True
    cp if cp == 0x2053 -> True
    cp if cp == 0x2054 -> True
    cp if cp >= 0x2055 && cp <= 0x205E -> True
    cp if cp == 0x207C -> True
    cp if cp == 0x207D -> True
    cp if cp == 0x207E -> True
    cp if cp == 0x208C -> True
    cp if cp == 0x208D -> True
    cp if cp == 0x208E -> True
    cp if cp >= 0x2100 && cp <= 0x2101 -> True
    cp if cp >= 0x2103 && cp <= 0x2106 -> True
    cp if cp >= 0x2108 && cp <= 0x2109 -> True
    cp if cp == 0x2114 -> True
    cp if cp >= 0x2116 && cp <= 0x2117 -> True
    cp if cp == 0x2118 -> True
    cp if cp >= 0x211E && cp <= 0x2123 -> True
    cp if cp == 0x2125 -> True
    cp if cp == 0x2127 -> True
    cp if cp == 0x2129 -> True
    cp if cp >= 0x213A && cp <= 0x213B -> True
    cp if cp >= 0x2140 && cp <= 0x2144 -> True
    cp if cp == 0x214A -> True
    cp if cp == 0x214B -> True
    cp if cp >= 0x214C && cp <= 0x214D -> True
    cp if cp >= 0x2150 && cp <= 0x215F -> True
    cp if cp == 0x2189 -> True
    cp if cp >= 0x218A && cp <= 0x218B -> True
    cp if cp >= 0x2190 && cp <= 0x2194 -> True
    cp if cp >= 0x2195 && cp <= 0x2199 -> True
    cp if cp >= 0x219A && cp <= 0x219B -> True
    cp if cp >= 0x219C && cp <= 0x219F -> True
    cp if cp == 0x21A0 -> True
    cp if cp >= 0x21A1 && cp <= 0x21A2 -> True
    cp if cp == 0x21A3 -> True
    cp if cp >= 0x21A4 && cp <= 0x21A5 -> True
    cp if cp == 0x21A6 -> True
    cp if cp >= 0x21A7 && cp <= 0x21AD -> True
    cp if cp == 0x21AE -> True
    cp if cp >= 0x21AF && cp <= 0x21CD -> True
    cp if cp >= 0x21CE && cp <= 0x21CF -> True
    cp if cp >= 0x21D0 && cp <= 0x21D1 -> True
    cp if cp == 0x21D2 -> True
    cp if cp == 0x21D3 -> True
    cp if cp == 0x21D4 -> True
    cp if cp >= 0x21D5 && cp <= 0x21F3 -> True
    cp if cp >= 0x21F4 && cp <= 0x2211 -> True
    cp if cp >= 0x2214 && cp <= 0x22FF -> True
    cp if cp >= 0x2300 && cp <= 0x2307 -> True
    cp if cp == 0x2308 -> True
    cp if cp == 0x2309 -> True
    cp if cp == 0x230A -> True
    cp if cp == 0x230B -> True
    cp if cp >= 0x230C && cp <= 0x231F -> True
    cp if cp >= 0x2320 && cp <= 0x2321 -> True
    cp if cp >= 0x2322 && cp <= 0x2328 -> True
    cp if cp == 0x2329 -> True
    cp if cp == 0x232A -> True
    cp if cp >= 0x232B && cp <= 0x2335 -> True
    cp if cp == 0x237B -> True
    cp if cp == 0x237C -> True
    cp if cp >= 0x237D && cp <= 0x2394 -> True
    cp if cp >= 0x2396 && cp <= 0x239A -> True
    cp if cp >= 0x239B && cp <= 0x23B3 -> True
    cp if cp >= 0x23B4 && cp <= 0x23DB -> True
    cp if cp >= 0x23DC && cp <= 0x23E1 -> True
    cp if cp >= 0x23E2 && cp <= 0x2429 -> True
    cp if cp >= 0x2440 && cp <= 0x244A -> True
    cp if cp >= 0x2460 && cp <= 0x2487 -> True
    cp if cp >= 0x24EA && cp <= 0x24FF -> True
    cp if cp >= 0x2500 && cp <= 0x25B6 -> True
    cp if cp == 0x25B7 -> True
    cp if cp >= 0x25B8 && cp <= 0x25C0 -> True
    cp if cp == 0x25C1 -> True
    cp if cp >= 0x25C2 && cp <= 0x25F7 -> True
    cp if cp >= 0x25F8 && cp <= 0x25FF -> True
    cp if cp >= 0x2600 && cp <= 0x266E -> True
    cp if cp == 0x266F -> True
    cp if cp >= 0x2670 && cp <= 0x26AB -> True
    cp if cp >= 0x26AD && cp <= 0x2767 -> True
    cp if cp == 0x2768 -> True
    cp if cp == 0x2769 -> True
    cp if cp == 0x276A -> True
    cp if cp == 0x276B -> True
    cp if cp == 0x276C -> True
    cp if cp == 0x276D -> True
    cp if cp == 0x276E -> True
    cp if cp == 0x276F -> True
    cp if cp == 0x2770 -> True
    cp if cp == 0x2771 -> True
    cp if cp == 0x2772 -> True
    cp if cp == 0x2773 -> True
    cp if cp == 0x2774 -> True
    cp if cp == 0x2775 -> True
    cp if cp >= 0x2776 && cp <= 0x2793 -> True
    cp if cp >= 0x2794 && cp <= 0x27BF -> True
    cp if cp >= 0x27C0 && cp <= 0x27C4 -> True
    cp if cp == 0x27C5 -> True
    cp if cp == 0x27C6 -> True
    cp if cp >= 0x27C7 && cp <= 0x27E5 -> True
    cp if cp == 0x27E6 -> True
    cp if cp == 0x27E7 -> True
    cp if cp == 0x27E8 -> True
    cp if cp == 0x27E9 -> True
    cp if cp == 0x27EA -> True
    cp if cp == 0x27EB -> True
    cp if cp == 0x27EC -> True
    cp if cp == 0x27ED -> True
    cp if cp == 0x27EE -> True
    cp if cp == 0x27EF -> True
    cp if cp >= 0x27F0 && cp <= 0x27FF -> True
    cp if cp >= 0x2900 && cp <= 0x2982 -> True
    cp if cp == 0x2983 -> True
    cp if cp == 0x2984 -> True
    cp if cp == 0x2985 -> True
    cp if cp == 0x2986 -> True
    cp if cp == 0x2987 -> True
    cp if cp == 0x2988 -> True
    cp if cp == 0x2989 -> True
    cp if cp == 0x298A -> True
    cp if cp == 0x298B -> True
    cp if cp == 0x298C -> True
    cp if cp == 0x298D -> True
    cp if cp == 0x298E -> True
    cp if cp == 0x298F -> True
    cp if cp == 0x2990 -> True
    cp if cp == 0x2991 -> True
    cp if cp == 0x2992 -> True
    cp if cp == 0x2993 -> True
    cp if cp == 0x2994 -> True
    cp if cp == 0x2995 -> True
    cp if cp == 0x2996 -> True
    cp if cp == 0x2997 -> True
    cp if cp == 0x2998 -> True
    cp if cp >= 0x2999 && cp <= 0x29D7 -> True
    cp if cp == 0x29D8 -> True
    cp if cp == 0x29D9 -> True
    cp if cp == 0x29DA -> True
    cp if cp == 0x29DB -> True
    cp if cp >= 0x29DC && cp <= 0x29FB -> True
    cp if cp == 0x29FC -> True
    cp if cp == 0x29FD -> True
    cp if cp >= 0x29FE && cp <= 0x2AFF -> True
    cp if cp >= 0x2B00 && cp <= 0x2B2F -> True
    cp if cp >= 0x2B30 && cp <= 0x2B44 -> True
    cp if cp >= 0x2B45 && cp <= 0x2B46 -> True
    cp if cp >= 0x2B47 && cp <= 0x2B4C -> True
    cp if cp >= 0x2B4D && cp <= 0x2B73 -> True
    cp if cp >= 0x2B76 && cp <= 0x2B95 -> True
    cp if cp >= 0x2B97 && cp <= 0x2BFF -> True
    cp if cp >= 0x2CE5 && cp <= 0x2CEA -> True
    cp if cp >= 0x2CF9 && cp <= 0x2CFC -> True
    cp if cp == 0x2CFD -> True
    cp if cp >= 0x2CFE && cp <= 0x2CFF -> True
    cp if cp >= 0x2E00 && cp <= 0x2E01 -> True
    cp if cp == 0x2E02 -> True
    cp if cp == 0x2E03 -> True
    cp if cp == 0x2E04 -> True
    cp if cp == 0x2E05 -> True
    cp if cp >= 0x2E06 && cp <= 0x2E08 -> True
    cp if cp == 0x2E09 -> True
    cp if cp == 0x2E0A -> True
    cp if cp == 0x2E0B -> True
    cp if cp == 0x2E0C -> True
    cp if cp == 0x2E0D -> True
    cp if cp >= 0x2E0E && cp <= 0x2E16 -> True
    cp if cp == 0x2E17 -> True
    cp if cp >= 0x2E18 && cp <= 0x2E19 -> True
    cp if cp == 0x2E1A -> True
    cp if cp == 0x2E1B -> True
    cp if cp == 0x2E1C -> True
    cp if cp == 0x2E1D -> True
    cp if cp >= 0x2E1E && cp <= 0x2E1F -> True
    cp if cp == 0x2E20 -> True
    cp if cp == 0x2E21 -> True
    cp if cp == 0x2E22 -> True
    cp if cp == 0x2E23 -> True
    cp if cp == 0x2E24 -> True
    cp if cp == 0x2E25 -> True
    cp if cp == 0x2E26 -> True
    cp if cp == 0x2E27 -> True
    cp if cp == 0x2E28 -> True
    cp if cp == 0x2E29 -> True
    cp if cp >= 0x2E2A && cp <= 0x2E2E -> True
    cp if cp == 0x2E2F -> True
    cp if cp >= 0x2E30 && cp <= 0x2E39 -> True
    cp if cp >= 0x2E3A && cp <= 0x2E3B -> True
    cp if cp >= 0x2E3C && cp <= 0x2E3F -> True
    cp if cp == 0x2E40 -> True
    cp if cp == 0x2E41 -> True
    cp if cp == 0x2E42 -> True
    cp if cp >= 0x2E43 && cp <= 0x2E4F -> True
    cp if cp >= 0x2E50 && cp <= 0x2E51 -> True
    cp if cp >= 0x2E52 && cp <= 0x2E54 -> True
    cp if cp == 0x2E55 -> True
    cp if cp == 0x2E56 -> True
    cp if cp == 0x2E57 -> True
    cp if cp == 0x2E58 -> True
    cp if cp == 0x2E59 -> True
    cp if cp == 0x2E5A -> True
    cp if cp == 0x2E5B -> True
    cp if cp == 0x2E5C -> True
    cp if cp == 0x2E5D -> True
    cp if cp >= 0x2E80 && cp <= 0x2E99 -> True
    cp if cp >= 0x2E9B && cp <= 0x2EF3 -> True
    cp if cp >= 0x2F00 && cp <= 0x2FD5 -> True
    cp if cp >= 0x2FF0 && cp <= 0x2FFF -> True
    cp if cp >= 0x3001 && cp <= 0x3003 -> True
    cp if cp == 0x3004 -> True
    cp if cp == 0x3008 -> True
    cp if cp == 0x3009 -> True
    cp if cp == 0x300A -> True
    cp if cp == 0x300B -> True
    cp if cp == 0x300C -> True
    cp if cp == 0x300D -> True
    cp if cp == 0x300E -> True
    cp if cp == 0x300F -> True
    cp if cp == 0x3010 -> True
    cp if cp == 0x3011 -> True
    cp if cp >= 0x3012 && cp <= 0x3013 -> True
    cp if cp == 0x3014 -> True
    cp if cp == 0x3015 -> True
    cp if cp == 0x3016 -> True
    cp if cp == 0x3017 -> True
    cp if cp == 0x3018 -> True
    cp if cp == 0x3019 -> True
    cp if cp == 0x301A -> True
    cp if cp == 0x301B -> True
    cp if cp == 0x301C -> True
    cp if cp == 0x301D -> True
    cp if cp >= 0x301E && cp <= 0x301F -> True
    cp if cp == 0x3020 -> True
    cp if cp == 0x3030 -> True
    cp if cp >= 0x3036 && cp <= 0x3037 -> True
    cp if cp == 0x303D -> True
    cp if cp >= 0x303E && cp <= 0x303F -> True
    cp if cp >= 0x309B && cp <= 0x309C -> True
    cp if cp == 0x30A0 -> True
    cp if cp == 0x30FB -> True
    cp if cp >= 0x31C0 && cp <= 0x31E5 -> True
    cp if cp == 0x31EF -> True
    cp if cp >= 0x321D && cp <= 0x321E -> True
    cp if cp == 0x3250 -> True
    cp if cp >= 0x3251 && cp <= 0x325F -> True
    cp if cp >= 0x327C && cp <= 0x327E -> True
    cp if cp >= 0x32B1 && cp <= 0x32BF -> True
    cp if cp >= 0x32CC && cp <= 0x32CF -> True
    cp if cp >= 0x3377 && cp <= 0x337A -> True
    cp if cp >= 0x33DE && cp <= 0x33DF -> True
    cp if cp == 0x33FF -> True
    cp if cp >= 0x4DC0 && cp <= 0x4DFF -> True
    cp if cp >= 0xA490 && cp <= 0xA4C6 -> True
    cp if cp >= 0xA60D && cp <= 0xA60F -> True
    cp if cp == 0xA673 -> True
    cp if cp == 0xA67E -> True
    cp if cp == 0xA67F -> True
    cp if cp >= 0xA700 && cp <= 0xA716 -> True
    cp if cp >= 0xA717 && cp <= 0xA71F -> True
    cp if cp >= 0xA720 && cp <= 0xA721 -> True
    cp if cp == 0xA788 -> True
    cp if cp >= 0xA828 && cp <= 0xA82B -> True
    cp if cp >= 0xA874 && cp <= 0xA877 -> True
    cp if cp >= 0xAB6A && cp <= 0xAB6B -> True
    cp if cp == 0xFD3E -> True
    cp if cp == 0xFD3F -> True
    cp if cp >= 0xFD40 && cp <= 0xFD4F -> True
    cp if cp == 0xFDCF -> True
    cp if cp >= 0xFDFD && cp <= 0xFDFF -> True
    cp if cp >= 0xFE10 && cp <= 0xFE16 -> True
    cp if cp == 0xFE17 -> True
    cp if cp == 0xFE18 -> True
    cp if cp == 0xFE19 -> True
    cp if cp == 0xFE30 -> True
    cp if cp >= 0xFE31 && cp <= 0xFE32 -> True
    cp if cp >= 0xFE33 && cp <= 0xFE34 -> True
    cp if cp == 0xFE35 -> True
    cp if cp == 0xFE36 -> True
    cp if cp == 0xFE37 -> True
    cp if cp == 0xFE38 -> True
    cp if cp == 0xFE39 -> True
    cp if cp == 0xFE3A -> True
    cp if cp == 0xFE3B -> True
    cp if cp == 0xFE3C -> True
    cp if cp == 0xFE3D -> True
    cp if cp == 0xFE3E -> True
    cp if cp == 0xFE3F -> True
    cp if cp == 0xFE40 -> True
    cp if cp == 0xFE41 -> True
    cp if cp == 0xFE42 -> True
    cp if cp == 0xFE43 -> True
    cp if cp == 0xFE44 -> True
    cp if cp >= 0xFE45 && cp <= 0xFE46 -> True
    cp if cp == 0xFE47 -> True
    cp if cp == 0xFE48 -> True
    cp if cp >= 0xFE49 && cp <= 0xFE4C -> True
    cp if cp >= 0xFE4D && cp <= 0xFE4F -> True
    cp if cp == 0xFE51 -> True
    cp if cp == 0xFE54 -> True
    cp if cp >= 0xFE56 && cp <= 0xFE57 -> True
    cp if cp == 0xFE58 -> True
    cp if cp == 0xFE59 -> True
    cp if cp == 0xFE5A -> True
    cp if cp == 0xFE5B -> True
    cp if cp == 0xFE5C -> True
    cp if cp == 0xFE5D -> True
    cp if cp == 0xFE5E -> True
    cp if cp >= 0xFE60 && cp <= 0xFE61 -> True
    cp if cp >= 0xFE64 && cp <= 0xFE66 -> True
    cp if cp == 0xFE68 -> True
    cp if cp == 0xFE6B -> True
    cp if cp >= 0xFF01 && cp <= 0xFF02 -> True
    cp if cp >= 0xFF06 && cp <= 0xFF07 -> True
    cp if cp == 0xFF08 -> True
    cp if cp == 0xFF09 -> True
    cp if cp == 0xFF0A -> True
    cp if cp == 0xFF1B -> True
    cp if cp >= 0xFF1C && cp <= 0xFF1E -> True
    cp if cp >= 0xFF1F && cp <= 0xFF20 -> True
    cp if cp == 0xFF3B -> True
    cp if cp == 0xFF3C -> True
    cp if cp == 0xFF3D -> True
    cp if cp == 0xFF3E -> True
    cp if cp == 0xFF3F -> True
    cp if cp == 0xFF40 -> True
    cp if cp == 0xFF5B -> True
    cp if cp == 0xFF5C -> True
    cp if cp == 0xFF5D -> True
    cp if cp == 0xFF5E -> True
    cp if cp == 0xFF5F -> True
    cp if cp == 0xFF60 -> True
    cp if cp == 0xFF61 -> True
    cp if cp == 0xFF62 -> True
    cp if cp == 0xFF63 -> True
    cp if cp >= 0xFF64 && cp <= 0xFF65 -> True
    cp if cp == 0xFFE2 -> True
    cp if cp == 0xFFE3 -> True
    cp if cp == 0xFFE4 -> True
    cp if cp == 0xFFE8 -> True
    cp if cp >= 0xFFE9 && cp <= 0xFFEC -> True
    cp if cp >= 0xFFED && cp <= 0xFFEE -> True
    cp if cp >= 0xFFF9 && cp <= 0xFFFB -> True
    cp if cp >= 0xFFFC && cp <= 0xFFFD -> True
    cp if cp == 0x10101 -> True
    cp if cp >= 0x10140 && cp <= 0x10174 -> True
    cp if cp >= 0x10175 && cp <= 0x10178 -> True
    cp if cp >= 0x10179 && cp <= 0x10189 -> True
    cp if cp >= 0x1018A && cp <= 0x1018B -> True
    cp if cp == 0x1018C -> True
    cp if cp >= 0x10190 && cp <= 0x1019C -> True
    cp if cp == 0x101A0 -> True
    cp if cp == 0x1091F -> True
    cp if cp >= 0x10B39 && cp <= 0x10B3F -> True
    cp if cp == 0x10D6E -> True
    cp if cp >= 0x11052 && cp <= 0x11065 -> True
    cp if cp >= 0x11660 && cp <= 0x1166C -> True
    cp if cp >= 0x11FD5 && cp <= 0x11FDC -> True
    cp if cp >= 0x11FE1 && cp <= 0x11FF1 -> True
    cp if cp == 0x16FE2 -> True
    cp if cp >= 0x1CC00 && cp <= 0x1CCD5 -> True
    cp if cp >= 0x1CD00 && cp <= 0x1CEB3 -> True
    cp if cp >= 0x1D1E9 && cp <= 0x1D1EA -> True
    cp if cp >= 0x1D200 && cp <= 0x1D241 -> True
    cp if cp == 0x1D245 -> True
    cp if cp >= 0x1D300 && cp <= 0x1D356 -> True
    cp if cp == 0x1D6C1 -> True
    cp if cp == 0x1D6DB -> True
    cp if cp == 0x1D6FB -> True
    cp if cp == 0x1D715 -> True
    cp if cp == 0x1D735 -> True
    cp if cp == 0x1D74F -> True
    cp if cp == 0x1D76F -> True
    cp if cp == 0x1D789 -> True
    cp if cp == 0x1D7A9 -> True
    cp if cp == 0x1D7C3 -> True
    cp if cp >= 0x1EEF0 && cp <= 0x1EEF1 -> True
    cp if cp >= 0x1F000 && cp <= 0x1F02B -> True
    cp if cp >= 0x1F030 && cp <= 0x1F093 -> True
    cp if cp >= 0x1F0A0 && cp <= 0x1F0AE -> True
    cp if cp >= 0x1F0B1 && cp <= 0x1F0BF -> True
    cp if cp >= 0x1F0C1 && cp <= 0x1F0CF -> True
    cp if cp >= 0x1F0D1 && cp <= 0x1F0F5 -> True
    cp if cp >= 0x1F10B && cp <= 0x1F10C -> True
    cp if cp >= 0x1F10D && cp <= 0x1F10F -> True
    cp if cp == 0x1F12F -> True
    cp if cp >= 0x1F16A && cp <= 0x1F16F -> True
    cp if cp == 0x1F1AD -> True
    cp if cp >= 0x1F260 && cp <= 0x1F265 -> True
    cp if cp >= 0x1F300 && cp <= 0x1F3FA -> True
    cp if cp >= 0x1F3FB && cp <= 0x1F3FF -> True
    cp if cp >= 0x1F400 && cp <= 0x1F6D7 -> True
    cp if cp >= 0x1F6DC && cp <= 0x1F6EC -> True
    cp if cp >= 0x1F6F0 && cp <= 0x1F6FC -> True
    cp if cp >= 0x1F700 && cp <= 0x1F776 -> True
    cp if cp >= 0x1F77B && cp <= 0x1F7D9 -> True
    cp if cp >= 0x1F7E0 && cp <= 0x1F7EB -> True
    cp if cp == 0x1F7F0 -> True
    cp if cp >= 0x1F800 && cp <= 0x1F80B -> True
    cp if cp >= 0x1F810 && cp <= 0x1F847 -> True
    cp if cp >= 0x1F850 && cp <= 0x1F859 -> True
    cp if cp >= 0x1F860 && cp <= 0x1F887 -> True
    cp if cp >= 0x1F890 && cp <= 0x1F8AD -> True
    cp if cp >= 0x1F8B0 && cp <= 0x1F8BB -> True
    cp if cp >= 0x1F8C0 && cp <= 0x1F8C1 -> True
    cp if cp >= 0x1F900 && cp <= 0x1FA53 -> True
    cp if cp >= 0x1FA60 && cp <= 0x1FA6D -> True
    cp if cp >= 0x1FA70 && cp <= 0x1FA7C -> True
    cp if cp >= 0x1FA80 && cp <= 0x1FA89 -> True
    cp if cp >= 0x1FA8F && cp <= 0x1FAC6 -> True
    cp if cp >= 0x1FACE && cp <= 0x1FADC -> True
    cp if cp >= 0x1FADF && cp <= 0x1FAE9 -> True
    cp if cp >= 0x1FAF0 && cp <= 0x1FAF8 -> True
    cp if cp >= 0x1FB00 && cp <= 0x1FB92 -> True
    cp if cp >= 0x1FB94 && cp <= 0x1FBEF -> True
    cp if cp >= 0x0000 && cp <= 0x0008 -> True
    cp if cp >= 0x000E && cp <= 0x001B -> True
    cp if cp >= 0x007F && cp <= 0x0084 -> True
    cp if cp >= 0x0086 && cp <= 0x009F -> True
    cp if cp == 0x00AD -> True
    cp if cp == 0x180E -> True
    cp if cp >= 0x200B && cp <= 0x200D -> True
    cp if cp >= 0x2060 && cp <= 0x2064 -> True
    cp if cp == 0x2065 -> True
    cp if cp >= 0x206A && cp <= 0x206F -> True
    cp if cp >= 0xFDD0 && cp <= 0xFDEF -> True
    cp if cp == 0xFEFF -> True
    cp if cp >= 0xFFF0 && cp <= 0xFFF8 -> True
    cp if cp >= 0xFFFE && cp <= 0xFFFF -> True
    cp if cp >= 0x1BCA0 && cp <= 0x1BCA3 -> True
    cp if cp >= 0x1D173 && cp <= 0x1D17A -> True
    cp if cp >= 0x1FFFE && cp <= 0x1FFFF -> True
    cp if cp >= 0x2FFFE && cp <= 0x2FFFF -> True
    cp if cp >= 0x3FFFE && cp <= 0x3FFFF -> True
    cp if cp >= 0x4FFFE && cp <= 0x4FFFF -> True
    cp if cp >= 0x5FFFE && cp <= 0x5FFFF -> True
    cp if cp >= 0x6FFFE && cp <= 0x6FFFF -> True
    cp if cp >= 0x7FFFE && cp <= 0x7FFFF -> True
    cp if cp >= 0x8FFFE && cp <= 0x8FFFF -> True
    cp if cp >= 0x9FFFE && cp <= 0x9FFFF -> True
    cp if cp >= 0xAFFFE && cp <= 0xAFFFF -> True
    cp if cp >= 0xBFFFE && cp <= 0xBFFFF -> True
    cp if cp >= 0xCFFFE && cp <= 0xCFFFF -> True
    cp if cp >= 0xDFFFE && cp <= 0xE0000 -> True
    cp if cp == 0xE0001 -> True
    cp if cp >= 0xE0002 && cp <= 0xE001F -> True
    cp if cp >= 0xE0020 && cp <= 0xE007F -> True
    cp if cp >= 0xE0080 && cp <= 0xE00FF -> True
    cp if cp >= 0xE01F0 && cp <= 0xE0FFF -> True
    cp if cp >= 0xEFFFE && cp <= 0xEFFFF -> True
    cp if cp >= 0xFFFFE && cp <= 0xFFFFF -> True
    cp if cp >= 0x0300 && cp <= 0x036F -> True
    cp if cp >= 0x0483 && cp <= 0x0487 -> True
    cp if cp >= 0x0488 && cp <= 0x0489 -> True
    cp if cp >= 0x0591 && cp <= 0x05BD -> True
    cp if cp == 0x05BF -> True
    cp if cp >= 0x05C1 && cp <= 0x05C2 -> True
    cp if cp >= 0x05C4 && cp <= 0x05C5 -> True
    cp if cp == 0x05C7 -> True
    cp if cp >= 0x0610 && cp <= 0x061A -> True
    cp if cp >= 0x064B && cp <= 0x065F -> True
    cp if cp == 0x0670 -> True
    cp if cp >= 0x06D6 && cp <= 0x06DC -> True
    cp if cp >= 0x06DF && cp <= 0x06E4 -> True
    cp if cp >= 0x06E7 && cp <= 0x06E8 -> True
    cp if cp >= 0x06EA && cp <= 0x06ED -> True
    cp if cp == 0x0711 -> True
    cp if cp >= 0x0730 && cp <= 0x074A -> True
    cp if cp >= 0x07A6 && cp <= 0x07B0 -> True
    cp if cp >= 0x07EB && cp <= 0x07F3 -> True
    cp if cp == 0x07FD -> True
    cp if cp >= 0x0816 && cp <= 0x0819 -> True
    cp if cp >= 0x081B && cp <= 0x0823 -> True
    cp if cp >= 0x0825 && cp <= 0x0827 -> True
    cp if cp >= 0x0829 && cp <= 0x082D -> True
    cp if cp >= 0x0859 && cp <= 0x085B -> True
    cp if cp >= 0x0897 && cp <= 0x089F -> True
    cp if cp >= 0x08CA && cp <= 0x08E1 -> True
    cp if cp >= 0x08E3 && cp <= 0x0902 -> True
    cp if cp == 0x093A -> True
    cp if cp == 0x093C -> True
    cp if cp >= 0x0941 && cp <= 0x0948 -> True
    cp if cp == 0x094D -> True
    cp if cp >= 0x0951 && cp <= 0x0957 -> True
    cp if cp >= 0x0962 && cp <= 0x0963 -> True
    cp if cp == 0x0981 -> True
    cp if cp == 0x09BC -> True
    cp if cp >= 0x09C1 && cp <= 0x09C4 -> True
    cp if cp == 0x09CD -> True
    cp if cp >= 0x09E2 && cp <= 0x09E3 -> True
    cp if cp == 0x09FE -> True
    cp if cp >= 0x0A01 && cp <= 0x0A02 -> True
    cp if cp == 0x0A3C -> True
    cp if cp >= 0x0A41 && cp <= 0x0A42 -> True
    cp if cp >= 0x0A47 && cp <= 0x0A48 -> True
    cp if cp >= 0x0A4B && cp <= 0x0A4D -> True
    cp if cp == 0x0A51 -> True
    cp if cp >= 0x0A70 && cp <= 0x0A71 -> True
    cp if cp == 0x0A75 -> True
    cp if cp >= 0x0A81 && cp <= 0x0A82 -> True
    cp if cp == 0x0ABC -> True
    cp if cp >= 0x0AC1 && cp <= 0x0AC5 -> True
    cp if cp >= 0x0AC7 && cp <= 0x0AC8 -> True
    cp if cp == 0x0ACD -> True
    cp if cp >= 0x0AE2 && cp <= 0x0AE3 -> True
    cp if cp >= 0x0AFA && cp <= 0x0AFF -> True
    cp if cp == 0x0B01 -> True
    cp if cp == 0x0B3C -> True
    cp if cp == 0x0B3F -> True
    cp if cp >= 0x0B41 && cp <= 0x0B44 -> True
    cp if cp == 0x0B4D -> True
    cp if cp >= 0x0B55 && cp <= 0x0B56 -> True
    cp if cp >= 0x0B62 && cp <= 0x0B63 -> True
    cp if cp == 0x0B82 -> True
    cp if cp == 0x0BC0 -> True
    cp if cp == 0x0BCD -> True
    cp if cp == 0x0C00 -> True
    cp if cp == 0x0C04 -> True
    cp if cp == 0x0C3C -> True
    cp if cp >= 0x0C3E && cp <= 0x0C40 -> True
    cp if cp >= 0x0C46 && cp <= 0x0C48 -> True
    cp if cp >= 0x0C4A && cp <= 0x0C4D -> True
    cp if cp >= 0x0C55 && cp <= 0x0C56 -> True
    cp if cp >= 0x0C62 && cp <= 0x0C63 -> True
    cp if cp == 0x0C81 -> True
    cp if cp == 0x0CBC -> True
    cp if cp >= 0x0CCC && cp <= 0x0CCD -> True
    cp if cp >= 0x0CE2 && cp <= 0x0CE3 -> True
    cp if cp >= 0x0D00 && cp <= 0x0D01 -> True
    cp if cp >= 0x0D3B && cp <= 0x0D3C -> True
    cp if cp >= 0x0D41 && cp <= 0x0D44 -> True
    cp if cp == 0x0D4D -> True
    cp if cp >= 0x0D62 && cp <= 0x0D63 -> True
    cp if cp == 0x0D81 -> True
    cp if cp == 0x0DCA -> True
    cp if cp >= 0x0DD2 && cp <= 0x0DD4 -> True
    cp if cp == 0x0DD6 -> True
    cp if cp == 0x0E31 -> True
    cp if cp >= 0x0E34 && cp <= 0x0E3A -> True
    cp if cp >= 0x0E47 && cp <= 0x0E4E -> True
    cp if cp == 0x0EB1 -> True
    cp if cp >= 0x0EB4 && cp <= 0x0EBC -> True
    cp if cp >= 0x0EC8 && cp <= 0x0ECE -> True
    cp if cp >= 0x0F18 && cp <= 0x0F19 -> True
    cp if cp == 0x0F35 -> True
    cp if cp == 0x0F37 -> True
    cp if cp == 0x0F39 -> True
    cp if cp >= 0x0F71 && cp <= 0x0F7E -> True
    cp if cp >= 0x0F80 && cp <= 0x0F84 -> True
    cp if cp >= 0x0F86 && cp <= 0x0F87 -> True
    cp if cp >= 0x0F8D && cp <= 0x0F97 -> True
    cp if cp >= 0x0F99 && cp <= 0x0FBC -> True
    cp if cp == 0x0FC6 -> True
    cp if cp >= 0x102D && cp <= 0x1030 -> True
    cp if cp >= 0x1032 && cp <= 0x1037 -> True
    cp if cp >= 0x1039 && cp <= 0x103A -> True
    cp if cp >= 0x103D && cp <= 0x103E -> True
    cp if cp >= 0x1058 && cp <= 0x1059 -> True
    cp if cp >= 0x105E && cp <= 0x1060 -> True
    cp if cp >= 0x1071 && cp <= 0x1074 -> True
    cp if cp == 0x1082 -> True
    cp if cp >= 0x1085 && cp <= 0x1086 -> True
    cp if cp == 0x108D -> True
    cp if cp == 0x109D -> True
    cp if cp >= 0x135D && cp <= 0x135F -> True
    cp if cp >= 0x1712 && cp <= 0x1714 -> True
    cp if cp >= 0x1732 && cp <= 0x1733 -> True
    cp if cp >= 0x1752 && cp <= 0x1753 -> True
    cp if cp >= 0x1772 && cp <= 0x1773 -> True
    cp if cp >= 0x17B4 && cp <= 0x17B5 -> True
    cp if cp >= 0x17B7 && cp <= 0x17BD -> True
    cp if cp == 0x17C6 -> True
    cp if cp >= 0x17C9 && cp <= 0x17D3 -> True
    cp if cp == 0x17DD -> True
    cp if cp >= 0x180B && cp <= 0x180D -> True
    cp if cp == 0x180F -> True
    cp if cp >= 0x1885 && cp <= 0x1886 -> True
    cp if cp == 0x18A9 -> True
    cp if cp >= 0x1920 && cp <= 0x1922 -> True
    cp if cp >= 0x1927 && cp <= 0x1928 -> True
    cp if cp == 0x1932 -> True
    cp if cp >= 0x1939 && cp <= 0x193B -> True
    cp if cp >= 0x1A17 && cp <= 0x1A18 -> True
    cp if cp == 0x1A1B -> True
    cp if cp == 0x1A56 -> True
    cp if cp >= 0x1A58 && cp <= 0x1A5E -> True
    cp if cp == 0x1A60 -> True
    cp if cp == 0x1A62 -> True
    cp if cp >= 0x1A65 && cp <= 0x1A6C -> True
    cp if cp >= 0x1A73 && cp <= 0x1A7C -> True
    cp if cp == 0x1A7F -> True
    cp if cp >= 0x1AB0 && cp <= 0x1ABD -> True
    cp if cp == 0x1ABE -> True
    cp if cp >= 0x1ABF && cp <= 0x1ACE -> True
    cp if cp >= 0x1B00 && cp <= 0x1B03 -> True
    cp if cp == 0x1B34 -> True
    cp if cp >= 0x1B36 && cp <= 0x1B3A -> True
    cp if cp == 0x1B3C -> True
    cp if cp == 0x1B42 -> True
    cp if cp >= 0x1B6B && cp <= 0x1B73 -> True
    cp if cp >= 0x1B80 && cp <= 0x1B81 -> True
    cp if cp >= 0x1BA2 && cp <= 0x1BA5 -> True
    cp if cp >= 0x1BA8 && cp <= 0x1BA9 -> True
    cp if cp >= 0x1BAB && cp <= 0x1BAD -> True
    cp if cp == 0x1BE6 -> True
    cp if cp >= 0x1BE8 && cp <= 0x1BE9 -> True
    cp if cp == 0x1BED -> True
    cp if cp >= 0x1BEF && cp <= 0x1BF1 -> True
    cp if cp >= 0x1C2C && cp <= 0x1C33 -> True
    cp if cp >= 0x1C36 && cp <= 0x1C37 -> True
    cp if cp >= 0x1CD0 && cp <= 0x1CD2 -> True
    cp if cp >= 0x1CD4 && cp <= 0x1CE0 -> True
    cp if cp >= 0x1CE2 && cp <= 0x1CE8 -> True
    cp if cp == 0x1CED -> True
    cp if cp == 0x1CF4 -> True
    cp if cp >= 0x1CF8 && cp <= 0x1CF9 -> True
    cp if cp >= 0x1DC0 && cp <= 0x1DFF -> True
    cp if cp >= 0x20D0 && cp <= 0x20DC -> True
    cp if cp >= 0x20DD && cp <= 0x20E0 -> True
    cp if cp == 0x20E1 -> True
    cp if cp >= 0x20E2 && cp <= 0x20E4 -> True
    cp if cp >= 0x20E5 && cp <= 0x20F0 -> True
    cp if cp >= 0x2CEF && cp <= 0x2CF1 -> True
    cp if cp == 0x2D7F -> True
    cp if cp >= 0x2DE0 && cp <= 0x2DFF -> True
    cp if cp >= 0x302A && cp <= 0x302D -> True
    cp if cp >= 0x3099 && cp <= 0x309A -> True
    cp if cp == 0xA66F -> True
    cp if cp >= 0xA670 && cp <= 0xA672 -> True
    cp if cp >= 0xA674 && cp <= 0xA67D -> True
    cp if cp >= 0xA69E && cp <= 0xA69F -> True
    cp if cp >= 0xA6F0 && cp <= 0xA6F1 -> True
    cp if cp == 0xA802 -> True
    cp if cp == 0xA806 -> True
    cp if cp == 0xA80B -> True
    cp if cp >= 0xA825 && cp <= 0xA826 -> True
    cp if cp == 0xA82C -> True
    cp if cp >= 0xA8C4 && cp <= 0xA8C5 -> True
    cp if cp >= 0xA8E0 && cp <= 0xA8F1 -> True
    cp if cp == 0xA8FF -> True
    cp if cp >= 0xA926 && cp <= 0xA92D -> True
    cp if cp >= 0xA947 && cp <= 0xA951 -> True
    cp if cp >= 0xA980 && cp <= 0xA982 -> True
    cp if cp == 0xA9B3 -> True
    cp if cp >= 0xA9B6 && cp <= 0xA9B9 -> True
    cp if cp >= 0xA9BC && cp <= 0xA9BD -> True
    cp if cp == 0xA9E5 -> True
    cp if cp >= 0xAA29 && cp <= 0xAA2E -> True
    cp if cp >= 0xAA31 && cp <= 0xAA32 -> True
    cp if cp >= 0xAA35 && cp <= 0xAA36 -> True
    cp if cp == 0xAA43 -> True
    cp if cp == 0xAA4C -> True
    cp if cp == 0xAA7C -> True
    cp if cp == 0xAAB0 -> True
    cp if cp >= 0xAAB2 && cp <= 0xAAB4 -> True
    cp if cp >= 0xAAB7 && cp <= 0xAAB8 -> True
    cp if cp >= 0xAABE && cp <= 0xAABF -> True
    cp if cp == 0xAAC1 -> True
    cp if cp >= 0xAAEC && cp <= 0xAAED -> True
    cp if cp == 0xAAF6 -> True
    cp if cp == 0xABE5 -> True
    cp if cp == 0xABE8 -> True
    cp if cp == 0xABED -> True
    cp if cp == 0xFB1E -> True
    cp if cp >= 0xFE00 && cp <= 0xFE0F -> True
    cp if cp >= 0xFE20 && cp <= 0xFE2F -> True
    cp if cp == 0x101FD -> True
    cp if cp == 0x102E0 -> True
    cp if cp >= 0x10376 && cp <= 0x1037A -> True
    cp if cp >= 0x10A01 && cp <= 0x10A03 -> True
    cp if cp >= 0x10A05 && cp <= 0x10A06 -> True
    cp if cp >= 0x10A0C && cp <= 0x10A0F -> True
    cp if cp >= 0x10A38 && cp <= 0x10A3A -> True
    cp if cp == 0x10A3F -> True
    cp if cp >= 0x10AE5 && cp <= 0x10AE6 -> True
    cp if cp >= 0x10D24 && cp <= 0x10D27 -> True
    cp if cp >= 0x10D69 && cp <= 0x10D6D -> True
    cp if cp >= 0x10EAB && cp <= 0x10EAC -> True
    cp if cp >= 0x10EFC && cp <= 0x10EFF -> True
    cp if cp >= 0x10F46 && cp <= 0x10F50 -> True
    cp if cp >= 0x10F82 && cp <= 0x10F85 -> True
    cp if cp == 0x11001 -> True
    cp if cp >= 0x11038 && cp <= 0x11046 -> True
    cp if cp == 0x11070 -> True
    cp if cp >= 0x11073 && cp <= 0x11074 -> True
    cp if cp >= 0x1107F && cp <= 0x11081 -> True
    cp if cp >= 0x110B3 && cp <= 0x110B6 -> True
    cp if cp >= 0x110B9 && cp <= 0x110BA -> True
    cp if cp == 0x110C2 -> True
    cp if cp >= 0x11100 && cp <= 0x11102 -> True
    cp if cp >= 0x11127 && cp <= 0x1112B -> True
    cp if cp >= 0x1112D && cp <= 0x11134 -> True
    cp if cp == 0x11173 -> True
    cp if cp >= 0x11180 && cp <= 0x11181 -> True
    cp if cp >= 0x111B6 && cp <= 0x111BE -> True
    cp if cp >= 0x111C9 && cp <= 0x111CC -> True
    cp if cp == 0x111CF -> True
    cp if cp >= 0x1122F && cp <= 0x11231 -> True
    cp if cp == 0x11234 -> True
    cp if cp >= 0x11236 && cp <= 0x11237 -> True
    cp if cp == 0x1123E -> True
    cp if cp == 0x11241 -> True
    cp if cp == 0x112DF -> True
    cp if cp >= 0x112E3 && cp <= 0x112EA -> True
    cp if cp >= 0x11300 && cp <= 0x11301 -> True
    cp if cp >= 0x1133B && cp <= 0x1133C -> True
    cp if cp == 0x11340 -> True
    cp if cp >= 0x11366 && cp <= 0x1136C -> True
    cp if cp >= 0x11370 && cp <= 0x11374 -> True
    cp if cp >= 0x113BB && cp <= 0x113C0 -> True
    cp if cp == 0x113CE -> True
    cp if cp == 0x113D0 -> True
    cp if cp == 0x113D2 -> True
    cp if cp >= 0x113E1 && cp <= 0x113E2 -> True
    cp if cp >= 0x11438 && cp <= 0x1143F -> True
    cp if cp >= 0x11442 && cp <= 0x11444 -> True
    cp if cp == 0x11446 -> True
    cp if cp == 0x1145E -> True
    cp if cp >= 0x114B3 && cp <= 0x114B8 -> True
    cp if cp == 0x114BA -> True
    cp if cp >= 0x114BF && cp <= 0x114C0 -> True
    cp if cp >= 0x114C2 && cp <= 0x114C3 -> True
    cp if cp >= 0x115B2 && cp <= 0x115B5 -> True
    cp if cp >= 0x115BC && cp <= 0x115BD -> True
    cp if cp >= 0x115BF && cp <= 0x115C0 -> True
    cp if cp >= 0x115DC && cp <= 0x115DD -> True
    cp if cp >= 0x11633 && cp <= 0x1163A -> True
    cp if cp == 0x1163D -> True
    cp if cp >= 0x1163F && cp <= 0x11640 -> True
    cp if cp == 0x116AB -> True
    cp if cp == 0x116AD -> True
    cp if cp >= 0x116B0 && cp <= 0x116B5 -> True
    cp if cp == 0x116B7 -> True
    cp if cp == 0x1171D -> True
    cp if cp == 0x1171F -> True
    cp if cp >= 0x11722 && cp <= 0x11725 -> True
    cp if cp >= 0x11727 && cp <= 0x1172B -> True
    cp if cp >= 0x1182F && cp <= 0x11837 -> True
    cp if cp >= 0x11839 && cp <= 0x1183A -> True
    cp if cp >= 0x1193B && cp <= 0x1193C -> True
    cp if cp == 0x1193E -> True
    cp if cp == 0x11943 -> True
    cp if cp >= 0x119D4 && cp <= 0x119D7 -> True
    cp if cp >= 0x119DA && cp <= 0x119DB -> True
    cp if cp == 0x119E0 -> True
    cp if cp >= 0x11A01 && cp <= 0x11A06 -> True
    cp if cp >= 0x11A09 && cp <= 0x11A0A -> True
    cp if cp >= 0x11A33 && cp <= 0x11A38 -> True
    cp if cp >= 0x11A3B && cp <= 0x11A3E -> True
    cp if cp == 0x11A47 -> True
    cp if cp >= 0x11A51 && cp <= 0x11A56 -> True
    cp if cp >= 0x11A59 && cp <= 0x11A5B -> True
    cp if cp >= 0x11A8A && cp <= 0x11A96 -> True
    cp if cp >= 0x11A98 && cp <= 0x11A99 -> True
    cp if cp >= 0x11C30 && cp <= 0x11C36 -> True
    cp if cp >= 0x11C38 && cp <= 0x11C3D -> True
    cp if cp >= 0x11C92 && cp <= 0x11CA7 -> True
    cp if cp >= 0x11CAA && cp <= 0x11CB0 -> True
    cp if cp >= 0x11CB2 && cp <= 0x11CB3 -> True
    cp if cp >= 0x11CB5 && cp <= 0x11CB6 -> True
    cp if cp >= 0x11D31 && cp <= 0x11D36 -> True
    cp if cp == 0x11D3A -> True
    cp if cp >= 0x11D3C && cp <= 0x11D3D -> True
    cp if cp >= 0x11D3F && cp <= 0x11D45 -> True
    cp if cp == 0x11D47 -> True
    cp if cp >= 0x11D90 && cp <= 0x11D91 -> True
    cp if cp == 0x11D95 -> True
    cp if cp == 0x11D97 -> True
    cp if cp >= 0x11EF3 && cp <= 0x11EF4 -> True
    cp if cp >= 0x11F00 && cp <= 0x11F01 -> True
    cp if cp >= 0x11F36 && cp <= 0x11F3A -> True
    cp if cp == 0x11F40 -> True
    cp if cp == 0x11F42 -> True
    cp if cp == 0x11F5A -> True
    cp if cp == 0x13440 -> True
    cp if cp >= 0x13447 && cp <= 0x13455 -> True
    cp if cp >= 0x1611E && cp <= 0x16129 -> True
    cp if cp >= 0x1612D && cp <= 0x1612F -> True
    cp if cp >= 0x16AF0 && cp <= 0x16AF4 -> True
    cp if cp >= 0x16B30 && cp <= 0x16B36 -> True
    cp if cp == 0x16F4F -> True
    cp if cp >= 0x16F8F && cp <= 0x16F92 -> True
    cp if cp == 0x16FE4 -> True
    cp if cp >= 0x1BC9D && cp <= 0x1BC9E -> True
    cp if cp >= 0x1CF00 && cp <= 0x1CF2D -> True
    cp if cp >= 0x1CF30 && cp <= 0x1CF46 -> True
    cp if cp >= 0x1D167 && cp <= 0x1D169 -> True
    cp if cp >= 0x1D17B && cp <= 0x1D182 -> True
    cp if cp >= 0x1D185 && cp <= 0x1D18B -> True
    cp if cp >= 0x1D1AA && cp <= 0x1D1AD -> True
    cp if cp >= 0x1D242 && cp <= 0x1D244 -> True
    cp if cp >= 0x1DA00 && cp <= 0x1DA36 -> True
    cp if cp >= 0x1DA3B && cp <= 0x1DA6C -> True
    cp if cp == 0x1DA75 -> True
    cp if cp == 0x1DA84 -> True
    cp if cp >= 0x1DA9B && cp <= 0x1DA9F -> True
    cp if cp >= 0x1DAA1 && cp <= 0x1DAAF -> True
    cp if cp >= 0x1E000 && cp <= 0x1E006 -> True
    cp if cp >= 0x1E008 && cp <= 0x1E018 -> True
    cp if cp >= 0x1E01B && cp <= 0x1E021 -> True
    cp if cp >= 0x1E023 && cp <= 0x1E024 -> True
    cp if cp >= 0x1E026 && cp <= 0x1E02A -> True
    cp if cp == 0x1E08F -> True
    cp if cp >= 0x1E130 && cp <= 0x1E136 -> True
    cp if cp == 0x1E2AE -> True
    cp if cp >= 0x1E2EC && cp <= 0x1E2EF -> True
    cp if cp >= 0x1E4EC && cp <= 0x1E4EF -> True
    cp if cp >= 0x1E5EE && cp <= 0x1E5EF -> True
    cp if cp >= 0x1E8D0 && cp <= 0x1E8D6 -> True
    cp if cp >= 0x1E944 && cp <= 0x1E94A -> True
    cp if cp >= 0xE0100 && cp <= 0xE01EF -> True
    cp if cp == 0x0608 -> True
    cp if cp == 0x060B -> True
    cp if cp == 0x060D -> True
    cp if cp == 0x061B -> True
    cp if cp == 0x061C -> True
    cp if cp >= 0x061D && cp <= 0x061F -> True
    cp if cp >= 0x0620 && cp <= 0x063F -> True
    cp if cp == 0x0640 -> True
    cp if cp >= 0x0641 && cp <= 0x064A -> True
    cp if cp == 0x066D -> True
    cp if cp >= 0x066E && cp <= 0x066F -> True
    cp if cp >= 0x0671 && cp <= 0x06D3 -> True
    cp if cp == 0x06D4 -> True
    cp if cp == 0x06D5 -> True
    cp if cp >= 0x06E5 && cp <= 0x06E6 -> True
    cp if cp >= 0x06EE && cp <= 0x06EF -> True
    cp if cp >= 0x06FA && cp <= 0x06FC -> True
    cp if cp >= 0x06FD && cp <= 0x06FE -> True
    cp if cp == 0x06FF -> True
    cp if cp >= 0x0700 && cp <= 0x070D -> True
    cp if cp == 0x070F -> True
    cp if cp == 0x0710 -> True
    cp if cp >= 0x0712 && cp <= 0x072F -> True
    cp if cp >= 0x074D && cp <= 0x07A5 -> True
    cp if cp == 0x07B1 -> True
    cp if cp >= 0x0860 && cp <= 0x086A -> True
    cp if cp >= 0x0870 && cp <= 0x0887 -> True
    cp if cp == 0x0888 -> True
    cp if cp >= 0x0889 && cp <= 0x088E -> True
    cp if cp >= 0x08A0 && cp <= 0x08C8 -> True
    cp if cp == 0x08C9 -> True
    cp if cp >= 0xFB50 && cp <= 0xFBB1 -> True
    cp if cp >= 0xFBB2 && cp <= 0xFBC2 -> True
    cp if cp >= 0xFBD3 && cp <= 0xFD3D -> True
    cp if cp >= 0xFD50 && cp <= 0xFD8F -> True
    cp if cp >= 0xFD92 && cp <= 0xFDC7 -> True
    cp if cp >= 0xFDF0 && cp <= 0xFDFB -> True
    cp if cp == 0xFDFC -> True
    cp if cp >= 0xFE70 && cp <= 0xFE74 -> True
    cp if cp >= 0xFE76 && cp <= 0xFEFC -> True
    cp if cp >= 0x10D00 && cp <= 0x10D23 -> True
    cp if cp >= 0x10EC2 && cp <= 0x10EC4 -> True
    cp if cp >= 0x10F30 && cp <= 0x10F45 -> True
    cp if cp >= 0x10F51 && cp <= 0x10F54 -> True
    cp if cp >= 0x10F55 && cp <= 0x10F59 -> True
    cp if cp >= 0x1EC71 && cp <= 0x1ECAB -> True
    cp if cp == 0x1ECAC -> True
    cp if cp >= 0x1ECAD && cp <= 0x1ECAF -> True
    cp if cp == 0x1ECB0 -> True
    cp if cp >= 0x1ECB1 && cp <= 0x1ECB4 -> True
    cp if cp >= 0x1ED01 && cp <= 0x1ED2D -> True
    cp if cp == 0x1ED2E -> True
    cp if cp >= 0x1ED2F && cp <= 0x1ED3D -> True
    cp if cp >= 0x1EE00 && cp <= 0x1EE03 -> True
    cp if cp >= 0x1EE05 && cp <= 0x1EE1F -> True
    cp if cp >= 0x1EE21 && cp <= 0x1EE22 -> True
    cp if cp == 0x1EE24 -> True
    cp if cp == 0x1EE27 -> True
    cp if cp >= 0x1EE29 && cp <= 0x1EE32 -> True
    cp if cp >= 0x1EE34 && cp <= 0x1EE37 -> True
    cp if cp == 0x1EE39 -> True
    cp if cp == 0x1EE3B -> True
    cp if cp == 0x1EE42 -> True
    cp if cp == 0x1EE47 -> True
    cp if cp == 0x1EE49 -> True
    cp if cp == 0x1EE4B -> True
    cp if cp >= 0x1EE4D && cp <= 0x1EE4F -> True
    cp if cp >= 0x1EE51 && cp <= 0x1EE52 -> True
    cp if cp == 0x1EE54 -> True
    cp if cp == 0x1EE57 -> True
    cp if cp == 0x1EE59 -> True
    cp if cp == 0x1EE5B -> True
    cp if cp == 0x1EE5D -> True
    cp if cp == 0x1EE5F -> True
    cp if cp >= 0x1EE61 && cp <= 0x1EE62 -> True
    cp if cp == 0x1EE64 -> True
    cp if cp >= 0x1EE67 && cp <= 0x1EE6A -> True
    cp if cp >= 0x1EE6C && cp <= 0x1EE72 -> True
    cp if cp >= 0x1EE74 && cp <= 0x1EE77 -> True
    cp if cp >= 0x1EE79 && cp <= 0x1EE7C -> True
    cp if cp == 0x1EE7E -> True
    cp if cp >= 0x1EE80 && cp <= 0x1EE89 -> True
    cp if cp >= 0x1EE8B && cp <= 0x1EE9B -> True
    cp if cp >= 0x1EEA1 && cp <= 0x1EEA3 -> True
    cp if cp >= 0x1EEA5 && cp <= 0x1EEA9 -> True
    cp if cp >= 0x1EEAB && cp <= 0x1EEBB -> True
    _ -> False
  }
}

pub fn in_right_to_left_last(codepoint: Int) -> Bool {
  case codepoint {
    cp if cp == 0x05BE -> True
    cp if cp == 0x05C0 -> True
    cp if cp == 0x05C3 -> True
    cp if cp == 0x05C6 -> True
    cp if cp >= 0x05D0 && cp <= 0x05EA -> True
    cp if cp >= 0x05EF && cp <= 0x05F2 -> True
    cp if cp >= 0x05F3 && cp <= 0x05F4 -> True
    cp if cp >= 0x07C0 && cp <= 0x07C9 -> True
    cp if cp >= 0x07CA && cp <= 0x07EA -> True
    cp if cp >= 0x07F4 && cp <= 0x07F5 -> True
    cp if cp == 0x07FA -> True
    cp if cp >= 0x07FE && cp <= 0x07FF -> True
    cp if cp >= 0x0800 && cp <= 0x0815 -> True
    cp if cp == 0x081A -> True
    cp if cp == 0x0824 -> True
    cp if cp == 0x0828 -> True
    cp if cp >= 0x0830 && cp <= 0x083E -> True
    cp if cp >= 0x0840 && cp <= 0x0858 -> True
    cp if cp == 0x085E -> True
    cp if cp == 0x200F -> True
    cp if cp == 0xFB1D -> True
    cp if cp >= 0xFB1F && cp <= 0xFB28 -> True
    cp if cp >= 0xFB2A && cp <= 0xFB36 -> True
    cp if cp >= 0xFB38 && cp <= 0xFB3C -> True
    cp if cp == 0xFB3E -> True
    cp if cp >= 0xFB40 && cp <= 0xFB41 -> True
    cp if cp >= 0xFB43 && cp <= 0xFB44 -> True
    cp if cp >= 0xFB46 && cp <= 0xFB4F -> True
    cp if cp >= 0x10800 && cp <= 0x10805 -> True
    cp if cp == 0x10808 -> True
    cp if cp >= 0x1080A && cp <= 0x10835 -> True
    cp if cp >= 0x10837 && cp <= 0x10838 -> True
    cp if cp == 0x1083C -> True
    cp if cp >= 0x1083F && cp <= 0x10855 -> True
    cp if cp == 0x10857 -> True
    cp if cp >= 0x10858 && cp <= 0x1085F -> True
    cp if cp >= 0x10860 && cp <= 0x10876 -> True
    cp if cp >= 0x10877 && cp <= 0x10878 -> True
    cp if cp >= 0x10879 && cp <= 0x1087F -> True
    cp if cp >= 0x10880 && cp <= 0x1089E -> True
    cp if cp >= 0x108A7 && cp <= 0x108AF -> True
    cp if cp >= 0x108E0 && cp <= 0x108F2 -> True
    cp if cp >= 0x108F4 && cp <= 0x108F5 -> True
    cp if cp >= 0x108FB && cp <= 0x108FF -> True
    cp if cp >= 0x10900 && cp <= 0x10915 -> True
    cp if cp >= 0x10916 && cp <= 0x1091B -> True
    cp if cp >= 0x10920 && cp <= 0x10939 -> True
    cp if cp == 0x1093F -> True
    cp if cp >= 0x10980 && cp <= 0x109B7 -> True
    cp if cp >= 0x109BC && cp <= 0x109BD -> True
    cp if cp >= 0x109BE && cp <= 0x109BF -> True
    cp if cp >= 0x109C0 && cp <= 0x109CF -> True
    cp if cp >= 0x109D2 && cp <= 0x109FF -> True
    cp if cp == 0x10A00 -> True
    cp if cp >= 0x10A10 && cp <= 0x10A13 -> True
    cp if cp >= 0x10A15 && cp <= 0x10A17 -> True
    cp if cp >= 0x10A19 && cp <= 0x10A35 -> True
    cp if cp >= 0x10A40 && cp <= 0x10A48 -> True
    cp if cp >= 0x10A50 && cp <= 0x10A58 -> True
    cp if cp >= 0x10A60 && cp <= 0x10A7C -> True
    cp if cp >= 0x10A7D && cp <= 0x10A7E -> True
    cp if cp == 0x10A7F -> True
    cp if cp >= 0x10A80 && cp <= 0x10A9C -> True
    cp if cp >= 0x10A9D && cp <= 0x10A9F -> True
    cp if cp >= 0x10AC0 && cp <= 0x10AC7 -> True
    cp if cp == 0x10AC8 -> True
    cp if cp >= 0x10AC9 && cp <= 0x10AE4 -> True
    cp if cp >= 0x10AEB && cp <= 0x10AEF -> True
    cp if cp >= 0x10AF0 && cp <= 0x10AF6 -> True
    cp if cp >= 0x10B00 && cp <= 0x10B35 -> True
    cp if cp >= 0x10B40 && cp <= 0x10B55 -> True
    cp if cp >= 0x10B58 && cp <= 0x10B5F -> True
    cp if cp >= 0x10B60 && cp <= 0x10B72 -> True
    cp if cp >= 0x10B78 && cp <= 0x10B7F -> True
    cp if cp >= 0x10B80 && cp <= 0x10B91 -> True
    cp if cp >= 0x10B99 && cp <= 0x10B9C -> True
    cp if cp >= 0x10BA9 && cp <= 0x10BAF -> True
    cp if cp >= 0x10C00 && cp <= 0x10C48 -> True
    cp if cp >= 0x10C80 && cp <= 0x10CB2 -> True
    cp if cp >= 0x10CC0 && cp <= 0x10CF2 -> True
    cp if cp >= 0x10CFA && cp <= 0x10CFF -> True
    cp if cp >= 0x10D4A && cp <= 0x10D4D -> True
    cp if cp == 0x10D4E -> True
    cp if cp == 0x10D4F -> True
    cp if cp >= 0x10D50 && cp <= 0x10D65 -> True
    cp if cp == 0x10D6F -> True
    cp if cp >= 0x10D70 && cp <= 0x10D85 -> True
    cp if cp >= 0x10D8E && cp <= 0x10D8F -> True
    cp if cp >= 0x10E80 && cp <= 0x10EA9 -> True
    cp if cp == 0x10EAD -> True
    cp if cp >= 0x10EB0 && cp <= 0x10EB1 -> True
    cp if cp >= 0x10F00 && cp <= 0x10F1C -> True
    cp if cp >= 0x10F1D && cp <= 0x10F26 -> True
    cp if cp == 0x10F27 -> True
    cp if cp >= 0x10F70 && cp <= 0x10F81 -> True
    cp if cp >= 0x10F86 && cp <= 0x10F89 -> True
    cp if cp >= 0x10FB0 && cp <= 0x10FC4 -> True
    cp if cp >= 0x10FC5 && cp <= 0x10FCB -> True
    cp if cp >= 0x10FE0 && cp <= 0x10FF6 -> True
    cp if cp >= 0x1E800 && cp <= 0x1E8C4 -> True
    cp if cp >= 0x1E8C7 && cp <= 0x1E8CF -> True
    cp if cp >= 0x1E900 && cp <= 0x1E943 -> True
    cp if cp == 0x1E94B -> True
    cp if cp >= 0x1E950 && cp <= 0x1E959 -> True
    cp if cp >= 0x1E95E && cp <= 0x1E95F -> True
    cp if cp >= 0x0030 && cp <= 0x0039 -> True
    cp if cp >= 0x00B2 && cp <= 0x00B3 -> True
    cp if cp == 0x00B9 -> True
    cp if cp >= 0x06F0 && cp <= 0x06F9 -> True
    cp if cp == 0x2070 -> True
    cp if cp >= 0x2074 && cp <= 0x2079 -> True
    cp if cp >= 0x2080 && cp <= 0x2089 -> True
    cp if cp >= 0x2488 && cp <= 0x249B -> True
    cp if cp >= 0xFF10 && cp <= 0xFF19 -> True
    cp if cp >= 0x102E1 && cp <= 0x102FB -> True
    cp if cp >= 0x1CCF0 && cp <= 0x1CCF9 -> True
    cp if cp >= 0x1D7CE && cp <= 0x1D7FF -> True
    cp if cp >= 0x1F100 && cp <= 0x1F10A -> True
    cp if cp >= 0x1FBF0 && cp <= 0x1FBF9 -> True
    cp if cp >= 0x0600 && cp <= 0x0605 -> True
    cp if cp >= 0x0660 && cp <= 0x0669 -> True
    cp if cp >= 0x066B && cp <= 0x066C -> True
    cp if cp == 0x06DD -> True
    cp if cp >= 0x0890 && cp <= 0x0891 -> True
    cp if cp == 0x08E2 -> True
    cp if cp >= 0x10D30 && cp <= 0x10D39 -> True
    cp if cp >= 0x10D40 && cp <= 0x10D49 -> True
    cp if cp >= 0x10E60 && cp <= 0x10E7E -> True
    cp if cp == 0x0608 -> True
    cp if cp == 0x060B -> True
    cp if cp == 0x060D -> True
    cp if cp == 0x061B -> True
    cp if cp == 0x061C -> True
    cp if cp >= 0x061D && cp <= 0x061F -> True
    cp if cp >= 0x0620 && cp <= 0x063F -> True
    cp if cp == 0x0640 -> True
    cp if cp >= 0x0641 && cp <= 0x064A -> True
    cp if cp == 0x066D -> True
    cp if cp >= 0x066E && cp <= 0x066F -> True
    cp if cp >= 0x0671 && cp <= 0x06D3 -> True
    cp if cp == 0x06D4 -> True
    cp if cp == 0x06D5 -> True
    cp if cp >= 0x06E5 && cp <= 0x06E6 -> True
    cp if cp >= 0x06EE && cp <= 0x06EF -> True
    cp if cp >= 0x06FA && cp <= 0x06FC -> True
    cp if cp >= 0x06FD && cp <= 0x06FE -> True
    cp if cp == 0x06FF -> True
    cp if cp >= 0x0700 && cp <= 0x070D -> True
    cp if cp == 0x070F -> True
    cp if cp == 0x0710 -> True
    cp if cp >= 0x0712 && cp <= 0x072F -> True
    cp if cp >= 0x074D && cp <= 0x07A5 -> True
    cp if cp == 0x07B1 -> True
    cp if cp >= 0x0860 && cp <= 0x086A -> True
    cp if cp >= 0x0870 && cp <= 0x0887 -> True
    cp if cp == 0x0888 -> True
    cp if cp >= 0x0889 && cp <= 0x088E -> True
    cp if cp >= 0x08A0 && cp <= 0x08C8 -> True
    cp if cp == 0x08C9 -> True
    cp if cp >= 0xFB50 && cp <= 0xFBB1 -> True
    cp if cp >= 0xFBB2 && cp <= 0xFBC2 -> True
    cp if cp >= 0xFBD3 && cp <= 0xFD3D -> True
    cp if cp >= 0xFD50 && cp <= 0xFD8F -> True
    cp if cp >= 0xFD92 && cp <= 0xFDC7 -> True
    cp if cp >= 0xFDF0 && cp <= 0xFDFB -> True
    cp if cp == 0xFDFC -> True
    cp if cp >= 0xFE70 && cp <= 0xFE74 -> True
    cp if cp >= 0xFE76 && cp <= 0xFEFC -> True
    cp if cp >= 0x10D00 && cp <= 0x10D23 -> True
    cp if cp >= 0x10EC2 && cp <= 0x10EC4 -> True
    cp if cp >= 0x10F30 && cp <= 0x10F45 -> True
    cp if cp >= 0x10F51 && cp <= 0x10F54 -> True
    cp if cp >= 0x10F55 && cp <= 0x10F59 -> True
    cp if cp >= 0x1EC71 && cp <= 0x1ECAB -> True
    cp if cp == 0x1ECAC -> True
    cp if cp >= 0x1ECAD && cp <= 0x1ECAF -> True
    cp if cp == 0x1ECB0 -> True
    cp if cp >= 0x1ECB1 && cp <= 0x1ECB4 -> True
    cp if cp >= 0x1ED01 && cp <= 0x1ED2D -> True
    cp if cp == 0x1ED2E -> True
    cp if cp >= 0x1ED2F && cp <= 0x1ED3D -> True
    cp if cp >= 0x1EE00 && cp <= 0x1EE03 -> True
    cp if cp >= 0x1EE05 && cp <= 0x1EE1F -> True
    cp if cp >= 0x1EE21 && cp <= 0x1EE22 -> True
    cp if cp == 0x1EE24 -> True
    cp if cp == 0x1EE27 -> True
    cp if cp >= 0x1EE29 && cp <= 0x1EE32 -> True
    cp if cp >= 0x1EE34 && cp <= 0x1EE37 -> True
    cp if cp == 0x1EE39 -> True
    cp if cp == 0x1EE3B -> True
    cp if cp == 0x1EE42 -> True
    cp if cp == 0x1EE47 -> True
    cp if cp == 0x1EE49 -> True
    cp if cp == 0x1EE4B -> True
    cp if cp >= 0x1EE4D && cp <= 0x1EE4F -> True
    cp if cp >= 0x1EE51 && cp <= 0x1EE52 -> True
    cp if cp == 0x1EE54 -> True
    cp if cp == 0x1EE57 -> True
    cp if cp == 0x1EE59 -> True
    cp if cp == 0x1EE5B -> True
    cp if cp == 0x1EE5D -> True
    cp if cp == 0x1EE5F -> True
    cp if cp >= 0x1EE61 && cp <= 0x1EE62 -> True
    cp if cp == 0x1EE64 -> True
    cp if cp >= 0x1EE67 && cp <= 0x1EE6A -> True
    cp if cp >= 0x1EE6C && cp <= 0x1EE72 -> True
    cp if cp >= 0x1EE74 && cp <= 0x1EE77 -> True
    cp if cp >= 0x1EE79 && cp <= 0x1EE7C -> True
    cp if cp == 0x1EE7E -> True
    cp if cp >= 0x1EE80 && cp <= 0x1EE89 -> True
    cp if cp >= 0x1EE8B && cp <= 0x1EE9B -> True
    cp if cp >= 0x1EEA1 && cp <= 0x1EEA3 -> True
    cp if cp >= 0x1EEA5 && cp <= 0x1EEA9 -> True
    cp if cp >= 0x1EEAB && cp <= 0x1EEBB -> True
    _ -> False
  }
}

pub fn in_non_spacing_mark(codepoint: Int) -> Bool {
  case codepoint {
    cp if cp >= 0x0300 && cp <= 0x036F -> True
    cp if cp >= 0x0483 && cp <= 0x0487 -> True
    cp if cp >= 0x0488 && cp <= 0x0489 -> True
    cp if cp >= 0x0591 && cp <= 0x05BD -> True
    cp if cp == 0x05BF -> True
    cp if cp >= 0x05C1 && cp <= 0x05C2 -> True
    cp if cp >= 0x05C4 && cp <= 0x05C5 -> True
    cp if cp == 0x05C7 -> True
    cp if cp >= 0x0610 && cp <= 0x061A -> True
    cp if cp >= 0x064B && cp <= 0x065F -> True
    cp if cp == 0x0670 -> True
    cp if cp >= 0x06D6 && cp <= 0x06DC -> True
    cp if cp >= 0x06DF && cp <= 0x06E4 -> True
    cp if cp >= 0x06E7 && cp <= 0x06E8 -> True
    cp if cp >= 0x06EA && cp <= 0x06ED -> True
    cp if cp == 0x0711 -> True
    cp if cp >= 0x0730 && cp <= 0x074A -> True
    cp if cp >= 0x07A6 && cp <= 0x07B0 -> True
    cp if cp >= 0x07EB && cp <= 0x07F3 -> True
    cp if cp == 0x07FD -> True
    cp if cp >= 0x0816 && cp <= 0x0819 -> True
    cp if cp >= 0x081B && cp <= 0x0823 -> True
    cp if cp >= 0x0825 && cp <= 0x0827 -> True
    cp if cp >= 0x0829 && cp <= 0x082D -> True
    cp if cp >= 0x0859 && cp <= 0x085B -> True
    cp if cp >= 0x0897 && cp <= 0x089F -> True
    cp if cp >= 0x08CA && cp <= 0x08E1 -> True
    cp if cp >= 0x08E3 && cp <= 0x0902 -> True
    cp if cp == 0x093A -> True
    cp if cp == 0x093C -> True
    cp if cp >= 0x0941 && cp <= 0x0948 -> True
    cp if cp == 0x094D -> True
    cp if cp >= 0x0951 && cp <= 0x0957 -> True
    cp if cp >= 0x0962 && cp <= 0x0963 -> True
    cp if cp == 0x0981 -> True
    cp if cp == 0x09BC -> True
    cp if cp >= 0x09C1 && cp <= 0x09C4 -> True
    cp if cp == 0x09CD -> True
    cp if cp >= 0x09E2 && cp <= 0x09E3 -> True
    cp if cp == 0x09FE -> True
    cp if cp >= 0x0A01 && cp <= 0x0A02 -> True
    cp if cp == 0x0A3C -> True
    cp if cp >= 0x0A41 && cp <= 0x0A42 -> True
    cp if cp >= 0x0A47 && cp <= 0x0A48 -> True
    cp if cp >= 0x0A4B && cp <= 0x0A4D -> True
    cp if cp == 0x0A51 -> True
    cp if cp >= 0x0A70 && cp <= 0x0A71 -> True
    cp if cp == 0x0A75 -> True
    cp if cp >= 0x0A81 && cp <= 0x0A82 -> True
    cp if cp == 0x0ABC -> True
    cp if cp >= 0x0AC1 && cp <= 0x0AC5 -> True
    cp if cp >= 0x0AC7 && cp <= 0x0AC8 -> True
    cp if cp == 0x0ACD -> True
    cp if cp >= 0x0AE2 && cp <= 0x0AE3 -> True
    cp if cp >= 0x0AFA && cp <= 0x0AFF -> True
    cp if cp == 0x0B01 -> True
    cp if cp == 0x0B3C -> True
    cp if cp == 0x0B3F -> True
    cp if cp >= 0x0B41 && cp <= 0x0B44 -> True
    cp if cp == 0x0B4D -> True
    cp if cp >= 0x0B55 && cp <= 0x0B56 -> True
    cp if cp >= 0x0B62 && cp <= 0x0B63 -> True
    cp if cp == 0x0B82 -> True
    cp if cp == 0x0BC0 -> True
    cp if cp == 0x0BCD -> True
    cp if cp == 0x0C00 -> True
    cp if cp == 0x0C04 -> True
    cp if cp == 0x0C3C -> True
    cp if cp >= 0x0C3E && cp <= 0x0C40 -> True
    cp if cp >= 0x0C46 && cp <= 0x0C48 -> True
    cp if cp >= 0x0C4A && cp <= 0x0C4D -> True
    cp if cp >= 0x0C55 && cp <= 0x0C56 -> True
    cp if cp >= 0x0C62 && cp <= 0x0C63 -> True
    cp if cp == 0x0C81 -> True
    cp if cp == 0x0CBC -> True
    cp if cp >= 0x0CCC && cp <= 0x0CCD -> True
    cp if cp >= 0x0CE2 && cp <= 0x0CE3 -> True
    cp if cp >= 0x0D00 && cp <= 0x0D01 -> True
    cp if cp >= 0x0D3B && cp <= 0x0D3C -> True
    cp if cp >= 0x0D41 && cp <= 0x0D44 -> True
    cp if cp == 0x0D4D -> True
    cp if cp >= 0x0D62 && cp <= 0x0D63 -> True
    cp if cp == 0x0D81 -> True
    cp if cp == 0x0DCA -> True
    cp if cp >= 0x0DD2 && cp <= 0x0DD4 -> True
    cp if cp == 0x0DD6 -> True
    cp if cp == 0x0E31 -> True
    cp if cp >= 0x0E34 && cp <= 0x0E3A -> True
    cp if cp >= 0x0E47 && cp <= 0x0E4E -> True
    cp if cp == 0x0EB1 -> True
    cp if cp >= 0x0EB4 && cp <= 0x0EBC -> True
    cp if cp >= 0x0EC8 && cp <= 0x0ECE -> True
    cp if cp >= 0x0F18 && cp <= 0x0F19 -> True
    cp if cp == 0x0F35 -> True
    cp if cp == 0x0F37 -> True
    cp if cp == 0x0F39 -> True
    cp if cp >= 0x0F71 && cp <= 0x0F7E -> True
    cp if cp >= 0x0F80 && cp <= 0x0F84 -> True
    cp if cp >= 0x0F86 && cp <= 0x0F87 -> True
    cp if cp >= 0x0F8D && cp <= 0x0F97 -> True
    cp if cp >= 0x0F99 && cp <= 0x0FBC -> True
    cp if cp == 0x0FC6 -> True
    cp if cp >= 0x102D && cp <= 0x1030 -> True
    cp if cp >= 0x1032 && cp <= 0x1037 -> True
    cp if cp >= 0x1039 && cp <= 0x103A -> True
    cp if cp >= 0x103D && cp <= 0x103E -> True
    cp if cp >= 0x1058 && cp <= 0x1059 -> True
    cp if cp >= 0x105E && cp <= 0x1060 -> True
    cp if cp >= 0x1071 && cp <= 0x1074 -> True
    cp if cp == 0x1082 -> True
    cp if cp >= 0x1085 && cp <= 0x1086 -> True
    cp if cp == 0x108D -> True
    cp if cp == 0x109D -> True
    cp if cp >= 0x135D && cp <= 0x135F -> True
    cp if cp >= 0x1712 && cp <= 0x1714 -> True
    cp if cp >= 0x1732 && cp <= 0x1733 -> True
    cp if cp >= 0x1752 && cp <= 0x1753 -> True
    cp if cp >= 0x1772 && cp <= 0x1773 -> True
    cp if cp >= 0x17B4 && cp <= 0x17B5 -> True
    cp if cp >= 0x17B7 && cp <= 0x17BD -> True
    cp if cp == 0x17C6 -> True
    cp if cp >= 0x17C9 && cp <= 0x17D3 -> True
    cp if cp == 0x17DD -> True
    cp if cp >= 0x180B && cp <= 0x180D -> True
    cp if cp == 0x180F -> True
    cp if cp >= 0x1885 && cp <= 0x1886 -> True
    cp if cp == 0x18A9 -> True
    cp if cp >= 0x1920 && cp <= 0x1922 -> True
    cp if cp >= 0x1927 && cp <= 0x1928 -> True
    cp if cp == 0x1932 -> True
    cp if cp >= 0x1939 && cp <= 0x193B -> True
    cp if cp >= 0x1A17 && cp <= 0x1A18 -> True
    cp if cp == 0x1A1B -> True
    cp if cp == 0x1A56 -> True
    cp if cp >= 0x1A58 && cp <= 0x1A5E -> True
    cp if cp == 0x1A60 -> True
    cp if cp == 0x1A62 -> True
    cp if cp >= 0x1A65 && cp <= 0x1A6C -> True
    cp if cp >= 0x1A73 && cp <= 0x1A7C -> True
    cp if cp == 0x1A7F -> True
    cp if cp >= 0x1AB0 && cp <= 0x1ABD -> True
    cp if cp == 0x1ABE -> True
    cp if cp >= 0x1ABF && cp <= 0x1ACE -> True
    cp if cp >= 0x1B00 && cp <= 0x1B03 -> True
    cp if cp == 0x1B34 -> True
    cp if cp >= 0x1B36 && cp <= 0x1B3A -> True
    cp if cp == 0x1B3C -> True
    cp if cp == 0x1B42 -> True
    cp if cp >= 0x1B6B && cp <= 0x1B73 -> True
    cp if cp >= 0x1B80 && cp <= 0x1B81 -> True
    cp if cp >= 0x1BA2 && cp <= 0x1BA5 -> True
    cp if cp >= 0x1BA8 && cp <= 0x1BA9 -> True
    cp if cp >= 0x1BAB && cp <= 0x1BAD -> True
    cp if cp == 0x1BE6 -> True
    cp if cp >= 0x1BE8 && cp <= 0x1BE9 -> True
    cp if cp == 0x1BED -> True
    cp if cp >= 0x1BEF && cp <= 0x1BF1 -> True
    cp if cp >= 0x1C2C && cp <= 0x1C33 -> True
    cp if cp >= 0x1C36 && cp <= 0x1C37 -> True
    cp if cp >= 0x1CD0 && cp <= 0x1CD2 -> True
    cp if cp >= 0x1CD4 && cp <= 0x1CE0 -> True
    cp if cp >= 0x1CE2 && cp <= 0x1CE8 -> True
    cp if cp == 0x1CED -> True
    cp if cp == 0x1CF4 -> True
    cp if cp >= 0x1CF8 && cp <= 0x1CF9 -> True
    cp if cp >= 0x1DC0 && cp <= 0x1DFF -> True
    cp if cp >= 0x20D0 && cp <= 0x20DC -> True
    cp if cp >= 0x20DD && cp <= 0x20E0 -> True
    cp if cp == 0x20E1 -> True
    cp if cp >= 0x20E2 && cp <= 0x20E4 -> True
    cp if cp >= 0x20E5 && cp <= 0x20F0 -> True
    cp if cp >= 0x2CEF && cp <= 0x2CF1 -> True
    cp if cp == 0x2D7F -> True
    cp if cp >= 0x2DE0 && cp <= 0x2DFF -> True
    cp if cp >= 0x302A && cp <= 0x302D -> True
    cp if cp >= 0x3099 && cp <= 0x309A -> True
    cp if cp == 0xA66F -> True
    cp if cp >= 0xA670 && cp <= 0xA672 -> True
    cp if cp >= 0xA674 && cp <= 0xA67D -> True
    cp if cp >= 0xA69E && cp <= 0xA69F -> True
    cp if cp >= 0xA6F0 && cp <= 0xA6F1 -> True
    cp if cp == 0xA802 -> True
    cp if cp == 0xA806 -> True
    cp if cp == 0xA80B -> True
    cp if cp >= 0xA825 && cp <= 0xA826 -> True
    cp if cp == 0xA82C -> True
    cp if cp >= 0xA8C4 && cp <= 0xA8C5 -> True
    cp if cp >= 0xA8E0 && cp <= 0xA8F1 -> True
    cp if cp == 0xA8FF -> True
    cp if cp >= 0xA926 && cp <= 0xA92D -> True
    cp if cp >= 0xA947 && cp <= 0xA951 -> True
    cp if cp >= 0xA980 && cp <= 0xA982 -> True
    cp if cp == 0xA9B3 -> True
    cp if cp >= 0xA9B6 && cp <= 0xA9B9 -> True
    cp if cp >= 0xA9BC && cp <= 0xA9BD -> True
    cp if cp == 0xA9E5 -> True
    cp if cp >= 0xAA29 && cp <= 0xAA2E -> True
    cp if cp >= 0xAA31 && cp <= 0xAA32 -> True
    cp if cp >= 0xAA35 && cp <= 0xAA36 -> True
    cp if cp == 0xAA43 -> True
    cp if cp == 0xAA4C -> True
    cp if cp == 0xAA7C -> True
    cp if cp == 0xAAB0 -> True
    cp if cp >= 0xAAB2 && cp <= 0xAAB4 -> True
    cp if cp >= 0xAAB7 && cp <= 0xAAB8 -> True
    cp if cp >= 0xAABE && cp <= 0xAABF -> True
    cp if cp == 0xAAC1 -> True
    cp if cp >= 0xAAEC && cp <= 0xAAED -> True
    cp if cp == 0xAAF6 -> True
    cp if cp == 0xABE5 -> True
    cp if cp == 0xABE8 -> True
    cp if cp == 0xABED -> True
    cp if cp == 0xFB1E -> True
    cp if cp >= 0xFE00 && cp <= 0xFE0F -> True
    cp if cp >= 0xFE20 && cp <= 0xFE2F -> True
    cp if cp == 0x101FD -> True
    cp if cp == 0x102E0 -> True
    cp if cp >= 0x10376 && cp <= 0x1037A -> True
    cp if cp >= 0x10A01 && cp <= 0x10A03 -> True
    cp if cp >= 0x10A05 && cp <= 0x10A06 -> True
    cp if cp >= 0x10A0C && cp <= 0x10A0F -> True
    cp if cp >= 0x10A38 && cp <= 0x10A3A -> True
    cp if cp == 0x10A3F -> True
    cp if cp >= 0x10AE5 && cp <= 0x10AE6 -> True
    cp if cp >= 0x10D24 && cp <= 0x10D27 -> True
    cp if cp >= 0x10D69 && cp <= 0x10D6D -> True
    cp if cp >= 0x10EAB && cp <= 0x10EAC -> True
    cp if cp >= 0x10EFC && cp <= 0x10EFF -> True
    cp if cp >= 0x10F46 && cp <= 0x10F50 -> True
    cp if cp >= 0x10F82 && cp <= 0x10F85 -> True
    cp if cp == 0x11001 -> True
    cp if cp >= 0x11038 && cp <= 0x11046 -> True
    cp if cp == 0x11070 -> True
    cp if cp >= 0x11073 && cp <= 0x11074 -> True
    cp if cp >= 0x1107F && cp <= 0x11081 -> True
    cp if cp >= 0x110B3 && cp <= 0x110B6 -> True
    cp if cp >= 0x110B9 && cp <= 0x110BA -> True
    cp if cp == 0x110C2 -> True
    cp if cp >= 0x11100 && cp <= 0x11102 -> True
    cp if cp >= 0x11127 && cp <= 0x1112B -> True
    cp if cp >= 0x1112D && cp <= 0x11134 -> True
    cp if cp == 0x11173 -> True
    cp if cp >= 0x11180 && cp <= 0x11181 -> True
    cp if cp >= 0x111B6 && cp <= 0x111BE -> True
    cp if cp >= 0x111C9 && cp <= 0x111CC -> True
    cp if cp == 0x111CF -> True
    cp if cp >= 0x1122F && cp <= 0x11231 -> True
    cp if cp == 0x11234 -> True
    cp if cp >= 0x11236 && cp <= 0x11237 -> True
    cp if cp == 0x1123E -> True
    cp if cp == 0x11241 -> True
    cp if cp == 0x112DF -> True
    cp if cp >= 0x112E3 && cp <= 0x112EA -> True
    cp if cp >= 0x11300 && cp <= 0x11301 -> True
    cp if cp >= 0x1133B && cp <= 0x1133C -> True
    cp if cp == 0x11340 -> True
    cp if cp >= 0x11366 && cp <= 0x1136C -> True
    cp if cp >= 0x11370 && cp <= 0x11374 -> True
    cp if cp >= 0x113BB && cp <= 0x113C0 -> True
    cp if cp == 0x113CE -> True
    cp if cp == 0x113D0 -> True
    cp if cp == 0x113D2 -> True
    cp if cp >= 0x113E1 && cp <= 0x113E2 -> True
    cp if cp >= 0x11438 && cp <= 0x1143F -> True
    cp if cp >= 0x11442 && cp <= 0x11444 -> True
    cp if cp == 0x11446 -> True
    cp if cp == 0x1145E -> True
    cp if cp >= 0x114B3 && cp <= 0x114B8 -> True
    cp if cp == 0x114BA -> True
    cp if cp >= 0x114BF && cp <= 0x114C0 -> True
    cp if cp >= 0x114C2 && cp <= 0x114C3 -> True
    cp if cp >= 0x115B2 && cp <= 0x115B5 -> True
    cp if cp >= 0x115BC && cp <= 0x115BD -> True
    cp if cp >= 0x115BF && cp <= 0x115C0 -> True
    cp if cp >= 0x115DC && cp <= 0x115DD -> True
    cp if cp >= 0x11633 && cp <= 0x1163A -> True
    cp if cp == 0x1163D -> True
    cp if cp >= 0x1163F && cp <= 0x11640 -> True
    cp if cp == 0x116AB -> True
    cp if cp == 0x116AD -> True
    cp if cp >= 0x116B0 && cp <= 0x116B5 -> True
    cp if cp == 0x116B7 -> True
    cp if cp == 0x1171D -> True
    cp if cp == 0x1171F -> True
    cp if cp >= 0x11722 && cp <= 0x11725 -> True
    cp if cp >= 0x11727 && cp <= 0x1172B -> True
    cp if cp >= 0x1182F && cp <= 0x11837 -> True
    cp if cp >= 0x11839 && cp <= 0x1183A -> True
    cp if cp >= 0x1193B && cp <= 0x1193C -> True
    cp if cp == 0x1193E -> True
    cp if cp == 0x11943 -> True
    cp if cp >= 0x119D4 && cp <= 0x119D7 -> True
    cp if cp >= 0x119DA && cp <= 0x119DB -> True
    cp if cp == 0x119E0 -> True
    cp if cp >= 0x11A01 && cp <= 0x11A06 -> True
    cp if cp >= 0x11A09 && cp <= 0x11A0A -> True
    cp if cp >= 0x11A33 && cp <= 0x11A38 -> True
    cp if cp >= 0x11A3B && cp <= 0x11A3E -> True
    cp if cp == 0x11A47 -> True
    cp if cp >= 0x11A51 && cp <= 0x11A56 -> True
    cp if cp >= 0x11A59 && cp <= 0x11A5B -> True
    cp if cp >= 0x11A8A && cp <= 0x11A96 -> True
    cp if cp >= 0x11A98 && cp <= 0x11A99 -> True
    cp if cp >= 0x11C30 && cp <= 0x11C36 -> True
    cp if cp >= 0x11C38 && cp <= 0x11C3D -> True
    cp if cp >= 0x11C92 && cp <= 0x11CA7 -> True
    cp if cp >= 0x11CAA && cp <= 0x11CB0 -> True
    cp if cp >= 0x11CB2 && cp <= 0x11CB3 -> True
    cp if cp >= 0x11CB5 && cp <= 0x11CB6 -> True
    cp if cp >= 0x11D31 && cp <= 0x11D36 -> True
    cp if cp == 0x11D3A -> True
    cp if cp >= 0x11D3C && cp <= 0x11D3D -> True
    cp if cp >= 0x11D3F && cp <= 0x11D45 -> True
    cp if cp == 0x11D47 -> True
    cp if cp >= 0x11D90 && cp <= 0x11D91 -> True
    cp if cp == 0x11D95 -> True
    cp if cp == 0x11D97 -> True
    cp if cp >= 0x11EF3 && cp <= 0x11EF4 -> True
    cp if cp >= 0x11F00 && cp <= 0x11F01 -> True
    cp if cp >= 0x11F36 && cp <= 0x11F3A -> True
    cp if cp == 0x11F40 -> True
    cp if cp == 0x11F42 -> True
    cp if cp == 0x11F5A -> True
    cp if cp == 0x13440 -> True
    cp if cp >= 0x13447 && cp <= 0x13455 -> True
    cp if cp >= 0x1611E && cp <= 0x16129 -> True
    cp if cp >= 0x1612D && cp <= 0x1612F -> True
    cp if cp >= 0x16AF0 && cp <= 0x16AF4 -> True
    cp if cp >= 0x16B30 && cp <= 0x16B36 -> True
    cp if cp == 0x16F4F -> True
    cp if cp >= 0x16F8F && cp <= 0x16F92 -> True
    cp if cp == 0x16FE4 -> True
    cp if cp >= 0x1BC9D && cp <= 0x1BC9E -> True
    cp if cp >= 0x1CF00 && cp <= 0x1CF2D -> True
    cp if cp >= 0x1CF30 && cp <= 0x1CF46 -> True
    cp if cp >= 0x1D167 && cp <= 0x1D169 -> True
    cp if cp >= 0x1D17B && cp <= 0x1D182 -> True
    cp if cp >= 0x1D185 && cp <= 0x1D18B -> True
    cp if cp >= 0x1D1AA && cp <= 0x1D1AD -> True
    cp if cp >= 0x1D242 && cp <= 0x1D244 -> True
    cp if cp >= 0x1DA00 && cp <= 0x1DA36 -> True
    cp if cp >= 0x1DA3B && cp <= 0x1DA6C -> True
    cp if cp == 0x1DA75 -> True
    cp if cp == 0x1DA84 -> True
    cp if cp >= 0x1DA9B && cp <= 0x1DA9F -> True
    cp if cp >= 0x1DAA1 && cp <= 0x1DAAF -> True
    cp if cp >= 0x1E000 && cp <= 0x1E006 -> True
    cp if cp >= 0x1E008 && cp <= 0x1E018 -> True
    cp if cp >= 0x1E01B && cp <= 0x1E021 -> True
    cp if cp >= 0x1E023 && cp <= 0x1E024 -> True
    cp if cp >= 0x1E026 && cp <= 0x1E02A -> True
    cp if cp == 0x1E08F -> True
    cp if cp >= 0x1E130 && cp <= 0x1E136 -> True
    cp if cp == 0x1E2AE -> True
    cp if cp >= 0x1E2EC && cp <= 0x1E2EF -> True
    cp if cp >= 0x1E4EC && cp <= 0x1E4EF -> True
    cp if cp >= 0x1E5EE && cp <= 0x1E5EF -> True
    cp if cp >= 0x1E8D0 && cp <= 0x1E8D6 -> True
    cp if cp >= 0x1E944 && cp <= 0x1E94A -> True
    cp if cp >= 0xE0100 && cp <= 0xE01EF -> True
    _ -> False
  }
}

pub fn in_english_number(codepoint: Int) -> Bool {
  case codepoint {
    cp if cp >= 0x0030 && cp <= 0x0039 -> True
    cp if cp >= 0x00B2 && cp <= 0x00B3 -> True
    cp if cp == 0x00B9 -> True
    cp if cp >= 0x06F0 && cp <= 0x06F9 -> True
    cp if cp == 0x2070 -> True
    cp if cp >= 0x2074 && cp <= 0x2079 -> True
    cp if cp >= 0x2080 && cp <= 0x2089 -> True
    cp if cp >= 0x2488 && cp <= 0x249B -> True
    cp if cp >= 0xFF10 && cp <= 0xFF19 -> True
    cp if cp >= 0x102E1 && cp <= 0x102FB -> True
    cp if cp >= 0x1CCF0 && cp <= 0x1CCF9 -> True
    cp if cp >= 0x1D7CE && cp <= 0x1D7FF -> True
    cp if cp >= 0x1F100 && cp <= 0x1F10A -> True
    cp if cp >= 0x1FBF0 && cp <= 0x1FBF9 -> True
    _ -> False
  }
}

pub fn in_arabic_number(codepoint: Int) -> Bool {
  case codepoint {
    cp if cp >= 0x0600 && cp <= 0x0605 -> True
    cp if cp >= 0x0660 && cp <= 0x0669 -> True
    cp if cp >= 0x066B && cp <= 0x066C -> True
    cp if cp == 0x06DD -> True
    cp if cp >= 0x0890 && cp <= 0x0891 -> True
    cp if cp == 0x08E2 -> True
    cp if cp >= 0x10D30 && cp <= 0x10D39 -> True
    cp if cp >= 0x10D40 && cp <= 0x10D49 -> True
    cp if cp >= 0x10E60 && cp <= 0x10E7E -> True
    _ -> False
  }
}

pub fn in_left_to_right_allowed(codepoint: Int) -> Bool {
  case codepoint {
    cp if cp >= 0x0041 && cp <= 0x005A -> True
    cp if cp >= 0x0061 && cp <= 0x007A -> True
    cp if cp == 0x00AA -> True
    cp if cp == 0x00B5 -> True
    cp if cp == 0x00BA -> True
    cp if cp >= 0x00C0 && cp <= 0x00D6 -> True
    cp if cp >= 0x00D8 && cp <= 0x00F6 -> True
    cp if cp >= 0x00F8 && cp <= 0x01BA -> True
    cp if cp == 0x01BB -> True
    cp if cp >= 0x01BC && cp <= 0x01BF -> True
    cp if cp >= 0x01C0 && cp <= 0x01C3 -> True
    cp if cp >= 0x01C4 && cp <= 0x0293 -> True
    cp if cp == 0x0294 -> True
    cp if cp >= 0x0295 && cp <= 0x02AF -> True
    cp if cp >= 0x02B0 && cp <= 0x02B8 -> True
    cp if cp >= 0x02BB && cp <= 0x02C1 -> True
    cp if cp >= 0x02D0 && cp <= 0x02D1 -> True
    cp if cp >= 0x02E0 && cp <= 0x02E4 -> True
    cp if cp == 0x02EE -> True
    cp if cp >= 0x0370 && cp <= 0x0373 -> True
    cp if cp >= 0x0376 && cp <= 0x0377 -> True
    cp if cp == 0x037A -> True
    cp if cp >= 0x037B && cp <= 0x037D -> True
    cp if cp == 0x037F -> True
    cp if cp == 0x0386 -> True
    cp if cp >= 0x0388 && cp <= 0x038A -> True
    cp if cp == 0x038C -> True
    cp if cp >= 0x038E && cp <= 0x03A1 -> True
    cp if cp >= 0x03A3 && cp <= 0x03F5 -> True
    cp if cp >= 0x03F7 && cp <= 0x0481 -> True
    cp if cp == 0x0482 -> True
    cp if cp >= 0x048A && cp <= 0x052F -> True
    cp if cp >= 0x0531 && cp <= 0x0556 -> True
    cp if cp == 0x0559 -> True
    cp if cp >= 0x055A && cp <= 0x055F -> True
    cp if cp >= 0x0560 && cp <= 0x0588 -> True
    cp if cp == 0x0589 -> True
    cp if cp == 0x0903 -> True
    cp if cp >= 0x0904 && cp <= 0x0939 -> True
    cp if cp == 0x093B -> True
    cp if cp == 0x093D -> True
    cp if cp >= 0x093E && cp <= 0x0940 -> True
    cp if cp >= 0x0949 && cp <= 0x094C -> True
    cp if cp >= 0x094E && cp <= 0x094F -> True
    cp if cp == 0x0950 -> True
    cp if cp >= 0x0958 && cp <= 0x0961 -> True
    cp if cp >= 0x0964 && cp <= 0x0965 -> True
    cp if cp >= 0x0966 && cp <= 0x096F -> True
    cp if cp == 0x0970 -> True
    cp if cp == 0x0971 -> True
    cp if cp >= 0x0972 && cp <= 0x0980 -> True
    cp if cp >= 0x0982 && cp <= 0x0983 -> True
    cp if cp >= 0x0985 && cp <= 0x098C -> True
    cp if cp >= 0x098F && cp <= 0x0990 -> True
    cp if cp >= 0x0993 && cp <= 0x09A8 -> True
    cp if cp >= 0x09AA && cp <= 0x09B0 -> True
    cp if cp == 0x09B2 -> True
    cp if cp >= 0x09B6 && cp <= 0x09B9 -> True
    cp if cp == 0x09BD -> True
    cp if cp >= 0x09BE && cp <= 0x09C0 -> True
    cp if cp >= 0x09C7 && cp <= 0x09C8 -> True
    cp if cp >= 0x09CB && cp <= 0x09CC -> True
    cp if cp == 0x09CE -> True
    cp if cp == 0x09D7 -> True
    cp if cp >= 0x09DC && cp <= 0x09DD -> True
    cp if cp >= 0x09DF && cp <= 0x09E1 -> True
    cp if cp >= 0x09E6 && cp <= 0x09EF -> True
    cp if cp >= 0x09F0 && cp <= 0x09F1 -> True
    cp if cp >= 0x09F4 && cp <= 0x09F9 -> True
    cp if cp == 0x09FA -> True
    cp if cp == 0x09FC -> True
    cp if cp == 0x09FD -> True
    cp if cp == 0x0A03 -> True
    cp if cp >= 0x0A05 && cp <= 0x0A0A -> True
    cp if cp >= 0x0A0F && cp <= 0x0A10 -> True
    cp if cp >= 0x0A13 && cp <= 0x0A28 -> True
    cp if cp >= 0x0A2A && cp <= 0x0A30 -> True
    cp if cp >= 0x0A32 && cp <= 0x0A33 -> True
    cp if cp >= 0x0A35 && cp <= 0x0A36 -> True
    cp if cp >= 0x0A38 && cp <= 0x0A39 -> True
    cp if cp >= 0x0A3E && cp <= 0x0A40 -> True
    cp if cp >= 0x0A59 && cp <= 0x0A5C -> True
    cp if cp == 0x0A5E -> True
    cp if cp >= 0x0A66 && cp <= 0x0A6F -> True
    cp if cp >= 0x0A72 && cp <= 0x0A74 -> True
    cp if cp == 0x0A76 -> True
    cp if cp == 0x0A83 -> True
    cp if cp >= 0x0A85 && cp <= 0x0A8D -> True
    cp if cp >= 0x0A8F && cp <= 0x0A91 -> True
    cp if cp >= 0x0A93 && cp <= 0x0AA8 -> True
    cp if cp >= 0x0AAA && cp <= 0x0AB0 -> True
    cp if cp >= 0x0AB2 && cp <= 0x0AB3 -> True
    cp if cp >= 0x0AB5 && cp <= 0x0AB9 -> True
    cp if cp == 0x0ABD -> True
    cp if cp >= 0x0ABE && cp <= 0x0AC0 -> True
    cp if cp == 0x0AC9 -> True
    cp if cp >= 0x0ACB && cp <= 0x0ACC -> True
    cp if cp == 0x0AD0 -> True
    cp if cp >= 0x0AE0 && cp <= 0x0AE1 -> True
    cp if cp >= 0x0AE6 && cp <= 0x0AEF -> True
    cp if cp == 0x0AF0 -> True
    cp if cp == 0x0AF9 -> True
    cp if cp >= 0x0B02 && cp <= 0x0B03 -> True
    cp if cp >= 0x0B05 && cp <= 0x0B0C -> True
    cp if cp >= 0x0B0F && cp <= 0x0B10 -> True
    cp if cp >= 0x0B13 && cp <= 0x0B28 -> True
    cp if cp >= 0x0B2A && cp <= 0x0B30 -> True
    cp if cp >= 0x0B32 && cp <= 0x0B33 -> True
    cp if cp >= 0x0B35 && cp <= 0x0B39 -> True
    cp if cp == 0x0B3D -> True
    cp if cp == 0x0B3E -> True
    cp if cp == 0x0B40 -> True
    cp if cp >= 0x0B47 && cp <= 0x0B48 -> True
    cp if cp >= 0x0B4B && cp <= 0x0B4C -> True
    cp if cp == 0x0B57 -> True
    cp if cp >= 0x0B5C && cp <= 0x0B5D -> True
    cp if cp >= 0x0B5F && cp <= 0x0B61 -> True
    cp if cp >= 0x0B66 && cp <= 0x0B6F -> True
    cp if cp == 0x0B70 -> True
    cp if cp == 0x0B71 -> True
    cp if cp >= 0x0B72 && cp <= 0x0B77 -> True
    cp if cp == 0x0B83 -> True
    cp if cp >= 0x0B85 && cp <= 0x0B8A -> True
    cp if cp >= 0x0B8E && cp <= 0x0B90 -> True
    cp if cp >= 0x0B92 && cp <= 0x0B95 -> True
    cp if cp >= 0x0B99 && cp <= 0x0B9A -> True
    cp if cp == 0x0B9C -> True
    cp if cp >= 0x0B9E && cp <= 0x0B9F -> True
    cp if cp >= 0x0BA3 && cp <= 0x0BA4 -> True
    cp if cp >= 0x0BA8 && cp <= 0x0BAA -> True
    cp if cp >= 0x0BAE && cp <= 0x0BB9 -> True
    cp if cp >= 0x0BBE && cp <= 0x0BBF -> True
    cp if cp >= 0x0BC1 && cp <= 0x0BC2 -> True
    cp if cp >= 0x0BC6 && cp <= 0x0BC8 -> True
    cp if cp >= 0x0BCA && cp <= 0x0BCC -> True
    cp if cp == 0x0BD0 -> True
    cp if cp == 0x0BD7 -> True
    cp if cp >= 0x0BE6 && cp <= 0x0BEF -> True
    cp if cp >= 0x0BF0 && cp <= 0x0BF2 -> True
    cp if cp >= 0x0C01 && cp <= 0x0C03 -> True
    cp if cp >= 0x0C05 && cp <= 0x0C0C -> True
    cp if cp >= 0x0C0E && cp <= 0x0C10 -> True
    cp if cp >= 0x0C12 && cp <= 0x0C28 -> True
    cp if cp >= 0x0C2A && cp <= 0x0C39 -> True
    cp if cp == 0x0C3D -> True
    cp if cp >= 0x0C41 && cp <= 0x0C44 -> True
    cp if cp >= 0x0C58 && cp <= 0x0C5A -> True
    cp if cp == 0x0C5D -> True
    cp if cp >= 0x0C60 && cp <= 0x0C61 -> True
    cp if cp >= 0x0C66 && cp <= 0x0C6F -> True
    cp if cp == 0x0C77 -> True
    cp if cp == 0x0C7F -> True
    cp if cp == 0x0C80 -> True
    cp if cp >= 0x0C82 && cp <= 0x0C83 -> True
    cp if cp == 0x0C84 -> True
    cp if cp >= 0x0C85 && cp <= 0x0C8C -> True
    cp if cp >= 0x0C8E && cp <= 0x0C90 -> True
    cp if cp >= 0x0C92 && cp <= 0x0CA8 -> True
    cp if cp >= 0x0CAA && cp <= 0x0CB3 -> True
    cp if cp >= 0x0CB5 && cp <= 0x0CB9 -> True
    cp if cp == 0x0CBD -> True
    cp if cp == 0x0CBE -> True
    cp if cp == 0x0CBF -> True
    cp if cp >= 0x0CC0 && cp <= 0x0CC4 -> True
    cp if cp == 0x0CC6 -> True
    cp if cp >= 0x0CC7 && cp <= 0x0CC8 -> True
    cp if cp >= 0x0CCA && cp <= 0x0CCB -> True
    cp if cp >= 0x0CD5 && cp <= 0x0CD6 -> True
    cp if cp >= 0x0CDD && cp <= 0x0CDE -> True
    cp if cp >= 0x0CE0 && cp <= 0x0CE1 -> True
    cp if cp >= 0x0CE6 && cp <= 0x0CEF -> True
    cp if cp >= 0x0CF1 && cp <= 0x0CF2 -> True
    cp if cp == 0x0CF3 -> True
    cp if cp >= 0x0D02 && cp <= 0x0D03 -> True
    cp if cp >= 0x0D04 && cp <= 0x0D0C -> True
    cp if cp >= 0x0D0E && cp <= 0x0D10 -> True
    cp if cp >= 0x0D12 && cp <= 0x0D3A -> True
    cp if cp == 0x0D3D -> True
    cp if cp >= 0x0D3E && cp <= 0x0D40 -> True
    cp if cp >= 0x0D46 && cp <= 0x0D48 -> True
    cp if cp >= 0x0D4A && cp <= 0x0D4C -> True
    cp if cp == 0x0D4E -> True
    cp if cp == 0x0D4F -> True
    cp if cp >= 0x0D54 && cp <= 0x0D56 -> True
    cp if cp == 0x0D57 -> True
    cp if cp >= 0x0D58 && cp <= 0x0D5E -> True
    cp if cp >= 0x0D5F && cp <= 0x0D61 -> True
    cp if cp >= 0x0D66 && cp <= 0x0D6F -> True
    cp if cp >= 0x0D70 && cp <= 0x0D78 -> True
    cp if cp == 0x0D79 -> True
    cp if cp >= 0x0D7A && cp <= 0x0D7F -> True
    cp if cp >= 0x0D82 && cp <= 0x0D83 -> True
    cp if cp >= 0x0D85 && cp <= 0x0D96 -> True
    cp if cp >= 0x0D9A && cp <= 0x0DB1 -> True
    cp if cp >= 0x0DB3 && cp <= 0x0DBB -> True
    cp if cp == 0x0DBD -> True
    cp if cp >= 0x0DC0 && cp <= 0x0DC6 -> True
    cp if cp >= 0x0DCF && cp <= 0x0DD1 -> True
    cp if cp >= 0x0DD8 && cp <= 0x0DDF -> True
    cp if cp >= 0x0DE6 && cp <= 0x0DEF -> True
    cp if cp >= 0x0DF2 && cp <= 0x0DF3 -> True
    cp if cp == 0x0DF4 -> True
    cp if cp >= 0x0E01 && cp <= 0x0E30 -> True
    cp if cp >= 0x0E32 && cp <= 0x0E33 -> True
    cp if cp >= 0x0E40 && cp <= 0x0E45 -> True
    cp if cp == 0x0E46 -> True
    cp if cp == 0x0E4F -> True
    cp if cp >= 0x0E50 && cp <= 0x0E59 -> True
    cp if cp >= 0x0E5A && cp <= 0x0E5B -> True
    cp if cp >= 0x0E81 && cp <= 0x0E82 -> True
    cp if cp == 0x0E84 -> True
    cp if cp >= 0x0E86 && cp <= 0x0E8A -> True
    cp if cp >= 0x0E8C && cp <= 0x0EA3 -> True
    cp if cp == 0x0EA5 -> True
    cp if cp >= 0x0EA7 && cp <= 0x0EB0 -> True
    cp if cp >= 0x0EB2 && cp <= 0x0EB3 -> True
    cp if cp == 0x0EBD -> True
    cp if cp >= 0x0EC0 && cp <= 0x0EC4 -> True
    cp if cp == 0x0EC6 -> True
    cp if cp >= 0x0ED0 && cp <= 0x0ED9 -> True
    cp if cp >= 0x0EDC && cp <= 0x0EDF -> True
    cp if cp == 0x0F00 -> True
    cp if cp >= 0x0F01 && cp <= 0x0F03 -> True
    cp if cp >= 0x0F04 && cp <= 0x0F12 -> True
    cp if cp == 0x0F13 -> True
    cp if cp == 0x0F14 -> True
    cp if cp >= 0x0F15 && cp <= 0x0F17 -> True
    cp if cp >= 0x0F1A && cp <= 0x0F1F -> True
    cp if cp >= 0x0F20 && cp <= 0x0F29 -> True
    cp if cp >= 0x0F2A && cp <= 0x0F33 -> True
    cp if cp == 0x0F34 -> True
    cp if cp == 0x0F36 -> True
    cp if cp == 0x0F38 -> True
    cp if cp >= 0x0F3E && cp <= 0x0F3F -> True
    cp if cp >= 0x0F40 && cp <= 0x0F47 -> True
    cp if cp >= 0x0F49 && cp <= 0x0F6C -> True
    cp if cp == 0x0F7F -> True
    cp if cp == 0x0F85 -> True
    cp if cp >= 0x0F88 && cp <= 0x0F8C -> True
    cp if cp >= 0x0FBE && cp <= 0x0FC5 -> True
    cp if cp >= 0x0FC7 && cp <= 0x0FCC -> True
    cp if cp >= 0x0FCE && cp <= 0x0FCF -> True
    cp if cp >= 0x0FD0 && cp <= 0x0FD4 -> True
    cp if cp >= 0x0FD5 && cp <= 0x0FD8 -> True
    cp if cp >= 0x0FD9 && cp <= 0x0FDA -> True
    cp if cp >= 0x1000 && cp <= 0x102A -> True
    cp if cp >= 0x102B && cp <= 0x102C -> True
    cp if cp == 0x1031 -> True
    cp if cp == 0x1038 -> True
    cp if cp >= 0x103B && cp <= 0x103C -> True
    cp if cp == 0x103F -> True
    cp if cp >= 0x1040 && cp <= 0x1049 -> True
    cp if cp >= 0x104A && cp <= 0x104F -> True
    cp if cp >= 0x1050 && cp <= 0x1055 -> True
    cp if cp >= 0x1056 && cp <= 0x1057 -> True
    cp if cp >= 0x105A && cp <= 0x105D -> True
    cp if cp == 0x1061 -> True
    cp if cp >= 0x1062 && cp <= 0x1064 -> True
    cp if cp >= 0x1065 && cp <= 0x1066 -> True
    cp if cp >= 0x1067 && cp <= 0x106D -> True
    cp if cp >= 0x106E && cp <= 0x1070 -> True
    cp if cp >= 0x1075 && cp <= 0x1081 -> True
    cp if cp >= 0x1083 && cp <= 0x1084 -> True
    cp if cp >= 0x1087 && cp <= 0x108C -> True
    cp if cp == 0x108E -> True
    cp if cp == 0x108F -> True
    cp if cp >= 0x1090 && cp <= 0x1099 -> True
    cp if cp >= 0x109A && cp <= 0x109C -> True
    cp if cp >= 0x109E && cp <= 0x109F -> True
    cp if cp >= 0x10A0 && cp <= 0x10C5 -> True
    cp if cp == 0x10C7 -> True
    cp if cp == 0x10CD -> True
    cp if cp >= 0x10D0 && cp <= 0x10FA -> True
    cp if cp == 0x10FB -> True
    cp if cp == 0x10FC -> True
    cp if cp >= 0x10FD && cp <= 0x10FF -> True
    cp if cp >= 0x1100 && cp <= 0x1248 -> True
    cp if cp >= 0x124A && cp <= 0x124D -> True
    cp if cp >= 0x1250 && cp <= 0x1256 -> True
    cp if cp == 0x1258 -> True
    cp if cp >= 0x125A && cp <= 0x125D -> True
    cp if cp >= 0x1260 && cp <= 0x1288 -> True
    cp if cp >= 0x128A && cp <= 0x128D -> True
    cp if cp >= 0x1290 && cp <= 0x12B0 -> True
    cp if cp >= 0x12B2 && cp <= 0x12B5 -> True
    cp if cp >= 0x12B8 && cp <= 0x12BE -> True
    cp if cp == 0x12C0 -> True
    cp if cp >= 0x12C2 && cp <= 0x12C5 -> True
    cp if cp >= 0x12C8 && cp <= 0x12D6 -> True
    cp if cp >= 0x12D8 && cp <= 0x1310 -> True
    cp if cp >= 0x1312 && cp <= 0x1315 -> True
    cp if cp >= 0x1318 && cp <= 0x135A -> True
    cp if cp >= 0x1360 && cp <= 0x1368 -> True
    cp if cp >= 0x1369 && cp <= 0x137C -> True
    cp if cp >= 0x1380 && cp <= 0x138F -> True
    cp if cp >= 0x13A0 && cp <= 0x13F5 -> True
    cp if cp >= 0x13F8 && cp <= 0x13FD -> True
    cp if cp >= 0x1401 && cp <= 0x166C -> True
    cp if cp == 0x166D -> True
    cp if cp == 0x166E -> True
    cp if cp >= 0x166F && cp <= 0x167F -> True
    cp if cp >= 0x1681 && cp <= 0x169A -> True
    cp if cp >= 0x16A0 && cp <= 0x16EA -> True
    cp if cp >= 0x16EB && cp <= 0x16ED -> True
    cp if cp >= 0x16EE && cp <= 0x16F0 -> True
    cp if cp >= 0x16F1 && cp <= 0x16F8 -> True
    cp if cp >= 0x1700 && cp <= 0x1711 -> True
    cp if cp == 0x1715 -> True
    cp if cp >= 0x171F && cp <= 0x1731 -> True
    cp if cp == 0x1734 -> True
    cp if cp >= 0x1735 && cp <= 0x1736 -> True
    cp if cp >= 0x1740 && cp <= 0x1751 -> True
    cp if cp >= 0x1760 && cp <= 0x176C -> True
    cp if cp >= 0x176E && cp <= 0x1770 -> True
    cp if cp >= 0x1780 && cp <= 0x17B3 -> True
    cp if cp == 0x17B6 -> True
    cp if cp >= 0x17BE && cp <= 0x17C5 -> True
    cp if cp >= 0x17C7 && cp <= 0x17C8 -> True
    cp if cp >= 0x17D4 && cp <= 0x17D6 -> True
    cp if cp == 0x17D7 -> True
    cp if cp >= 0x17D8 && cp <= 0x17DA -> True
    cp if cp == 0x17DC -> True
    cp if cp >= 0x17E0 && cp <= 0x17E9 -> True
    cp if cp >= 0x1810 && cp <= 0x1819 -> True
    cp if cp >= 0x1820 && cp <= 0x1842 -> True
    cp if cp == 0x1843 -> True
    cp if cp >= 0x1844 && cp <= 0x1878 -> True
    cp if cp >= 0x1880 && cp <= 0x1884 -> True
    cp if cp >= 0x1887 && cp <= 0x18A8 -> True
    cp if cp == 0x18AA -> True
    cp if cp >= 0x18B0 && cp <= 0x18F5 -> True
    cp if cp >= 0x1900 && cp <= 0x191E -> True
    cp if cp >= 0x1923 && cp <= 0x1926 -> True
    cp if cp >= 0x1929 && cp <= 0x192B -> True
    cp if cp >= 0x1930 && cp <= 0x1931 -> True
    cp if cp >= 0x1933 && cp <= 0x1938 -> True
    cp if cp >= 0x1946 && cp <= 0x194F -> True
    cp if cp >= 0x1950 && cp <= 0x196D -> True
    cp if cp >= 0x1970 && cp <= 0x1974 -> True
    cp if cp >= 0x1980 && cp <= 0x19AB -> True
    cp if cp >= 0x19B0 && cp <= 0x19C9 -> True
    cp if cp >= 0x19D0 && cp <= 0x19D9 -> True
    cp if cp == 0x19DA -> True
    cp if cp >= 0x1A00 && cp <= 0x1A16 -> True
    cp if cp >= 0x1A19 && cp <= 0x1A1A -> True
    cp if cp >= 0x1A1E && cp <= 0x1A1F -> True
    cp if cp >= 0x1A20 && cp <= 0x1A54 -> True
    cp if cp == 0x1A55 -> True
    cp if cp == 0x1A57 -> True
    cp if cp == 0x1A61 -> True
    cp if cp >= 0x1A63 && cp <= 0x1A64 -> True
    cp if cp >= 0x1A6D && cp <= 0x1A72 -> True
    cp if cp >= 0x1A80 && cp <= 0x1A89 -> True
    cp if cp >= 0x1A90 && cp <= 0x1A99 -> True
    cp if cp >= 0x1AA0 && cp <= 0x1AA6 -> True
    cp if cp == 0x1AA7 -> True
    cp if cp >= 0x1AA8 && cp <= 0x1AAD -> True
    cp if cp == 0x1B04 -> True
    cp if cp >= 0x1B05 && cp <= 0x1B33 -> True
    cp if cp == 0x1B35 -> True
    cp if cp == 0x1B3B -> True
    cp if cp >= 0x1B3D && cp <= 0x1B41 -> True
    cp if cp >= 0x1B43 && cp <= 0x1B44 -> True
    cp if cp >= 0x1B45 && cp <= 0x1B4C -> True
    cp if cp >= 0x1B4E && cp <= 0x1B4F -> True
    cp if cp >= 0x1B50 && cp <= 0x1B59 -> True
    cp if cp >= 0x1B5A && cp <= 0x1B60 -> True
    cp if cp >= 0x1B61 && cp <= 0x1B6A -> True
    cp if cp >= 0x1B74 && cp <= 0x1B7C -> True
    cp if cp >= 0x1B7D && cp <= 0x1B7F -> True
    cp if cp == 0x1B82 -> True
    cp if cp >= 0x1B83 && cp <= 0x1BA0 -> True
    cp if cp == 0x1BA1 -> True
    cp if cp >= 0x1BA6 && cp <= 0x1BA7 -> True
    cp if cp == 0x1BAA -> True
    cp if cp >= 0x1BAE && cp <= 0x1BAF -> True
    cp if cp >= 0x1BB0 && cp <= 0x1BB9 -> True
    cp if cp >= 0x1BBA && cp <= 0x1BE5 -> True
    cp if cp == 0x1BE7 -> True
    cp if cp >= 0x1BEA && cp <= 0x1BEC -> True
    cp if cp == 0x1BEE -> True
    cp if cp >= 0x1BF2 && cp <= 0x1BF3 -> True
    cp if cp >= 0x1BFC && cp <= 0x1BFF -> True
    cp if cp >= 0x1C00 && cp <= 0x1C23 -> True
    cp if cp >= 0x1C24 && cp <= 0x1C2B -> True
    cp if cp >= 0x1C34 && cp <= 0x1C35 -> True
    cp if cp >= 0x1C3B && cp <= 0x1C3F -> True
    cp if cp >= 0x1C40 && cp <= 0x1C49 -> True
    cp if cp >= 0x1C4D && cp <= 0x1C4F -> True
    cp if cp >= 0x1C50 && cp <= 0x1C59 -> True
    cp if cp >= 0x1C5A && cp <= 0x1C77 -> True
    cp if cp >= 0x1C78 && cp <= 0x1C7D -> True
    cp if cp >= 0x1C7E && cp <= 0x1C7F -> True
    cp if cp >= 0x1C80 && cp <= 0x1C8A -> True
    cp if cp >= 0x1C90 && cp <= 0x1CBA -> True
    cp if cp >= 0x1CBD && cp <= 0x1CBF -> True
    cp if cp >= 0x1CC0 && cp <= 0x1CC7 -> True
    cp if cp == 0x1CD3 -> True
    cp if cp == 0x1CE1 -> True
    cp if cp >= 0x1CE9 && cp <= 0x1CEC -> True
    cp if cp >= 0x1CEE && cp <= 0x1CF3 -> True
    cp if cp >= 0x1CF5 && cp <= 0x1CF6 -> True
    cp if cp == 0x1CF7 -> True
    cp if cp == 0x1CFA -> True
    cp if cp >= 0x1D00 && cp <= 0x1D2B -> True
    cp if cp >= 0x1D2C && cp <= 0x1D6A -> True
    cp if cp >= 0x1D6B && cp <= 0x1D77 -> True
    cp if cp == 0x1D78 -> True
    cp if cp >= 0x1D79 && cp <= 0x1D9A -> True
    cp if cp >= 0x1D9B && cp <= 0x1DBF -> True
    cp if cp >= 0x1E00 && cp <= 0x1F15 -> True
    cp if cp >= 0x1F18 && cp <= 0x1F1D -> True
    cp if cp >= 0x1F20 && cp <= 0x1F45 -> True
    cp if cp >= 0x1F48 && cp <= 0x1F4D -> True
    cp if cp >= 0x1F50 && cp <= 0x1F57 -> True
    cp if cp == 0x1F59 -> True
    cp if cp == 0x1F5B -> True
    cp if cp == 0x1F5D -> True
    cp if cp >= 0x1F5F && cp <= 0x1F7D -> True
    cp if cp >= 0x1F80 && cp <= 0x1FB4 -> True
    cp if cp >= 0x1FB6 && cp <= 0x1FBC -> True
    cp if cp == 0x1FBE -> True
    cp if cp >= 0x1FC2 && cp <= 0x1FC4 -> True
    cp if cp >= 0x1FC6 && cp <= 0x1FCC -> True
    cp if cp >= 0x1FD0 && cp <= 0x1FD3 -> True
    cp if cp >= 0x1FD6 && cp <= 0x1FDB -> True
    cp if cp >= 0x1FE0 && cp <= 0x1FEC -> True
    cp if cp >= 0x1FF2 && cp <= 0x1FF4 -> True
    cp if cp >= 0x1FF6 && cp <= 0x1FFC -> True
    cp if cp == 0x200E -> True
    cp if cp == 0x2071 -> True
    cp if cp == 0x207F -> True
    cp if cp >= 0x2090 && cp <= 0x209C -> True
    cp if cp == 0x2102 -> True
    cp if cp == 0x2107 -> True
    cp if cp >= 0x210A && cp <= 0x2113 -> True
    cp if cp == 0x2115 -> True
    cp if cp >= 0x2119 && cp <= 0x211D -> True
    cp if cp == 0x2124 -> True
    cp if cp == 0x2126 -> True
    cp if cp == 0x2128 -> True
    cp if cp >= 0x212A && cp <= 0x212D -> True
    cp if cp >= 0x212F && cp <= 0x2134 -> True
    cp if cp >= 0x2135 && cp <= 0x2138 -> True
    cp if cp == 0x2139 -> True
    cp if cp >= 0x213C && cp <= 0x213F -> True
    cp if cp >= 0x2145 && cp <= 0x2149 -> True
    cp if cp == 0x214E -> True
    cp if cp == 0x214F -> True
    cp if cp >= 0x2160 && cp <= 0x2182 -> True
    cp if cp >= 0x2183 && cp <= 0x2184 -> True
    cp if cp >= 0x2185 && cp <= 0x2188 -> True
    cp if cp >= 0x2336 && cp <= 0x237A -> True
    cp if cp == 0x2395 -> True
    cp if cp >= 0x249C && cp <= 0x24E9 -> True
    cp if cp == 0x26AC -> True
    cp if cp >= 0x2800 && cp <= 0x28FF -> True
    cp if cp >= 0x2C00 && cp <= 0x2C7B -> True
    cp if cp >= 0x2C7C && cp <= 0x2C7D -> True
    cp if cp >= 0x2C7E && cp <= 0x2CE4 -> True
    cp if cp >= 0x2CEB && cp <= 0x2CEE -> True
    cp if cp >= 0x2CF2 && cp <= 0x2CF3 -> True
    cp if cp >= 0x2D00 && cp <= 0x2D25 -> True
    cp if cp == 0x2D27 -> True
    cp if cp == 0x2D2D -> True
    cp if cp >= 0x2D30 && cp <= 0x2D67 -> True
    cp if cp == 0x2D6F -> True
    cp if cp == 0x2D70 -> True
    cp if cp >= 0x2D80 && cp <= 0x2D96 -> True
    cp if cp >= 0x2DA0 && cp <= 0x2DA6 -> True
    cp if cp >= 0x2DA8 && cp <= 0x2DAE -> True
    cp if cp >= 0x2DB0 && cp <= 0x2DB6 -> True
    cp if cp >= 0x2DB8 && cp <= 0x2DBE -> True
    cp if cp >= 0x2DC0 && cp <= 0x2DC6 -> True
    cp if cp >= 0x2DC8 && cp <= 0x2DCE -> True
    cp if cp >= 0x2DD0 && cp <= 0x2DD6 -> True
    cp if cp >= 0x2DD8 && cp <= 0x2DDE -> True
    cp if cp == 0x3005 -> True
    cp if cp == 0x3006 -> True
    cp if cp == 0x3007 -> True
    cp if cp >= 0x3021 && cp <= 0x3029 -> True
    cp if cp >= 0x302E && cp <= 0x302F -> True
    cp if cp >= 0x3031 && cp <= 0x3035 -> True
    cp if cp >= 0x3038 && cp <= 0x303A -> True
    cp if cp == 0x303B -> True
    cp if cp == 0x303C -> True
    cp if cp >= 0x3041 && cp <= 0x3096 -> True
    cp if cp >= 0x309D && cp <= 0x309E -> True
    cp if cp == 0x309F -> True
    cp if cp >= 0x30A1 && cp <= 0x30FA -> True
    cp if cp >= 0x30FC && cp <= 0x30FE -> True
    cp if cp == 0x30FF -> True
    cp if cp >= 0x3105 && cp <= 0x312F -> True
    cp if cp >= 0x3131 && cp <= 0x318E -> True
    cp if cp >= 0x3190 && cp <= 0x3191 -> True
    cp if cp >= 0x3192 && cp <= 0x3195 -> True
    cp if cp >= 0x3196 && cp <= 0x319F -> True
    cp if cp >= 0x31A0 && cp <= 0x31BF -> True
    cp if cp >= 0x31F0 && cp <= 0x31FF -> True
    cp if cp >= 0x3200 && cp <= 0x321C -> True
    cp if cp >= 0x3220 && cp <= 0x3229 -> True
    cp if cp >= 0x322A && cp <= 0x3247 -> True
    cp if cp >= 0x3248 && cp <= 0x324F -> True
    cp if cp >= 0x3260 && cp <= 0x327B -> True
    cp if cp == 0x327F -> True
    cp if cp >= 0x3280 && cp <= 0x3289 -> True
    cp if cp >= 0x328A && cp <= 0x32B0 -> True
    cp if cp >= 0x32C0 && cp <= 0x32CB -> True
    cp if cp >= 0x32D0 && cp <= 0x3376 -> True
    cp if cp >= 0x337B && cp <= 0x33DD -> True
    cp if cp >= 0x33E0 && cp <= 0x33FE -> True
    cp if cp >= 0x3400 && cp <= 0x4DBF -> True
    cp if cp >= 0x4E00 && cp <= 0xA014 -> True
    cp if cp == 0xA015 -> True
    cp if cp >= 0xA016 && cp <= 0xA48C -> True
    cp if cp >= 0xA4D0 && cp <= 0xA4F7 -> True
    cp if cp >= 0xA4F8 && cp <= 0xA4FD -> True
    cp if cp >= 0xA4FE && cp <= 0xA4FF -> True
    cp if cp >= 0xA500 && cp <= 0xA60B -> True
    cp if cp == 0xA60C -> True
    cp if cp >= 0xA610 && cp <= 0xA61F -> True
    cp if cp >= 0xA620 && cp <= 0xA629 -> True
    cp if cp >= 0xA62A && cp <= 0xA62B -> True
    cp if cp >= 0xA640 && cp <= 0xA66D -> True
    cp if cp == 0xA66E -> True
    cp if cp >= 0xA680 && cp <= 0xA69B -> True
    cp if cp >= 0xA69C && cp <= 0xA69D -> True
    cp if cp >= 0xA6A0 && cp <= 0xA6E5 -> True
    cp if cp >= 0xA6E6 && cp <= 0xA6EF -> True
    cp if cp >= 0xA6F2 && cp <= 0xA6F7 -> True
    cp if cp >= 0xA722 && cp <= 0xA76F -> True
    cp if cp == 0xA770 -> True
    cp if cp >= 0xA771 && cp <= 0xA787 -> True
    cp if cp >= 0xA789 && cp <= 0xA78A -> True
    cp if cp >= 0xA78B && cp <= 0xA78E -> True
    cp if cp == 0xA78F -> True
    cp if cp >= 0xA790 && cp <= 0xA7CD -> True
    cp if cp >= 0xA7D0 && cp <= 0xA7D1 -> True
    cp if cp == 0xA7D3 -> True
    cp if cp >= 0xA7D5 && cp <= 0xA7DC -> True
    cp if cp >= 0xA7F2 && cp <= 0xA7F4 -> True
    cp if cp >= 0xA7F5 && cp <= 0xA7F6 -> True
    cp if cp == 0xA7F7 -> True
    cp if cp >= 0xA7F8 && cp <= 0xA7F9 -> True
    cp if cp == 0xA7FA -> True
    cp if cp >= 0xA7FB && cp <= 0xA801 -> True
    cp if cp >= 0xA803 && cp <= 0xA805 -> True
    cp if cp >= 0xA807 && cp <= 0xA80A -> True
    cp if cp >= 0xA80C && cp <= 0xA822 -> True
    cp if cp >= 0xA823 && cp <= 0xA824 -> True
    cp if cp == 0xA827 -> True
    cp if cp >= 0xA830 && cp <= 0xA835 -> True
    cp if cp >= 0xA836 && cp <= 0xA837 -> True
    cp if cp >= 0xA840 && cp <= 0xA873 -> True
    cp if cp >= 0xA880 && cp <= 0xA881 -> True
    cp if cp >= 0xA882 && cp <= 0xA8B3 -> True
    cp if cp >= 0xA8B4 && cp <= 0xA8C3 -> True
    cp if cp >= 0xA8CE && cp <= 0xA8CF -> True
    cp if cp >= 0xA8D0 && cp <= 0xA8D9 -> True
    cp if cp >= 0xA8F2 && cp <= 0xA8F7 -> True
    cp if cp >= 0xA8F8 && cp <= 0xA8FA -> True
    cp if cp == 0xA8FB -> True
    cp if cp == 0xA8FC -> True
    cp if cp >= 0xA8FD && cp <= 0xA8FE -> True
    cp if cp >= 0xA900 && cp <= 0xA909 -> True
    cp if cp >= 0xA90A && cp <= 0xA925 -> True
    cp if cp >= 0xA92E && cp <= 0xA92F -> True
    cp if cp >= 0xA930 && cp <= 0xA946 -> True
    cp if cp >= 0xA952 && cp <= 0xA953 -> True
    cp if cp == 0xA95F -> True
    cp if cp >= 0xA960 && cp <= 0xA97C -> True
    cp if cp == 0xA983 -> True
    cp if cp >= 0xA984 && cp <= 0xA9B2 -> True
    cp if cp >= 0xA9B4 && cp <= 0xA9B5 -> True
    cp if cp >= 0xA9BA && cp <= 0xA9BB -> True
    cp if cp >= 0xA9BE && cp <= 0xA9C0 -> True
    cp if cp >= 0xA9C1 && cp <= 0xA9CD -> True
    cp if cp == 0xA9CF -> True
    cp if cp >= 0xA9D0 && cp <= 0xA9D9 -> True
    cp if cp >= 0xA9DE && cp <= 0xA9DF -> True
    cp if cp >= 0xA9E0 && cp <= 0xA9E4 -> True
    cp if cp == 0xA9E6 -> True
    cp if cp >= 0xA9E7 && cp <= 0xA9EF -> True
    cp if cp >= 0xA9F0 && cp <= 0xA9F9 -> True
    cp if cp >= 0xA9FA && cp <= 0xA9FE -> True
    cp if cp >= 0xAA00 && cp <= 0xAA28 -> True
    cp if cp >= 0xAA2F && cp <= 0xAA30 -> True
    cp if cp >= 0xAA33 && cp <= 0xAA34 -> True
    cp if cp >= 0xAA40 && cp <= 0xAA42 -> True
    cp if cp >= 0xAA44 && cp <= 0xAA4B -> True
    cp if cp == 0xAA4D -> True
    cp if cp >= 0xAA50 && cp <= 0xAA59 -> True
    cp if cp >= 0xAA5C && cp <= 0xAA5F -> True
    cp if cp >= 0xAA60 && cp <= 0xAA6F -> True
    cp if cp == 0xAA70 -> True
    cp if cp >= 0xAA71 && cp <= 0xAA76 -> True
    cp if cp >= 0xAA77 && cp <= 0xAA79 -> True
    cp if cp == 0xAA7A -> True
    cp if cp == 0xAA7B -> True
    cp if cp == 0xAA7D -> True
    cp if cp >= 0xAA7E && cp <= 0xAAAF -> True
    cp if cp == 0xAAB1 -> True
    cp if cp >= 0xAAB5 && cp <= 0xAAB6 -> True
    cp if cp >= 0xAAB9 && cp <= 0xAABD -> True
    cp if cp == 0xAAC0 -> True
    cp if cp == 0xAAC2 -> True
    cp if cp >= 0xAADB && cp <= 0xAADC -> True
    cp if cp == 0xAADD -> True
    cp if cp >= 0xAADE && cp <= 0xAADF -> True
    cp if cp >= 0xAAE0 && cp <= 0xAAEA -> True
    cp if cp == 0xAAEB -> True
    cp if cp >= 0xAAEE && cp <= 0xAAEF -> True
    cp if cp >= 0xAAF0 && cp <= 0xAAF1 -> True
    cp if cp == 0xAAF2 -> True
    cp if cp >= 0xAAF3 && cp <= 0xAAF4 -> True
    cp if cp == 0xAAF5 -> True
    cp if cp >= 0xAB01 && cp <= 0xAB06 -> True
    cp if cp >= 0xAB09 && cp <= 0xAB0E -> True
    cp if cp >= 0xAB11 && cp <= 0xAB16 -> True
    cp if cp >= 0xAB20 && cp <= 0xAB26 -> True
    cp if cp >= 0xAB28 && cp <= 0xAB2E -> True
    cp if cp >= 0xAB30 && cp <= 0xAB5A -> True
    cp if cp == 0xAB5B -> True
    cp if cp >= 0xAB5C && cp <= 0xAB5F -> True
    cp if cp >= 0xAB60 && cp <= 0xAB68 -> True
    cp if cp == 0xAB69 -> True
    cp if cp >= 0xAB70 && cp <= 0xABBF -> True
    cp if cp >= 0xABC0 && cp <= 0xABE2 -> True
    cp if cp >= 0xABE3 && cp <= 0xABE4 -> True
    cp if cp >= 0xABE6 && cp <= 0xABE7 -> True
    cp if cp >= 0xABE9 && cp <= 0xABEA -> True
    cp if cp == 0xABEB -> True
    cp if cp == 0xABEC -> True
    cp if cp >= 0xABF0 && cp <= 0xABF9 -> True
    cp if cp >= 0xAC00 && cp <= 0xD7A3 -> True
    cp if cp >= 0xD7B0 && cp <= 0xD7C6 -> True
    cp if cp >= 0xD7CB && cp <= 0xD7FB -> True
    cp if cp >= 0xE000 && cp <= 0xF8FF -> True
    cp if cp >= 0xF900 && cp <= 0xFA6D -> True
    cp if cp >= 0xFA70 && cp <= 0xFAD9 -> True
    cp if cp >= 0xFB00 && cp <= 0xFB06 -> True
    cp if cp >= 0xFB13 && cp <= 0xFB17 -> True
    cp if cp >= 0xFF21 && cp <= 0xFF3A -> True
    cp if cp >= 0xFF41 && cp <= 0xFF5A -> True
    cp if cp >= 0xFF66 && cp <= 0xFF6F -> True
    cp if cp == 0xFF70 -> True
    cp if cp >= 0xFF71 && cp <= 0xFF9D -> True
    cp if cp >= 0xFF9E && cp <= 0xFF9F -> True
    cp if cp >= 0xFFA0 && cp <= 0xFFBE -> True
    cp if cp >= 0xFFC2 && cp <= 0xFFC7 -> True
    cp if cp >= 0xFFCA && cp <= 0xFFCF -> True
    cp if cp >= 0xFFD2 && cp <= 0xFFD7 -> True
    cp if cp >= 0xFFDA && cp <= 0xFFDC -> True
    cp if cp >= 0x10000 && cp <= 0x1000B -> True
    cp if cp >= 0x1000D && cp <= 0x10026 -> True
    cp if cp >= 0x10028 && cp <= 0x1003A -> True
    cp if cp >= 0x1003C && cp <= 0x1003D -> True
    cp if cp >= 0x1003F && cp <= 0x1004D -> True
    cp if cp >= 0x10050 && cp <= 0x1005D -> True
    cp if cp >= 0x10080 && cp <= 0x100FA -> True
    cp if cp == 0x10100 -> True
    cp if cp == 0x10102 -> True
    cp if cp >= 0x10107 && cp <= 0x10133 -> True
    cp if cp >= 0x10137 && cp <= 0x1013F -> True
    cp if cp >= 0x1018D && cp <= 0x1018E -> True
    cp if cp >= 0x101D0 && cp <= 0x101FC -> True
    cp if cp >= 0x10280 && cp <= 0x1029C -> True
    cp if cp >= 0x102A0 && cp <= 0x102D0 -> True
    cp if cp >= 0x10300 && cp <= 0x1031F -> True
    cp if cp >= 0x10320 && cp <= 0x10323 -> True
    cp if cp >= 0x1032D && cp <= 0x10340 -> True
    cp if cp == 0x10341 -> True
    cp if cp >= 0x10342 && cp <= 0x10349 -> True
    cp if cp == 0x1034A -> True
    cp if cp >= 0x10350 && cp <= 0x10375 -> True
    cp if cp >= 0x10380 && cp <= 0x1039D -> True
    cp if cp == 0x1039F -> True
    cp if cp >= 0x103A0 && cp <= 0x103C3 -> True
    cp if cp >= 0x103C8 && cp <= 0x103CF -> True
    cp if cp == 0x103D0 -> True
    cp if cp >= 0x103D1 && cp <= 0x103D5 -> True
    cp if cp >= 0x10400 && cp <= 0x1044F -> True
    cp if cp >= 0x10450 && cp <= 0x1049D -> True
    cp if cp >= 0x104A0 && cp <= 0x104A9 -> True
    cp if cp >= 0x104B0 && cp <= 0x104D3 -> True
    cp if cp >= 0x104D8 && cp <= 0x104FB -> True
    cp if cp >= 0x10500 && cp <= 0x10527 -> True
    cp if cp >= 0x10530 && cp <= 0x10563 -> True
    cp if cp == 0x1056F -> True
    cp if cp >= 0x10570 && cp <= 0x1057A -> True
    cp if cp >= 0x1057C && cp <= 0x1058A -> True
    cp if cp >= 0x1058C && cp <= 0x10592 -> True
    cp if cp >= 0x10594 && cp <= 0x10595 -> True
    cp if cp >= 0x10597 && cp <= 0x105A1 -> True
    cp if cp >= 0x105A3 && cp <= 0x105B1 -> True
    cp if cp >= 0x105B3 && cp <= 0x105B9 -> True
    cp if cp >= 0x105BB && cp <= 0x105BC -> True
    cp if cp >= 0x105C0 && cp <= 0x105F3 -> True
    cp if cp >= 0x10600 && cp <= 0x10736 -> True
    cp if cp >= 0x10740 && cp <= 0x10755 -> True
    cp if cp >= 0x10760 && cp <= 0x10767 -> True
    cp if cp >= 0x10780 && cp <= 0x10785 -> True
    cp if cp >= 0x10787 && cp <= 0x107B0 -> True
    cp if cp >= 0x107B2 && cp <= 0x107BA -> True
    cp if cp == 0x11000 -> True
    cp if cp == 0x11002 -> True
    cp if cp >= 0x11003 && cp <= 0x11037 -> True
    cp if cp >= 0x11047 && cp <= 0x1104D -> True
    cp if cp >= 0x11066 && cp <= 0x1106F -> True
    cp if cp >= 0x11071 && cp <= 0x11072 -> True
    cp if cp == 0x11075 -> True
    cp if cp == 0x11082 -> True
    cp if cp >= 0x11083 && cp <= 0x110AF -> True
    cp if cp >= 0x110B0 && cp <= 0x110B2 -> True
    cp if cp >= 0x110B7 && cp <= 0x110B8 -> True
    cp if cp >= 0x110BB && cp <= 0x110BC -> True
    cp if cp == 0x110BD -> True
    cp if cp >= 0x110BE && cp <= 0x110C1 -> True
    cp if cp == 0x110CD -> True
    cp if cp >= 0x110D0 && cp <= 0x110E8 -> True
    cp if cp >= 0x110F0 && cp <= 0x110F9 -> True
    cp if cp >= 0x11103 && cp <= 0x11126 -> True
    cp if cp == 0x1112C -> True
    cp if cp >= 0x11136 && cp <= 0x1113F -> True
    cp if cp >= 0x11140 && cp <= 0x11143 -> True
    cp if cp == 0x11144 -> True
    cp if cp >= 0x11145 && cp <= 0x11146 -> True
    cp if cp == 0x11147 -> True
    cp if cp >= 0x11150 && cp <= 0x11172 -> True
    cp if cp >= 0x11174 && cp <= 0x11175 -> True
    cp if cp == 0x11176 -> True
    cp if cp == 0x11182 -> True
    cp if cp >= 0x11183 && cp <= 0x111B2 -> True
    cp if cp >= 0x111B3 && cp <= 0x111B5 -> True
    cp if cp >= 0x111BF && cp <= 0x111C0 -> True
    cp if cp >= 0x111C1 && cp <= 0x111C4 -> True
    cp if cp >= 0x111C5 && cp <= 0x111C8 -> True
    cp if cp == 0x111CD -> True
    cp if cp == 0x111CE -> True
    cp if cp >= 0x111D0 && cp <= 0x111D9 -> True
    cp if cp == 0x111DA -> True
    cp if cp == 0x111DB -> True
    cp if cp == 0x111DC -> True
    cp if cp >= 0x111DD && cp <= 0x111DF -> True
    cp if cp >= 0x111E1 && cp <= 0x111F4 -> True
    cp if cp >= 0x11200 && cp <= 0x11211 -> True
    cp if cp >= 0x11213 && cp <= 0x1122B -> True
    cp if cp >= 0x1122C && cp <= 0x1122E -> True
    cp if cp >= 0x11232 && cp <= 0x11233 -> True
    cp if cp == 0x11235 -> True
    cp if cp >= 0x11238 && cp <= 0x1123D -> True
    cp if cp >= 0x1123F && cp <= 0x11240 -> True
    cp if cp >= 0x11280 && cp <= 0x11286 -> True
    cp if cp == 0x11288 -> True
    cp if cp >= 0x1128A && cp <= 0x1128D -> True
    cp if cp >= 0x1128F && cp <= 0x1129D -> True
    cp if cp >= 0x1129F && cp <= 0x112A8 -> True
    cp if cp == 0x112A9 -> True
    cp if cp >= 0x112B0 && cp <= 0x112DE -> True
    cp if cp >= 0x112E0 && cp <= 0x112E2 -> True
    cp if cp >= 0x112F0 && cp <= 0x112F9 -> True
    cp if cp >= 0x11302 && cp <= 0x11303 -> True
    cp if cp >= 0x11305 && cp <= 0x1130C -> True
    cp if cp >= 0x1130F && cp <= 0x11310 -> True
    cp if cp >= 0x11313 && cp <= 0x11328 -> True
    cp if cp >= 0x1132A && cp <= 0x11330 -> True
    cp if cp >= 0x11332 && cp <= 0x11333 -> True
    cp if cp >= 0x11335 && cp <= 0x11339 -> True
    cp if cp == 0x1133D -> True
    cp if cp >= 0x1133E && cp <= 0x1133F -> True
    cp if cp >= 0x11341 && cp <= 0x11344 -> True
    cp if cp >= 0x11347 && cp <= 0x11348 -> True
    cp if cp >= 0x1134B && cp <= 0x1134D -> True
    cp if cp == 0x11350 -> True
    cp if cp == 0x11357 -> True
    cp if cp >= 0x1135D && cp <= 0x11361 -> True
    cp if cp >= 0x11362 && cp <= 0x11363 -> True
    cp if cp >= 0x11380 && cp <= 0x11389 -> True
    cp if cp == 0x1138B -> True
    cp if cp == 0x1138E -> True
    cp if cp >= 0x11390 && cp <= 0x113B5 -> True
    cp if cp == 0x113B7 -> True
    cp if cp >= 0x113B8 && cp <= 0x113BA -> True
    cp if cp == 0x113C2 -> True
    cp if cp == 0x113C5 -> True
    cp if cp >= 0x113C7 && cp <= 0x113CA -> True
    cp if cp >= 0x113CC && cp <= 0x113CD -> True
    cp if cp == 0x113CF -> True
    cp if cp == 0x113D1 -> True
    cp if cp == 0x113D3 -> True
    cp if cp >= 0x113D4 && cp <= 0x113D5 -> True
    cp if cp >= 0x113D7 && cp <= 0x113D8 -> True
    cp if cp >= 0x11400 && cp <= 0x11434 -> True
    cp if cp >= 0x11435 && cp <= 0x11437 -> True
    cp if cp >= 0x11440 && cp <= 0x11441 -> True
    cp if cp == 0x11445 -> True
    cp if cp >= 0x11447 && cp <= 0x1144A -> True
    cp if cp >= 0x1144B && cp <= 0x1144F -> True
    cp if cp >= 0x11450 && cp <= 0x11459 -> True
    cp if cp >= 0x1145A && cp <= 0x1145B -> True
    cp if cp == 0x1145D -> True
    cp if cp >= 0x1145F && cp <= 0x11461 -> True
    cp if cp >= 0x11480 && cp <= 0x114AF -> True
    cp if cp >= 0x114B0 && cp <= 0x114B2 -> True
    cp if cp == 0x114B9 -> True
    cp if cp >= 0x114BB && cp <= 0x114BE -> True
    cp if cp == 0x114C1 -> True
    cp if cp >= 0x114C4 && cp <= 0x114C5 -> True
    cp if cp == 0x114C6 -> True
    cp if cp == 0x114C7 -> True
    cp if cp >= 0x114D0 && cp <= 0x114D9 -> True
    cp if cp >= 0x11580 && cp <= 0x115AE -> True
    cp if cp >= 0x115AF && cp <= 0x115B1 -> True
    cp if cp >= 0x115B8 && cp <= 0x115BB -> True
    cp if cp == 0x115BE -> True
    cp if cp >= 0x115C1 && cp <= 0x115D7 -> True
    cp if cp >= 0x115D8 && cp <= 0x115DB -> True
    cp if cp >= 0x11600 && cp <= 0x1162F -> True
    cp if cp >= 0x11630 && cp <= 0x11632 -> True
    cp if cp >= 0x1163B && cp <= 0x1163C -> True
    cp if cp == 0x1163E -> True
    cp if cp >= 0x11641 && cp <= 0x11643 -> True
    cp if cp == 0x11644 -> True
    cp if cp >= 0x11650 && cp <= 0x11659 -> True
    cp if cp >= 0x11680 && cp <= 0x116AA -> True
    cp if cp == 0x116AC -> True
    cp if cp >= 0x116AE && cp <= 0x116AF -> True
    cp if cp == 0x116B6 -> True
    cp if cp == 0x116B8 -> True
    cp if cp == 0x116B9 -> True
    cp if cp >= 0x116C0 && cp <= 0x116C9 -> True
    cp if cp >= 0x116D0 && cp <= 0x116E3 -> True
    cp if cp >= 0x11700 && cp <= 0x1171A -> True
    cp if cp == 0x1171E -> True
    cp if cp >= 0x11720 && cp <= 0x11721 -> True
    cp if cp == 0x11726 -> True
    cp if cp >= 0x11730 && cp <= 0x11739 -> True
    cp if cp >= 0x1173A && cp <= 0x1173B -> True
    cp if cp >= 0x1173C && cp <= 0x1173E -> True
    cp if cp == 0x1173F -> True
    cp if cp >= 0x11740 && cp <= 0x11746 -> True
    cp if cp >= 0x11800 && cp <= 0x1182B -> True
    cp if cp >= 0x1182C && cp <= 0x1182E -> True
    cp if cp == 0x11838 -> True
    cp if cp == 0x1183B -> True
    cp if cp >= 0x118A0 && cp <= 0x118DF -> True
    cp if cp >= 0x118E0 && cp <= 0x118E9 -> True
    cp if cp >= 0x118EA && cp <= 0x118F2 -> True
    cp if cp >= 0x118FF && cp <= 0x11906 -> True
    cp if cp == 0x11909 -> True
    cp if cp >= 0x1190C && cp <= 0x11913 -> True
    cp if cp >= 0x11915 && cp <= 0x11916 -> True
    cp if cp >= 0x11918 && cp <= 0x1192F -> True
    cp if cp >= 0x11930 && cp <= 0x11935 -> True
    cp if cp >= 0x11937 && cp <= 0x11938 -> True
    cp if cp == 0x1193D -> True
    cp if cp == 0x1193F -> True
    cp if cp == 0x11940 -> True
    cp if cp == 0x11941 -> True
    cp if cp == 0x11942 -> True
    cp if cp >= 0x11944 && cp <= 0x11946 -> True
    cp if cp >= 0x11950 && cp <= 0x11959 -> True
    cp if cp >= 0x119A0 && cp <= 0x119A7 -> True
    cp if cp >= 0x119AA && cp <= 0x119D0 -> True
    cp if cp >= 0x119D1 && cp <= 0x119D3 -> True
    cp if cp >= 0x119DC && cp <= 0x119DF -> True
    cp if cp == 0x119E1 -> True
    cp if cp == 0x119E2 -> True
    cp if cp == 0x119E3 -> True
    cp if cp == 0x119E4 -> True
    cp if cp == 0x11A00 -> True
    cp if cp >= 0x11A07 && cp <= 0x11A08 -> True
    cp if cp >= 0x11A0B && cp <= 0x11A32 -> True
    cp if cp == 0x11A39 -> True
    cp if cp == 0x11A3A -> True
    cp if cp >= 0x11A3F && cp <= 0x11A46 -> True
    cp if cp == 0x11A50 -> True
    cp if cp >= 0x11A57 && cp <= 0x11A58 -> True
    cp if cp >= 0x11A5C && cp <= 0x11A89 -> True
    cp if cp == 0x11A97 -> True
    cp if cp >= 0x11A9A && cp <= 0x11A9C -> True
    cp if cp == 0x11A9D -> True
    cp if cp >= 0x11A9E && cp <= 0x11AA2 -> True
    cp if cp >= 0x11AB0 && cp <= 0x11AF8 -> True
    cp if cp >= 0x11B00 && cp <= 0x11B09 -> True
    cp if cp >= 0x11BC0 && cp <= 0x11BE0 -> True
    cp if cp == 0x11BE1 -> True
    cp if cp >= 0x11BF0 && cp <= 0x11BF9 -> True
    cp if cp >= 0x11C00 && cp <= 0x11C08 -> True
    cp if cp >= 0x11C0A && cp <= 0x11C2E -> True
    cp if cp == 0x11C2F -> True
    cp if cp == 0x11C3E -> True
    cp if cp == 0x11C3F -> True
    cp if cp == 0x11C40 -> True
    cp if cp >= 0x11C41 && cp <= 0x11C45 -> True
    cp if cp >= 0x11C50 && cp <= 0x11C59 -> True
    cp if cp >= 0x11C5A && cp <= 0x11C6C -> True
    cp if cp >= 0x11C70 && cp <= 0x11C71 -> True
    cp if cp >= 0x11C72 && cp <= 0x11C8F -> True
    cp if cp == 0x11CA9 -> True
    cp if cp == 0x11CB1 -> True
    cp if cp == 0x11CB4 -> True
    cp if cp >= 0x11D00 && cp <= 0x11D06 -> True
    cp if cp >= 0x11D08 && cp <= 0x11D09 -> True
    cp if cp >= 0x11D0B && cp <= 0x11D30 -> True
    cp if cp == 0x11D46 -> True
    cp if cp >= 0x11D50 && cp <= 0x11D59 -> True
    cp if cp >= 0x11D60 && cp <= 0x11D65 -> True
    cp if cp >= 0x11D67 && cp <= 0x11D68 -> True
    cp if cp >= 0x11D6A && cp <= 0x11D89 -> True
    cp if cp >= 0x11D8A && cp <= 0x11D8E -> True
    cp if cp >= 0x11D93 && cp <= 0x11D94 -> True
    cp if cp == 0x11D96 -> True
    cp if cp == 0x11D98 -> True
    cp if cp >= 0x11DA0 && cp <= 0x11DA9 -> True
    cp if cp >= 0x11EE0 && cp <= 0x11EF2 -> True
    cp if cp >= 0x11EF5 && cp <= 0x11EF6 -> True
    cp if cp >= 0x11EF7 && cp <= 0x11EF8 -> True
    cp if cp == 0x11F02 -> True
    cp if cp == 0x11F03 -> True
    cp if cp >= 0x11F04 && cp <= 0x11F10 -> True
    cp if cp >= 0x11F12 && cp <= 0x11F33 -> True
    cp if cp >= 0x11F34 && cp <= 0x11F35 -> True
    cp if cp >= 0x11F3E && cp <= 0x11F3F -> True
    cp if cp == 0x11F41 -> True
    cp if cp >= 0x11F43 && cp <= 0x11F4F -> True
    cp if cp >= 0x11F50 && cp <= 0x11F59 -> True
    cp if cp == 0x11FB0 -> True
    cp if cp >= 0x11FC0 && cp <= 0x11FD4 -> True
    cp if cp == 0x11FFF -> True
    cp if cp >= 0x12000 && cp <= 0x12399 -> True
    cp if cp >= 0x12400 && cp <= 0x1246E -> True
    cp if cp >= 0x12470 && cp <= 0x12474 -> True
    cp if cp >= 0x12480 && cp <= 0x12543 -> True
    cp if cp >= 0x12F90 && cp <= 0x12FF0 -> True
    cp if cp >= 0x12FF1 && cp <= 0x12FF2 -> True
    cp if cp >= 0x13000 && cp <= 0x1342F -> True
    cp if cp >= 0x13430 && cp <= 0x1343F -> True
    cp if cp >= 0x13441 && cp <= 0x13446 -> True
    cp if cp >= 0x13460 && cp <= 0x143FA -> True
    cp if cp >= 0x14400 && cp <= 0x14646 -> True
    cp if cp >= 0x16100 && cp <= 0x1611D -> True
    cp if cp >= 0x1612A && cp <= 0x1612C -> True
    cp if cp >= 0x16130 && cp <= 0x16139 -> True
    cp if cp >= 0x16800 && cp <= 0x16A38 -> True
    cp if cp >= 0x16A40 && cp <= 0x16A5E -> True
    cp if cp >= 0x16A60 && cp <= 0x16A69 -> True
    cp if cp >= 0x16A6E && cp <= 0x16A6F -> True
    cp if cp >= 0x16A70 && cp <= 0x16ABE -> True
    cp if cp >= 0x16AC0 && cp <= 0x16AC9 -> True
    cp if cp >= 0x16AD0 && cp <= 0x16AED -> True
    cp if cp == 0x16AF5 -> True
    cp if cp >= 0x16B00 && cp <= 0x16B2F -> True
    cp if cp >= 0x16B37 && cp <= 0x16B3B -> True
    cp if cp >= 0x16B3C && cp <= 0x16B3F -> True
    cp if cp >= 0x16B40 && cp <= 0x16B43 -> True
    cp if cp == 0x16B44 -> True
    cp if cp == 0x16B45 -> True
    cp if cp >= 0x16B50 && cp <= 0x16B59 -> True
    cp if cp >= 0x16B5B && cp <= 0x16B61 -> True
    cp if cp >= 0x16B63 && cp <= 0x16B77 -> True
    cp if cp >= 0x16B7D && cp <= 0x16B8F -> True
    cp if cp >= 0x16D40 && cp <= 0x16D42 -> True
    cp if cp >= 0x16D43 && cp <= 0x16D6A -> True
    cp if cp >= 0x16D6B && cp <= 0x16D6C -> True
    cp if cp >= 0x16D6D && cp <= 0x16D6F -> True
    cp if cp >= 0x16D70 && cp <= 0x16D79 -> True
    cp if cp >= 0x16E40 && cp <= 0x16E7F -> True
    cp if cp >= 0x16E80 && cp <= 0x16E96 -> True
    cp if cp >= 0x16E97 && cp <= 0x16E9A -> True
    cp if cp >= 0x16F00 && cp <= 0x16F4A -> True
    cp if cp == 0x16F50 -> True
    cp if cp >= 0x16F51 && cp <= 0x16F87 -> True
    cp if cp >= 0x16F93 && cp <= 0x16F9F -> True
    cp if cp >= 0x16FE0 && cp <= 0x16FE1 -> True
    cp if cp == 0x16FE3 -> True
    cp if cp >= 0x16FF0 && cp <= 0x16FF1 -> True
    cp if cp >= 0x17000 && cp <= 0x187F7 -> True
    cp if cp >= 0x18800 && cp <= 0x18CD5 -> True
    cp if cp >= 0x18CFF && cp <= 0x18D08 -> True
    cp if cp >= 0x1AFF0 && cp <= 0x1AFF3 -> True
    cp if cp >= 0x1AFF5 && cp <= 0x1AFFB -> True
    cp if cp >= 0x1AFFD && cp <= 0x1AFFE -> True
    cp if cp >= 0x1B000 && cp <= 0x1B122 -> True
    cp if cp == 0x1B132 -> True
    cp if cp >= 0x1B150 && cp <= 0x1B152 -> True
    cp if cp == 0x1B155 -> True
    cp if cp >= 0x1B164 && cp <= 0x1B167 -> True
    cp if cp >= 0x1B170 && cp <= 0x1B2FB -> True
    cp if cp >= 0x1BC00 && cp <= 0x1BC6A -> True
    cp if cp >= 0x1BC70 && cp <= 0x1BC7C -> True
    cp if cp >= 0x1BC80 && cp <= 0x1BC88 -> True
    cp if cp >= 0x1BC90 && cp <= 0x1BC99 -> True
    cp if cp == 0x1BC9C -> True
    cp if cp == 0x1BC9F -> True
    cp if cp >= 0x1CCD6 && cp <= 0x1CCEF -> True
    cp if cp >= 0x1CF50 && cp <= 0x1CFC3 -> True
    cp if cp >= 0x1D000 && cp <= 0x1D0F5 -> True
    cp if cp >= 0x1D100 && cp <= 0x1D126 -> True
    cp if cp >= 0x1D129 && cp <= 0x1D164 -> True
    cp if cp >= 0x1D165 && cp <= 0x1D166 -> True
    cp if cp >= 0x1D16A && cp <= 0x1D16C -> True
    cp if cp >= 0x1D16D && cp <= 0x1D172 -> True
    cp if cp >= 0x1D183 && cp <= 0x1D184 -> True
    cp if cp >= 0x1D18C && cp <= 0x1D1A9 -> True
    cp if cp >= 0x1D1AE && cp <= 0x1D1E8 -> True
    cp if cp >= 0x1D2C0 && cp <= 0x1D2D3 -> True
    cp if cp >= 0x1D2E0 && cp <= 0x1D2F3 -> True
    cp if cp >= 0x1D360 && cp <= 0x1D378 -> True
    cp if cp >= 0x1D400 && cp <= 0x1D454 -> True
    cp if cp >= 0x1D456 && cp <= 0x1D49C -> True
    cp if cp >= 0x1D49E && cp <= 0x1D49F -> True
    cp if cp == 0x1D4A2 -> True
    cp if cp >= 0x1D4A5 && cp <= 0x1D4A6 -> True
    cp if cp >= 0x1D4A9 && cp <= 0x1D4AC -> True
    cp if cp >= 0x1D4AE && cp <= 0x1D4B9 -> True
    cp if cp == 0x1D4BB -> True
    cp if cp >= 0x1D4BD && cp <= 0x1D4C3 -> True
    cp if cp >= 0x1D4C5 && cp <= 0x1D505 -> True
    cp if cp >= 0x1D507 && cp <= 0x1D50A -> True
    cp if cp >= 0x1D50D && cp <= 0x1D514 -> True
    cp if cp >= 0x1D516 && cp <= 0x1D51C -> True
    cp if cp >= 0x1D51E && cp <= 0x1D539 -> True
    cp if cp >= 0x1D53B && cp <= 0x1D53E -> True
    cp if cp >= 0x1D540 && cp <= 0x1D544 -> True
    cp if cp == 0x1D546 -> True
    cp if cp >= 0x1D54A && cp <= 0x1D550 -> True
    cp if cp >= 0x1D552 && cp <= 0x1D6A5 -> True
    cp if cp >= 0x1D6A8 && cp <= 0x1D6C0 -> True
    cp if cp >= 0x1D6C2 && cp <= 0x1D6DA -> True
    cp if cp >= 0x1D6DC && cp <= 0x1D6FA -> True
    cp if cp >= 0x1D6FC && cp <= 0x1D714 -> True
    cp if cp >= 0x1D716 && cp <= 0x1D734 -> True
    cp if cp >= 0x1D736 && cp <= 0x1D74E -> True
    cp if cp >= 0x1D750 && cp <= 0x1D76E -> True
    cp if cp >= 0x1D770 && cp <= 0x1D788 -> True
    cp if cp >= 0x1D78A && cp <= 0x1D7A8 -> True
    cp if cp >= 0x1D7AA && cp <= 0x1D7C2 -> True
    cp if cp >= 0x1D7C4 && cp <= 0x1D7CB -> True
    cp if cp >= 0x1D800 && cp <= 0x1D9FF -> True
    cp if cp >= 0x1DA37 && cp <= 0x1DA3A -> True
    cp if cp >= 0x1DA6D && cp <= 0x1DA74 -> True
    cp if cp >= 0x1DA76 && cp <= 0x1DA83 -> True
    cp if cp >= 0x1DA85 && cp <= 0x1DA86 -> True
    cp if cp >= 0x1DA87 && cp <= 0x1DA8B -> True
    cp if cp >= 0x1DF00 && cp <= 0x1DF09 -> True
    cp if cp == 0x1DF0A -> True
    cp if cp >= 0x1DF0B && cp <= 0x1DF1E -> True
    cp if cp >= 0x1DF25 && cp <= 0x1DF2A -> True
    cp if cp >= 0x1E030 && cp <= 0x1E06D -> True
    cp if cp >= 0x1E100 && cp <= 0x1E12C -> True
    cp if cp >= 0x1E137 && cp <= 0x1E13D -> True
    cp if cp >= 0x1E140 && cp <= 0x1E149 -> True
    cp if cp == 0x1E14E -> True
    cp if cp == 0x1E14F -> True
    cp if cp >= 0x1E290 && cp <= 0x1E2AD -> True
    cp if cp >= 0x1E2C0 && cp <= 0x1E2EB -> True
    cp if cp >= 0x1E2F0 && cp <= 0x1E2F9 -> True
    cp if cp >= 0x1E4D0 && cp <= 0x1E4EA -> True
    cp if cp == 0x1E4EB -> True
    cp if cp >= 0x1E4F0 && cp <= 0x1E4F9 -> True
    cp if cp >= 0x1E5D0 && cp <= 0x1E5ED -> True
    cp if cp == 0x1E5F0 -> True
    cp if cp >= 0x1E5F1 && cp <= 0x1E5FA -> True
    cp if cp == 0x1E5FF -> True
    cp if cp >= 0x1E7E0 && cp <= 0x1E7E6 -> True
    cp if cp >= 0x1E7E8 && cp <= 0x1E7EB -> True
    cp if cp >= 0x1E7ED && cp <= 0x1E7EE -> True
    cp if cp >= 0x1E7F0 && cp <= 0x1E7FE -> True
    cp if cp >= 0x1F110 && cp <= 0x1F12E -> True
    cp if cp >= 0x1F130 && cp <= 0x1F169 -> True
    cp if cp >= 0x1F170 && cp <= 0x1F1AC -> True
    cp if cp >= 0x1F1E6 && cp <= 0x1F202 -> True
    cp if cp >= 0x1F210 && cp <= 0x1F23B -> True
    cp if cp >= 0x1F240 && cp <= 0x1F248 -> True
    cp if cp >= 0x1F250 && cp <= 0x1F251 -> True
    cp if cp >= 0x20000 && cp <= 0x2A6DF -> True
    cp if cp >= 0x2A700 && cp <= 0x2B739 -> True
    cp if cp >= 0x2B740 && cp <= 0x2B81D -> True
    cp if cp >= 0x2B820 && cp <= 0x2CEA1 -> True
    cp if cp >= 0x2CEB0 && cp <= 0x2EBE0 -> True
    cp if cp >= 0x2EBF0 && cp <= 0x2EE5D -> True
    cp if cp >= 0x2F800 && cp <= 0x2FA1D -> True
    cp if cp >= 0x30000 && cp <= 0x3134A -> True
    cp if cp >= 0x31350 && cp <= 0x323AF -> True
    cp if cp >= 0xF0000 && cp <= 0xFFFFD -> True
    cp if cp >= 0x0030 && cp <= 0x0039 -> True
    cp if cp >= 0x00B2 && cp <= 0x00B3 -> True
    cp if cp == 0x00B9 -> True
    cp if cp >= 0x06F0 && cp <= 0x06F9 -> True
    cp if cp == 0x2070 -> True
    cp if cp >= 0x2074 && cp <= 0x2079 -> True
    cp if cp >= 0x2080 && cp <= 0x2089 -> True
    cp if cp >= 0x2488 && cp <= 0x249B -> True
    cp if cp >= 0xFF10 && cp <= 0xFF19 -> True
    cp if cp >= 0x102E1 && cp <= 0x102FB -> True
    cp if cp >= 0x1CCF0 && cp <= 0x1CCF9 -> True
    cp if cp >= 0x1D7CE && cp <= 0x1D7FF -> True
    cp if cp >= 0x1F100 && cp <= 0x1F10A -> True
    cp if cp >= 0x1FBF0 && cp <= 0x1FBF9 -> True
    cp if cp == 0x002B -> True
    cp if cp == 0x002D -> True
    cp if cp >= 0x207A && cp <= 0x207B -> True
    cp if cp >= 0x208A && cp <= 0x208B -> True
    cp if cp == 0x2212 -> True
    cp if cp == 0xFB29 -> True
    cp if cp == 0xFE62 -> True
    cp if cp == 0xFE63 -> True
    cp if cp == 0xFF0B -> True
    cp if cp == 0xFF0D -> True
    cp if cp == 0x0023 -> True
    cp if cp == 0x0024 -> True
    cp if cp == 0x0025 -> True
    cp if cp >= 0x00A2 && cp <= 0x00A5 -> True
    cp if cp == 0x00B0 -> True
    cp if cp == 0x00B1 -> True
    cp if cp == 0x058F -> True
    cp if cp >= 0x0609 && cp <= 0x060A -> True
    cp if cp == 0x066A -> True
    cp if cp >= 0x09F2 && cp <= 0x09F3 -> True
    cp if cp == 0x09FB -> True
    cp if cp == 0x0AF1 -> True
    cp if cp == 0x0BF9 -> True
    cp if cp == 0x0E3F -> True
    cp if cp == 0x17DB -> True
    cp if cp >= 0x2030 && cp <= 0x2034 -> True
    cp if cp >= 0x20A0 && cp <= 0x20C0 -> True
    cp if cp == 0x212E -> True
    cp if cp == 0x2213 -> True
    cp if cp == 0xA838 -> True
    cp if cp == 0xA839 -> True
    cp if cp == 0xFE5F -> True
    cp if cp == 0xFE69 -> True
    cp if cp == 0xFE6A -> True
    cp if cp == 0xFF03 -> True
    cp if cp == 0xFF04 -> True
    cp if cp == 0xFF05 -> True
    cp if cp >= 0xFFE0 && cp <= 0xFFE1 -> True
    cp if cp >= 0xFFE5 && cp <= 0xFFE6 -> True
    cp if cp >= 0x11FDD && cp <= 0x11FE0 -> True
    cp if cp == 0x1E2FF -> True
    cp if cp == 0x002C -> True
    cp if cp >= 0x002E && cp <= 0x002F -> True
    cp if cp == 0x003A -> True
    cp if cp == 0x00A0 -> True
    cp if cp == 0x060C -> True
    cp if cp == 0x202F -> True
    cp if cp == 0x2044 -> True
    cp if cp == 0xFE50 -> True
    cp if cp == 0xFE52 -> True
    cp if cp == 0xFE55 -> True
    cp if cp == 0xFF0C -> True
    cp if cp >= 0xFF0E && cp <= 0xFF0F -> True
    cp if cp == 0xFF1A -> True
    cp if cp >= 0x0021 && cp <= 0x0022 -> True
    cp if cp >= 0x0026 && cp <= 0x0027 -> True
    cp if cp == 0x0028 -> True
    cp if cp == 0x0029 -> True
    cp if cp == 0x002A -> True
    cp if cp == 0x003B -> True
    cp if cp >= 0x003C && cp <= 0x003E -> True
    cp if cp >= 0x003F && cp <= 0x0040 -> True
    cp if cp == 0x005B -> True
    cp if cp == 0x005C -> True
    cp if cp == 0x005D -> True
    cp if cp == 0x005E -> True
    cp if cp == 0x005F -> True
    cp if cp == 0x0060 -> True
    cp if cp == 0x007B -> True
    cp if cp == 0x007C -> True
    cp if cp == 0x007D -> True
    cp if cp == 0x007E -> True
    cp if cp == 0x00A1 -> True
    cp if cp == 0x00A6 -> True
    cp if cp == 0x00A7 -> True
    cp if cp == 0x00A8 -> True
    cp if cp == 0x00A9 -> True
    cp if cp == 0x00AB -> True
    cp if cp == 0x00AC -> True
    cp if cp == 0x00AE -> True
    cp if cp == 0x00AF -> True
    cp if cp == 0x00B4 -> True
    cp if cp >= 0x00B6 && cp <= 0x00B7 -> True
    cp if cp == 0x00B8 -> True
    cp if cp == 0x00BB -> True
    cp if cp >= 0x00BC && cp <= 0x00BE -> True
    cp if cp == 0x00BF -> True
    cp if cp == 0x00D7 -> True
    cp if cp == 0x00F7 -> True
    cp if cp >= 0x02B9 && cp <= 0x02BA -> True
    cp if cp >= 0x02C2 && cp <= 0x02C5 -> True
    cp if cp >= 0x02C6 && cp <= 0x02CF -> True
    cp if cp >= 0x02D2 && cp <= 0x02DF -> True
    cp if cp >= 0x02E5 && cp <= 0x02EB -> True
    cp if cp == 0x02EC -> True
    cp if cp == 0x02ED -> True
    cp if cp >= 0x02EF && cp <= 0x02FF -> True
    cp if cp == 0x0374 -> True
    cp if cp == 0x0375 -> True
    cp if cp == 0x037E -> True
    cp if cp >= 0x0384 && cp <= 0x0385 -> True
    cp if cp == 0x0387 -> True
    cp if cp == 0x03F6 -> True
    cp if cp == 0x058A -> True
    cp if cp >= 0x058D && cp <= 0x058E -> True
    cp if cp >= 0x0606 && cp <= 0x0607 -> True
    cp if cp >= 0x060E && cp <= 0x060F -> True
    cp if cp == 0x06DE -> True
    cp if cp == 0x06E9 -> True
    cp if cp == 0x07F6 -> True
    cp if cp >= 0x07F7 && cp <= 0x07F9 -> True
    cp if cp >= 0x0BF3 && cp <= 0x0BF8 -> True
    cp if cp == 0x0BFA -> True
    cp if cp >= 0x0C78 && cp <= 0x0C7E -> True
    cp if cp == 0x0F3A -> True
    cp if cp == 0x0F3B -> True
    cp if cp == 0x0F3C -> True
    cp if cp == 0x0F3D -> True
    cp if cp >= 0x1390 && cp <= 0x1399 -> True
    cp if cp == 0x1400 -> True
    cp if cp == 0x169B -> True
    cp if cp == 0x169C -> True
    cp if cp >= 0x17F0 && cp <= 0x17F9 -> True
    cp if cp >= 0x1800 && cp <= 0x1805 -> True
    cp if cp == 0x1806 -> True
    cp if cp >= 0x1807 && cp <= 0x180A -> True
    cp if cp == 0x1940 -> True
    cp if cp >= 0x1944 && cp <= 0x1945 -> True
    cp if cp >= 0x19DE && cp <= 0x19FF -> True
    cp if cp == 0x1FBD -> True
    cp if cp >= 0x1FBF && cp <= 0x1FC1 -> True
    cp if cp >= 0x1FCD && cp <= 0x1FCF -> True
    cp if cp >= 0x1FDD && cp <= 0x1FDF -> True
    cp if cp >= 0x1FED && cp <= 0x1FEF -> True
    cp if cp >= 0x1FFD && cp <= 0x1FFE -> True
    cp if cp >= 0x2010 && cp <= 0x2015 -> True
    cp if cp >= 0x2016 && cp <= 0x2017 -> True
    cp if cp == 0x2018 -> True
    cp if cp == 0x2019 -> True
    cp if cp == 0x201A -> True
    cp if cp >= 0x201B && cp <= 0x201C -> True
    cp if cp == 0x201D -> True
    cp if cp == 0x201E -> True
    cp if cp == 0x201F -> True
    cp if cp >= 0x2020 && cp <= 0x2027 -> True
    cp if cp >= 0x2035 && cp <= 0x2038 -> True
    cp if cp == 0x2039 -> True
    cp if cp == 0x203A -> True
    cp if cp >= 0x203B && cp <= 0x203E -> True
    cp if cp >= 0x203F && cp <= 0x2040 -> True
    cp if cp >= 0x2041 && cp <= 0x2043 -> True
    cp if cp == 0x2045 -> True
    cp if cp == 0x2046 -> True
    cp if cp >= 0x2047 && cp <= 0x2051 -> True
    cp if cp == 0x2052 -> True
    cp if cp == 0x2053 -> True
    cp if cp == 0x2054 -> True
    cp if cp >= 0x2055 && cp <= 0x205E -> True
    cp if cp == 0x207C -> True
    cp if cp == 0x207D -> True
    cp if cp == 0x207E -> True
    cp if cp == 0x208C -> True
    cp if cp == 0x208D -> True
    cp if cp == 0x208E -> True
    cp if cp >= 0x2100 && cp <= 0x2101 -> True
    cp if cp >= 0x2103 && cp <= 0x2106 -> True
    cp if cp >= 0x2108 && cp <= 0x2109 -> True
    cp if cp == 0x2114 -> True
    cp if cp >= 0x2116 && cp <= 0x2117 -> True
    cp if cp == 0x2118 -> True
    cp if cp >= 0x211E && cp <= 0x2123 -> True
    cp if cp == 0x2125 -> True
    cp if cp == 0x2127 -> True
    cp if cp == 0x2129 -> True
    cp if cp >= 0x213A && cp <= 0x213B -> True
    cp if cp >= 0x2140 && cp <= 0x2144 -> True
    cp if cp == 0x214A -> True
    cp if cp == 0x214B -> True
    cp if cp >= 0x214C && cp <= 0x214D -> True
    cp if cp >= 0x2150 && cp <= 0x215F -> True
    cp if cp == 0x2189 -> True
    cp if cp >= 0x218A && cp <= 0x218B -> True
    cp if cp >= 0x2190 && cp <= 0x2194 -> True
    cp if cp >= 0x2195 && cp <= 0x2199 -> True
    cp if cp >= 0x219A && cp <= 0x219B -> True
    cp if cp >= 0x219C && cp <= 0x219F -> True
    cp if cp == 0x21A0 -> True
    cp if cp >= 0x21A1 && cp <= 0x21A2 -> True
    cp if cp == 0x21A3 -> True
    cp if cp >= 0x21A4 && cp <= 0x21A5 -> True
    cp if cp == 0x21A6 -> True
    cp if cp >= 0x21A7 && cp <= 0x21AD -> True
    cp if cp == 0x21AE -> True
    cp if cp >= 0x21AF && cp <= 0x21CD -> True
    cp if cp >= 0x21CE && cp <= 0x21CF -> True
    cp if cp >= 0x21D0 && cp <= 0x21D1 -> True
    cp if cp == 0x21D2 -> True
    cp if cp == 0x21D3 -> True
    cp if cp == 0x21D4 -> True
    cp if cp >= 0x21D5 && cp <= 0x21F3 -> True
    cp if cp >= 0x21F4 && cp <= 0x2211 -> True
    cp if cp >= 0x2214 && cp <= 0x22FF -> True
    cp if cp >= 0x2300 && cp <= 0x2307 -> True
    cp if cp == 0x2308 -> True
    cp if cp == 0x2309 -> True
    cp if cp == 0x230A -> True
    cp if cp == 0x230B -> True
    cp if cp >= 0x230C && cp <= 0x231F -> True
    cp if cp >= 0x2320 && cp <= 0x2321 -> True
    cp if cp >= 0x2322 && cp <= 0x2328 -> True
    cp if cp == 0x2329 -> True
    cp if cp == 0x232A -> True
    cp if cp >= 0x232B && cp <= 0x2335 -> True
    cp if cp == 0x237B -> True
    cp if cp == 0x237C -> True
    cp if cp >= 0x237D && cp <= 0x2394 -> True
    cp if cp >= 0x2396 && cp <= 0x239A -> True
    cp if cp >= 0x239B && cp <= 0x23B3 -> True
    cp if cp >= 0x23B4 && cp <= 0x23DB -> True
    cp if cp >= 0x23DC && cp <= 0x23E1 -> True
    cp if cp >= 0x23E2 && cp <= 0x2429 -> True
    cp if cp >= 0x2440 && cp <= 0x244A -> True
    cp if cp >= 0x2460 && cp <= 0x2487 -> True
    cp if cp >= 0x24EA && cp <= 0x24FF -> True
    cp if cp >= 0x2500 && cp <= 0x25B6 -> True
    cp if cp == 0x25B7 -> True
    cp if cp >= 0x25B8 && cp <= 0x25C0 -> True
    cp if cp == 0x25C1 -> True
    cp if cp >= 0x25C2 && cp <= 0x25F7 -> True
    cp if cp >= 0x25F8 && cp <= 0x25FF -> True
    cp if cp >= 0x2600 && cp <= 0x266E -> True
    cp if cp == 0x266F -> True
    cp if cp >= 0x2670 && cp <= 0x26AB -> True
    cp if cp >= 0x26AD && cp <= 0x2767 -> True
    cp if cp == 0x2768 -> True
    cp if cp == 0x2769 -> True
    cp if cp == 0x276A -> True
    cp if cp == 0x276B -> True
    cp if cp == 0x276C -> True
    cp if cp == 0x276D -> True
    cp if cp == 0x276E -> True
    cp if cp == 0x276F -> True
    cp if cp == 0x2770 -> True
    cp if cp == 0x2771 -> True
    cp if cp == 0x2772 -> True
    cp if cp == 0x2773 -> True
    cp if cp == 0x2774 -> True
    cp if cp == 0x2775 -> True
    cp if cp >= 0x2776 && cp <= 0x2793 -> True
    cp if cp >= 0x2794 && cp <= 0x27BF -> True
    cp if cp >= 0x27C0 && cp <= 0x27C4 -> True
    cp if cp == 0x27C5 -> True
    cp if cp == 0x27C6 -> True
    cp if cp >= 0x27C7 && cp <= 0x27E5 -> True
    cp if cp == 0x27E6 -> True
    cp if cp == 0x27E7 -> True
    cp if cp == 0x27E8 -> True
    cp if cp == 0x27E9 -> True
    cp if cp == 0x27EA -> True
    cp if cp == 0x27EB -> True
    cp if cp == 0x27EC -> True
    cp if cp == 0x27ED -> True
    cp if cp == 0x27EE -> True
    cp if cp == 0x27EF -> True
    cp if cp >= 0x27F0 && cp <= 0x27FF -> True
    cp if cp >= 0x2900 && cp <= 0x2982 -> True
    cp if cp == 0x2983 -> True
    cp if cp == 0x2984 -> True
    cp if cp == 0x2985 -> True
    cp if cp == 0x2986 -> True
    cp if cp == 0x2987 -> True
    cp if cp == 0x2988 -> True
    cp if cp == 0x2989 -> True
    cp if cp == 0x298A -> True
    cp if cp == 0x298B -> True
    cp if cp == 0x298C -> True
    cp if cp == 0x298D -> True
    cp if cp == 0x298E -> True
    cp if cp == 0x298F -> True
    cp if cp == 0x2990 -> True
    cp if cp == 0x2991 -> True
    cp if cp == 0x2992 -> True
    cp if cp == 0x2993 -> True
    cp if cp == 0x2994 -> True
    cp if cp == 0x2995 -> True
    cp if cp == 0x2996 -> True
    cp if cp == 0x2997 -> True
    cp if cp == 0x2998 -> True
    cp if cp >= 0x2999 && cp <= 0x29D7 -> True
    cp if cp == 0x29D8 -> True
    cp if cp == 0x29D9 -> True
    cp if cp == 0x29DA -> True
    cp if cp == 0x29DB -> True
    cp if cp >= 0x29DC && cp <= 0x29FB -> True
    cp if cp == 0x29FC -> True
    cp if cp == 0x29FD -> True
    cp if cp >= 0x29FE && cp <= 0x2AFF -> True
    cp if cp >= 0x2B00 && cp <= 0x2B2F -> True
    cp if cp >= 0x2B30 && cp <= 0x2B44 -> True
    cp if cp >= 0x2B45 && cp <= 0x2B46 -> True
    cp if cp >= 0x2B47 && cp <= 0x2B4C -> True
    cp if cp >= 0x2B4D && cp <= 0x2B73 -> True
    cp if cp >= 0x2B76 && cp <= 0x2B95 -> True
    cp if cp >= 0x2B97 && cp <= 0x2BFF -> True
    cp if cp >= 0x2CE5 && cp <= 0x2CEA -> True
    cp if cp >= 0x2CF9 && cp <= 0x2CFC -> True
    cp if cp == 0x2CFD -> True
    cp if cp >= 0x2CFE && cp <= 0x2CFF -> True
    cp if cp >= 0x2E00 && cp <= 0x2E01 -> True
    cp if cp == 0x2E02 -> True
    cp if cp == 0x2E03 -> True
    cp if cp == 0x2E04 -> True
    cp if cp == 0x2E05 -> True
    cp if cp >= 0x2E06 && cp <= 0x2E08 -> True
    cp if cp == 0x2E09 -> True
    cp if cp == 0x2E0A -> True
    cp if cp == 0x2E0B -> True
    cp if cp == 0x2E0C -> True
    cp if cp == 0x2E0D -> True
    cp if cp >= 0x2E0E && cp <= 0x2E16 -> True
    cp if cp == 0x2E17 -> True
    cp if cp >= 0x2E18 && cp <= 0x2E19 -> True
    cp if cp == 0x2E1A -> True
    cp if cp == 0x2E1B -> True
    cp if cp == 0x2E1C -> True
    cp if cp == 0x2E1D -> True
    cp if cp >= 0x2E1E && cp <= 0x2E1F -> True
    cp if cp == 0x2E20 -> True
    cp if cp == 0x2E21 -> True
    cp if cp == 0x2E22 -> True
    cp if cp == 0x2E23 -> True
    cp if cp == 0x2E24 -> True
    cp if cp == 0x2E25 -> True
    cp if cp == 0x2E26 -> True
    cp if cp == 0x2E27 -> True
    cp if cp == 0x2E28 -> True
    cp if cp == 0x2E29 -> True
    cp if cp >= 0x2E2A && cp <= 0x2E2E -> True
    cp if cp == 0x2E2F -> True
    cp if cp >= 0x2E30 && cp <= 0x2E39 -> True
    cp if cp >= 0x2E3A && cp <= 0x2E3B -> True
    cp if cp >= 0x2E3C && cp <= 0x2E3F -> True
    cp if cp == 0x2E40 -> True
    cp if cp == 0x2E41 -> True
    cp if cp == 0x2E42 -> True
    cp if cp >= 0x2E43 && cp <= 0x2E4F -> True
    cp if cp >= 0x2E50 && cp <= 0x2E51 -> True
    cp if cp >= 0x2E52 && cp <= 0x2E54 -> True
    cp if cp == 0x2E55 -> True
    cp if cp == 0x2E56 -> True
    cp if cp == 0x2E57 -> True
    cp if cp == 0x2E58 -> True
    cp if cp == 0x2E59 -> True
    cp if cp == 0x2E5A -> True
    cp if cp == 0x2E5B -> True
    cp if cp == 0x2E5C -> True
    cp if cp == 0x2E5D -> True
    cp if cp >= 0x2E80 && cp <= 0x2E99 -> True
    cp if cp >= 0x2E9B && cp <= 0x2EF3 -> True
    cp if cp >= 0x2F00 && cp <= 0x2FD5 -> True
    cp if cp >= 0x2FF0 && cp <= 0x2FFF -> True
    cp if cp >= 0x3001 && cp <= 0x3003 -> True
    cp if cp == 0x3004 -> True
    cp if cp == 0x3008 -> True
    cp if cp == 0x3009 -> True
    cp if cp == 0x300A -> True
    cp if cp == 0x300B -> True
    cp if cp == 0x300C -> True
    cp if cp == 0x300D -> True
    cp if cp == 0x300E -> True
    cp if cp == 0x300F -> True
    cp if cp == 0x3010 -> True
    cp if cp == 0x3011 -> True
    cp if cp >= 0x3012 && cp <= 0x3013 -> True
    cp if cp == 0x3014 -> True
    cp if cp == 0x3015 -> True
    cp if cp == 0x3016 -> True
    cp if cp == 0x3017 -> True
    cp if cp == 0x3018 -> True
    cp if cp == 0x3019 -> True
    cp if cp == 0x301A -> True
    cp if cp == 0x301B -> True
    cp if cp == 0x301C -> True
    cp if cp == 0x301D -> True
    cp if cp >= 0x301E && cp <= 0x301F -> True
    cp if cp == 0x3020 -> True
    cp if cp == 0x3030 -> True
    cp if cp >= 0x3036 && cp <= 0x3037 -> True
    cp if cp == 0x303D -> True
    cp if cp >= 0x303E && cp <= 0x303F -> True
    cp if cp >= 0x309B && cp <= 0x309C -> True
    cp if cp == 0x30A0 -> True
    cp if cp == 0x30FB -> True
    cp if cp >= 0x31C0 && cp <= 0x31E5 -> True
    cp if cp == 0x31EF -> True
    cp if cp >= 0x321D && cp <= 0x321E -> True
    cp if cp == 0x3250 -> True
    cp if cp >= 0x3251 && cp <= 0x325F -> True
    cp if cp >= 0x327C && cp <= 0x327E -> True
    cp if cp >= 0x32B1 && cp <= 0x32BF -> True
    cp if cp >= 0x32CC && cp <= 0x32CF -> True
    cp if cp >= 0x3377 && cp <= 0x337A -> True
    cp if cp >= 0x33DE && cp <= 0x33DF -> True
    cp if cp == 0x33FF -> True
    cp if cp >= 0x4DC0 && cp <= 0x4DFF -> True
    cp if cp >= 0xA490 && cp <= 0xA4C6 -> True
    cp if cp >= 0xA60D && cp <= 0xA60F -> True
    cp if cp == 0xA673 -> True
    cp if cp == 0xA67E -> True
    cp if cp == 0xA67F -> True
    cp if cp >= 0xA700 && cp <= 0xA716 -> True
    cp if cp >= 0xA717 && cp <= 0xA71F -> True
    cp if cp >= 0xA720 && cp <= 0xA721 -> True
    cp if cp == 0xA788 -> True
    cp if cp >= 0xA828 && cp <= 0xA82B -> True
    cp if cp >= 0xA874 && cp <= 0xA877 -> True
    cp if cp >= 0xAB6A && cp <= 0xAB6B -> True
    cp if cp == 0xFD3E -> True
    cp if cp == 0xFD3F -> True
    cp if cp >= 0xFD40 && cp <= 0xFD4F -> True
    cp if cp == 0xFDCF -> True
    cp if cp >= 0xFDFD && cp <= 0xFDFF -> True
    cp if cp >= 0xFE10 && cp <= 0xFE16 -> True
    cp if cp == 0xFE17 -> True
    cp if cp == 0xFE18 -> True
    cp if cp == 0xFE19 -> True
    cp if cp == 0xFE30 -> True
    cp if cp >= 0xFE31 && cp <= 0xFE32 -> True
    cp if cp >= 0xFE33 && cp <= 0xFE34 -> True
    cp if cp == 0xFE35 -> True
    cp if cp == 0xFE36 -> True
    cp if cp == 0xFE37 -> True
    cp if cp == 0xFE38 -> True
    cp if cp == 0xFE39 -> True
    cp if cp == 0xFE3A -> True
    cp if cp == 0xFE3B -> True
    cp if cp == 0xFE3C -> True
    cp if cp == 0xFE3D -> True
    cp if cp == 0xFE3E -> True
    cp if cp == 0xFE3F -> True
    cp if cp == 0xFE40 -> True
    cp if cp == 0xFE41 -> True
    cp if cp == 0xFE42 -> True
    cp if cp == 0xFE43 -> True
    cp if cp == 0xFE44 -> True
    cp if cp >= 0xFE45 && cp <= 0xFE46 -> True
    cp if cp == 0xFE47 -> True
    cp if cp == 0xFE48 -> True
    cp if cp >= 0xFE49 && cp <= 0xFE4C -> True
    cp if cp >= 0xFE4D && cp <= 0xFE4F -> True
    cp if cp == 0xFE51 -> True
    cp if cp == 0xFE54 -> True
    cp if cp >= 0xFE56 && cp <= 0xFE57 -> True
    cp if cp == 0xFE58 -> True
    cp if cp == 0xFE59 -> True
    cp if cp == 0xFE5A -> True
    cp if cp == 0xFE5B -> True
    cp if cp == 0xFE5C -> True
    cp if cp == 0xFE5D -> True
    cp if cp == 0xFE5E -> True
    cp if cp >= 0xFE60 && cp <= 0xFE61 -> True
    cp if cp >= 0xFE64 && cp <= 0xFE66 -> True
    cp if cp == 0xFE68 -> True
    cp if cp == 0xFE6B -> True
    cp if cp >= 0xFF01 && cp <= 0xFF02 -> True
    cp if cp >= 0xFF06 && cp <= 0xFF07 -> True
    cp if cp == 0xFF08 -> True
    cp if cp == 0xFF09 -> True
    cp if cp == 0xFF0A -> True
    cp if cp == 0xFF1B -> True
    cp if cp >= 0xFF1C && cp <= 0xFF1E -> True
    cp if cp >= 0xFF1F && cp <= 0xFF20 -> True
    cp if cp == 0xFF3B -> True
    cp if cp == 0xFF3C -> True
    cp if cp == 0xFF3D -> True
    cp if cp == 0xFF3E -> True
    cp if cp == 0xFF3F -> True
    cp if cp == 0xFF40 -> True
    cp if cp == 0xFF5B -> True
    cp if cp == 0xFF5C -> True
    cp if cp == 0xFF5D -> True
    cp if cp == 0xFF5E -> True
    cp if cp == 0xFF5F -> True
    cp if cp == 0xFF60 -> True
    cp if cp == 0xFF61 -> True
    cp if cp == 0xFF62 -> True
    cp if cp == 0xFF63 -> True
    cp if cp >= 0xFF64 && cp <= 0xFF65 -> True
    cp if cp == 0xFFE2 -> True
    cp if cp == 0xFFE3 -> True
    cp if cp == 0xFFE4 -> True
    cp if cp == 0xFFE8 -> True
    cp if cp >= 0xFFE9 && cp <= 0xFFEC -> True
    cp if cp >= 0xFFED && cp <= 0xFFEE -> True
    cp if cp >= 0xFFF9 && cp <= 0xFFFB -> True
    cp if cp >= 0xFFFC && cp <= 0xFFFD -> True
    cp if cp == 0x10101 -> True
    cp if cp >= 0x10140 && cp <= 0x10174 -> True
    cp if cp >= 0x10175 && cp <= 0x10178 -> True
    cp if cp >= 0x10179 && cp <= 0x10189 -> True
    cp if cp >= 0x1018A && cp <= 0x1018B -> True
    cp if cp == 0x1018C -> True
    cp if cp >= 0x10190 && cp <= 0x1019C -> True
    cp if cp == 0x101A0 -> True
    cp if cp == 0x1091F -> True
    cp if cp >= 0x10B39 && cp <= 0x10B3F -> True
    cp if cp == 0x10D6E -> True
    cp if cp >= 0x11052 && cp <= 0x11065 -> True
    cp if cp >= 0x11660 && cp <= 0x1166C -> True
    cp if cp >= 0x11FD5 && cp <= 0x11FDC -> True
    cp if cp >= 0x11FE1 && cp <= 0x11FF1 -> True
    cp if cp == 0x16FE2 -> True
    cp if cp >= 0x1CC00 && cp <= 0x1CCD5 -> True
    cp if cp >= 0x1CD00 && cp <= 0x1CEB3 -> True
    cp if cp >= 0x1D1E9 && cp <= 0x1D1EA -> True
    cp if cp >= 0x1D200 && cp <= 0x1D241 -> True
    cp if cp == 0x1D245 -> True
    cp if cp >= 0x1D300 && cp <= 0x1D356 -> True
    cp if cp == 0x1D6C1 -> True
    cp if cp == 0x1D6DB -> True
    cp if cp == 0x1D6FB -> True
    cp if cp == 0x1D715 -> True
    cp if cp == 0x1D735 -> True
    cp if cp == 0x1D74F -> True
    cp if cp == 0x1D76F -> True
    cp if cp == 0x1D789 -> True
    cp if cp == 0x1D7A9 -> True
    cp if cp == 0x1D7C3 -> True
    cp if cp >= 0x1EEF0 && cp <= 0x1EEF1 -> True
    cp if cp >= 0x1F000 && cp <= 0x1F02B -> True
    cp if cp >= 0x1F030 && cp <= 0x1F093 -> True
    cp if cp >= 0x1F0A0 && cp <= 0x1F0AE -> True
    cp if cp >= 0x1F0B1 && cp <= 0x1F0BF -> True
    cp if cp >= 0x1F0C1 && cp <= 0x1F0CF -> True
    cp if cp >= 0x1F0D1 && cp <= 0x1F0F5 -> True
    cp if cp >= 0x1F10B && cp <= 0x1F10C -> True
    cp if cp >= 0x1F10D && cp <= 0x1F10F -> True
    cp if cp == 0x1F12F -> True
    cp if cp >= 0x1F16A && cp <= 0x1F16F -> True
    cp if cp == 0x1F1AD -> True
    cp if cp >= 0x1F260 && cp <= 0x1F265 -> True
    cp if cp >= 0x1F300 && cp <= 0x1F3FA -> True
    cp if cp >= 0x1F3FB && cp <= 0x1F3FF -> True
    cp if cp >= 0x1F400 && cp <= 0x1F6D7 -> True
    cp if cp >= 0x1F6DC && cp <= 0x1F6EC -> True
    cp if cp >= 0x1F6F0 && cp <= 0x1F6FC -> True
    cp if cp >= 0x1F700 && cp <= 0x1F776 -> True
    cp if cp >= 0x1F77B && cp <= 0x1F7D9 -> True
    cp if cp >= 0x1F7E0 && cp <= 0x1F7EB -> True
    cp if cp == 0x1F7F0 -> True
    cp if cp >= 0x1F800 && cp <= 0x1F80B -> True
    cp if cp >= 0x1F810 && cp <= 0x1F847 -> True
    cp if cp >= 0x1F850 && cp <= 0x1F859 -> True
    cp if cp >= 0x1F860 && cp <= 0x1F887 -> True
    cp if cp >= 0x1F890 && cp <= 0x1F8AD -> True
    cp if cp >= 0x1F8B0 && cp <= 0x1F8BB -> True
    cp if cp >= 0x1F8C0 && cp <= 0x1F8C1 -> True
    cp if cp >= 0x1F900 && cp <= 0x1FA53 -> True
    cp if cp >= 0x1FA60 && cp <= 0x1FA6D -> True
    cp if cp >= 0x1FA70 && cp <= 0x1FA7C -> True
    cp if cp >= 0x1FA80 && cp <= 0x1FA89 -> True
    cp if cp >= 0x1FA8F && cp <= 0x1FAC6 -> True
    cp if cp >= 0x1FACE && cp <= 0x1FADC -> True
    cp if cp >= 0x1FADF && cp <= 0x1FAE9 -> True
    cp if cp >= 0x1FAF0 && cp <= 0x1FAF8 -> True
    cp if cp >= 0x1FB00 && cp <= 0x1FB92 -> True
    cp if cp >= 0x1FB94 && cp <= 0x1FBEF -> True
    cp if cp >= 0x0000 && cp <= 0x0008 -> True
    cp if cp >= 0x000E && cp <= 0x001B -> True
    cp if cp >= 0x007F && cp <= 0x0084 -> True
    cp if cp >= 0x0086 && cp <= 0x009F -> True
    cp if cp == 0x00AD -> True
    cp if cp == 0x180E -> True
    cp if cp >= 0x200B && cp <= 0x200D -> True
    cp if cp >= 0x2060 && cp <= 0x2064 -> True
    cp if cp == 0x2065 -> True
    cp if cp >= 0x206A && cp <= 0x206F -> True
    cp if cp >= 0xFDD0 && cp <= 0xFDEF -> True
    cp if cp == 0xFEFF -> True
    cp if cp >= 0xFFF0 && cp <= 0xFFF8 -> True
    cp if cp >= 0xFFFE && cp <= 0xFFFF -> True
    cp if cp >= 0x1BCA0 && cp <= 0x1BCA3 -> True
    cp if cp >= 0x1D173 && cp <= 0x1D17A -> True
    cp if cp >= 0x1FFFE && cp <= 0x1FFFF -> True
    cp if cp >= 0x2FFFE && cp <= 0x2FFFF -> True
    cp if cp >= 0x3FFFE && cp <= 0x3FFFF -> True
    cp if cp >= 0x4FFFE && cp <= 0x4FFFF -> True
    cp if cp >= 0x5FFFE && cp <= 0x5FFFF -> True
    cp if cp >= 0x6FFFE && cp <= 0x6FFFF -> True
    cp if cp >= 0x7FFFE && cp <= 0x7FFFF -> True
    cp if cp >= 0x8FFFE && cp <= 0x8FFFF -> True
    cp if cp >= 0x9FFFE && cp <= 0x9FFFF -> True
    cp if cp >= 0xAFFFE && cp <= 0xAFFFF -> True
    cp if cp >= 0xBFFFE && cp <= 0xBFFFF -> True
    cp if cp >= 0xCFFFE && cp <= 0xCFFFF -> True
    cp if cp >= 0xDFFFE && cp <= 0xE0000 -> True
    cp if cp == 0xE0001 -> True
    cp if cp >= 0xE0002 && cp <= 0xE001F -> True
    cp if cp >= 0xE0020 && cp <= 0xE007F -> True
    cp if cp >= 0xE0080 && cp <= 0xE00FF -> True
    cp if cp >= 0xE01F0 && cp <= 0xE0FFF -> True
    cp if cp >= 0xEFFFE && cp <= 0xEFFFF -> True
    cp if cp >= 0xFFFFE && cp <= 0xFFFFF -> True
    cp if cp >= 0x0300 && cp <= 0x036F -> True
    cp if cp >= 0x0483 && cp <= 0x0487 -> True
    cp if cp >= 0x0488 && cp <= 0x0489 -> True
    cp if cp >= 0x0591 && cp <= 0x05BD -> True
    cp if cp == 0x05BF -> True
    cp if cp >= 0x05C1 && cp <= 0x05C2 -> True
    cp if cp >= 0x05C4 && cp <= 0x05C5 -> True
    cp if cp == 0x05C7 -> True
    cp if cp >= 0x0610 && cp <= 0x061A -> True
    cp if cp >= 0x064B && cp <= 0x065F -> True
    cp if cp == 0x0670 -> True
    cp if cp >= 0x06D6 && cp <= 0x06DC -> True
    cp if cp >= 0x06DF && cp <= 0x06E4 -> True
    cp if cp >= 0x06E7 && cp <= 0x06E8 -> True
    cp if cp >= 0x06EA && cp <= 0x06ED -> True
    cp if cp == 0x0711 -> True
    cp if cp >= 0x0730 && cp <= 0x074A -> True
    cp if cp >= 0x07A6 && cp <= 0x07B0 -> True
    cp if cp >= 0x07EB && cp <= 0x07F3 -> True
    cp if cp == 0x07FD -> True
    cp if cp >= 0x0816 && cp <= 0x0819 -> True
    cp if cp >= 0x081B && cp <= 0x0823 -> True
    cp if cp >= 0x0825 && cp <= 0x0827 -> True
    cp if cp >= 0x0829 && cp <= 0x082D -> True
    cp if cp >= 0x0859 && cp <= 0x085B -> True
    cp if cp >= 0x0897 && cp <= 0x089F -> True
    cp if cp >= 0x08CA && cp <= 0x08E1 -> True
    cp if cp >= 0x08E3 && cp <= 0x0902 -> True
    cp if cp == 0x093A -> True
    cp if cp == 0x093C -> True
    cp if cp >= 0x0941 && cp <= 0x0948 -> True
    cp if cp == 0x094D -> True
    cp if cp >= 0x0951 && cp <= 0x0957 -> True
    cp if cp >= 0x0962 && cp <= 0x0963 -> True
    cp if cp == 0x0981 -> True
    cp if cp == 0x09BC -> True
    cp if cp >= 0x09C1 && cp <= 0x09C4 -> True
    cp if cp == 0x09CD -> True
    cp if cp >= 0x09E2 && cp <= 0x09E3 -> True
    cp if cp == 0x09FE -> True
    cp if cp >= 0x0A01 && cp <= 0x0A02 -> True
    cp if cp == 0x0A3C -> True
    cp if cp >= 0x0A41 && cp <= 0x0A42 -> True
    cp if cp >= 0x0A47 && cp <= 0x0A48 -> True
    cp if cp >= 0x0A4B && cp <= 0x0A4D -> True
    cp if cp == 0x0A51 -> True
    cp if cp >= 0x0A70 && cp <= 0x0A71 -> True
    cp if cp == 0x0A75 -> True
    cp if cp >= 0x0A81 && cp <= 0x0A82 -> True
    cp if cp == 0x0ABC -> True
    cp if cp >= 0x0AC1 && cp <= 0x0AC5 -> True
    cp if cp >= 0x0AC7 && cp <= 0x0AC8 -> True
    cp if cp == 0x0ACD -> True
    cp if cp >= 0x0AE2 && cp <= 0x0AE3 -> True
    cp if cp >= 0x0AFA && cp <= 0x0AFF -> True
    cp if cp == 0x0B01 -> True
    cp if cp == 0x0B3C -> True
    cp if cp == 0x0B3F -> True
    cp if cp >= 0x0B41 && cp <= 0x0B44 -> True
    cp if cp == 0x0B4D -> True
    cp if cp >= 0x0B55 && cp <= 0x0B56 -> True
    cp if cp >= 0x0B62 && cp <= 0x0B63 -> True
    cp if cp == 0x0B82 -> True
    cp if cp == 0x0BC0 -> True
    cp if cp == 0x0BCD -> True
    cp if cp == 0x0C00 -> True
    cp if cp == 0x0C04 -> True
    cp if cp == 0x0C3C -> True
    cp if cp >= 0x0C3E && cp <= 0x0C40 -> True
    cp if cp >= 0x0C46 && cp <= 0x0C48 -> True
    cp if cp >= 0x0C4A && cp <= 0x0C4D -> True
    cp if cp >= 0x0C55 && cp <= 0x0C56 -> True
    cp if cp >= 0x0C62 && cp <= 0x0C63 -> True
    cp if cp == 0x0C81 -> True
    cp if cp == 0x0CBC -> True
    cp if cp >= 0x0CCC && cp <= 0x0CCD -> True
    cp if cp >= 0x0CE2 && cp <= 0x0CE3 -> True
    cp if cp >= 0x0D00 && cp <= 0x0D01 -> True
    cp if cp >= 0x0D3B && cp <= 0x0D3C -> True
    cp if cp >= 0x0D41 && cp <= 0x0D44 -> True
    cp if cp == 0x0D4D -> True
    cp if cp >= 0x0D62 && cp <= 0x0D63 -> True
    cp if cp == 0x0D81 -> True
    cp if cp == 0x0DCA -> True
    cp if cp >= 0x0DD2 && cp <= 0x0DD4 -> True
    cp if cp == 0x0DD6 -> True
    cp if cp == 0x0E31 -> True
    cp if cp >= 0x0E34 && cp <= 0x0E3A -> True
    cp if cp >= 0x0E47 && cp <= 0x0E4E -> True
    cp if cp == 0x0EB1 -> True
    cp if cp >= 0x0EB4 && cp <= 0x0EBC -> True
    cp if cp >= 0x0EC8 && cp <= 0x0ECE -> True
    cp if cp >= 0x0F18 && cp <= 0x0F19 -> True
    cp if cp == 0x0F35 -> True
    cp if cp == 0x0F37 -> True
    cp if cp == 0x0F39 -> True
    cp if cp >= 0x0F71 && cp <= 0x0F7E -> True
    cp if cp >= 0x0F80 && cp <= 0x0F84 -> True
    cp if cp >= 0x0F86 && cp <= 0x0F87 -> True
    cp if cp >= 0x0F8D && cp <= 0x0F97 -> True
    cp if cp >= 0x0F99 && cp <= 0x0FBC -> True
    cp if cp == 0x0FC6 -> True
    cp if cp >= 0x102D && cp <= 0x1030 -> True
    cp if cp >= 0x1032 && cp <= 0x1037 -> True
    cp if cp >= 0x1039 && cp <= 0x103A -> True
    cp if cp >= 0x103D && cp <= 0x103E -> True
    cp if cp >= 0x1058 && cp <= 0x1059 -> True
    cp if cp >= 0x105E && cp <= 0x1060 -> True
    cp if cp >= 0x1071 && cp <= 0x1074 -> True
    cp if cp == 0x1082 -> True
    cp if cp >= 0x1085 && cp <= 0x1086 -> True
    cp if cp == 0x108D -> True
    cp if cp == 0x109D -> True
    cp if cp >= 0x135D && cp <= 0x135F -> True
    cp if cp >= 0x1712 && cp <= 0x1714 -> True
    cp if cp >= 0x1732 && cp <= 0x1733 -> True
    cp if cp >= 0x1752 && cp <= 0x1753 -> True
    cp if cp >= 0x1772 && cp <= 0x1773 -> True
    cp if cp >= 0x17B4 && cp <= 0x17B5 -> True
    cp if cp >= 0x17B7 && cp <= 0x17BD -> True
    cp if cp == 0x17C6 -> True
    cp if cp >= 0x17C9 && cp <= 0x17D3 -> True
    cp if cp == 0x17DD -> True
    cp if cp >= 0x180B && cp <= 0x180D -> True
    cp if cp == 0x180F -> True
    cp if cp >= 0x1885 && cp <= 0x1886 -> True
    cp if cp == 0x18A9 -> True
    cp if cp >= 0x1920 && cp <= 0x1922 -> True
    cp if cp >= 0x1927 && cp <= 0x1928 -> True
    cp if cp == 0x1932 -> True
    cp if cp >= 0x1939 && cp <= 0x193B -> True
    cp if cp >= 0x1A17 && cp <= 0x1A18 -> True
    cp if cp == 0x1A1B -> True
    cp if cp == 0x1A56 -> True
    cp if cp >= 0x1A58 && cp <= 0x1A5E -> True
    cp if cp == 0x1A60 -> True
    cp if cp == 0x1A62 -> True
    cp if cp >= 0x1A65 && cp <= 0x1A6C -> True
    cp if cp >= 0x1A73 && cp <= 0x1A7C -> True
    cp if cp == 0x1A7F -> True
    cp if cp >= 0x1AB0 && cp <= 0x1ABD -> True
    cp if cp == 0x1ABE -> True
    cp if cp >= 0x1ABF && cp <= 0x1ACE -> True
    cp if cp >= 0x1B00 && cp <= 0x1B03 -> True
    cp if cp == 0x1B34 -> True
    cp if cp >= 0x1B36 && cp <= 0x1B3A -> True
    cp if cp == 0x1B3C -> True
    cp if cp == 0x1B42 -> True
    cp if cp >= 0x1B6B && cp <= 0x1B73 -> True
    cp if cp >= 0x1B80 && cp <= 0x1B81 -> True
    cp if cp >= 0x1BA2 && cp <= 0x1BA5 -> True
    cp if cp >= 0x1BA8 && cp <= 0x1BA9 -> True
    cp if cp >= 0x1BAB && cp <= 0x1BAD -> True
    cp if cp == 0x1BE6 -> True
    cp if cp >= 0x1BE8 && cp <= 0x1BE9 -> True
    cp if cp == 0x1BED -> True
    cp if cp >= 0x1BEF && cp <= 0x1BF1 -> True
    cp if cp >= 0x1C2C && cp <= 0x1C33 -> True
    cp if cp >= 0x1C36 && cp <= 0x1C37 -> True
    cp if cp >= 0x1CD0 && cp <= 0x1CD2 -> True
    cp if cp >= 0x1CD4 && cp <= 0x1CE0 -> True
    cp if cp >= 0x1CE2 && cp <= 0x1CE8 -> True
    cp if cp == 0x1CED -> True
    cp if cp == 0x1CF4 -> True
    cp if cp >= 0x1CF8 && cp <= 0x1CF9 -> True
    cp if cp >= 0x1DC0 && cp <= 0x1DFF -> True
    cp if cp >= 0x20D0 && cp <= 0x20DC -> True
    cp if cp >= 0x20DD && cp <= 0x20E0 -> True
    cp if cp == 0x20E1 -> True
    cp if cp >= 0x20E2 && cp <= 0x20E4 -> True
    cp if cp >= 0x20E5 && cp <= 0x20F0 -> True
    cp if cp >= 0x2CEF && cp <= 0x2CF1 -> True
    cp if cp == 0x2D7F -> True
    cp if cp >= 0x2DE0 && cp <= 0x2DFF -> True
    cp if cp >= 0x302A && cp <= 0x302D -> True
    cp if cp >= 0x3099 && cp <= 0x309A -> True
    cp if cp == 0xA66F -> True
    cp if cp >= 0xA670 && cp <= 0xA672 -> True
    cp if cp >= 0xA674 && cp <= 0xA67D -> True
    cp if cp >= 0xA69E && cp <= 0xA69F -> True
    cp if cp >= 0xA6F0 && cp <= 0xA6F1 -> True
    cp if cp == 0xA802 -> True
    cp if cp == 0xA806 -> True
    cp if cp == 0xA80B -> True
    cp if cp >= 0xA825 && cp <= 0xA826 -> True
    cp if cp == 0xA82C -> True
    cp if cp >= 0xA8C4 && cp <= 0xA8C5 -> True
    cp if cp >= 0xA8E0 && cp <= 0xA8F1 -> True
    cp if cp == 0xA8FF -> True
    cp if cp >= 0xA926 && cp <= 0xA92D -> True
    cp if cp >= 0xA947 && cp <= 0xA951 -> True
    cp if cp >= 0xA980 && cp <= 0xA982 -> True
    cp if cp == 0xA9B3 -> True
    cp if cp >= 0xA9B6 && cp <= 0xA9B9 -> True
    cp if cp >= 0xA9BC && cp <= 0xA9BD -> True
    cp if cp == 0xA9E5 -> True
    cp if cp >= 0xAA29 && cp <= 0xAA2E -> True
    cp if cp >= 0xAA31 && cp <= 0xAA32 -> True
    cp if cp >= 0xAA35 && cp <= 0xAA36 -> True
    cp if cp == 0xAA43 -> True
    cp if cp == 0xAA4C -> True
    cp if cp == 0xAA7C -> True
    cp if cp == 0xAAB0 -> True
    cp if cp >= 0xAAB2 && cp <= 0xAAB4 -> True
    cp if cp >= 0xAAB7 && cp <= 0xAAB8 -> True
    cp if cp >= 0xAABE && cp <= 0xAABF -> True
    cp if cp == 0xAAC1 -> True
    cp if cp >= 0xAAEC && cp <= 0xAAED -> True
    cp if cp == 0xAAF6 -> True
    cp if cp == 0xABE5 -> True
    cp if cp == 0xABE8 -> True
    cp if cp == 0xABED -> True
    cp if cp == 0xFB1E -> True
    cp if cp >= 0xFE00 && cp <= 0xFE0F -> True
    cp if cp >= 0xFE20 && cp <= 0xFE2F -> True
    cp if cp == 0x101FD -> True
    cp if cp == 0x102E0 -> True
    cp if cp >= 0x10376 && cp <= 0x1037A -> True
    cp if cp >= 0x10A01 && cp <= 0x10A03 -> True
    cp if cp >= 0x10A05 && cp <= 0x10A06 -> True
    cp if cp >= 0x10A0C && cp <= 0x10A0F -> True
    cp if cp >= 0x10A38 && cp <= 0x10A3A -> True
    cp if cp == 0x10A3F -> True
    cp if cp >= 0x10AE5 && cp <= 0x10AE6 -> True
    cp if cp >= 0x10D24 && cp <= 0x10D27 -> True
    cp if cp >= 0x10D69 && cp <= 0x10D6D -> True
    cp if cp >= 0x10EAB && cp <= 0x10EAC -> True
    cp if cp >= 0x10EFC && cp <= 0x10EFF -> True
    cp if cp >= 0x10F46 && cp <= 0x10F50 -> True
    cp if cp >= 0x10F82 && cp <= 0x10F85 -> True
    cp if cp == 0x11001 -> True
    cp if cp >= 0x11038 && cp <= 0x11046 -> True
    cp if cp == 0x11070 -> True
    cp if cp >= 0x11073 && cp <= 0x11074 -> True
    cp if cp >= 0x1107F && cp <= 0x11081 -> True
    cp if cp >= 0x110B3 && cp <= 0x110B6 -> True
    cp if cp >= 0x110B9 && cp <= 0x110BA -> True
    cp if cp == 0x110C2 -> True
    cp if cp >= 0x11100 && cp <= 0x11102 -> True
    cp if cp >= 0x11127 && cp <= 0x1112B -> True
    cp if cp >= 0x1112D && cp <= 0x11134 -> True
    cp if cp == 0x11173 -> True
    cp if cp >= 0x11180 && cp <= 0x11181 -> True
    cp if cp >= 0x111B6 && cp <= 0x111BE -> True
    cp if cp >= 0x111C9 && cp <= 0x111CC -> True
    cp if cp == 0x111CF -> True
    cp if cp >= 0x1122F && cp <= 0x11231 -> True
    cp if cp == 0x11234 -> True
    cp if cp >= 0x11236 && cp <= 0x11237 -> True
    cp if cp == 0x1123E -> True
    cp if cp == 0x11241 -> True
    cp if cp == 0x112DF -> True
    cp if cp >= 0x112E3 && cp <= 0x112EA -> True
    cp if cp >= 0x11300 && cp <= 0x11301 -> True
    cp if cp >= 0x1133B && cp <= 0x1133C -> True
    cp if cp == 0x11340 -> True
    cp if cp >= 0x11366 && cp <= 0x1136C -> True
    cp if cp >= 0x11370 && cp <= 0x11374 -> True
    cp if cp >= 0x113BB && cp <= 0x113C0 -> True
    cp if cp == 0x113CE -> True
    cp if cp == 0x113D0 -> True
    cp if cp == 0x113D2 -> True
    cp if cp >= 0x113E1 && cp <= 0x113E2 -> True
    cp if cp >= 0x11438 && cp <= 0x1143F -> True
    cp if cp >= 0x11442 && cp <= 0x11444 -> True
    cp if cp == 0x11446 -> True
    cp if cp == 0x1145E -> True
    cp if cp >= 0x114B3 && cp <= 0x114B8 -> True
    cp if cp == 0x114BA -> True
    cp if cp >= 0x114BF && cp <= 0x114C0 -> True
    cp if cp >= 0x114C2 && cp <= 0x114C3 -> True
    cp if cp >= 0x115B2 && cp <= 0x115B5 -> True
    cp if cp >= 0x115BC && cp <= 0x115BD -> True
    cp if cp >= 0x115BF && cp <= 0x115C0 -> True
    cp if cp >= 0x115DC && cp <= 0x115DD -> True
    cp if cp >= 0x11633 && cp <= 0x1163A -> True
    cp if cp == 0x1163D -> True
    cp if cp >= 0x1163F && cp <= 0x11640 -> True
    cp if cp == 0x116AB -> True
    cp if cp == 0x116AD -> True
    cp if cp >= 0x116B0 && cp <= 0x116B5 -> True
    cp if cp == 0x116B7 -> True
    cp if cp == 0x1171D -> True
    cp if cp == 0x1171F -> True
    cp if cp >= 0x11722 && cp <= 0x11725 -> True
    cp if cp >= 0x11727 && cp <= 0x1172B -> True
    cp if cp >= 0x1182F && cp <= 0x11837 -> True
    cp if cp >= 0x11839 && cp <= 0x1183A -> True
    cp if cp >= 0x1193B && cp <= 0x1193C -> True
    cp if cp == 0x1193E -> True
    cp if cp == 0x11943 -> True
    cp if cp >= 0x119D4 && cp <= 0x119D7 -> True
    cp if cp >= 0x119DA && cp <= 0x119DB -> True
    cp if cp == 0x119E0 -> True
    cp if cp >= 0x11A01 && cp <= 0x11A06 -> True
    cp if cp >= 0x11A09 && cp <= 0x11A0A -> True
    cp if cp >= 0x11A33 && cp <= 0x11A38 -> True
    cp if cp >= 0x11A3B && cp <= 0x11A3E -> True
    cp if cp == 0x11A47 -> True
    cp if cp >= 0x11A51 && cp <= 0x11A56 -> True
    cp if cp >= 0x11A59 && cp <= 0x11A5B -> True
    cp if cp >= 0x11A8A && cp <= 0x11A96 -> True
    cp if cp >= 0x11A98 && cp <= 0x11A99 -> True
    cp if cp >= 0x11C30 && cp <= 0x11C36 -> True
    cp if cp >= 0x11C38 && cp <= 0x11C3D -> True
    cp if cp >= 0x11C92 && cp <= 0x11CA7 -> True
    cp if cp >= 0x11CAA && cp <= 0x11CB0 -> True
    cp if cp >= 0x11CB2 && cp <= 0x11CB3 -> True
    cp if cp >= 0x11CB5 && cp <= 0x11CB6 -> True
    cp if cp >= 0x11D31 && cp <= 0x11D36 -> True
    cp if cp == 0x11D3A -> True
    cp if cp >= 0x11D3C && cp <= 0x11D3D -> True
    cp if cp >= 0x11D3F && cp <= 0x11D45 -> True
    cp if cp == 0x11D47 -> True
    cp if cp >= 0x11D90 && cp <= 0x11D91 -> True
    cp if cp == 0x11D95 -> True
    cp if cp == 0x11D97 -> True
    cp if cp >= 0x11EF3 && cp <= 0x11EF4 -> True
    cp if cp >= 0x11F00 && cp <= 0x11F01 -> True
    cp if cp >= 0x11F36 && cp <= 0x11F3A -> True
    cp if cp == 0x11F40 -> True
    cp if cp == 0x11F42 -> True
    cp if cp == 0x11F5A -> True
    cp if cp == 0x13440 -> True
    cp if cp >= 0x13447 && cp <= 0x13455 -> True
    cp if cp >= 0x1611E && cp <= 0x16129 -> True
    cp if cp >= 0x1612D && cp <= 0x1612F -> True
    cp if cp >= 0x16AF0 && cp <= 0x16AF4 -> True
    cp if cp >= 0x16B30 && cp <= 0x16B36 -> True
    cp if cp == 0x16F4F -> True
    cp if cp >= 0x16F8F && cp <= 0x16F92 -> True
    cp if cp == 0x16FE4 -> True
    cp if cp >= 0x1BC9D && cp <= 0x1BC9E -> True
    cp if cp >= 0x1CF00 && cp <= 0x1CF2D -> True
    cp if cp >= 0x1CF30 && cp <= 0x1CF46 -> True
    cp if cp >= 0x1D167 && cp <= 0x1D169 -> True
    cp if cp >= 0x1D17B && cp <= 0x1D182 -> True
    cp if cp >= 0x1D185 && cp <= 0x1D18B -> True
    cp if cp >= 0x1D1AA && cp <= 0x1D1AD -> True
    cp if cp >= 0x1D242 && cp <= 0x1D244 -> True
    cp if cp >= 0x1DA00 && cp <= 0x1DA36 -> True
    cp if cp >= 0x1DA3B && cp <= 0x1DA6C -> True
    cp if cp == 0x1DA75 -> True
    cp if cp == 0x1DA84 -> True
    cp if cp >= 0x1DA9B && cp <= 0x1DA9F -> True
    cp if cp >= 0x1DAA1 && cp <= 0x1DAAF -> True
    cp if cp >= 0x1E000 && cp <= 0x1E006 -> True
    cp if cp >= 0x1E008 && cp <= 0x1E018 -> True
    cp if cp >= 0x1E01B && cp <= 0x1E021 -> True
    cp if cp >= 0x1E023 && cp <= 0x1E024 -> True
    cp if cp >= 0x1E026 && cp <= 0x1E02A -> True
    cp if cp == 0x1E08F -> True
    cp if cp >= 0x1E130 && cp <= 0x1E136 -> True
    cp if cp == 0x1E2AE -> True
    cp if cp >= 0x1E2EC && cp <= 0x1E2EF -> True
    cp if cp >= 0x1E4EC && cp <= 0x1E4EF -> True
    cp if cp >= 0x1E5EE && cp <= 0x1E5EF -> True
    cp if cp >= 0x1E8D0 && cp <= 0x1E8D6 -> True
    cp if cp >= 0x1E944 && cp <= 0x1E94A -> True
    cp if cp >= 0xE0100 && cp <= 0xE01EF -> True
    _ -> False
  }
}

pub fn in_right_to_left_any(codepoint: Int) -> Bool {
  case codepoint {
    cp if cp == 0x05BE -> True
    cp if cp == 0x05C0 -> True
    cp if cp == 0x05C3 -> True
    cp if cp == 0x05C6 -> True
    cp if cp >= 0x05D0 && cp <= 0x05EA -> True
    cp if cp >= 0x05EF && cp <= 0x05F2 -> True
    cp if cp >= 0x05F3 && cp <= 0x05F4 -> True
    cp if cp >= 0x07C0 && cp <= 0x07C9 -> True
    cp if cp >= 0x07CA && cp <= 0x07EA -> True
    cp if cp >= 0x07F4 && cp <= 0x07F5 -> True
    cp if cp == 0x07FA -> True
    cp if cp >= 0x07FE && cp <= 0x07FF -> True
    cp if cp >= 0x0800 && cp <= 0x0815 -> True
    cp if cp == 0x081A -> True
    cp if cp == 0x0824 -> True
    cp if cp == 0x0828 -> True
    cp if cp >= 0x0830 && cp <= 0x083E -> True
    cp if cp >= 0x0840 && cp <= 0x0858 -> True
    cp if cp == 0x085E -> True
    cp if cp == 0x200F -> True
    cp if cp == 0xFB1D -> True
    cp if cp >= 0xFB1F && cp <= 0xFB28 -> True
    cp if cp >= 0xFB2A && cp <= 0xFB36 -> True
    cp if cp >= 0xFB38 && cp <= 0xFB3C -> True
    cp if cp == 0xFB3E -> True
    cp if cp >= 0xFB40 && cp <= 0xFB41 -> True
    cp if cp >= 0xFB43 && cp <= 0xFB44 -> True
    cp if cp >= 0xFB46 && cp <= 0xFB4F -> True
    cp if cp >= 0x10800 && cp <= 0x10805 -> True
    cp if cp == 0x10808 -> True
    cp if cp >= 0x1080A && cp <= 0x10835 -> True
    cp if cp >= 0x10837 && cp <= 0x10838 -> True
    cp if cp == 0x1083C -> True
    cp if cp >= 0x1083F && cp <= 0x10855 -> True
    cp if cp == 0x10857 -> True
    cp if cp >= 0x10858 && cp <= 0x1085F -> True
    cp if cp >= 0x10860 && cp <= 0x10876 -> True
    cp if cp >= 0x10877 && cp <= 0x10878 -> True
    cp if cp >= 0x10879 && cp <= 0x1087F -> True
    cp if cp >= 0x10880 && cp <= 0x1089E -> True
    cp if cp >= 0x108A7 && cp <= 0x108AF -> True
    cp if cp >= 0x108E0 && cp <= 0x108F2 -> True
    cp if cp >= 0x108F4 && cp <= 0x108F5 -> True
    cp if cp >= 0x108FB && cp <= 0x108FF -> True
    cp if cp >= 0x10900 && cp <= 0x10915 -> True
    cp if cp >= 0x10916 && cp <= 0x1091B -> True
    cp if cp >= 0x10920 && cp <= 0x10939 -> True
    cp if cp == 0x1093F -> True
    cp if cp >= 0x10980 && cp <= 0x109B7 -> True
    cp if cp >= 0x109BC && cp <= 0x109BD -> True
    cp if cp >= 0x109BE && cp <= 0x109BF -> True
    cp if cp >= 0x109C0 && cp <= 0x109CF -> True
    cp if cp >= 0x109D2 && cp <= 0x109FF -> True
    cp if cp == 0x10A00 -> True
    cp if cp >= 0x10A10 && cp <= 0x10A13 -> True
    cp if cp >= 0x10A15 && cp <= 0x10A17 -> True
    cp if cp >= 0x10A19 && cp <= 0x10A35 -> True
    cp if cp >= 0x10A40 && cp <= 0x10A48 -> True
    cp if cp >= 0x10A50 && cp <= 0x10A58 -> True
    cp if cp >= 0x10A60 && cp <= 0x10A7C -> True
    cp if cp >= 0x10A7D && cp <= 0x10A7E -> True
    cp if cp == 0x10A7F -> True
    cp if cp >= 0x10A80 && cp <= 0x10A9C -> True
    cp if cp >= 0x10A9D && cp <= 0x10A9F -> True
    cp if cp >= 0x10AC0 && cp <= 0x10AC7 -> True
    cp if cp == 0x10AC8 -> True
    cp if cp >= 0x10AC9 && cp <= 0x10AE4 -> True
    cp if cp >= 0x10AEB && cp <= 0x10AEF -> True
    cp if cp >= 0x10AF0 && cp <= 0x10AF6 -> True
    cp if cp >= 0x10B00 && cp <= 0x10B35 -> True
    cp if cp >= 0x10B40 && cp <= 0x10B55 -> True
    cp if cp >= 0x10B58 && cp <= 0x10B5F -> True
    cp if cp >= 0x10B60 && cp <= 0x10B72 -> True
    cp if cp >= 0x10B78 && cp <= 0x10B7F -> True
    cp if cp >= 0x10B80 && cp <= 0x10B91 -> True
    cp if cp >= 0x10B99 && cp <= 0x10B9C -> True
    cp if cp >= 0x10BA9 && cp <= 0x10BAF -> True
    cp if cp >= 0x10C00 && cp <= 0x10C48 -> True
    cp if cp >= 0x10C80 && cp <= 0x10CB2 -> True
    cp if cp >= 0x10CC0 && cp <= 0x10CF2 -> True
    cp if cp >= 0x10CFA && cp <= 0x10CFF -> True
    cp if cp >= 0x10D4A && cp <= 0x10D4D -> True
    cp if cp == 0x10D4E -> True
    cp if cp == 0x10D4F -> True
    cp if cp >= 0x10D50 && cp <= 0x10D65 -> True
    cp if cp == 0x10D6F -> True
    cp if cp >= 0x10D70 && cp <= 0x10D85 -> True
    cp if cp >= 0x10D8E && cp <= 0x10D8F -> True
    cp if cp >= 0x10E80 && cp <= 0x10EA9 -> True
    cp if cp == 0x10EAD -> True
    cp if cp >= 0x10EB0 && cp <= 0x10EB1 -> True
    cp if cp >= 0x10F00 && cp <= 0x10F1C -> True
    cp if cp >= 0x10F1D && cp <= 0x10F26 -> True
    cp if cp == 0x10F27 -> True
    cp if cp >= 0x10F70 && cp <= 0x10F81 -> True
    cp if cp >= 0x10F86 && cp <= 0x10F89 -> True
    cp if cp >= 0x10FB0 && cp <= 0x10FC4 -> True
    cp if cp >= 0x10FC5 && cp <= 0x10FCB -> True
    cp if cp >= 0x10FE0 && cp <= 0x10FF6 -> True
    cp if cp >= 0x1E800 && cp <= 0x1E8C4 -> True
    cp if cp >= 0x1E8C7 && cp <= 0x1E8CF -> True
    cp if cp >= 0x1E900 && cp <= 0x1E943 -> True
    cp if cp == 0x1E94B -> True
    cp if cp >= 0x1E950 && cp <= 0x1E959 -> True
    cp if cp >= 0x1E95E && cp <= 0x1E95F -> True
    cp if cp >= 0x0600 && cp <= 0x0605 -> True
    cp if cp >= 0x0660 && cp <= 0x0669 -> True
    cp if cp >= 0x066B && cp <= 0x066C -> True
    cp if cp == 0x06DD -> True
    cp if cp >= 0x0890 && cp <= 0x0891 -> True
    cp if cp == 0x08E2 -> True
    cp if cp >= 0x10D30 && cp <= 0x10D39 -> True
    cp if cp >= 0x10D40 && cp <= 0x10D49 -> True
    cp if cp >= 0x10E60 && cp <= 0x10E7E -> True
    cp if cp == 0x0608 -> True
    cp if cp == 0x060B -> True
    cp if cp == 0x060D -> True
    cp if cp == 0x061B -> True
    cp if cp == 0x061C -> True
    cp if cp >= 0x061D && cp <= 0x061F -> True
    cp if cp >= 0x0620 && cp <= 0x063F -> True
    cp if cp == 0x0640 -> True
    cp if cp >= 0x0641 && cp <= 0x064A -> True
    cp if cp == 0x066D -> True
    cp if cp >= 0x066E && cp <= 0x066F -> True
    cp if cp >= 0x0671 && cp <= 0x06D3 -> True
    cp if cp == 0x06D4 -> True
    cp if cp == 0x06D5 -> True
    cp if cp >= 0x06E5 && cp <= 0x06E6 -> True
    cp if cp >= 0x06EE && cp <= 0x06EF -> True
    cp if cp >= 0x06FA && cp <= 0x06FC -> True
    cp if cp >= 0x06FD && cp <= 0x06FE -> True
    cp if cp == 0x06FF -> True
    cp if cp >= 0x0700 && cp <= 0x070D -> True
    cp if cp == 0x070F -> True
    cp if cp == 0x0710 -> True
    cp if cp >= 0x0712 && cp <= 0x072F -> True
    cp if cp >= 0x074D && cp <= 0x07A5 -> True
    cp if cp == 0x07B1 -> True
    cp if cp >= 0x0860 && cp <= 0x086A -> True
    cp if cp >= 0x0870 && cp <= 0x0887 -> True
    cp if cp == 0x0888 -> True
    cp if cp >= 0x0889 && cp <= 0x088E -> True
    cp if cp >= 0x08A0 && cp <= 0x08C8 -> True
    cp if cp == 0x08C9 -> True
    cp if cp >= 0xFB50 && cp <= 0xFBB1 -> True
    cp if cp >= 0xFBB2 && cp <= 0xFBC2 -> True
    cp if cp >= 0xFBD3 && cp <= 0xFD3D -> True
    cp if cp >= 0xFD50 && cp <= 0xFD8F -> True
    cp if cp >= 0xFD92 && cp <= 0xFDC7 -> True
    cp if cp >= 0xFDF0 && cp <= 0xFDFB -> True
    cp if cp == 0xFDFC -> True
    cp if cp >= 0xFE70 && cp <= 0xFE74 -> True
    cp if cp >= 0xFE76 && cp <= 0xFEFC -> True
    cp if cp >= 0x10D00 && cp <= 0x10D23 -> True
    cp if cp >= 0x10EC2 && cp <= 0x10EC4 -> True
    cp if cp >= 0x10F30 && cp <= 0x10F45 -> True
    cp if cp >= 0x10F51 && cp <= 0x10F54 -> True
    cp if cp >= 0x10F55 && cp <= 0x10F59 -> True
    cp if cp >= 0x1EC71 && cp <= 0x1ECAB -> True
    cp if cp == 0x1ECAC -> True
    cp if cp >= 0x1ECAD && cp <= 0x1ECAF -> True
    cp if cp == 0x1ECB0 -> True
    cp if cp >= 0x1ECB1 && cp <= 0x1ECB4 -> True
    cp if cp >= 0x1ED01 && cp <= 0x1ED2D -> True
    cp if cp == 0x1ED2E -> True
    cp if cp >= 0x1ED2F && cp <= 0x1ED3D -> True
    cp if cp >= 0x1EE00 && cp <= 0x1EE03 -> True
    cp if cp >= 0x1EE05 && cp <= 0x1EE1F -> True
    cp if cp >= 0x1EE21 && cp <= 0x1EE22 -> True
    cp if cp == 0x1EE24 -> True
    cp if cp == 0x1EE27 -> True
    cp if cp >= 0x1EE29 && cp <= 0x1EE32 -> True
    cp if cp >= 0x1EE34 && cp <= 0x1EE37 -> True
    cp if cp == 0x1EE39 -> True
    cp if cp == 0x1EE3B -> True
    cp if cp == 0x1EE42 -> True
    cp if cp == 0x1EE47 -> True
    cp if cp == 0x1EE49 -> True
    cp if cp == 0x1EE4B -> True
    cp if cp >= 0x1EE4D && cp <= 0x1EE4F -> True
    cp if cp >= 0x1EE51 && cp <= 0x1EE52 -> True
    cp if cp == 0x1EE54 -> True
    cp if cp == 0x1EE57 -> True
    cp if cp == 0x1EE59 -> True
    cp if cp == 0x1EE5B -> True
    cp if cp == 0x1EE5D -> True
    cp if cp == 0x1EE5F -> True
    cp if cp >= 0x1EE61 && cp <= 0x1EE62 -> True
    cp if cp == 0x1EE64 -> True
    cp if cp >= 0x1EE67 && cp <= 0x1EE6A -> True
    cp if cp >= 0x1EE6C && cp <= 0x1EE72 -> True
    cp if cp >= 0x1EE74 && cp <= 0x1EE77 -> True
    cp if cp >= 0x1EE79 && cp <= 0x1EE7C -> True
    cp if cp == 0x1EE7E -> True
    cp if cp >= 0x1EE80 && cp <= 0x1EE89 -> True
    cp if cp >= 0x1EE8B && cp <= 0x1EE9B -> True
    cp if cp >= 0x1EEA1 && cp <= 0x1EEA3 -> True
    cp if cp >= 0x1EEA5 && cp <= 0x1EEA9 -> True
    cp if cp >= 0x1EEAB && cp <= 0x1EEBB -> True
    _ -> False
  }
}

pub fn in_combining_virama(codepoint: Int) -> Bool {
  case codepoint {
    cp if cp == 0x094D -> True
    cp if cp == 0x09CD -> True
    cp if cp == 0x0A4D -> True
    cp if cp == 0x0ACD -> True
    cp if cp == 0x0B4D -> True
    cp if cp == 0x0BCD -> True
    cp if cp == 0x0C4D -> True
    cp if cp == 0x0CCD -> True
    cp if cp >= 0x0D3B && cp <= 0x0D3C -> True
    cp if cp == 0x0D4D -> True
    cp if cp == 0x0DCA -> True
    cp if cp == 0x0E3A -> True
    cp if cp == 0x0EBA -> True
    cp if cp == 0x0F84 -> True
    cp if cp >= 0x1039 && cp <= 0x103A -> True
    cp if cp == 0x1714 -> True
    cp if cp == 0x1715 -> True
    cp if cp == 0x1734 -> True
    cp if cp == 0x17D2 -> True
    cp if cp == 0x1A60 -> True
    cp if cp == 0x1B44 -> True
    cp if cp == 0x1BAA -> True
    cp if cp == 0x1BAB -> True
    cp if cp >= 0x1BF2 && cp <= 0x1BF3 -> True
    cp if cp == 0x2D7F -> True
    cp if cp == 0xA806 -> True
    cp if cp == 0xA82C -> True
    cp if cp == 0xA8C4 -> True
    cp if cp == 0xA953 -> True
    cp if cp == 0xA9C0 -> True
    cp if cp == 0xAAF6 -> True
    cp if cp == 0xABED -> True
    cp if cp == 0x10A3F -> True
    cp if cp == 0x11046 -> True
    cp if cp == 0x11070 -> True
    cp if cp == 0x1107F -> True
    cp if cp == 0x110B9 -> True
    cp if cp >= 0x11133 && cp <= 0x11134 -> True
    cp if cp == 0x111C0 -> True
    cp if cp == 0x11235 -> True
    cp if cp == 0x112EA -> True
    cp if cp == 0x1134D -> True
    cp if cp == 0x113CE -> True
    cp if cp == 0x113CF -> True
    cp if cp == 0x113D0 -> True
    cp if cp == 0x11442 -> True
    cp if cp == 0x114C2 -> True
    cp if cp == 0x115BF -> True
    cp if cp == 0x1163F -> True
    cp if cp == 0x116B6 -> True
    cp if cp == 0x1172B -> True
    cp if cp == 0x11839 -> True
    cp if cp == 0x1193D -> True
    cp if cp == 0x1193E -> True
    cp if cp == 0x119E0 -> True
    cp if cp == 0x11A34 -> True
    cp if cp == 0x11A47 -> True
    cp if cp == 0x11A99 -> True
    cp if cp == 0x11C3F -> True
    cp if cp >= 0x11D44 && cp <= 0x11D45 -> True
    cp if cp == 0x11D97 -> True
    cp if cp == 0x11F41 -> True
    cp if cp == 0x11F42 -> True
    cp if cp == 0x1612F -> True
    _ -> False
  }
}

pub fn in_greek_script(codepoint: Int) -> Bool {
  case codepoint {
    cp if cp >= 0x0370 && cp <= 0x0373 -> True
    cp if cp == 0x0375 -> True
    cp if cp >= 0x0376 && cp <= 0x0377 -> True
    cp if cp == 0x037A -> True
    cp if cp >= 0x037B && cp <= 0x037D -> True
    cp if cp == 0x037F -> True
    cp if cp == 0x0384 -> True
    cp if cp == 0x0386 -> True
    cp if cp >= 0x0388 && cp <= 0x038A -> True
    cp if cp == 0x038C -> True
    cp if cp >= 0x038E && cp <= 0x03A1 -> True
    cp if cp >= 0x03A3 && cp <= 0x03E1 -> True
    cp if cp >= 0x03F0 && cp <= 0x03F5 -> True
    cp if cp == 0x03F6 -> True
    cp if cp >= 0x03F7 && cp <= 0x03FF -> True
    cp if cp >= 0x1D26 && cp <= 0x1D2A -> True
    cp if cp >= 0x1D5D && cp <= 0x1D61 -> True
    cp if cp >= 0x1D66 && cp <= 0x1D6A -> True
    cp if cp == 0x1DBF -> True
    cp if cp >= 0x1F00 && cp <= 0x1F15 -> True
    cp if cp >= 0x1F18 && cp <= 0x1F1D -> True
    cp if cp >= 0x1F20 && cp <= 0x1F45 -> True
    cp if cp >= 0x1F48 && cp <= 0x1F4D -> True
    cp if cp >= 0x1F50 && cp <= 0x1F57 -> True
    cp if cp == 0x1F59 -> True
    cp if cp == 0x1F5B -> True
    cp if cp == 0x1F5D -> True
    cp if cp >= 0x1F5F && cp <= 0x1F7D -> True
    cp if cp >= 0x1F80 && cp <= 0x1FB4 -> True
    cp if cp >= 0x1FB6 && cp <= 0x1FBC -> True
    cp if cp == 0x1FBD -> True
    cp if cp == 0x1FBE -> True
    cp if cp >= 0x1FBF && cp <= 0x1FC1 -> True
    cp if cp >= 0x1FC2 && cp <= 0x1FC4 -> True
    cp if cp >= 0x1FC6 && cp <= 0x1FCC -> True
    cp if cp >= 0x1FCD && cp <= 0x1FCF -> True
    cp if cp >= 0x1FD0 && cp <= 0x1FD3 -> True
    cp if cp >= 0x1FD6 && cp <= 0x1FDB -> True
    cp if cp >= 0x1FDD && cp <= 0x1FDF -> True
    cp if cp >= 0x1FE0 && cp <= 0x1FEC -> True
    cp if cp >= 0x1FED && cp <= 0x1FEF -> True
    cp if cp >= 0x1FF2 && cp <= 0x1FF4 -> True
    cp if cp >= 0x1FF6 && cp <= 0x1FFC -> True
    cp if cp >= 0x1FFD && cp <= 0x1FFE -> True
    cp if cp == 0x2126 -> True
    cp if cp == 0xAB65 -> True
    cp if cp >= 0x10140 && cp <= 0x10174 -> True
    cp if cp >= 0x10175 && cp <= 0x10178 -> True
    cp if cp >= 0x10179 && cp <= 0x10189 -> True
    cp if cp >= 0x1018A && cp <= 0x1018B -> True
    cp if cp >= 0x1018C && cp <= 0x1018E -> True
    cp if cp == 0x101A0 -> True
    cp if cp >= 0x1D200 && cp <= 0x1D241 -> True
    cp if cp >= 0x1D242 && cp <= 0x1D244 -> True
    cp if cp == 0x1D245 -> True
    _ -> False
  }
}

pub fn in_hebrew_script(codepoint: Int) -> Bool {
  case codepoint {
    cp if cp >= 0x0591 && cp <= 0x05BD -> True
    cp if cp == 0x05BE -> True
    cp if cp == 0x05BF -> True
    cp if cp == 0x05C0 -> True
    cp if cp >= 0x05C1 && cp <= 0x05C2 -> True
    cp if cp == 0x05C3 -> True
    cp if cp >= 0x05C4 && cp <= 0x05C5 -> True
    cp if cp == 0x05C6 -> True
    cp if cp == 0x05C7 -> True
    cp if cp >= 0x05D0 && cp <= 0x05EA -> True
    cp if cp >= 0x05EF && cp <= 0x05F2 -> True
    cp if cp >= 0x05F3 && cp <= 0x05F4 -> True
    cp if cp == 0xFB1D -> True
    cp if cp == 0xFB1E -> True
    cp if cp >= 0xFB1F && cp <= 0xFB28 -> True
    cp if cp == 0xFB29 -> True
    cp if cp >= 0xFB2A && cp <= 0xFB36 -> True
    cp if cp >= 0xFB38 && cp <= 0xFB3C -> True
    cp if cp == 0xFB3E -> True
    cp if cp >= 0xFB40 && cp <= 0xFB41 -> True
    cp if cp >= 0xFB43 && cp <= 0xFB44 -> True
    cp if cp >= 0xFB46 && cp <= 0xFB4F -> True
    _ -> False
  }
}

pub fn in_dual_joining(codepoint: Int) -> Bool {
  case codepoint {
    cp if cp == 0x0620 -> True
    cp if cp == 0x0626 -> True
    cp if cp == 0x0628 -> True
    cp if cp >= 0x062A && cp <= 0x062E -> True
    cp if cp >= 0x0633 && cp <= 0x063F -> True
    cp if cp >= 0x0641 && cp <= 0x0647 -> True
    cp if cp >= 0x0649 && cp <= 0x064A -> True
    cp if cp >= 0x066E && cp <= 0x066F -> True
    cp if cp >= 0x0678 && cp <= 0x0687 -> True
    cp if cp >= 0x069A && cp <= 0x06BF -> True
    cp if cp >= 0x06C1 && cp <= 0x06C2 -> True
    cp if cp == 0x06CC -> True
    cp if cp == 0x06CE -> True
    cp if cp >= 0x06D0 && cp <= 0x06D1 -> True
    cp if cp >= 0x06FA && cp <= 0x06FC -> True
    cp if cp == 0x06FF -> True
    cp if cp >= 0x0712 && cp <= 0x0714 -> True
    cp if cp >= 0x071A && cp <= 0x071D -> True
    cp if cp >= 0x071F && cp <= 0x0727 -> True
    cp if cp == 0x0729 -> True
    cp if cp == 0x072B -> True
    cp if cp >= 0x072D && cp <= 0x072E -> True
    cp if cp >= 0x074E && cp <= 0x0758 -> True
    cp if cp >= 0x075C && cp <= 0x076A -> True
    cp if cp >= 0x076D && cp <= 0x0770 -> True
    cp if cp == 0x0772 -> True
    cp if cp >= 0x0775 && cp <= 0x0777 -> True
    cp if cp >= 0x077A && cp <= 0x077F -> True
    cp if cp >= 0x07CA && cp <= 0x07EA -> True
    cp if cp >= 0x0841 && cp <= 0x0845 -> True
    cp if cp == 0x0848 -> True
    cp if cp >= 0x084A && cp <= 0x0853 -> True
    cp if cp == 0x0855 -> True
    cp if cp == 0x0860 -> True
    cp if cp >= 0x0862 && cp <= 0x0865 -> True
    cp if cp == 0x0868 -> True
    cp if cp == 0x0886 -> True
    cp if cp >= 0x0889 && cp <= 0x088D -> True
    cp if cp >= 0x08A0 && cp <= 0x08A9 -> True
    cp if cp >= 0x08AF && cp <= 0x08B0 -> True
    cp if cp >= 0x08B3 && cp <= 0x08B8 -> True
    cp if cp >= 0x08BA && cp <= 0x08C8 -> True
    cp if cp == 0x1807 -> True
    cp if cp >= 0x1820 && cp <= 0x1842 -> True
    cp if cp == 0x1843 -> True
    cp if cp >= 0x1844 && cp <= 0x1878 -> True
    cp if cp >= 0x1887 && cp <= 0x18A8 -> True
    cp if cp == 0x18AA -> True
    cp if cp >= 0xA840 && cp <= 0xA871 -> True
    cp if cp >= 0x10AC0 && cp <= 0x10AC4 -> True
    cp if cp >= 0x10AD3 && cp <= 0x10AD6 -> True
    cp if cp >= 0x10AD8 && cp <= 0x10ADC -> True
    cp if cp >= 0x10ADE && cp <= 0x10AE0 -> True
    cp if cp >= 0x10AEB && cp <= 0x10AEE -> True
    cp if cp == 0x10B80 -> True
    cp if cp == 0x10B82 -> True
    cp if cp >= 0x10B86 && cp <= 0x10B88 -> True
    cp if cp >= 0x10B8A && cp <= 0x10B8B -> True
    cp if cp == 0x10B8D -> True
    cp if cp == 0x10B90 -> True
    cp if cp >= 0x10BAD && cp <= 0x10BAE -> True
    cp if cp >= 0x10D01 && cp <= 0x10D21 -> True
    cp if cp == 0x10D23 -> True
    cp if cp >= 0x10EC3 && cp <= 0x10EC4 -> True
    cp if cp >= 0x10F30 && cp <= 0x10F32 -> True
    cp if cp >= 0x10F34 && cp <= 0x10F44 -> True
    cp if cp >= 0x10F51 && cp <= 0x10F53 -> True
    cp if cp >= 0x10F70 && cp <= 0x10F73 -> True
    cp if cp >= 0x10F76 && cp <= 0x10F81 -> True
    cp if cp == 0x10FB0 -> True
    cp if cp >= 0x10FB2 && cp <= 0x10FB3 -> True
    cp if cp == 0x10FB8 -> True
    cp if cp >= 0x10FBB && cp <= 0x10FBC -> True
    cp if cp >= 0x10FBE && cp <= 0x10FBF -> True
    cp if cp == 0x10FC1 -> True
    cp if cp == 0x10FC4 -> True
    cp if cp == 0x10FCA -> True
    cp if cp >= 0x1E900 && cp <= 0x1E943 -> True
    _ -> False
  }
}

pub fn in_right_joining(codepoint: Int) -> Bool {
  case codepoint {
    cp if cp >= 0x0622 && cp <= 0x0625 -> True
    cp if cp == 0x0627 -> True
    cp if cp == 0x0629 -> True
    cp if cp >= 0x062F && cp <= 0x0632 -> True
    cp if cp == 0x0648 -> True
    cp if cp >= 0x0671 && cp <= 0x0673 -> True
    cp if cp >= 0x0675 && cp <= 0x0677 -> True
    cp if cp >= 0x0688 && cp <= 0x0699 -> True
    cp if cp == 0x06C0 -> True
    cp if cp >= 0x06C3 && cp <= 0x06CB -> True
    cp if cp == 0x06CD -> True
    cp if cp == 0x06CF -> True
    cp if cp >= 0x06D2 && cp <= 0x06D3 -> True
    cp if cp == 0x06D5 -> True
    cp if cp >= 0x06EE && cp <= 0x06EF -> True
    cp if cp == 0x0710 -> True
    cp if cp >= 0x0715 && cp <= 0x0719 -> True
    cp if cp == 0x071E -> True
    cp if cp == 0x0728 -> True
    cp if cp == 0x072A -> True
    cp if cp == 0x072C -> True
    cp if cp == 0x072F -> True
    cp if cp == 0x074D -> True
    cp if cp >= 0x0759 && cp <= 0x075B -> True
    cp if cp >= 0x076B && cp <= 0x076C -> True
    cp if cp == 0x0771 -> True
    cp if cp >= 0x0773 && cp <= 0x0774 -> True
    cp if cp >= 0x0778 && cp <= 0x0779 -> True
    cp if cp == 0x0840 -> True
    cp if cp >= 0x0846 && cp <= 0x0847 -> True
    cp if cp == 0x0849 -> True
    cp if cp == 0x0854 -> True
    cp if cp >= 0x0856 && cp <= 0x0858 -> True
    cp if cp == 0x0867 -> True
    cp if cp >= 0x0869 && cp <= 0x086A -> True
    cp if cp >= 0x0870 && cp <= 0x0882 -> True
    cp if cp == 0x088E -> True
    cp if cp >= 0x08AA && cp <= 0x08AC -> True
    cp if cp == 0x08AE -> True
    cp if cp >= 0x08B1 && cp <= 0x08B2 -> True
    cp if cp == 0x08B9 -> True
    cp if cp == 0x10AC5 -> True
    cp if cp == 0x10AC7 -> True
    cp if cp >= 0x10AC9 && cp <= 0x10ACA -> True
    cp if cp >= 0x10ACE && cp <= 0x10AD2 -> True
    cp if cp == 0x10ADD -> True
    cp if cp == 0x10AE1 -> True
    cp if cp == 0x10AE4 -> True
    cp if cp == 0x10AEF -> True
    cp if cp == 0x10B81 -> True
    cp if cp >= 0x10B83 && cp <= 0x10B85 -> True
    cp if cp == 0x10B89 -> True
    cp if cp == 0x10B8C -> True
    cp if cp >= 0x10B8E && cp <= 0x10B8F -> True
    cp if cp == 0x10B91 -> True
    cp if cp >= 0x10BA9 && cp <= 0x10BAC -> True
    cp if cp == 0x10D22 -> True
    cp if cp == 0x10EC2 -> True
    cp if cp == 0x10F33 -> True
    cp if cp == 0x10F54 -> True
    cp if cp >= 0x10F74 && cp <= 0x10F75 -> True
    cp if cp >= 0x10FB4 && cp <= 0x10FB6 -> True
    cp if cp >= 0x10FB9 && cp <= 0x10FBA -> True
    cp if cp == 0x10FBD -> True
    cp if cp >= 0x10FC2 && cp <= 0x10FC3 -> True
    cp if cp == 0x10FC9 -> True
    _ -> False
  }
}

pub fn in_left_joining(codepoint: Int) -> Bool {
  case codepoint {
    cp if cp == 0xA872 -> True
    cp if cp == 0x10ACD -> True
    cp if cp == 0x10AD7 -> True
    cp if cp == 0x10D00 -> True
    cp if cp == 0x10FCB -> True
    _ -> False
  }
}

pub fn in_transparent_joining(codepoint: Int) -> Bool {
  case codepoint {
    cp if cp == 0x00AD -> True
    cp if cp >= 0x0300 && cp <= 0x036F -> True
    cp if cp >= 0x0483 && cp <= 0x0487 -> True
    cp if cp >= 0x0488 && cp <= 0x0489 -> True
    cp if cp >= 0x0591 && cp <= 0x05BD -> True
    cp if cp == 0x05BF -> True
    cp if cp >= 0x05C1 && cp <= 0x05C2 -> True
    cp if cp >= 0x05C4 && cp <= 0x05C5 -> True
    cp if cp == 0x05C7 -> True
    cp if cp >= 0x0610 && cp <= 0x061A -> True
    cp if cp == 0x061C -> True
    cp if cp >= 0x064B && cp <= 0x065F -> True
    cp if cp == 0x0670 -> True
    cp if cp >= 0x06D6 && cp <= 0x06DC -> True
    cp if cp >= 0x06DF && cp <= 0x06E4 -> True
    cp if cp >= 0x06E7 && cp <= 0x06E8 -> True
    cp if cp >= 0x06EA && cp <= 0x06ED -> True
    cp if cp == 0x070F -> True
    cp if cp == 0x0711 -> True
    cp if cp >= 0x0730 && cp <= 0x074A -> True
    cp if cp >= 0x07A6 && cp <= 0x07B0 -> True
    cp if cp >= 0x07EB && cp <= 0x07F3 -> True
    cp if cp == 0x07FD -> True
    cp if cp >= 0x0816 && cp <= 0x0819 -> True
    cp if cp >= 0x081B && cp <= 0x0823 -> True
    cp if cp >= 0x0825 && cp <= 0x0827 -> True
    cp if cp >= 0x0829 && cp <= 0x082D -> True
    cp if cp >= 0x0859 && cp <= 0x085B -> True
    cp if cp >= 0x0897 && cp <= 0x089F -> True
    cp if cp >= 0x08CA && cp <= 0x08E1 -> True
    cp if cp >= 0x08E3 && cp <= 0x0902 -> True
    cp if cp == 0x093A -> True
    cp if cp == 0x093C -> True
    cp if cp >= 0x0941 && cp <= 0x0948 -> True
    cp if cp == 0x094D -> True
    cp if cp >= 0x0951 && cp <= 0x0957 -> True
    cp if cp >= 0x0962 && cp <= 0x0963 -> True
    cp if cp == 0x0981 -> True
    cp if cp == 0x09BC -> True
    cp if cp >= 0x09C1 && cp <= 0x09C4 -> True
    cp if cp == 0x09CD -> True
    cp if cp >= 0x09E2 && cp <= 0x09E3 -> True
    cp if cp == 0x09FE -> True
    cp if cp >= 0x0A01 && cp <= 0x0A02 -> True
    cp if cp == 0x0A3C -> True
    cp if cp >= 0x0A41 && cp <= 0x0A42 -> True
    cp if cp >= 0x0A47 && cp <= 0x0A48 -> True
    cp if cp >= 0x0A4B && cp <= 0x0A4D -> True
    cp if cp == 0x0A51 -> True
    cp if cp >= 0x0A70 && cp <= 0x0A71 -> True
    cp if cp == 0x0A75 -> True
    cp if cp >= 0x0A81 && cp <= 0x0A82 -> True
    cp if cp == 0x0ABC -> True
    cp if cp >= 0x0AC1 && cp <= 0x0AC5 -> True
    cp if cp >= 0x0AC7 && cp <= 0x0AC8 -> True
    cp if cp == 0x0ACD -> True
    cp if cp >= 0x0AE2 && cp <= 0x0AE3 -> True
    cp if cp >= 0x0AFA && cp <= 0x0AFF -> True
    cp if cp == 0x0B01 -> True
    cp if cp == 0x0B3C -> True
    cp if cp == 0x0B3F -> True
    cp if cp >= 0x0B41 && cp <= 0x0B44 -> True
    cp if cp == 0x0B4D -> True
    cp if cp >= 0x0B55 && cp <= 0x0B56 -> True
    cp if cp >= 0x0B62 && cp <= 0x0B63 -> True
    cp if cp == 0x0B82 -> True
    cp if cp == 0x0BC0 -> True
    cp if cp == 0x0BCD -> True
    cp if cp == 0x0C00 -> True
    cp if cp == 0x0C04 -> True
    cp if cp == 0x0C3C -> True
    cp if cp >= 0x0C3E && cp <= 0x0C40 -> True
    cp if cp >= 0x0C46 && cp <= 0x0C48 -> True
    cp if cp >= 0x0C4A && cp <= 0x0C4D -> True
    cp if cp >= 0x0C55 && cp <= 0x0C56 -> True
    cp if cp >= 0x0C62 && cp <= 0x0C63 -> True
    cp if cp == 0x0C81 -> True
    cp if cp == 0x0CBC -> True
    cp if cp == 0x0CBF -> True
    cp if cp == 0x0CC6 -> True
    cp if cp >= 0x0CCC && cp <= 0x0CCD -> True
    cp if cp >= 0x0CE2 && cp <= 0x0CE3 -> True
    cp if cp >= 0x0D00 && cp <= 0x0D01 -> True
    cp if cp >= 0x0D3B && cp <= 0x0D3C -> True
    cp if cp >= 0x0D41 && cp <= 0x0D44 -> True
    cp if cp == 0x0D4D -> True
    cp if cp >= 0x0D62 && cp <= 0x0D63 -> True
    cp if cp == 0x0D81 -> True
    cp if cp == 0x0DCA -> True
    cp if cp >= 0x0DD2 && cp <= 0x0DD4 -> True
    cp if cp == 0x0DD6 -> True
    cp if cp == 0x0E31 -> True
    cp if cp >= 0x0E34 && cp <= 0x0E3A -> True
    cp if cp >= 0x0E47 && cp <= 0x0E4E -> True
    cp if cp == 0x0EB1 -> True
    cp if cp >= 0x0EB4 && cp <= 0x0EBC -> True
    cp if cp >= 0x0EC8 && cp <= 0x0ECE -> True
    cp if cp >= 0x0F18 && cp <= 0x0F19 -> True
    cp if cp == 0x0F35 -> True
    cp if cp == 0x0F37 -> True
    cp if cp == 0x0F39 -> True
    cp if cp >= 0x0F71 && cp <= 0x0F7E -> True
    cp if cp >= 0x0F80 && cp <= 0x0F84 -> True
    cp if cp >= 0x0F86 && cp <= 0x0F87 -> True
    cp if cp >= 0x0F8D && cp <= 0x0F97 -> True
    cp if cp >= 0x0F99 && cp <= 0x0FBC -> True
    cp if cp == 0x0FC6 -> True
    cp if cp >= 0x102D && cp <= 0x1030 -> True
    cp if cp >= 0x1032 && cp <= 0x1037 -> True
    cp if cp >= 0x1039 && cp <= 0x103A -> True
    cp if cp >= 0x103D && cp <= 0x103E -> True
    cp if cp >= 0x1058 && cp <= 0x1059 -> True
    cp if cp >= 0x105E && cp <= 0x1060 -> True
    cp if cp >= 0x1071 && cp <= 0x1074 -> True
    cp if cp == 0x1082 -> True
    cp if cp >= 0x1085 && cp <= 0x1086 -> True
    cp if cp == 0x108D -> True
    cp if cp == 0x109D -> True
    cp if cp >= 0x135D && cp <= 0x135F -> True
    cp if cp >= 0x1712 && cp <= 0x1714 -> True
    cp if cp >= 0x1732 && cp <= 0x1733 -> True
    cp if cp >= 0x1752 && cp <= 0x1753 -> True
    cp if cp >= 0x1772 && cp <= 0x1773 -> True
    cp if cp >= 0x17B4 && cp <= 0x17B5 -> True
    cp if cp >= 0x17B7 && cp <= 0x17BD -> True
    cp if cp == 0x17C6 -> True
    cp if cp >= 0x17C9 && cp <= 0x17D3 -> True
    cp if cp == 0x17DD -> True
    cp if cp >= 0x180B && cp <= 0x180D -> True
    cp if cp == 0x180F -> True
    cp if cp >= 0x1885 && cp <= 0x1886 -> True
    cp if cp == 0x18A9 -> True
    cp if cp >= 0x1920 && cp <= 0x1922 -> True
    cp if cp >= 0x1927 && cp <= 0x1928 -> True
    cp if cp == 0x1932 -> True
    cp if cp >= 0x1939 && cp <= 0x193B -> True
    cp if cp >= 0x1A17 && cp <= 0x1A18 -> True
    cp if cp == 0x1A1B -> True
    cp if cp == 0x1A56 -> True
    cp if cp >= 0x1A58 && cp <= 0x1A5E -> True
    cp if cp == 0x1A60 -> True
    cp if cp == 0x1A62 -> True
    cp if cp >= 0x1A65 && cp <= 0x1A6C -> True
    cp if cp >= 0x1A73 && cp <= 0x1A7C -> True
    cp if cp == 0x1A7F -> True
    cp if cp >= 0x1AB0 && cp <= 0x1ABD -> True
    cp if cp == 0x1ABE -> True
    cp if cp >= 0x1ABF && cp <= 0x1ACE -> True
    cp if cp >= 0x1B00 && cp <= 0x1B03 -> True
    cp if cp == 0x1B34 -> True
    cp if cp >= 0x1B36 && cp <= 0x1B3A -> True
    cp if cp == 0x1B3C -> True
    cp if cp == 0x1B42 -> True
    cp if cp >= 0x1B6B && cp <= 0x1B73 -> True
    cp if cp >= 0x1B80 && cp <= 0x1B81 -> True
    cp if cp >= 0x1BA2 && cp <= 0x1BA5 -> True
    cp if cp >= 0x1BA8 && cp <= 0x1BA9 -> True
    cp if cp >= 0x1BAB && cp <= 0x1BAD -> True
    cp if cp == 0x1BE6 -> True
    cp if cp >= 0x1BE8 && cp <= 0x1BE9 -> True
    cp if cp == 0x1BED -> True
    cp if cp >= 0x1BEF && cp <= 0x1BF1 -> True
    cp if cp >= 0x1C2C && cp <= 0x1C33 -> True
    cp if cp >= 0x1C36 && cp <= 0x1C37 -> True
    cp if cp >= 0x1CD0 && cp <= 0x1CD2 -> True
    cp if cp >= 0x1CD4 && cp <= 0x1CE0 -> True
    cp if cp >= 0x1CE2 && cp <= 0x1CE8 -> True
    cp if cp == 0x1CED -> True
    cp if cp == 0x1CF4 -> True
    cp if cp >= 0x1CF8 && cp <= 0x1CF9 -> True
    cp if cp >= 0x1DC0 && cp <= 0x1DFF -> True
    cp if cp == 0x200B -> True
    cp if cp >= 0x200E && cp <= 0x200F -> True
    cp if cp >= 0x202A && cp <= 0x202E -> True
    cp if cp >= 0x2060 && cp <= 0x2064 -> True
    cp if cp >= 0x206A && cp <= 0x206F -> True
    cp if cp >= 0x20D0 && cp <= 0x20DC -> True
    cp if cp >= 0x20DD && cp <= 0x20E0 -> True
    cp if cp == 0x20E1 -> True
    cp if cp >= 0x20E2 && cp <= 0x20E4 -> True
    cp if cp >= 0x20E5 && cp <= 0x20F0 -> True
    cp if cp >= 0x2CEF && cp <= 0x2CF1 -> True
    cp if cp == 0x2D7F -> True
    cp if cp >= 0x2DE0 && cp <= 0x2DFF -> True
    cp if cp >= 0x302A && cp <= 0x302D -> True
    cp if cp >= 0x3099 && cp <= 0x309A -> True
    cp if cp == 0xA66F -> True
    cp if cp >= 0xA670 && cp <= 0xA672 -> True
    cp if cp >= 0xA674 && cp <= 0xA67D -> True
    cp if cp >= 0xA69E && cp <= 0xA69F -> True
    cp if cp >= 0xA6F0 && cp <= 0xA6F1 -> True
    cp if cp == 0xA802 -> True
    cp if cp == 0xA806 -> True
    cp if cp == 0xA80B -> True
    cp if cp >= 0xA825 && cp <= 0xA826 -> True
    cp if cp == 0xA82C -> True
    cp if cp >= 0xA8C4 && cp <= 0xA8C5 -> True
    cp if cp >= 0xA8E0 && cp <= 0xA8F1 -> True
    cp if cp == 0xA8FF -> True
    cp if cp >= 0xA926 && cp <= 0xA92D -> True
    cp if cp >= 0xA947 && cp <= 0xA951 -> True
    cp if cp >= 0xA980 && cp <= 0xA982 -> True
    cp if cp == 0xA9B3 -> True
    cp if cp >= 0xA9B6 && cp <= 0xA9B9 -> True
    cp if cp >= 0xA9BC && cp <= 0xA9BD -> True
    cp if cp == 0xA9E5 -> True
    cp if cp >= 0xAA29 && cp <= 0xAA2E -> True
    cp if cp >= 0xAA31 && cp <= 0xAA32 -> True
    cp if cp >= 0xAA35 && cp <= 0xAA36 -> True
    cp if cp == 0xAA43 -> True
    cp if cp == 0xAA4C -> True
    cp if cp == 0xAA7C -> True
    cp if cp == 0xAAB0 -> True
    cp if cp >= 0xAAB2 && cp <= 0xAAB4 -> True
    cp if cp >= 0xAAB7 && cp <= 0xAAB8 -> True
    cp if cp >= 0xAABE && cp <= 0xAABF -> True
    cp if cp == 0xAAC1 -> True
    cp if cp >= 0xAAEC && cp <= 0xAAED -> True
    cp if cp == 0xAAF6 -> True
    cp if cp == 0xABE5 -> True
    cp if cp == 0xABE8 -> True
    cp if cp == 0xABED -> True
    cp if cp == 0xFB1E -> True
    cp if cp >= 0xFE00 && cp <= 0xFE0F -> True
    cp if cp >= 0xFE20 && cp <= 0xFE2F -> True
    cp if cp == 0xFEFF -> True
    cp if cp >= 0xFFF9 && cp <= 0xFFFB -> True
    cp if cp == 0x101FD -> True
    cp if cp == 0x102E0 -> True
    cp if cp >= 0x10376 && cp <= 0x1037A -> True
    cp if cp >= 0x10A01 && cp <= 0x10A03 -> True
    cp if cp >= 0x10A05 && cp <= 0x10A06 -> True
    cp if cp >= 0x10A0C && cp <= 0x10A0F -> True
    cp if cp >= 0x10A38 && cp <= 0x10A3A -> True
    cp if cp == 0x10A3F -> True
    cp if cp >= 0x10AE5 && cp <= 0x10AE6 -> True
    cp if cp >= 0x10D24 && cp <= 0x10D27 -> True
    cp if cp >= 0x10D69 && cp <= 0x10D6D -> True
    cp if cp >= 0x10EAB && cp <= 0x10EAC -> True
    cp if cp >= 0x10EFC && cp <= 0x10EFF -> True
    cp if cp >= 0x10F46 && cp <= 0x10F50 -> True
    cp if cp >= 0x10F82 && cp <= 0x10F85 -> True
    cp if cp == 0x11001 -> True
    cp if cp >= 0x11038 && cp <= 0x11046 -> True
    cp if cp == 0x11070 -> True
    cp if cp >= 0x11073 && cp <= 0x11074 -> True
    cp if cp >= 0x1107F && cp <= 0x11081 -> True
    cp if cp >= 0x110B3 && cp <= 0x110B6 -> True
    cp if cp >= 0x110B9 && cp <= 0x110BA -> True
    cp if cp == 0x110C2 -> True
    cp if cp >= 0x11100 && cp <= 0x11102 -> True
    cp if cp >= 0x11127 && cp <= 0x1112B -> True
    cp if cp >= 0x1112D && cp <= 0x11134 -> True
    cp if cp == 0x11173 -> True
    cp if cp >= 0x11180 && cp <= 0x11181 -> True
    cp if cp >= 0x111B6 && cp <= 0x111BE -> True
    cp if cp >= 0x111C9 && cp <= 0x111CC -> True
    cp if cp == 0x111CF -> True
    cp if cp >= 0x1122F && cp <= 0x11231 -> True
    cp if cp == 0x11234 -> True
    cp if cp >= 0x11236 && cp <= 0x11237 -> True
    cp if cp == 0x1123E -> True
    cp if cp == 0x11241 -> True
    cp if cp == 0x112DF -> True
    cp if cp >= 0x112E3 && cp <= 0x112EA -> True
    cp if cp >= 0x11300 && cp <= 0x11301 -> True
    cp if cp >= 0x1133B && cp <= 0x1133C -> True
    cp if cp == 0x11340 -> True
    cp if cp >= 0x11366 && cp <= 0x1136C -> True
    cp if cp >= 0x11370 && cp <= 0x11374 -> True
    cp if cp >= 0x113BB && cp <= 0x113C0 -> True
    cp if cp == 0x113CE -> True
    cp if cp == 0x113D0 -> True
    cp if cp == 0x113D2 -> True
    cp if cp >= 0x113E1 && cp <= 0x113E2 -> True
    cp if cp >= 0x11438 && cp <= 0x1143F -> True
    cp if cp >= 0x11442 && cp <= 0x11444 -> True
    cp if cp == 0x11446 -> True
    cp if cp == 0x1145E -> True
    cp if cp >= 0x114B3 && cp <= 0x114B8 -> True
    cp if cp == 0x114BA -> True
    cp if cp >= 0x114BF && cp <= 0x114C0 -> True
    cp if cp >= 0x114C2 && cp <= 0x114C3 -> True
    cp if cp >= 0x115B2 && cp <= 0x115B5 -> True
    cp if cp >= 0x115BC && cp <= 0x115BD -> True
    cp if cp >= 0x115BF && cp <= 0x115C0 -> True
    cp if cp >= 0x115DC && cp <= 0x115DD -> True
    cp if cp >= 0x11633 && cp <= 0x1163A -> True
    cp if cp == 0x1163D -> True
    cp if cp >= 0x1163F && cp <= 0x11640 -> True
    cp if cp == 0x116AB -> True
    cp if cp == 0x116AD -> True
    cp if cp >= 0x116B0 && cp <= 0x116B5 -> True
    cp if cp == 0x116B7 -> True
    cp if cp == 0x1171D -> True
    cp if cp == 0x1171F -> True
    cp if cp >= 0x11722 && cp <= 0x11725 -> True
    cp if cp >= 0x11727 && cp <= 0x1172B -> True
    cp if cp >= 0x1182F && cp <= 0x11837 -> True
    cp if cp >= 0x11839 && cp <= 0x1183A -> True
    cp if cp >= 0x1193B && cp <= 0x1193C -> True
    cp if cp == 0x1193E -> True
    cp if cp == 0x11943 -> True
    cp if cp >= 0x119D4 && cp <= 0x119D7 -> True
    cp if cp >= 0x119DA && cp <= 0x119DB -> True
    cp if cp == 0x119E0 -> True
    cp if cp >= 0x11A01 && cp <= 0x11A0A -> True
    cp if cp >= 0x11A33 && cp <= 0x11A38 -> True
    cp if cp >= 0x11A3B && cp <= 0x11A3E -> True
    cp if cp == 0x11A47 -> True
    cp if cp >= 0x11A51 && cp <= 0x11A56 -> True
    cp if cp >= 0x11A59 && cp <= 0x11A5B -> True
    cp if cp >= 0x11A8A && cp <= 0x11A96 -> True
    cp if cp >= 0x11A98 && cp <= 0x11A99 -> True
    cp if cp >= 0x11C30 && cp <= 0x11C36 -> True
    cp if cp >= 0x11C38 && cp <= 0x11C3D -> True
    cp if cp == 0x11C3F -> True
    cp if cp >= 0x11C92 && cp <= 0x11CA7 -> True
    cp if cp >= 0x11CAA && cp <= 0x11CB0 -> True
    cp if cp >= 0x11CB2 && cp <= 0x11CB3 -> True
    cp if cp >= 0x11CB5 && cp <= 0x11CB6 -> True
    cp if cp >= 0x11D31 && cp <= 0x11D36 -> True
    cp if cp == 0x11D3A -> True
    cp if cp >= 0x11D3C && cp <= 0x11D3D -> True
    cp if cp >= 0x11D3F && cp <= 0x11D45 -> True
    cp if cp == 0x11D47 -> True
    cp if cp >= 0x11D90 && cp <= 0x11D91 -> True
    cp if cp == 0x11D95 -> True
    cp if cp == 0x11D97 -> True
    cp if cp >= 0x11EF3 && cp <= 0x11EF4 -> True
    cp if cp >= 0x11F00 && cp <= 0x11F01 -> True
    cp if cp >= 0x11F36 && cp <= 0x11F3A -> True
    cp if cp == 0x11F40 -> True
    cp if cp == 0x11F42 -> True
    cp if cp == 0x11F5A -> True
    cp if cp >= 0x13430 && cp <= 0x1343F -> True
    cp if cp == 0x13440 -> True
    cp if cp >= 0x13447 && cp <= 0x13455 -> True
    cp if cp >= 0x1611E && cp <= 0x16129 -> True
    cp if cp >= 0x1612D && cp <= 0x1612F -> True
    cp if cp >= 0x16AF0 && cp <= 0x16AF4 -> True
    cp if cp >= 0x16B30 && cp <= 0x16B36 -> True
    cp if cp == 0x16F4F -> True
    cp if cp >= 0x16F8F && cp <= 0x16F92 -> True
    cp if cp == 0x16FE4 -> True
    cp if cp >= 0x1BC9D && cp <= 0x1BC9E -> True
    cp if cp >= 0x1BCA0 && cp <= 0x1BCA3 -> True
    cp if cp >= 0x1CF00 && cp <= 0x1CF2D -> True
    cp if cp >= 0x1CF30 && cp <= 0x1CF46 -> True
    cp if cp >= 0x1D167 && cp <= 0x1D169 -> True
    cp if cp >= 0x1D173 && cp <= 0x1D17A -> True
    cp if cp >= 0x1D17B && cp <= 0x1D182 -> True
    cp if cp >= 0x1D185 && cp <= 0x1D18B -> True
    cp if cp >= 0x1D1AA && cp <= 0x1D1AD -> True
    cp if cp >= 0x1D242 && cp <= 0x1D244 -> True
    cp if cp >= 0x1DA00 && cp <= 0x1DA36 -> True
    cp if cp >= 0x1DA3B && cp <= 0x1DA6C -> True
    cp if cp == 0x1DA75 -> True
    cp if cp == 0x1DA84 -> True
    cp if cp >= 0x1DA9B && cp <= 0x1DA9F -> True
    cp if cp >= 0x1DAA1 && cp <= 0x1DAAF -> True
    cp if cp >= 0x1E000 && cp <= 0x1E006 -> True
    cp if cp >= 0x1E008 && cp <= 0x1E018 -> True
    cp if cp >= 0x1E01B && cp <= 0x1E021 -> True
    cp if cp >= 0x1E023 && cp <= 0x1E024 -> True
    cp if cp >= 0x1E026 && cp <= 0x1E02A -> True
    cp if cp == 0x1E08F -> True
    cp if cp >= 0x1E130 && cp <= 0x1E136 -> True
    cp if cp == 0x1E2AE -> True
    cp if cp >= 0x1E2EC && cp <= 0x1E2EF -> True
    cp if cp >= 0x1E4EC && cp <= 0x1E4EF -> True
    cp if cp >= 0x1E5EE && cp <= 0x1E5EF -> True
    cp if cp >= 0x1E8D0 && cp <= 0x1E8D6 -> True
    cp if cp >= 0x1E944 && cp <= 0x1E94A -> True
    cp if cp == 0x1E94B -> True
    cp if cp == 0xE0001 -> True
    cp if cp >= 0xE0020 && cp <= 0xE007F -> True
    cp if cp >= 0xE0100 && cp <= 0xE01EF -> True
    _ -> False
  }
}

pub fn in_hiragana_katakana_han_script(codepoint: Int) -> Bool {
  case codepoint {
    cp if cp >= 0x3041 && cp <= 0x3096 -> True
    cp if cp >= 0x309D && cp <= 0x309E -> True
    cp if cp == 0x309F -> True
    cp if cp >= 0x1B001 && cp <= 0x1B11F -> True
    cp if cp == 0x1B132 -> True
    cp if cp >= 0x1B150 && cp <= 0x1B152 -> True
    cp if cp == 0x1F200 -> True
    cp if cp >= 0x30A1 && cp <= 0x30FA -> True
    cp if cp >= 0x30FD && cp <= 0x30FE -> True
    cp if cp == 0x30FF -> True
    cp if cp >= 0x31F0 && cp <= 0x31FF -> True
    cp if cp >= 0x32D0 && cp <= 0x32FE -> True
    cp if cp >= 0x3300 && cp <= 0x3357 -> True
    cp if cp >= 0xFF66 && cp <= 0xFF6F -> True
    cp if cp >= 0xFF71 && cp <= 0xFF9D -> True
    cp if cp >= 0x1AFF0 && cp <= 0x1AFF3 -> True
    cp if cp >= 0x1AFF5 && cp <= 0x1AFFB -> True
    cp if cp >= 0x1AFFD && cp <= 0x1AFFE -> True
    cp if cp == 0x1B000 -> True
    cp if cp >= 0x1B120 && cp <= 0x1B122 -> True
    cp if cp == 0x1B155 -> True
    cp if cp >= 0x1B164 && cp <= 0x1B167 -> True
    cp if cp >= 0x2E80 && cp <= 0x2E99 -> True
    cp if cp >= 0x2E9B && cp <= 0x2EF3 -> True
    cp if cp >= 0x2F00 && cp <= 0x2FD5 -> True
    cp if cp == 0x3005 -> True
    cp if cp == 0x3007 -> True
    cp if cp >= 0x3021 && cp <= 0x3029 -> True
    cp if cp >= 0x3038 && cp <= 0x303A -> True
    cp if cp == 0x303B -> True
    cp if cp >= 0x3400 && cp <= 0x4DBF -> True
    cp if cp >= 0x4E00 && cp <= 0x9FFF -> True
    cp if cp >= 0xF900 && cp <= 0xFA6D -> True
    cp if cp >= 0xFA70 && cp <= 0xFAD9 -> True
    cp if cp == 0x16FE2 -> True
    cp if cp == 0x16FE3 -> True
    cp if cp >= 0x16FF0 && cp <= 0x16FF1 -> True
    cp if cp >= 0x20000 && cp <= 0x2A6DF -> True
    cp if cp >= 0x2A700 && cp <= 0x2B739 -> True
    cp if cp >= 0x2B740 && cp <= 0x2B81D -> True
    cp if cp >= 0x2B820 && cp <= 0x2CEA1 -> True
    cp if cp >= 0x2CEB0 && cp <= 0x2EBE0 -> True
    cp if cp >= 0x2EBF0 && cp <= 0x2EE5D -> True
    cp if cp >= 0x2F800 && cp <= 0x2FA1D -> True
    cp if cp >= 0x30000 && cp <= 0x3134A -> True
    cp if cp >= 0x31350 && cp <= 0x323AF -> True
    _ -> False
  }
}

pub fn in_uncategorized(codepoint: Int) -> Bool {
  case codepoint {
    cp if cp >= 0x0378 && cp <= 0x0379 -> True
    cp if cp >= 0x0380 && cp <= 0x0383 -> True
    cp if cp == 0x038B -> True
    cp if cp == 0x038D -> True
    cp if cp == 0x03A2 -> True
    cp if cp == 0x0530 -> True
    cp if cp >= 0x0557 && cp <= 0x0558 -> True
    cp if cp >= 0x058B && cp <= 0x058C -> True
    cp if cp == 0x0590 -> True
    cp if cp >= 0x05C8 && cp <= 0x05CF -> True
    cp if cp >= 0x05EB && cp <= 0x05EE -> True
    cp if cp >= 0x05F5 && cp <= 0x05FF -> True
    cp if cp == 0x070E -> True
    cp if cp >= 0x074B && cp <= 0x074C -> True
    cp if cp >= 0x07B2 && cp <= 0x07BF -> True
    cp if cp >= 0x07FB && cp <= 0x07FC -> True
    cp if cp >= 0x082E && cp <= 0x082F -> True
    cp if cp == 0x083F -> True
    cp if cp >= 0x085C && cp <= 0x085D -> True
    cp if cp == 0x085F -> True
    cp if cp >= 0x086B && cp <= 0x086F -> True
    cp if cp == 0x088F -> True
    cp if cp >= 0x0892 && cp <= 0x0896 -> True
    cp if cp == 0x0984 -> True
    cp if cp >= 0x098D && cp <= 0x098E -> True
    cp if cp >= 0x0991 && cp <= 0x0992 -> True
    cp if cp == 0x09A9 -> True
    cp if cp == 0x09B1 -> True
    cp if cp >= 0x09B3 && cp <= 0x09B5 -> True
    cp if cp >= 0x09BA && cp <= 0x09BB -> True
    cp if cp >= 0x09C5 && cp <= 0x09C6 -> True
    cp if cp >= 0x09C9 && cp <= 0x09CA -> True
    cp if cp >= 0x09CF && cp <= 0x09D6 -> True
    cp if cp >= 0x09D8 && cp <= 0x09DB -> True
    cp if cp == 0x09DE -> True
    cp if cp >= 0x09E4 && cp <= 0x09E5 -> True
    cp if cp >= 0x09FF && cp <= 0x0A00 -> True
    cp if cp == 0x0A04 -> True
    cp if cp >= 0x0A0B && cp <= 0x0A0E -> True
    cp if cp >= 0x0A11 && cp <= 0x0A12 -> True
    cp if cp == 0x0A29 -> True
    cp if cp == 0x0A31 -> True
    cp if cp == 0x0A34 -> True
    cp if cp == 0x0A37 -> True
    cp if cp >= 0x0A3A && cp <= 0x0A3B -> True
    cp if cp == 0x0A3D -> True
    cp if cp >= 0x0A43 && cp <= 0x0A46 -> True
    cp if cp >= 0x0A49 && cp <= 0x0A4A -> True
    cp if cp >= 0x0A4E && cp <= 0x0A50 -> True
    cp if cp >= 0x0A52 && cp <= 0x0A58 -> True
    cp if cp == 0x0A5D -> True
    cp if cp >= 0x0A5F && cp <= 0x0A65 -> True
    cp if cp >= 0x0A77 && cp <= 0x0A80 -> True
    cp if cp == 0x0A84 -> True
    cp if cp == 0x0A8E -> True
    cp if cp == 0x0A92 -> True
    cp if cp == 0x0AA9 -> True
    cp if cp == 0x0AB1 -> True
    cp if cp == 0x0AB4 -> True
    cp if cp >= 0x0ABA && cp <= 0x0ABB -> True
    cp if cp == 0x0AC6 -> True
    cp if cp == 0x0ACA -> True
    cp if cp >= 0x0ACE && cp <= 0x0ACF -> True
    cp if cp >= 0x0AD1 && cp <= 0x0ADF -> True
    cp if cp >= 0x0AE4 && cp <= 0x0AE5 -> True
    cp if cp >= 0x0AF2 && cp <= 0x0AF8 -> True
    cp if cp == 0x0B00 -> True
    cp if cp == 0x0B04 -> True
    cp if cp >= 0x0B0D && cp <= 0x0B0E -> True
    cp if cp >= 0x0B11 && cp <= 0x0B12 -> True
    cp if cp == 0x0B29 -> True
    cp if cp == 0x0B31 -> True
    cp if cp == 0x0B34 -> True
    cp if cp >= 0x0B3A && cp <= 0x0B3B -> True
    cp if cp >= 0x0B45 && cp <= 0x0B46 -> True
    cp if cp >= 0x0B49 && cp <= 0x0B4A -> True
    cp if cp >= 0x0B4E && cp <= 0x0B54 -> True
    cp if cp >= 0x0B58 && cp <= 0x0B5B -> True
    cp if cp == 0x0B5E -> True
    cp if cp >= 0x0B64 && cp <= 0x0B65 -> True
    cp if cp >= 0x0B78 && cp <= 0x0B81 -> True
    cp if cp == 0x0B84 -> True
    cp if cp >= 0x0B8B && cp <= 0x0B8D -> True
    cp if cp == 0x0B91 -> True
    cp if cp >= 0x0B96 && cp <= 0x0B98 -> True
    cp if cp == 0x0B9B -> True
    cp if cp == 0x0B9D -> True
    cp if cp >= 0x0BA0 && cp <= 0x0BA2 -> True
    cp if cp >= 0x0BA5 && cp <= 0x0BA7 -> True
    cp if cp >= 0x0BAB && cp <= 0x0BAD -> True
    cp if cp >= 0x0BBA && cp <= 0x0BBD -> True
    cp if cp >= 0x0BC3 && cp <= 0x0BC5 -> True
    cp if cp == 0x0BC9 -> True
    cp if cp >= 0x0BCE && cp <= 0x0BCF -> True
    cp if cp >= 0x0BD1 && cp <= 0x0BD6 -> True
    cp if cp >= 0x0BD8 && cp <= 0x0BE5 -> True
    cp if cp >= 0x0BFB && cp <= 0x0BFF -> True
    cp if cp == 0x0C0D -> True
    cp if cp == 0x0C11 -> True
    cp if cp == 0x0C29 -> True
    cp if cp >= 0x0C3A && cp <= 0x0C3B -> True
    cp if cp == 0x0C45 -> True
    cp if cp == 0x0C49 -> True
    cp if cp >= 0x0C4E && cp <= 0x0C54 -> True
    cp if cp == 0x0C57 -> True
    cp if cp >= 0x0C5B && cp <= 0x0C5C -> True
    cp if cp >= 0x0C5E && cp <= 0x0C5F -> True
    cp if cp >= 0x0C64 && cp <= 0x0C65 -> True
    cp if cp >= 0x0C70 && cp <= 0x0C76 -> True
    cp if cp == 0x0C8D -> True
    cp if cp == 0x0C91 -> True
    cp if cp == 0x0CA9 -> True
    cp if cp == 0x0CB4 -> True
    cp if cp >= 0x0CBA && cp <= 0x0CBB -> True
    cp if cp == 0x0CC5 -> True
    cp if cp == 0x0CC9 -> True
    cp if cp >= 0x0CCE && cp <= 0x0CD4 -> True
    cp if cp >= 0x0CD7 && cp <= 0x0CDC -> True
    cp if cp == 0x0CDF -> True
    cp if cp >= 0x0CE4 && cp <= 0x0CE5 -> True
    cp if cp == 0x0CF0 -> True
    cp if cp >= 0x0CF4 && cp <= 0x0CFF -> True
    cp if cp == 0x0D0D -> True
    cp if cp == 0x0D11 -> True
    cp if cp == 0x0D45 -> True
    cp if cp == 0x0D49 -> True
    cp if cp >= 0x0D50 && cp <= 0x0D53 -> True
    cp if cp >= 0x0D64 && cp <= 0x0D65 -> True
    cp if cp == 0x0D80 -> True
    cp if cp == 0x0D84 -> True
    cp if cp >= 0x0D97 && cp <= 0x0D99 -> True
    cp if cp == 0x0DB2 -> True
    cp if cp == 0x0DBC -> True
    cp if cp >= 0x0DBE && cp <= 0x0DBF -> True
    cp if cp >= 0x0DC7 && cp <= 0x0DC9 -> True
    cp if cp >= 0x0DCB && cp <= 0x0DCE -> True
    cp if cp == 0x0DD5 -> True
    cp if cp == 0x0DD7 -> True
    cp if cp >= 0x0DE0 && cp <= 0x0DE5 -> True
    cp if cp >= 0x0DF0 && cp <= 0x0DF1 -> True
    cp if cp >= 0x0DF5 && cp <= 0x0E00 -> True
    cp if cp >= 0x0E3B && cp <= 0x0E3E -> True
    cp if cp >= 0x0E5C && cp <= 0x0E80 -> True
    cp if cp == 0x0E83 -> True
    cp if cp == 0x0E85 -> True
    cp if cp == 0x0E8B -> True
    cp if cp == 0x0EA4 -> True
    cp if cp == 0x0EA6 -> True
    cp if cp >= 0x0EBE && cp <= 0x0EBF -> True
    cp if cp == 0x0EC5 -> True
    cp if cp == 0x0EC7 -> True
    cp if cp == 0x0ECF -> True
    cp if cp >= 0x0EDA && cp <= 0x0EDB -> True
    cp if cp >= 0x0EE0 && cp <= 0x0EFF -> True
    cp if cp == 0x0F48 -> True
    cp if cp >= 0x0F6D && cp <= 0x0F70 -> True
    cp if cp == 0x0F98 -> True
    cp if cp == 0x0FBD -> True
    cp if cp == 0x0FCD -> True
    cp if cp >= 0x0FDB && cp <= 0x0FFF -> True
    cp if cp == 0x10C6 -> True
    cp if cp >= 0x10C8 && cp <= 0x10CC -> True
    cp if cp >= 0x10CE && cp <= 0x10CF -> True
    cp if cp == 0x1249 -> True
    cp if cp >= 0x124E && cp <= 0x124F -> True
    cp if cp == 0x1257 -> True
    cp if cp == 0x1259 -> True
    cp if cp >= 0x125E && cp <= 0x125F -> True
    cp if cp == 0x1289 -> True
    cp if cp >= 0x128E && cp <= 0x128F -> True
    cp if cp == 0x12B1 -> True
    cp if cp >= 0x12B6 && cp <= 0x12B7 -> True
    cp if cp == 0x12BF -> True
    cp if cp == 0x12C1 -> True
    cp if cp >= 0x12C6 && cp <= 0x12C7 -> True
    cp if cp == 0x12D7 -> True
    cp if cp == 0x1311 -> True
    cp if cp >= 0x1316 && cp <= 0x1317 -> True
    cp if cp >= 0x135B && cp <= 0x135C -> True
    cp if cp >= 0x137D && cp <= 0x137F -> True
    cp if cp >= 0x139A && cp <= 0x139F -> True
    cp if cp >= 0x13F6 && cp <= 0x13F7 -> True
    cp if cp >= 0x13FE && cp <= 0x13FF -> True
    cp if cp >= 0x169D && cp <= 0x169F -> True
    cp if cp >= 0x16F9 && cp <= 0x16FF -> True
    cp if cp >= 0x1716 && cp <= 0x171E -> True
    cp if cp >= 0x1737 && cp <= 0x173F -> True
    cp if cp >= 0x1754 && cp <= 0x175F -> True
    cp if cp == 0x176D -> True
    cp if cp == 0x1771 -> True
    cp if cp >= 0x1774 && cp <= 0x177F -> True
    cp if cp >= 0x17DE && cp <= 0x17DF -> True
    cp if cp >= 0x17EA && cp <= 0x17EF -> True
    cp if cp >= 0x17FA && cp <= 0x17FF -> True
    cp if cp >= 0x181A && cp <= 0x181F -> True
    cp if cp >= 0x1879 && cp <= 0x187F -> True
    cp if cp >= 0x18AB && cp <= 0x18AF -> True
    cp if cp >= 0x18F6 && cp <= 0x18FF -> True
    cp if cp == 0x191F -> True
    cp if cp >= 0x192C && cp <= 0x192F -> True
    cp if cp >= 0x193C && cp <= 0x193F -> True
    cp if cp >= 0x1941 && cp <= 0x1943 -> True
    cp if cp >= 0x196E && cp <= 0x196F -> True
    cp if cp >= 0x1975 && cp <= 0x197F -> True
    cp if cp >= 0x19AC && cp <= 0x19AF -> True
    cp if cp >= 0x19CA && cp <= 0x19CF -> True
    cp if cp >= 0x19DB && cp <= 0x19DD -> True
    cp if cp >= 0x1A1C && cp <= 0x1A1D -> True
    cp if cp == 0x1A5F -> True
    cp if cp >= 0x1A7D && cp <= 0x1A7E -> True
    cp if cp >= 0x1A8A && cp <= 0x1A8F -> True
    cp if cp >= 0x1A9A && cp <= 0x1A9F -> True
    cp if cp >= 0x1AAE && cp <= 0x1AAF -> True
    cp if cp >= 0x1ACF && cp <= 0x1AFF -> True
    cp if cp == 0x1B4D -> True
    cp if cp >= 0x1BF4 && cp <= 0x1BFB -> True
    cp if cp >= 0x1C38 && cp <= 0x1C3A -> True
    cp if cp >= 0x1C4A && cp <= 0x1C4C -> True
    cp if cp >= 0x1C8B && cp <= 0x1C8F -> True
    cp if cp >= 0x1CBB && cp <= 0x1CBC -> True
    cp if cp >= 0x1CC8 && cp <= 0x1CCF -> True
    cp if cp >= 0x1CFB && cp <= 0x1CFF -> True
    cp if cp >= 0x1F16 && cp <= 0x1F17 -> True
    cp if cp >= 0x1F1E && cp <= 0x1F1F -> True
    cp if cp >= 0x1F46 && cp <= 0x1F47 -> True
    cp if cp >= 0x1F4E && cp <= 0x1F4F -> True
    cp if cp == 0x1F58 -> True
    cp if cp == 0x1F5A -> True
    cp if cp == 0x1F5C -> True
    cp if cp == 0x1F5E -> True
    cp if cp >= 0x1F7E && cp <= 0x1F7F -> True
    cp if cp == 0x1FB5 -> True
    cp if cp == 0x1FC5 -> True
    cp if cp >= 0x1FD4 && cp <= 0x1FD5 -> True
    cp if cp == 0x1FDC -> True
    cp if cp >= 0x1FF0 && cp <= 0x1FF1 -> True
    cp if cp == 0x1FF5 -> True
    cp if cp == 0x1FFF -> True
    cp if cp == 0x2065 -> True
    cp if cp >= 0x2072 && cp <= 0x2073 -> True
    cp if cp == 0x208F -> True
    cp if cp >= 0x209D && cp <= 0x209F -> True
    cp if cp >= 0x20C1 && cp <= 0x20CF -> True
    cp if cp >= 0x20F1 && cp <= 0x20FF -> True
    cp if cp >= 0x218C && cp <= 0x218F -> True
    cp if cp >= 0x242A && cp <= 0x243F -> True
    cp if cp >= 0x244B && cp <= 0x245F -> True
    cp if cp >= 0x2B74 && cp <= 0x2B75 -> True
    cp if cp == 0x2B96 -> True
    cp if cp >= 0x2CF4 && cp <= 0x2CF8 -> True
    cp if cp == 0x2D26 -> True
    cp if cp >= 0x2D28 && cp <= 0x2D2C -> True
    cp if cp >= 0x2D2E && cp <= 0x2D2F -> True
    cp if cp >= 0x2D68 && cp <= 0x2D6E -> True
    cp if cp >= 0x2D71 && cp <= 0x2D7E -> True
    cp if cp >= 0x2D97 && cp <= 0x2D9F -> True
    cp if cp == 0x2DA7 -> True
    cp if cp == 0x2DAF -> True
    cp if cp == 0x2DB7 -> True
    cp if cp == 0x2DBF -> True
    cp if cp == 0x2DC7 -> True
    cp if cp == 0x2DCF -> True
    cp if cp == 0x2DD7 -> True
    cp if cp == 0x2DDF -> True
    cp if cp >= 0x2E5E && cp <= 0x2E7F -> True
    cp if cp == 0x2E9A -> True
    cp if cp >= 0x2EF4 && cp <= 0x2EFF -> True
    cp if cp >= 0x2FD6 && cp <= 0x2FEF -> True
    cp if cp == 0x3040 -> True
    cp if cp >= 0x3097 && cp <= 0x3098 -> True
    cp if cp >= 0x3100 && cp <= 0x3104 -> True
    cp if cp == 0x3130 -> True
    cp if cp == 0x318F -> True
    cp if cp >= 0x31E6 && cp <= 0x31EE -> True
    cp if cp == 0x321F -> True
    cp if cp >= 0xA48D && cp <= 0xA48F -> True
    cp if cp >= 0xA4C7 && cp <= 0xA4CF -> True
    cp if cp >= 0xA62C && cp <= 0xA63F -> True
    cp if cp >= 0xA6F8 && cp <= 0xA6FF -> True
    cp if cp >= 0xA7CE && cp <= 0xA7CF -> True
    cp if cp == 0xA7D2 -> True
    cp if cp == 0xA7D4 -> True
    cp if cp >= 0xA7DD && cp <= 0xA7F1 -> True
    cp if cp >= 0xA82D && cp <= 0xA82F -> True
    cp if cp >= 0xA83A && cp <= 0xA83F -> True
    cp if cp >= 0xA878 && cp <= 0xA87F -> True
    cp if cp >= 0xA8C6 && cp <= 0xA8CD -> True
    cp if cp >= 0xA8DA && cp <= 0xA8DF -> True
    cp if cp >= 0xA954 && cp <= 0xA95E -> True
    cp if cp >= 0xA97D && cp <= 0xA97F -> True
    cp if cp == 0xA9CE -> True
    cp if cp >= 0xA9DA && cp <= 0xA9DD -> True
    cp if cp == 0xA9FF -> True
    cp if cp >= 0xAA37 && cp <= 0xAA3F -> True
    cp if cp >= 0xAA4E && cp <= 0xAA4F -> True
    cp if cp >= 0xAA5A && cp <= 0xAA5B -> True
    cp if cp >= 0xAAC3 && cp <= 0xAADA -> True
    cp if cp >= 0xAAF7 && cp <= 0xAB00 -> True
    cp if cp >= 0xAB07 && cp <= 0xAB08 -> True
    cp if cp >= 0xAB0F && cp <= 0xAB10 -> True
    cp if cp >= 0xAB17 && cp <= 0xAB1F -> True
    cp if cp == 0xAB27 -> True
    cp if cp == 0xAB2F -> True
    cp if cp >= 0xAB6C && cp <= 0xAB6F -> True
    cp if cp >= 0xABEE && cp <= 0xABEF -> True
    cp if cp >= 0xABFA && cp <= 0xABFF -> True
    cp if cp >= 0xD7A4 && cp <= 0xD7AF -> True
    cp if cp >= 0xD7C7 && cp <= 0xD7CA -> True
    cp if cp >= 0xD7FC && cp <= 0xD7FF -> True
    cp if cp >= 0xFA6E && cp <= 0xFA6F -> True
    cp if cp >= 0xFADA && cp <= 0xFAFF -> True
    cp if cp >= 0xFB07 && cp <= 0xFB12 -> True
    cp if cp >= 0xFB18 && cp <= 0xFB1C -> True
    cp if cp == 0xFB37 -> True
    cp if cp == 0xFB3D -> True
    cp if cp == 0xFB3F -> True
    cp if cp == 0xFB42 -> True
    cp if cp == 0xFB45 -> True
    cp if cp >= 0xFBC3 && cp <= 0xFBD2 -> True
    cp if cp >= 0xFD90 && cp <= 0xFD91 -> True
    cp if cp >= 0xFDC8 && cp <= 0xFDCE -> True
    cp if cp >= 0xFDD0 && cp <= 0xFDEF -> True
    cp if cp >= 0xFE1A && cp <= 0xFE1F -> True
    cp if cp == 0xFE53 -> True
    cp if cp == 0xFE67 -> True
    cp if cp >= 0xFE6C && cp <= 0xFE6F -> True
    cp if cp == 0xFE75 -> True
    cp if cp >= 0xFEFD && cp <= 0xFEFE -> True
    cp if cp == 0xFF00 -> True
    cp if cp >= 0xFFBF && cp <= 0xFFC1 -> True
    cp if cp >= 0xFFC8 && cp <= 0xFFC9 -> True
    cp if cp >= 0xFFD0 && cp <= 0xFFD1 -> True
    cp if cp >= 0xFFD8 && cp <= 0xFFD9 -> True
    cp if cp >= 0xFFDD && cp <= 0xFFDF -> True
    cp if cp == 0xFFE7 -> True
    cp if cp >= 0xFFEF && cp <= 0xFFF8 -> True
    cp if cp >= 0xFFFE && cp <= 0xFFFF -> True
    cp if cp == 0x1000C -> True
    cp if cp == 0x10027 -> True
    cp if cp == 0x1003B -> True
    cp if cp == 0x1003E -> True
    cp if cp >= 0x1004E && cp <= 0x1004F -> True
    cp if cp >= 0x1005E && cp <= 0x1007F -> True
    cp if cp >= 0x100FB && cp <= 0x100FF -> True
    cp if cp >= 0x10103 && cp <= 0x10106 -> True
    cp if cp >= 0x10134 && cp <= 0x10136 -> True
    cp if cp == 0x1018F -> True
    cp if cp >= 0x1019D && cp <= 0x1019F -> True
    cp if cp >= 0x101A1 && cp <= 0x101CF -> True
    cp if cp >= 0x101FE && cp <= 0x1027F -> True
    cp if cp >= 0x1029D && cp <= 0x1029F -> True
    cp if cp >= 0x102D1 && cp <= 0x102DF -> True
    cp if cp >= 0x102FC && cp <= 0x102FF -> True
    cp if cp >= 0x10324 && cp <= 0x1032C -> True
    cp if cp >= 0x1034B && cp <= 0x1034F -> True
    cp if cp >= 0x1037B && cp <= 0x1037F -> True
    cp if cp == 0x1039E -> True
    cp if cp >= 0x103C4 && cp <= 0x103C7 -> True
    cp if cp >= 0x103D6 && cp <= 0x103FF -> True
    cp if cp >= 0x1049E && cp <= 0x1049F -> True
    cp if cp >= 0x104AA && cp <= 0x104AF -> True
    cp if cp >= 0x104D4 && cp <= 0x104D7 -> True
    cp if cp >= 0x104FC && cp <= 0x104FF -> True
    cp if cp >= 0x10528 && cp <= 0x1052F -> True
    cp if cp >= 0x10564 && cp <= 0x1056E -> True
    cp if cp == 0x1057B -> True
    cp if cp == 0x1058B -> True
    cp if cp == 0x10593 -> True
    cp if cp == 0x10596 -> True
    cp if cp == 0x105A2 -> True
    cp if cp == 0x105B2 -> True
    cp if cp == 0x105BA -> True
    cp if cp >= 0x105BD && cp <= 0x105BF -> True
    cp if cp >= 0x105F4 && cp <= 0x105FF -> True
    cp if cp >= 0x10737 && cp <= 0x1073F -> True
    cp if cp >= 0x10756 && cp <= 0x1075F -> True
    cp if cp >= 0x10768 && cp <= 0x1077F -> True
    cp if cp == 0x10786 -> True
    cp if cp == 0x107B1 -> True
    cp if cp >= 0x107BB && cp <= 0x107FF -> True
    cp if cp >= 0x10806 && cp <= 0x10807 -> True
    cp if cp == 0x10809 -> True
    cp if cp == 0x10836 -> True
    cp if cp >= 0x10839 && cp <= 0x1083B -> True
    cp if cp >= 0x1083D && cp <= 0x1083E -> True
    cp if cp == 0x10856 -> True
    cp if cp >= 0x1089F && cp <= 0x108A6 -> True
    cp if cp >= 0x108B0 && cp <= 0x108DF -> True
    cp if cp == 0x108F3 -> True
    cp if cp >= 0x108F6 && cp <= 0x108FA -> True
    cp if cp >= 0x1091C && cp <= 0x1091E -> True
    cp if cp >= 0x1093A && cp <= 0x1093E -> True
    cp if cp >= 0x10940 && cp <= 0x1097F -> True
    cp if cp >= 0x109B8 && cp <= 0x109BB -> True
    cp if cp >= 0x109D0 && cp <= 0x109D1 -> True
    cp if cp == 0x10A04 -> True
    cp if cp >= 0x10A07 && cp <= 0x10A0B -> True
    cp if cp == 0x10A14 -> True
    cp if cp == 0x10A18 -> True
    cp if cp >= 0x10A36 && cp <= 0x10A37 -> True
    cp if cp >= 0x10A3B && cp <= 0x10A3E -> True
    cp if cp >= 0x10A49 && cp <= 0x10A4F -> True
    cp if cp >= 0x10A59 && cp <= 0x10A5F -> True
    cp if cp >= 0x10AA0 && cp <= 0x10ABF -> True
    cp if cp >= 0x10AE7 && cp <= 0x10AEA -> True
    cp if cp >= 0x10AF7 && cp <= 0x10AFF -> True
    cp if cp >= 0x10B36 && cp <= 0x10B38 -> True
    cp if cp >= 0x10B56 && cp <= 0x10B57 -> True
    cp if cp >= 0x10B73 && cp <= 0x10B77 -> True
    cp if cp >= 0x10B92 && cp <= 0x10B98 -> True
    cp if cp >= 0x10B9D && cp <= 0x10BA8 -> True
    cp if cp >= 0x10BB0 && cp <= 0x10BFF -> True
    cp if cp >= 0x10C49 && cp <= 0x10C7F -> True
    cp if cp >= 0x10CB3 && cp <= 0x10CBF -> True
    cp if cp >= 0x10CF3 && cp <= 0x10CF9 -> True
    cp if cp >= 0x10D28 && cp <= 0x10D2F -> True
    cp if cp >= 0x10D3A && cp <= 0x10D3F -> True
    cp if cp >= 0x10D66 && cp <= 0x10D68 -> True
    cp if cp >= 0x10D86 && cp <= 0x10D8D -> True
    cp if cp >= 0x10D90 && cp <= 0x10E5F -> True
    cp if cp == 0x10E7F -> True
    cp if cp == 0x10EAA -> True
    cp if cp >= 0x10EAE && cp <= 0x10EAF -> True
    cp if cp >= 0x10EB2 && cp <= 0x10EC1 -> True
    cp if cp >= 0x10EC5 && cp <= 0x10EFB -> True
    cp if cp >= 0x10F28 && cp <= 0x10F2F -> True
    cp if cp >= 0x10F5A && cp <= 0x10F6F -> True
    cp if cp >= 0x10F8A && cp <= 0x10FAF -> True
    cp if cp >= 0x10FCC && cp <= 0x10FDF -> True
    cp if cp >= 0x10FF7 && cp <= 0x10FFF -> True
    cp if cp >= 0x1104E && cp <= 0x11051 -> True
    cp if cp >= 0x11076 && cp <= 0x1107E -> True
    cp if cp >= 0x110C3 && cp <= 0x110CC -> True
    cp if cp >= 0x110CE && cp <= 0x110CF -> True
    cp if cp >= 0x110E9 && cp <= 0x110EF -> True
    cp if cp >= 0x110FA && cp <= 0x110FF -> True
    cp if cp == 0x11135 -> True
    cp if cp >= 0x11148 && cp <= 0x1114F -> True
    cp if cp >= 0x11177 && cp <= 0x1117F -> True
    cp if cp == 0x111E0 -> True
    cp if cp >= 0x111F5 && cp <= 0x111FF -> True
    cp if cp == 0x11212 -> True
    cp if cp >= 0x11242 && cp <= 0x1127F -> True
    cp if cp == 0x11287 -> True
    cp if cp == 0x11289 -> True
    cp if cp == 0x1128E -> True
    cp if cp == 0x1129E -> True
    cp if cp >= 0x112AA && cp <= 0x112AF -> True
    cp if cp >= 0x112EB && cp <= 0x112EF -> True
    cp if cp >= 0x112FA && cp <= 0x112FF -> True
    cp if cp == 0x11304 -> True
    cp if cp >= 0x1130D && cp <= 0x1130E -> True
    cp if cp >= 0x11311 && cp <= 0x11312 -> True
    cp if cp == 0x11329 -> True
    cp if cp == 0x11331 -> True
    cp if cp == 0x11334 -> True
    cp if cp == 0x1133A -> True
    cp if cp >= 0x11345 && cp <= 0x11346 -> True
    cp if cp >= 0x11349 && cp <= 0x1134A -> True
    cp if cp >= 0x1134E && cp <= 0x1134F -> True
    cp if cp >= 0x11351 && cp <= 0x11356 -> True
    cp if cp >= 0x11358 && cp <= 0x1135C -> True
    cp if cp >= 0x11364 && cp <= 0x11365 -> True
    cp if cp >= 0x1136D && cp <= 0x1136F -> True
    cp if cp >= 0x11375 && cp <= 0x1137F -> True
    cp if cp == 0x1138A -> True
    cp if cp >= 0x1138C && cp <= 0x1138D -> True
    cp if cp == 0x1138F -> True
    cp if cp == 0x113B6 -> True
    cp if cp == 0x113C1 -> True
    cp if cp >= 0x113C3 && cp <= 0x113C4 -> True
    cp if cp == 0x113C6 -> True
    cp if cp == 0x113CB -> True
    cp if cp == 0x113D6 -> True
    cp if cp >= 0x113D9 && cp <= 0x113E0 -> True
    cp if cp >= 0x113E3 && cp <= 0x113FF -> True
    cp if cp == 0x1145C -> True
    cp if cp >= 0x11462 && cp <= 0x1147F -> True
    cp if cp >= 0x114C8 && cp <= 0x114CF -> True
    cp if cp >= 0x114DA && cp <= 0x1157F -> True
    cp if cp >= 0x115B6 && cp <= 0x115B7 -> True
    cp if cp >= 0x115DE && cp <= 0x115FF -> True
    cp if cp >= 0x11645 && cp <= 0x1164F -> True
    cp if cp >= 0x1165A && cp <= 0x1165F -> True
    cp if cp >= 0x1166D && cp <= 0x1167F -> True
    cp if cp >= 0x116BA && cp <= 0x116BF -> True
    cp if cp >= 0x116CA && cp <= 0x116CF -> True
    cp if cp >= 0x116E4 && cp <= 0x116FF -> True
    cp if cp >= 0x1171B && cp <= 0x1171C -> True
    cp if cp >= 0x1172C && cp <= 0x1172F -> True
    cp if cp >= 0x11747 && cp <= 0x117FF -> True
    cp if cp >= 0x1183C && cp <= 0x1189F -> True
    cp if cp >= 0x118F3 && cp <= 0x118FE -> True
    cp if cp >= 0x11907 && cp <= 0x11908 -> True
    cp if cp >= 0x1190A && cp <= 0x1190B -> True
    cp if cp == 0x11914 -> True
    cp if cp == 0x11917 -> True
    cp if cp == 0x11936 -> True
    cp if cp >= 0x11939 && cp <= 0x1193A -> True
    cp if cp >= 0x11947 && cp <= 0x1194F -> True
    cp if cp >= 0x1195A && cp <= 0x1199F -> True
    cp if cp >= 0x119A8 && cp <= 0x119A9 -> True
    cp if cp >= 0x119D8 && cp <= 0x119D9 -> True
    cp if cp >= 0x119E5 && cp <= 0x119FF -> True
    cp if cp >= 0x11A48 && cp <= 0x11A4F -> True
    cp if cp >= 0x11AA3 && cp <= 0x11AAF -> True
    cp if cp >= 0x11AF9 && cp <= 0x11AFF -> True
    cp if cp >= 0x11B0A && cp <= 0x11BBF -> True
    cp if cp >= 0x11BE2 && cp <= 0x11BEF -> True
    cp if cp >= 0x11BFA && cp <= 0x11BFF -> True
    cp if cp == 0x11C09 -> True
    cp if cp == 0x11C37 -> True
    cp if cp >= 0x11C46 && cp <= 0x11C4F -> True
    cp if cp >= 0x11C6D && cp <= 0x11C6F -> True
    cp if cp >= 0x11C90 && cp <= 0x11C91 -> True
    cp if cp == 0x11CA8 -> True
    cp if cp >= 0x11CB7 && cp <= 0x11CFF -> True
    cp if cp == 0x11D07 -> True
    cp if cp == 0x11D0A -> True
    cp if cp >= 0x11D37 && cp <= 0x11D39 -> True
    cp if cp == 0x11D3B -> True
    cp if cp == 0x11D3E -> True
    cp if cp >= 0x11D48 && cp <= 0x11D4F -> True
    cp if cp >= 0x11D5A && cp <= 0x11D5F -> True
    cp if cp == 0x11D66 -> True
    cp if cp == 0x11D69 -> True
    cp if cp == 0x11D8F -> True
    cp if cp == 0x11D92 -> True
    cp if cp >= 0x11D99 && cp <= 0x11D9F -> True
    cp if cp >= 0x11DAA && cp <= 0x11EDF -> True
    cp if cp >= 0x11EF9 && cp <= 0x11EFF -> True
    cp if cp == 0x11F11 -> True
    cp if cp >= 0x11F3B && cp <= 0x11F3D -> True
    cp if cp >= 0x11F5B && cp <= 0x11FAF -> True
    cp if cp >= 0x11FB1 && cp <= 0x11FBF -> True
    cp if cp >= 0x11FF2 && cp <= 0x11FFE -> True
    cp if cp >= 0x1239A && cp <= 0x123FF -> True
    cp if cp == 0x1246F -> True
    cp if cp >= 0x12475 && cp <= 0x1247F -> True
    cp if cp >= 0x12544 && cp <= 0x12F8F -> True
    cp if cp >= 0x12FF3 && cp <= 0x12FFF -> True
    cp if cp >= 0x13456 && cp <= 0x1345F -> True
    cp if cp >= 0x143FB && cp <= 0x143FF -> True
    cp if cp >= 0x14647 && cp <= 0x160FF -> True
    cp if cp >= 0x1613A && cp <= 0x167FF -> True
    cp if cp >= 0x16A39 && cp <= 0x16A3F -> True
    cp if cp == 0x16A5F -> True
    cp if cp >= 0x16A6A && cp <= 0x16A6D -> True
    cp if cp == 0x16ABF -> True
    cp if cp >= 0x16ACA && cp <= 0x16ACF -> True
    cp if cp >= 0x16AEE && cp <= 0x16AEF -> True
    cp if cp >= 0x16AF6 && cp <= 0x16AFF -> True
    cp if cp >= 0x16B46 && cp <= 0x16B4F -> True
    cp if cp == 0x16B5A -> True
    cp if cp == 0x16B62 -> True
    cp if cp >= 0x16B78 && cp <= 0x16B7C -> True
    cp if cp >= 0x16B90 && cp <= 0x16D3F -> True
    cp if cp >= 0x16D7A && cp <= 0x16E3F -> True
    cp if cp >= 0x16E9B && cp <= 0x16EFF -> True
    cp if cp >= 0x16F4B && cp <= 0x16F4E -> True
    cp if cp >= 0x16F88 && cp <= 0x16F8E -> True
    cp if cp >= 0x16FA0 && cp <= 0x16FDF -> True
    cp if cp >= 0x16FE5 && cp <= 0x16FEF -> True
    cp if cp >= 0x16FF2 && cp <= 0x16FFF -> True
    cp if cp >= 0x187F8 && cp <= 0x187FF -> True
    cp if cp >= 0x18CD6 && cp <= 0x18CFE -> True
    cp if cp >= 0x18D09 && cp <= 0x1AFEF -> True
    cp if cp == 0x1AFF4 -> True
    cp if cp == 0x1AFFC -> True
    cp if cp == 0x1AFFF -> True
    cp if cp >= 0x1B123 && cp <= 0x1B131 -> True
    cp if cp >= 0x1B133 && cp <= 0x1B14F -> True
    cp if cp >= 0x1B153 && cp <= 0x1B154 -> True
    cp if cp >= 0x1B156 && cp <= 0x1B163 -> True
    cp if cp >= 0x1B168 && cp <= 0x1B16F -> True
    cp if cp >= 0x1B2FC && cp <= 0x1BBFF -> True
    cp if cp >= 0x1BC6B && cp <= 0x1BC6F -> True
    cp if cp >= 0x1BC7D && cp <= 0x1BC7F -> True
    cp if cp >= 0x1BC89 && cp <= 0x1BC8F -> True
    cp if cp >= 0x1BC9A && cp <= 0x1BC9B -> True
    cp if cp >= 0x1BCA4 && cp <= 0x1CBFF -> True
    cp if cp >= 0x1CCFA && cp <= 0x1CCFF -> True
    cp if cp >= 0x1CEB4 && cp <= 0x1CEFF -> True
    cp if cp >= 0x1CF2E && cp <= 0x1CF2F -> True
    cp if cp >= 0x1CF47 && cp <= 0x1CF4F -> True
    cp if cp >= 0x1CFC4 && cp <= 0x1CFFF -> True
    cp if cp >= 0x1D0F6 && cp <= 0x1D0FF -> True
    cp if cp >= 0x1D127 && cp <= 0x1D128 -> True
    cp if cp >= 0x1D1EB && cp <= 0x1D1FF -> True
    cp if cp >= 0x1D246 && cp <= 0x1D2BF -> True
    cp if cp >= 0x1D2D4 && cp <= 0x1D2DF -> True
    cp if cp >= 0x1D2F4 && cp <= 0x1D2FF -> True
    cp if cp >= 0x1D357 && cp <= 0x1D35F -> True
    cp if cp >= 0x1D379 && cp <= 0x1D3FF -> True
    cp if cp == 0x1D455 -> True
    cp if cp == 0x1D49D -> True
    cp if cp >= 0x1D4A0 && cp <= 0x1D4A1 -> True
    cp if cp >= 0x1D4A3 && cp <= 0x1D4A4 -> True
    cp if cp >= 0x1D4A7 && cp <= 0x1D4A8 -> True
    cp if cp == 0x1D4AD -> True
    cp if cp == 0x1D4BA -> True
    cp if cp == 0x1D4BC -> True
    cp if cp == 0x1D4C4 -> True
    cp if cp == 0x1D506 -> True
    cp if cp >= 0x1D50B && cp <= 0x1D50C -> True
    cp if cp == 0x1D515 -> True
    cp if cp == 0x1D51D -> True
    cp if cp == 0x1D53A -> True
    cp if cp == 0x1D53F -> True
    cp if cp == 0x1D545 -> True
    cp if cp >= 0x1D547 && cp <= 0x1D549 -> True
    cp if cp == 0x1D551 -> True
    cp if cp >= 0x1D6A6 && cp <= 0x1D6A7 -> True
    cp if cp >= 0x1D7CC && cp <= 0x1D7CD -> True
    cp if cp >= 0x1DA8C && cp <= 0x1DA9A -> True
    cp if cp == 0x1DAA0 -> True
    cp if cp >= 0x1DAB0 && cp <= 0x1DEFF -> True
    cp if cp >= 0x1DF1F && cp <= 0x1DF24 -> True
    cp if cp >= 0x1DF2B && cp <= 0x1DFFF -> True
    cp if cp == 0x1E007 -> True
    cp if cp >= 0x1E019 && cp <= 0x1E01A -> True
    cp if cp == 0x1E022 -> True
    cp if cp == 0x1E025 -> True
    cp if cp >= 0x1E02B && cp <= 0x1E02F -> True
    cp if cp >= 0x1E06E && cp <= 0x1E08E -> True
    cp if cp >= 0x1E090 && cp <= 0x1E0FF -> True
    cp if cp >= 0x1E12D && cp <= 0x1E12F -> True
    cp if cp >= 0x1E13E && cp <= 0x1E13F -> True
    cp if cp >= 0x1E14A && cp <= 0x1E14D -> True
    cp if cp >= 0x1E150 && cp <= 0x1E28F -> True
    cp if cp >= 0x1E2AF && cp <= 0x1E2BF -> True
    cp if cp >= 0x1E2FA && cp <= 0x1E2FE -> True
    cp if cp >= 0x1E300 && cp <= 0x1E4CF -> True
    cp if cp >= 0x1E4FA && cp <= 0x1E5CF -> True
    cp if cp >= 0x1E5FB && cp <= 0x1E5FE -> True
    cp if cp >= 0x1E600 && cp <= 0x1E7DF -> True
    cp if cp == 0x1E7E7 -> True
    cp if cp == 0x1E7EC -> True
    cp if cp == 0x1E7EF -> True
    cp if cp == 0x1E7FF -> True
    cp if cp >= 0x1E8C5 && cp <= 0x1E8C6 -> True
    cp if cp >= 0x1E8D7 && cp <= 0x1E8FF -> True
    cp if cp >= 0x1E94C && cp <= 0x1E94F -> True
    cp if cp >= 0x1E95A && cp <= 0x1E95D -> True
    cp if cp >= 0x1E960 && cp <= 0x1EC70 -> True
    cp if cp >= 0x1ECB5 && cp <= 0x1ED00 -> True
    cp if cp >= 0x1ED3E && cp <= 0x1EDFF -> True
    cp if cp == 0x1EE04 -> True
    cp if cp == 0x1EE20 -> True
    cp if cp == 0x1EE23 -> True
    cp if cp >= 0x1EE25 && cp <= 0x1EE26 -> True
    cp if cp == 0x1EE28 -> True
    cp if cp == 0x1EE33 -> True
    cp if cp == 0x1EE38 -> True
    cp if cp == 0x1EE3A -> True
    cp if cp >= 0x1EE3C && cp <= 0x1EE41 -> True
    cp if cp >= 0x1EE43 && cp <= 0x1EE46 -> True
    cp if cp == 0x1EE48 -> True
    cp if cp == 0x1EE4A -> True
    cp if cp == 0x1EE4C -> True
    cp if cp == 0x1EE50 -> True
    cp if cp == 0x1EE53 -> True
    cp if cp >= 0x1EE55 && cp <= 0x1EE56 -> True
    cp if cp == 0x1EE58 -> True
    cp if cp == 0x1EE5A -> True
    cp if cp == 0x1EE5C -> True
    cp if cp == 0x1EE5E -> True
    cp if cp == 0x1EE60 -> True
    cp if cp == 0x1EE63 -> True
    cp if cp >= 0x1EE65 && cp <= 0x1EE66 -> True
    cp if cp == 0x1EE6B -> True
    cp if cp == 0x1EE73 -> True
    cp if cp == 0x1EE78 -> True
    cp if cp == 0x1EE7D -> True
    cp if cp == 0x1EE7F -> True
    cp if cp == 0x1EE8A -> True
    cp if cp >= 0x1EE9C && cp <= 0x1EEA0 -> True
    cp if cp == 0x1EEA4 -> True
    cp if cp == 0x1EEAA -> True
    cp if cp >= 0x1EEBC && cp <= 0x1EEEF -> True
    cp if cp >= 0x1EEF2 && cp <= 0x1EFFF -> True
    cp if cp >= 0x1F02C && cp <= 0x1F02F -> True
    cp if cp >= 0x1F094 && cp <= 0x1F09F -> True
    cp if cp >= 0x1F0AF && cp <= 0x1F0B0 -> True
    cp if cp == 0x1F0C0 -> True
    cp if cp == 0x1F0D0 -> True
    cp if cp >= 0x1F0F6 && cp <= 0x1F0FF -> True
    cp if cp >= 0x1F1AE && cp <= 0x1F1E5 -> True
    cp if cp >= 0x1F203 && cp <= 0x1F20F -> True
    cp if cp >= 0x1F23C && cp <= 0x1F23F -> True
    cp if cp >= 0x1F249 && cp <= 0x1F24F -> True
    cp if cp >= 0x1F252 && cp <= 0x1F25F -> True
    cp if cp >= 0x1F266 && cp <= 0x1F2FF -> True
    cp if cp >= 0x1F6D8 && cp <= 0x1F6DB -> True
    cp if cp >= 0x1F6ED && cp <= 0x1F6EF -> True
    cp if cp >= 0x1F6FD && cp <= 0x1F6FF -> True
    cp if cp >= 0x1F777 && cp <= 0x1F77A -> True
    cp if cp >= 0x1F7DA && cp <= 0x1F7DF -> True
    cp if cp >= 0x1F7EC && cp <= 0x1F7EF -> True
    cp if cp >= 0x1F7F1 && cp <= 0x1F7FF -> True
    cp if cp >= 0x1F80C && cp <= 0x1F80F -> True
    cp if cp >= 0x1F848 && cp <= 0x1F84F -> True
    cp if cp >= 0x1F85A && cp <= 0x1F85F -> True
    cp if cp >= 0x1F888 && cp <= 0x1F88F -> True
    cp if cp >= 0x1F8AE && cp <= 0x1F8AF -> True
    cp if cp >= 0x1F8BC && cp <= 0x1F8BF -> True
    cp if cp >= 0x1F8C2 && cp <= 0x1F8FF -> True
    cp if cp >= 0x1FA54 && cp <= 0x1FA5F -> True
    cp if cp >= 0x1FA6E && cp <= 0x1FA6F -> True
    cp if cp >= 0x1FA7D && cp <= 0x1FA7F -> True
    cp if cp >= 0x1FA8A && cp <= 0x1FA8E -> True
    cp if cp >= 0x1FAC7 && cp <= 0x1FACD -> True
    cp if cp >= 0x1FADD && cp <= 0x1FADE -> True
    cp if cp >= 0x1FAEA && cp <= 0x1FAEF -> True
    cp if cp >= 0x1FAF9 && cp <= 0x1FAFF -> True
    cp if cp == 0x1FB93 -> True
    cp if cp >= 0x1FBFA && cp <= 0x1FFFF -> True
    cp if cp >= 0x2A6E0 && cp <= 0x2A6FF -> True
    cp if cp >= 0x2B73A && cp <= 0x2B73F -> True
    cp if cp >= 0x2B81E && cp <= 0x2B81F -> True
    cp if cp >= 0x2CEA2 && cp <= 0x2CEAF -> True
    cp if cp >= 0x2EBE1 && cp <= 0x2EBEF -> True
    cp if cp >= 0x2EE5E && cp <= 0x2F7FF -> True
    cp if cp >= 0x2FA1E && cp <= 0x2FFFF -> True
    cp if cp >= 0x3134B && cp <= 0x3134F -> True
    cp if cp >= 0x323B0 && cp <= 0xE0000 -> True
    cp if cp >= 0xE0002 && cp <= 0xE001F -> True
    cp if cp >= 0xE0080 && cp <= 0xE00FF -> True
    cp if cp >= 0xE01F0 && cp <= 0xEFFFF -> True
    cp if cp >= 0xFFFFE && cp <= 0xFFFFF -> True
    _ -> False
  }
}

pub fn in_join_type_dual_joining(codepoint: Int) -> Bool {
  case codepoint {
    cp if cp == 0x0620 -> True
    cp if cp == 0x0626 -> True
    cp if cp == 0x0628 -> True
    cp if cp >= 0x062A && cp <= 0x062E -> True
    cp if cp >= 0x0633 && cp <= 0x063F -> True
    cp if cp >= 0x0641 && cp <= 0x0647 -> True
    cp if cp >= 0x0649 && cp <= 0x064A -> True
    cp if cp >= 0x066E && cp <= 0x066F -> True
    cp if cp >= 0x0678 && cp <= 0x0687 -> True
    cp if cp >= 0x069A && cp <= 0x06BF -> True
    cp if cp >= 0x06C1 && cp <= 0x06C2 -> True
    cp if cp == 0x06CC -> True
    cp if cp == 0x06CE -> True
    cp if cp >= 0x06D0 && cp <= 0x06D1 -> True
    cp if cp >= 0x06FA && cp <= 0x06FC -> True
    cp if cp == 0x06FF -> True
    cp if cp >= 0x0712 && cp <= 0x0714 -> True
    cp if cp >= 0x071A && cp <= 0x071D -> True
    cp if cp >= 0x071F && cp <= 0x0727 -> True
    cp if cp == 0x0729 -> True
    cp if cp == 0x072B -> True
    cp if cp >= 0x072D && cp <= 0x072E -> True
    cp if cp >= 0x074E && cp <= 0x0758 -> True
    cp if cp >= 0x075C && cp <= 0x076A -> True
    cp if cp >= 0x076D && cp <= 0x0770 -> True
    cp if cp == 0x0772 -> True
    cp if cp >= 0x0775 && cp <= 0x0777 -> True
    cp if cp >= 0x077A && cp <= 0x077F -> True
    cp if cp >= 0x07CA && cp <= 0x07EA -> True
    cp if cp >= 0x0841 && cp <= 0x0845 -> True
    cp if cp == 0x0848 -> True
    cp if cp >= 0x084A && cp <= 0x0853 -> True
    cp if cp == 0x0855 -> True
    cp if cp == 0x0860 -> True
    cp if cp >= 0x0862 && cp <= 0x0865 -> True
    cp if cp == 0x0868 -> True
    cp if cp == 0x0886 -> True
    cp if cp >= 0x0889 && cp <= 0x088D -> True
    cp if cp >= 0x08A0 && cp <= 0x08A9 -> True
    cp if cp >= 0x08AF && cp <= 0x08B0 -> True
    cp if cp >= 0x08B3 && cp <= 0x08B8 -> True
    cp if cp >= 0x08BA && cp <= 0x08C8 -> True
    cp if cp == 0x1807 -> True
    cp if cp >= 0x1820 && cp <= 0x1842 -> True
    cp if cp == 0x1843 -> True
    cp if cp >= 0x1844 && cp <= 0x1878 -> True
    cp if cp >= 0x1887 && cp <= 0x18A8 -> True
    cp if cp == 0x18AA -> True
    cp if cp >= 0xA840 && cp <= 0xA871 -> True
    cp if cp >= 0x10AC0 && cp <= 0x10AC4 -> True
    cp if cp >= 0x10AD3 && cp <= 0x10AD6 -> True
    cp if cp >= 0x10AD8 && cp <= 0x10ADC -> True
    cp if cp >= 0x10ADE && cp <= 0x10AE0 -> True
    cp if cp >= 0x10AEB && cp <= 0x10AEE -> True
    cp if cp == 0x10B80 -> True
    cp if cp == 0x10B82 -> True
    cp if cp >= 0x10B86 && cp <= 0x10B88 -> True
    cp if cp >= 0x10B8A && cp <= 0x10B8B -> True
    cp if cp == 0x10B8D -> True
    cp if cp == 0x10B90 -> True
    cp if cp >= 0x10BAD && cp <= 0x10BAE -> True
    cp if cp >= 0x10D01 && cp <= 0x10D21 -> True
    cp if cp == 0x10D23 -> True
    cp if cp >= 0x10EC3 && cp <= 0x10EC4 -> True
    cp if cp >= 0x10F30 && cp <= 0x10F32 -> True
    cp if cp >= 0x10F34 && cp <= 0x10F44 -> True
    cp if cp >= 0x10F51 && cp <= 0x10F53 -> True
    cp if cp >= 0x10F70 && cp <= 0x10F73 -> True
    cp if cp >= 0x10F76 && cp <= 0x10F81 -> True
    cp if cp == 0x10FB0 -> True
    cp if cp >= 0x10FB2 && cp <= 0x10FB3 -> True
    cp if cp == 0x10FB8 -> True
    cp if cp >= 0x10FBB && cp <= 0x10FBC -> True
    cp if cp >= 0x10FBE && cp <= 0x10FBF -> True
    cp if cp == 0x10FC1 -> True
    cp if cp == 0x10FC4 -> True
    cp if cp == 0x10FCA -> True
    cp if cp >= 0x1E900 && cp <= 0x1E943 -> True
    _ -> False
  }
}

pub fn in_join_type_right_joining(codepoint: Int) -> Bool {
  case codepoint {
    cp if cp >= 0x0622 && cp <= 0x0625 -> True
    cp if cp == 0x0627 -> True
    cp if cp == 0x0629 -> True
    cp if cp >= 0x062F && cp <= 0x0632 -> True
    cp if cp == 0x0648 -> True
    cp if cp >= 0x0671 && cp <= 0x0673 -> True
    cp if cp >= 0x0675 && cp <= 0x0677 -> True
    cp if cp >= 0x0688 && cp <= 0x0699 -> True
    cp if cp == 0x06C0 -> True
    cp if cp >= 0x06C3 && cp <= 0x06CB -> True
    cp if cp == 0x06CD -> True
    cp if cp == 0x06CF -> True
    cp if cp >= 0x06D2 && cp <= 0x06D3 -> True
    cp if cp == 0x06D5 -> True
    cp if cp >= 0x06EE && cp <= 0x06EF -> True
    cp if cp == 0x0710 -> True
    cp if cp >= 0x0715 && cp <= 0x0719 -> True
    cp if cp == 0x071E -> True
    cp if cp == 0x0728 -> True
    cp if cp == 0x072A -> True
    cp if cp == 0x072C -> True
    cp if cp == 0x072F -> True
    cp if cp == 0x074D -> True
    cp if cp >= 0x0759 && cp <= 0x075B -> True
    cp if cp >= 0x076B && cp <= 0x076C -> True
    cp if cp == 0x0771 -> True
    cp if cp >= 0x0773 && cp <= 0x0774 -> True
    cp if cp >= 0x0778 && cp <= 0x0779 -> True
    cp if cp == 0x0840 -> True
    cp if cp >= 0x0846 && cp <= 0x0847 -> True
    cp if cp == 0x0849 -> True
    cp if cp == 0x0854 -> True
    cp if cp >= 0x0856 && cp <= 0x0858 -> True
    cp if cp == 0x0867 -> True
    cp if cp >= 0x0869 && cp <= 0x086A -> True
    cp if cp >= 0x0870 && cp <= 0x0882 -> True
    cp if cp == 0x088E -> True
    cp if cp >= 0x08AA && cp <= 0x08AC -> True
    cp if cp == 0x08AE -> True
    cp if cp >= 0x08B1 && cp <= 0x08B2 -> True
    cp if cp == 0x08B9 -> True
    cp if cp == 0x10AC5 -> True
    cp if cp == 0x10AC7 -> True
    cp if cp >= 0x10AC9 && cp <= 0x10ACA -> True
    cp if cp >= 0x10ACE && cp <= 0x10AD2 -> True
    cp if cp == 0x10ADD -> True
    cp if cp == 0x10AE1 -> True
    cp if cp == 0x10AE4 -> True
    cp if cp == 0x10AEF -> True
    cp if cp == 0x10B81 -> True
    cp if cp >= 0x10B83 && cp <= 0x10B85 -> True
    cp if cp == 0x10B89 -> True
    cp if cp == 0x10B8C -> True
    cp if cp >= 0x10B8E && cp <= 0x10B8F -> True
    cp if cp == 0x10B91 -> True
    cp if cp >= 0x10BA9 && cp <= 0x10BAC -> True
    cp if cp == 0x10D22 -> True
    cp if cp == 0x10EC2 -> True
    cp if cp == 0x10F33 -> True
    cp if cp == 0x10F54 -> True
    cp if cp >= 0x10F74 && cp <= 0x10F75 -> True
    cp if cp >= 0x10FB4 && cp <= 0x10FB6 -> True
    cp if cp >= 0x10FB9 && cp <= 0x10FBA -> True
    cp if cp == 0x10FBD -> True
    cp if cp >= 0x10FC2 && cp <= 0x10FC3 -> True
    cp if cp == 0x10FC9 -> True
    _ -> False
  }
}

pub fn in_default_ignorable(codepoint: Int) -> Bool {
  case codepoint {
    cp if cp == 0x00AD -> True
    cp if cp == 0x034F -> True
    cp if cp == 0x061C -> True
    cp if cp >= 0x115F && cp <= 0x1160 -> True
    cp if cp >= 0x17B4 && cp <= 0x17B5 -> True
    cp if cp >= 0x180B && cp <= 0x180D -> True
    cp if cp == 0x180E -> True
    cp if cp == 0x180F -> True
    cp if cp >= 0x200B && cp <= 0x200F -> True
    cp if cp >= 0x202A && cp <= 0x202E -> True
    cp if cp >= 0x2060 && cp <= 0x2064 -> True
    cp if cp == 0x2065 -> True
    cp if cp >= 0x2066 && cp <= 0x206F -> True
    cp if cp == 0x3164 -> True
    cp if cp >= 0xFE00 && cp <= 0xFE0F -> True
    cp if cp == 0xFEFF -> True
    cp if cp == 0xFFA0 -> True
    cp if cp >= 0xFFF0 && cp <= 0xFFF8 -> True
    cp if cp >= 0x1BCA0 && cp <= 0x1BCA3 -> True
    cp if cp >= 0x1D173 && cp <= 0x1D17A -> True
    cp if cp == 0xE0000 -> True
    cp if cp == 0xE0001 -> True
    cp if cp >= 0xE0002 && cp <= 0xE001F -> True
    cp if cp >= 0xE0020 && cp <= 0xE007F -> True
    cp if cp >= 0xE0080 && cp <= 0xE00FF -> True
    cp if cp >= 0xE0100 && cp <= 0xE01EF -> True
    cp if cp >= 0xE01F0 && cp <= 0xE0FFF -> True
    _ -> False
  }
}

pub fn in_old_hangul_jamo(codepoint: Int) -> Bool {
  case codepoint {
    cp if cp >= 0x1100 && cp <= 0x115F -> True
    cp if cp >= 0xA960 && cp <= 0xA97C -> True
    cp if cp >= 0x1160 && cp <= 0x11A7 -> True
    cp if cp >= 0xD7B0 && cp <= 0xD7C6 -> True
    cp if cp >= 0x11A8 && cp <= 0x11FF -> True
    cp if cp >= 0xD7CB && cp <= 0xD7FB -> True
    _ -> False
  }
}

pub fn in_letter_digit(codepoint: Int) -> Bool {
  case codepoint {
    cp if cp >= 0x0041 && cp <= 0x005A -> True
    cp if cp >= 0x00C0 && cp <= 0x00D6 -> True
    cp if cp >= 0x00D8 && cp <= 0x00DE -> True
    cp if cp == 0x0100 -> True
    cp if cp == 0x0102 -> True
    cp if cp == 0x0104 -> True
    cp if cp == 0x0106 -> True
    cp if cp == 0x0108 -> True
    cp if cp == 0x010A -> True
    cp if cp == 0x010C -> True
    cp if cp == 0x010E -> True
    cp if cp == 0x0110 -> True
    cp if cp == 0x0112 -> True
    cp if cp == 0x0114 -> True
    cp if cp == 0x0116 -> True
    cp if cp == 0x0118 -> True
    cp if cp == 0x011A -> True
    cp if cp == 0x011C -> True
    cp if cp == 0x011E -> True
    cp if cp == 0x0120 -> True
    cp if cp == 0x0122 -> True
    cp if cp == 0x0124 -> True
    cp if cp == 0x0126 -> True
    cp if cp == 0x0128 -> True
    cp if cp == 0x012A -> True
    cp if cp == 0x012C -> True
    cp if cp == 0x012E -> True
    cp if cp == 0x0130 -> True
    cp if cp == 0x0132 -> True
    cp if cp == 0x0134 -> True
    cp if cp == 0x0136 -> True
    cp if cp == 0x0139 -> True
    cp if cp == 0x013B -> True
    cp if cp == 0x013D -> True
    cp if cp == 0x013F -> True
    cp if cp == 0x0141 -> True
    cp if cp == 0x0143 -> True
    cp if cp == 0x0145 -> True
    cp if cp == 0x0147 -> True
    cp if cp == 0x014A -> True
    cp if cp == 0x014C -> True
    cp if cp == 0x014E -> True
    cp if cp == 0x0150 -> True
    cp if cp == 0x0152 -> True
    cp if cp == 0x0154 -> True
    cp if cp == 0x0156 -> True
    cp if cp == 0x0158 -> True
    cp if cp == 0x015A -> True
    cp if cp == 0x015C -> True
    cp if cp == 0x015E -> True
    cp if cp == 0x0160 -> True
    cp if cp == 0x0162 -> True
    cp if cp == 0x0164 -> True
    cp if cp == 0x0166 -> True
    cp if cp == 0x0168 -> True
    cp if cp == 0x016A -> True
    cp if cp == 0x016C -> True
    cp if cp == 0x016E -> True
    cp if cp == 0x0170 -> True
    cp if cp == 0x0172 -> True
    cp if cp == 0x0174 -> True
    cp if cp == 0x0176 -> True
    cp if cp >= 0x0178 && cp <= 0x0179 -> True
    cp if cp == 0x017B -> True
    cp if cp == 0x017D -> True
    cp if cp >= 0x0181 && cp <= 0x0182 -> True
    cp if cp == 0x0184 -> True
    cp if cp >= 0x0186 && cp <= 0x0187 -> True
    cp if cp >= 0x0189 && cp <= 0x018B -> True
    cp if cp >= 0x018E && cp <= 0x0191 -> True
    cp if cp >= 0x0193 && cp <= 0x0194 -> True
    cp if cp >= 0x0196 && cp <= 0x0198 -> True
    cp if cp >= 0x019C && cp <= 0x019D -> True
    cp if cp >= 0x019F && cp <= 0x01A0 -> True
    cp if cp == 0x01A2 -> True
    cp if cp == 0x01A4 -> True
    cp if cp >= 0x01A6 && cp <= 0x01A7 -> True
    cp if cp == 0x01A9 -> True
    cp if cp == 0x01AC -> True
    cp if cp >= 0x01AE && cp <= 0x01AF -> True
    cp if cp >= 0x01B1 && cp <= 0x01B3 -> True
    cp if cp == 0x01B5 -> True
    cp if cp >= 0x01B7 && cp <= 0x01B8 -> True
    cp if cp == 0x01BC -> True
    cp if cp == 0x01C4 -> True
    cp if cp == 0x01C7 -> True
    cp if cp == 0x01CA -> True
    cp if cp == 0x01CD -> True
    cp if cp == 0x01CF -> True
    cp if cp == 0x01D1 -> True
    cp if cp == 0x01D3 -> True
    cp if cp == 0x01D5 -> True
    cp if cp == 0x01D7 -> True
    cp if cp == 0x01D9 -> True
    cp if cp == 0x01DB -> True
    cp if cp == 0x01DE -> True
    cp if cp == 0x01E0 -> True
    cp if cp == 0x01E2 -> True
    cp if cp == 0x01E4 -> True
    cp if cp == 0x01E6 -> True
    cp if cp == 0x01E8 -> True
    cp if cp == 0x01EA -> True
    cp if cp == 0x01EC -> True
    cp if cp == 0x01EE -> True
    cp if cp == 0x01F1 -> True
    cp if cp == 0x01F4 -> True
    cp if cp >= 0x01F6 && cp <= 0x01F8 -> True
    cp if cp == 0x01FA -> True
    cp if cp == 0x01FC -> True
    cp if cp == 0x01FE -> True
    cp if cp == 0x0200 -> True
    cp if cp == 0x0202 -> True
    cp if cp == 0x0204 -> True
    cp if cp == 0x0206 -> True
    cp if cp == 0x0208 -> True
    cp if cp == 0x020A -> True
    cp if cp == 0x020C -> True
    cp if cp == 0x020E -> True
    cp if cp == 0x0210 -> True
    cp if cp == 0x0212 -> True
    cp if cp == 0x0214 -> True
    cp if cp == 0x0216 -> True
    cp if cp == 0x0218 -> True
    cp if cp == 0x021A -> True
    cp if cp == 0x021C -> True
    cp if cp == 0x021E -> True
    cp if cp == 0x0220 -> True
    cp if cp == 0x0222 -> True
    cp if cp == 0x0224 -> True
    cp if cp == 0x0226 -> True
    cp if cp == 0x0228 -> True
    cp if cp == 0x022A -> True
    cp if cp == 0x022C -> True
    cp if cp == 0x022E -> True
    cp if cp == 0x0230 -> True
    cp if cp == 0x0232 -> True
    cp if cp >= 0x023A && cp <= 0x023B -> True
    cp if cp >= 0x023D && cp <= 0x023E -> True
    cp if cp == 0x0241 -> True
    cp if cp >= 0x0243 && cp <= 0x0246 -> True
    cp if cp == 0x0248 -> True
    cp if cp == 0x024A -> True
    cp if cp == 0x024C -> True
    cp if cp == 0x024E -> True
    cp if cp == 0x0370 -> True
    cp if cp == 0x0372 -> True
    cp if cp == 0x0376 -> True
    cp if cp == 0x037F -> True
    cp if cp == 0x0386 -> True
    cp if cp >= 0x0388 && cp <= 0x038A -> True
    cp if cp == 0x038C -> True
    cp if cp >= 0x038E && cp <= 0x038F -> True
    cp if cp >= 0x0391 && cp <= 0x03A1 -> True
    cp if cp >= 0x03A3 && cp <= 0x03AB -> True
    cp if cp == 0x03CF -> True
    cp if cp >= 0x03D2 && cp <= 0x03D4 -> True
    cp if cp == 0x03D8 -> True
    cp if cp == 0x03DA -> True
    cp if cp == 0x03DC -> True
    cp if cp == 0x03DE -> True
    cp if cp == 0x03E0 -> True
    cp if cp == 0x03E2 -> True
    cp if cp == 0x03E4 -> True
    cp if cp == 0x03E6 -> True
    cp if cp == 0x03E8 -> True
    cp if cp == 0x03EA -> True
    cp if cp == 0x03EC -> True
    cp if cp == 0x03EE -> True
    cp if cp == 0x03F4 -> True
    cp if cp == 0x03F7 -> True
    cp if cp >= 0x03F9 && cp <= 0x03FA -> True
    cp if cp >= 0x03FD && cp <= 0x042F -> True
    cp if cp == 0x0460 -> True
    cp if cp == 0x0462 -> True
    cp if cp == 0x0464 -> True
    cp if cp == 0x0466 -> True
    cp if cp == 0x0468 -> True
    cp if cp == 0x046A -> True
    cp if cp == 0x046C -> True
    cp if cp == 0x046E -> True
    cp if cp == 0x0470 -> True
    cp if cp == 0x0472 -> True
    cp if cp == 0x0474 -> True
    cp if cp == 0x0476 -> True
    cp if cp == 0x0478 -> True
    cp if cp == 0x047A -> True
    cp if cp == 0x047C -> True
    cp if cp == 0x047E -> True
    cp if cp == 0x0480 -> True
    cp if cp == 0x048A -> True
    cp if cp == 0x048C -> True
    cp if cp == 0x048E -> True
    cp if cp == 0x0490 -> True
    cp if cp == 0x0492 -> True
    cp if cp == 0x0494 -> True
    cp if cp == 0x0496 -> True
    cp if cp == 0x0498 -> True
    cp if cp == 0x049A -> True
    cp if cp == 0x049C -> True
    cp if cp == 0x049E -> True
    cp if cp == 0x04A0 -> True
    cp if cp == 0x04A2 -> True
    cp if cp == 0x04A4 -> True
    cp if cp == 0x04A6 -> True
    cp if cp == 0x04A8 -> True
    cp if cp == 0x04AA -> True
    cp if cp == 0x04AC -> True
    cp if cp == 0x04AE -> True
    cp if cp == 0x04B0 -> True
    cp if cp == 0x04B2 -> True
    cp if cp == 0x04B4 -> True
    cp if cp == 0x04B6 -> True
    cp if cp == 0x04B8 -> True
    cp if cp == 0x04BA -> True
    cp if cp == 0x04BC -> True
    cp if cp == 0x04BE -> True
    cp if cp >= 0x04C0 && cp <= 0x04C1 -> True
    cp if cp == 0x04C3 -> True
    cp if cp == 0x04C5 -> True
    cp if cp == 0x04C7 -> True
    cp if cp == 0x04C9 -> True
    cp if cp == 0x04CB -> True
    cp if cp == 0x04CD -> True
    cp if cp == 0x04D0 -> True
    cp if cp == 0x04D2 -> True
    cp if cp == 0x04D4 -> True
    cp if cp == 0x04D6 -> True
    cp if cp == 0x04D8 -> True
    cp if cp == 0x04DA -> True
    cp if cp == 0x04DC -> True
    cp if cp == 0x04DE -> True
    cp if cp == 0x04E0 -> True
    cp if cp == 0x04E2 -> True
    cp if cp == 0x04E4 -> True
    cp if cp == 0x04E6 -> True
    cp if cp == 0x04E8 -> True
    cp if cp == 0x04EA -> True
    cp if cp == 0x04EC -> True
    cp if cp == 0x04EE -> True
    cp if cp == 0x04F0 -> True
    cp if cp == 0x04F2 -> True
    cp if cp == 0x04F4 -> True
    cp if cp == 0x04F6 -> True
    cp if cp == 0x04F8 -> True
    cp if cp == 0x04FA -> True
    cp if cp == 0x04FC -> True
    cp if cp == 0x04FE -> True
    cp if cp == 0x0500 -> True
    cp if cp == 0x0502 -> True
    cp if cp == 0x0504 -> True
    cp if cp == 0x0506 -> True
    cp if cp == 0x0508 -> True
    cp if cp == 0x050A -> True
    cp if cp == 0x050C -> True
    cp if cp == 0x050E -> True
    cp if cp == 0x0510 -> True
    cp if cp == 0x0512 -> True
    cp if cp == 0x0514 -> True
    cp if cp == 0x0516 -> True
    cp if cp == 0x0518 -> True
    cp if cp == 0x051A -> True
    cp if cp == 0x051C -> True
    cp if cp == 0x051E -> True
    cp if cp == 0x0520 -> True
    cp if cp == 0x0522 -> True
    cp if cp == 0x0524 -> True
    cp if cp == 0x0526 -> True
    cp if cp == 0x0528 -> True
    cp if cp == 0x052A -> True
    cp if cp == 0x052C -> True
    cp if cp == 0x052E -> True
    cp if cp >= 0x0531 && cp <= 0x0556 -> True
    cp if cp >= 0x10A0 && cp <= 0x10C5 -> True
    cp if cp == 0x10C7 -> True
    cp if cp == 0x10CD -> True
    cp if cp >= 0x13A0 && cp <= 0x13F5 -> True
    cp if cp == 0x1C89 -> True
    cp if cp >= 0x1C90 && cp <= 0x1CBA -> True
    cp if cp >= 0x1CBD && cp <= 0x1CBF -> True
    cp if cp == 0x1E00 -> True
    cp if cp == 0x1E02 -> True
    cp if cp == 0x1E04 -> True
    cp if cp == 0x1E06 -> True
    cp if cp == 0x1E08 -> True
    cp if cp == 0x1E0A -> True
    cp if cp == 0x1E0C -> True
    cp if cp == 0x1E0E -> True
    cp if cp == 0x1E10 -> True
    cp if cp == 0x1E12 -> True
    cp if cp == 0x1E14 -> True
    cp if cp == 0x1E16 -> True
    cp if cp == 0x1E18 -> True
    cp if cp == 0x1E1A -> True
    cp if cp == 0x1E1C -> True
    cp if cp == 0x1E1E -> True
    cp if cp == 0x1E20 -> True
    cp if cp == 0x1E22 -> True
    cp if cp == 0x1E24 -> True
    cp if cp == 0x1E26 -> True
    cp if cp == 0x1E28 -> True
    cp if cp == 0x1E2A -> True
    cp if cp == 0x1E2C -> True
    cp if cp == 0x1E2E -> True
    cp if cp == 0x1E30 -> True
    cp if cp == 0x1E32 -> True
    cp if cp == 0x1E34 -> True
    cp if cp == 0x1E36 -> True
    cp if cp == 0x1E38 -> True
    cp if cp == 0x1E3A -> True
    cp if cp == 0x1E3C -> True
    cp if cp == 0x1E3E -> True
    cp if cp == 0x1E40 -> True
    cp if cp == 0x1E42 -> True
    cp if cp == 0x1E44 -> True
    cp if cp == 0x1E46 -> True
    cp if cp == 0x1E48 -> True
    cp if cp == 0x1E4A -> True
    cp if cp == 0x1E4C -> True
    cp if cp == 0x1E4E -> True
    cp if cp == 0x1E50 -> True
    cp if cp == 0x1E52 -> True
    cp if cp == 0x1E54 -> True
    cp if cp == 0x1E56 -> True
    cp if cp == 0x1E58 -> True
    cp if cp == 0x1E5A -> True
    cp if cp == 0x1E5C -> True
    cp if cp == 0x1E5E -> True
    cp if cp == 0x1E60 -> True
    cp if cp == 0x1E62 -> True
    cp if cp == 0x1E64 -> True
    cp if cp == 0x1E66 -> True
    cp if cp == 0x1E68 -> True
    cp if cp == 0x1E6A -> True
    cp if cp == 0x1E6C -> True
    cp if cp == 0x1E6E -> True
    cp if cp == 0x1E70 -> True
    cp if cp == 0x1E72 -> True
    cp if cp == 0x1E74 -> True
    cp if cp == 0x1E76 -> True
    cp if cp == 0x1E78 -> True
    cp if cp == 0x1E7A -> True
    cp if cp == 0x1E7C -> True
    cp if cp == 0x1E7E -> True
    cp if cp == 0x1E80 -> True
    cp if cp == 0x1E82 -> True
    cp if cp == 0x1E84 -> True
    cp if cp == 0x1E86 -> True
    cp if cp == 0x1E88 -> True
    cp if cp == 0x1E8A -> True
    cp if cp == 0x1E8C -> True
    cp if cp == 0x1E8E -> True
    cp if cp == 0x1E90 -> True
    cp if cp == 0x1E92 -> True
    cp if cp == 0x1E94 -> True
    cp if cp == 0x1E9E -> True
    cp if cp == 0x1EA0 -> True
    cp if cp == 0x1EA2 -> True
    cp if cp == 0x1EA4 -> True
    cp if cp == 0x1EA6 -> True
    cp if cp == 0x1EA8 -> True
    cp if cp == 0x1EAA -> True
    cp if cp == 0x1EAC -> True
    cp if cp == 0x1EAE -> True
    cp if cp == 0x1EB0 -> True
    cp if cp == 0x1EB2 -> True
    cp if cp == 0x1EB4 -> True
    cp if cp == 0x1EB6 -> True
    cp if cp == 0x1EB8 -> True
    cp if cp == 0x1EBA -> True
    cp if cp == 0x1EBC -> True
    cp if cp == 0x1EBE -> True
    cp if cp == 0x1EC0 -> True
    cp if cp == 0x1EC2 -> True
    cp if cp == 0x1EC4 -> True
    cp if cp == 0x1EC6 -> True
    cp if cp == 0x1EC8 -> True
    cp if cp == 0x1ECA -> True
    cp if cp == 0x1ECC -> True
    cp if cp == 0x1ECE -> True
    cp if cp == 0x1ED0 -> True
    cp if cp == 0x1ED2 -> True
    cp if cp == 0x1ED4 -> True
    cp if cp == 0x1ED6 -> True
    cp if cp == 0x1ED8 -> True
    cp if cp == 0x1EDA -> True
    cp if cp == 0x1EDC -> True
    cp if cp == 0x1EDE -> True
    cp if cp == 0x1EE0 -> True
    cp if cp == 0x1EE2 -> True
    cp if cp == 0x1EE4 -> True
    cp if cp == 0x1EE6 -> True
    cp if cp == 0x1EE8 -> True
    cp if cp == 0x1EEA -> True
    cp if cp == 0x1EEC -> True
    cp if cp == 0x1EEE -> True
    cp if cp == 0x1EF0 -> True
    cp if cp == 0x1EF2 -> True
    cp if cp == 0x1EF4 -> True
    cp if cp == 0x1EF6 -> True
    cp if cp == 0x1EF8 -> True
    cp if cp == 0x1EFA -> True
    cp if cp == 0x1EFC -> True
    cp if cp == 0x1EFE -> True
    cp if cp >= 0x1F08 && cp <= 0x1F0F -> True
    cp if cp >= 0x1F18 && cp <= 0x1F1D -> True
    cp if cp >= 0x1F28 && cp <= 0x1F2F -> True
    cp if cp >= 0x1F38 && cp <= 0x1F3F -> True
    cp if cp >= 0x1F48 && cp <= 0x1F4D -> True
    cp if cp == 0x1F59 -> True
    cp if cp == 0x1F5B -> True
    cp if cp == 0x1F5D -> True
    cp if cp == 0x1F5F -> True
    cp if cp >= 0x1F68 && cp <= 0x1F6F -> True
    cp if cp >= 0x1FB8 && cp <= 0x1FBB -> True
    cp if cp >= 0x1FC8 && cp <= 0x1FCB -> True
    cp if cp >= 0x1FD8 && cp <= 0x1FDB -> True
    cp if cp >= 0x1FE8 && cp <= 0x1FEC -> True
    cp if cp >= 0x1FF8 && cp <= 0x1FFB -> True
    cp if cp == 0x2102 -> True
    cp if cp == 0x2107 -> True
    cp if cp >= 0x210B && cp <= 0x210D -> True
    cp if cp >= 0x2110 && cp <= 0x2112 -> True
    cp if cp == 0x2115 -> True
    cp if cp >= 0x2119 && cp <= 0x211D -> True
    cp if cp == 0x2124 -> True
    cp if cp == 0x2126 -> True
    cp if cp == 0x2128 -> True
    cp if cp >= 0x212A && cp <= 0x212D -> True
    cp if cp >= 0x2130 && cp <= 0x2133 -> True
    cp if cp >= 0x213E && cp <= 0x213F -> True
    cp if cp == 0x2145 -> True
    cp if cp == 0x2183 -> True
    cp if cp >= 0x2C00 && cp <= 0x2C2F -> True
    cp if cp == 0x2C60 -> True
    cp if cp >= 0x2C62 && cp <= 0x2C64 -> True
    cp if cp == 0x2C67 -> True
    cp if cp == 0x2C69 -> True
    cp if cp == 0x2C6B -> True
    cp if cp >= 0x2C6D && cp <= 0x2C70 -> True
    cp if cp == 0x2C72 -> True
    cp if cp == 0x2C75 -> True
    cp if cp >= 0x2C7E && cp <= 0x2C80 -> True
    cp if cp == 0x2C82 -> True
    cp if cp == 0x2C84 -> True
    cp if cp == 0x2C86 -> True
    cp if cp == 0x2C88 -> True
    cp if cp == 0x2C8A -> True
    cp if cp == 0x2C8C -> True
    cp if cp == 0x2C8E -> True
    cp if cp == 0x2C90 -> True
    cp if cp == 0x2C92 -> True
    cp if cp == 0x2C94 -> True
    cp if cp == 0x2C96 -> True
    cp if cp == 0x2C98 -> True
    cp if cp == 0x2C9A -> True
    cp if cp == 0x2C9C -> True
    cp if cp == 0x2C9E -> True
    cp if cp == 0x2CA0 -> True
    cp if cp == 0x2CA2 -> True
    cp if cp == 0x2CA4 -> True
    cp if cp == 0x2CA6 -> True
    cp if cp == 0x2CA8 -> True
    cp if cp == 0x2CAA -> True
    cp if cp == 0x2CAC -> True
    cp if cp == 0x2CAE -> True
    cp if cp == 0x2CB0 -> True
    cp if cp == 0x2CB2 -> True
    cp if cp == 0x2CB4 -> True
    cp if cp == 0x2CB6 -> True
    cp if cp == 0x2CB8 -> True
    cp if cp == 0x2CBA -> True
    cp if cp == 0x2CBC -> True
    cp if cp == 0x2CBE -> True
    cp if cp == 0x2CC0 -> True
    cp if cp == 0x2CC2 -> True
    cp if cp == 0x2CC4 -> True
    cp if cp == 0x2CC6 -> True
    cp if cp == 0x2CC8 -> True
    cp if cp == 0x2CCA -> True
    cp if cp == 0x2CCC -> True
    cp if cp == 0x2CCE -> True
    cp if cp == 0x2CD0 -> True
    cp if cp == 0x2CD2 -> True
    cp if cp == 0x2CD4 -> True
    cp if cp == 0x2CD6 -> True
    cp if cp == 0x2CD8 -> True
    cp if cp == 0x2CDA -> True
    cp if cp == 0x2CDC -> True
    cp if cp == 0x2CDE -> True
    cp if cp == 0x2CE0 -> True
    cp if cp == 0x2CE2 -> True
    cp if cp == 0x2CEB -> True
    cp if cp == 0x2CED -> True
    cp if cp == 0x2CF2 -> True
    cp if cp == 0xA640 -> True
    cp if cp == 0xA642 -> True
    cp if cp == 0xA644 -> True
    cp if cp == 0xA646 -> True
    cp if cp == 0xA648 -> True
    cp if cp == 0xA64A -> True
    cp if cp == 0xA64C -> True
    cp if cp == 0xA64E -> True
    cp if cp == 0xA650 -> True
    cp if cp == 0xA652 -> True
    cp if cp == 0xA654 -> True
    cp if cp == 0xA656 -> True
    cp if cp == 0xA658 -> True
    cp if cp == 0xA65A -> True
    cp if cp == 0xA65C -> True
    cp if cp == 0xA65E -> True
    cp if cp == 0xA660 -> True
    cp if cp == 0xA662 -> True
    cp if cp == 0xA664 -> True
    cp if cp == 0xA666 -> True
    cp if cp == 0xA668 -> True
    cp if cp == 0xA66A -> True
    cp if cp == 0xA66C -> True
    cp if cp == 0xA680 -> True
    cp if cp == 0xA682 -> True
    cp if cp == 0xA684 -> True
    cp if cp == 0xA686 -> True
    cp if cp == 0xA688 -> True
    cp if cp == 0xA68A -> True
    cp if cp == 0xA68C -> True
    cp if cp == 0xA68E -> True
    cp if cp == 0xA690 -> True
    cp if cp == 0xA692 -> True
    cp if cp == 0xA694 -> True
    cp if cp == 0xA696 -> True
    cp if cp == 0xA698 -> True
    cp if cp == 0xA69A -> True
    cp if cp == 0xA722 -> True
    cp if cp == 0xA724 -> True
    cp if cp == 0xA726 -> True
    cp if cp == 0xA728 -> True
    cp if cp == 0xA72A -> True
    cp if cp == 0xA72C -> True
    cp if cp == 0xA72E -> True
    cp if cp == 0xA732 -> True
    cp if cp == 0xA734 -> True
    cp if cp == 0xA736 -> True
    cp if cp == 0xA738 -> True
    cp if cp == 0xA73A -> True
    cp if cp == 0xA73C -> True
    cp if cp == 0xA73E -> True
    cp if cp == 0xA740 -> True
    cp if cp == 0xA742 -> True
    cp if cp == 0xA744 -> True
    cp if cp == 0xA746 -> True
    cp if cp == 0xA748 -> True
    cp if cp == 0xA74A -> True
    cp if cp == 0xA74C -> True
    cp if cp == 0xA74E -> True
    cp if cp == 0xA750 -> True
    cp if cp == 0xA752 -> True
    cp if cp == 0xA754 -> True
    cp if cp == 0xA756 -> True
    cp if cp == 0xA758 -> True
    cp if cp == 0xA75A -> True
    cp if cp == 0xA75C -> True
    cp if cp == 0xA75E -> True
    cp if cp == 0xA760 -> True
    cp if cp == 0xA762 -> True
    cp if cp == 0xA764 -> True
    cp if cp == 0xA766 -> True
    cp if cp == 0xA768 -> True
    cp if cp == 0xA76A -> True
    cp if cp == 0xA76C -> True
    cp if cp == 0xA76E -> True
    cp if cp == 0xA779 -> True
    cp if cp == 0xA77B -> True
    cp if cp >= 0xA77D && cp <= 0xA77E -> True
    cp if cp == 0xA780 -> True
    cp if cp == 0xA782 -> True
    cp if cp == 0xA784 -> True
    cp if cp == 0xA786 -> True
    cp if cp == 0xA78B -> True
    cp if cp == 0xA78D -> True
    cp if cp == 0xA790 -> True
    cp if cp == 0xA792 -> True
    cp if cp == 0xA796 -> True
    cp if cp == 0xA798 -> True
    cp if cp == 0xA79A -> True
    cp if cp == 0xA79C -> True
    cp if cp == 0xA79E -> True
    cp if cp == 0xA7A0 -> True
    cp if cp == 0xA7A2 -> True
    cp if cp == 0xA7A4 -> True
    cp if cp == 0xA7A6 -> True
    cp if cp == 0xA7A8 -> True
    cp if cp >= 0xA7AA && cp <= 0xA7AE -> True
    cp if cp >= 0xA7B0 && cp <= 0xA7B4 -> True
    cp if cp == 0xA7B6 -> True
    cp if cp == 0xA7B8 -> True
    cp if cp == 0xA7BA -> True
    cp if cp == 0xA7BC -> True
    cp if cp == 0xA7BE -> True
    cp if cp == 0xA7C0 -> True
    cp if cp == 0xA7C2 -> True
    cp if cp >= 0xA7C4 && cp <= 0xA7C7 -> True
    cp if cp == 0xA7C9 -> True
    cp if cp >= 0xA7CB && cp <= 0xA7CC -> True
    cp if cp == 0xA7D0 -> True
    cp if cp == 0xA7D6 -> True
    cp if cp == 0xA7D8 -> True
    cp if cp == 0xA7DA -> True
    cp if cp == 0xA7DC -> True
    cp if cp == 0xA7F5 -> True
    cp if cp >= 0xFF21 && cp <= 0xFF3A -> True
    cp if cp >= 0x10400 && cp <= 0x10427 -> True
    cp if cp >= 0x104B0 && cp <= 0x104D3 -> True
    cp if cp >= 0x10570 && cp <= 0x1057A -> True
    cp if cp >= 0x1057C && cp <= 0x1058A -> True
    cp if cp >= 0x1058C && cp <= 0x10592 -> True
    cp if cp >= 0x10594 && cp <= 0x10595 -> True
    cp if cp >= 0x10C80 && cp <= 0x10CB2 -> True
    cp if cp >= 0x10D50 && cp <= 0x10D65 -> True
    cp if cp >= 0x118A0 && cp <= 0x118BF -> True
    cp if cp >= 0x16E40 && cp <= 0x16E5F -> True
    cp if cp >= 0x1D400 && cp <= 0x1D419 -> True
    cp if cp >= 0x1D434 && cp <= 0x1D44D -> True
    cp if cp >= 0x1D468 && cp <= 0x1D481 -> True
    cp if cp == 0x1D49C -> True
    cp if cp >= 0x1D49E && cp <= 0x1D49F -> True
    cp if cp == 0x1D4A2 -> True
    cp if cp >= 0x1D4A5 && cp <= 0x1D4A6 -> True
    cp if cp >= 0x1D4A9 && cp <= 0x1D4AC -> True
    cp if cp >= 0x1D4AE && cp <= 0x1D4B5 -> True
    cp if cp >= 0x1D4D0 && cp <= 0x1D4E9 -> True
    cp if cp >= 0x1D504 && cp <= 0x1D505 -> True
    cp if cp >= 0x1D507 && cp <= 0x1D50A -> True
    cp if cp >= 0x1D50D && cp <= 0x1D514 -> True
    cp if cp >= 0x1D516 && cp <= 0x1D51C -> True
    cp if cp >= 0x1D538 && cp <= 0x1D539 -> True
    cp if cp >= 0x1D53B && cp <= 0x1D53E -> True
    cp if cp >= 0x1D540 && cp <= 0x1D544 -> True
    cp if cp == 0x1D546 -> True
    cp if cp >= 0x1D54A && cp <= 0x1D550 -> True
    cp if cp >= 0x1D56C && cp <= 0x1D585 -> True
    cp if cp >= 0x1D5A0 && cp <= 0x1D5B9 -> True
    cp if cp >= 0x1D5D4 && cp <= 0x1D5ED -> True
    cp if cp >= 0x1D608 && cp <= 0x1D621 -> True
    cp if cp >= 0x1D63C && cp <= 0x1D655 -> True
    cp if cp >= 0x1D670 && cp <= 0x1D689 -> True
    cp if cp >= 0x1D6A8 && cp <= 0x1D6C0 -> True
    cp if cp >= 0x1D6E2 && cp <= 0x1D6FA -> True
    cp if cp >= 0x1D71C && cp <= 0x1D734 -> True
    cp if cp >= 0x1D756 && cp <= 0x1D76E -> True
    cp if cp >= 0x1D790 && cp <= 0x1D7A8 -> True
    cp if cp == 0x1D7CA -> True
    cp if cp >= 0x1E900 && cp <= 0x1E921 -> True
    cp if cp >= 0x0061 && cp <= 0x007A -> True
    cp if cp == 0x00B5 -> True
    cp if cp >= 0x00DF && cp <= 0x00F6 -> True
    cp if cp >= 0x00F8 && cp <= 0x00FF -> True
    cp if cp == 0x0101 -> True
    cp if cp == 0x0103 -> True
    cp if cp == 0x0105 -> True
    cp if cp == 0x0107 -> True
    cp if cp == 0x0109 -> True
    cp if cp == 0x010B -> True
    cp if cp == 0x010D -> True
    cp if cp == 0x010F -> True
    cp if cp == 0x0111 -> True
    cp if cp == 0x0113 -> True
    cp if cp == 0x0115 -> True
    cp if cp == 0x0117 -> True
    cp if cp == 0x0119 -> True
    cp if cp == 0x011B -> True
    cp if cp == 0x011D -> True
    cp if cp == 0x011F -> True
    cp if cp == 0x0121 -> True
    cp if cp == 0x0123 -> True
    cp if cp == 0x0125 -> True
    cp if cp == 0x0127 -> True
    cp if cp == 0x0129 -> True
    cp if cp == 0x012B -> True
    cp if cp == 0x012D -> True
    cp if cp == 0x012F -> True
    cp if cp == 0x0131 -> True
    cp if cp == 0x0133 -> True
    cp if cp == 0x0135 -> True
    cp if cp >= 0x0137 && cp <= 0x0138 -> True
    cp if cp == 0x013A -> True
    cp if cp == 0x013C -> True
    cp if cp == 0x013E -> True
    cp if cp == 0x0140 -> True
    cp if cp == 0x0142 -> True
    cp if cp == 0x0144 -> True
    cp if cp == 0x0146 -> True
    cp if cp >= 0x0148 && cp <= 0x0149 -> True
    cp if cp == 0x014B -> True
    cp if cp == 0x014D -> True
    cp if cp == 0x014F -> True
    cp if cp == 0x0151 -> True
    cp if cp == 0x0153 -> True
    cp if cp == 0x0155 -> True
    cp if cp == 0x0157 -> True
    cp if cp == 0x0159 -> True
    cp if cp == 0x015B -> True
    cp if cp == 0x015D -> True
    cp if cp == 0x015F -> True
    cp if cp == 0x0161 -> True
    cp if cp == 0x0163 -> True
    cp if cp == 0x0165 -> True
    cp if cp == 0x0167 -> True
    cp if cp == 0x0169 -> True
    cp if cp == 0x016B -> True
    cp if cp == 0x016D -> True
    cp if cp == 0x016F -> True
    cp if cp == 0x0171 -> True
    cp if cp == 0x0173 -> True
    cp if cp == 0x0175 -> True
    cp if cp == 0x0177 -> True
    cp if cp == 0x017A -> True
    cp if cp == 0x017C -> True
    cp if cp >= 0x017E && cp <= 0x0180 -> True
    cp if cp == 0x0183 -> True
    cp if cp == 0x0185 -> True
    cp if cp == 0x0188 -> True
    cp if cp >= 0x018C && cp <= 0x018D -> True
    cp if cp == 0x0192 -> True
    cp if cp == 0x0195 -> True
    cp if cp >= 0x0199 && cp <= 0x019B -> True
    cp if cp == 0x019E -> True
    cp if cp == 0x01A1 -> True
    cp if cp == 0x01A3 -> True
    cp if cp == 0x01A5 -> True
    cp if cp == 0x01A8 -> True
    cp if cp >= 0x01AA && cp <= 0x01AB -> True
    cp if cp == 0x01AD -> True
    cp if cp == 0x01B0 -> True
    cp if cp == 0x01B4 -> True
    cp if cp == 0x01B6 -> True
    cp if cp >= 0x01B9 && cp <= 0x01BA -> True
    cp if cp >= 0x01BD && cp <= 0x01BF -> True
    cp if cp == 0x01C6 -> True
    cp if cp == 0x01C9 -> True
    cp if cp == 0x01CC -> True
    cp if cp == 0x01CE -> True
    cp if cp == 0x01D0 -> True
    cp if cp == 0x01D2 -> True
    cp if cp == 0x01D4 -> True
    cp if cp == 0x01D6 -> True
    cp if cp == 0x01D8 -> True
    cp if cp == 0x01DA -> True
    cp if cp >= 0x01DC && cp <= 0x01DD -> True
    cp if cp == 0x01DF -> True
    cp if cp == 0x01E1 -> True
    cp if cp == 0x01E3 -> True
    cp if cp == 0x01E5 -> True
    cp if cp == 0x01E7 -> True
    cp if cp == 0x01E9 -> True
    cp if cp == 0x01EB -> True
    cp if cp == 0x01ED -> True
    cp if cp >= 0x01EF && cp <= 0x01F0 -> True
    cp if cp == 0x01F3 -> True
    cp if cp == 0x01F5 -> True
    cp if cp == 0x01F9 -> True
    cp if cp == 0x01FB -> True
    cp if cp == 0x01FD -> True
    cp if cp == 0x01FF -> True
    cp if cp == 0x0201 -> True
    cp if cp == 0x0203 -> True
    cp if cp == 0x0205 -> True
    cp if cp == 0x0207 -> True
    cp if cp == 0x0209 -> True
    cp if cp == 0x020B -> True
    cp if cp == 0x020D -> True
    cp if cp == 0x020F -> True
    cp if cp == 0x0211 -> True
    cp if cp == 0x0213 -> True
    cp if cp == 0x0215 -> True
    cp if cp == 0x0217 -> True
    cp if cp == 0x0219 -> True
    cp if cp == 0x021B -> True
    cp if cp == 0x021D -> True
    cp if cp == 0x021F -> True
    cp if cp == 0x0221 -> True
    cp if cp == 0x0223 -> True
    cp if cp == 0x0225 -> True
    cp if cp == 0x0227 -> True
    cp if cp == 0x0229 -> True
    cp if cp == 0x022B -> True
    cp if cp == 0x022D -> True
    cp if cp == 0x022F -> True
    cp if cp == 0x0231 -> True
    cp if cp >= 0x0233 && cp <= 0x0239 -> True
    cp if cp == 0x023C -> True
    cp if cp >= 0x023F && cp <= 0x0240 -> True
    cp if cp == 0x0242 -> True
    cp if cp == 0x0247 -> True
    cp if cp == 0x0249 -> True
    cp if cp == 0x024B -> True
    cp if cp == 0x024D -> True
    cp if cp >= 0x024F && cp <= 0x0293 -> True
    cp if cp >= 0x0295 && cp <= 0x02AF -> True
    cp if cp == 0x0371 -> True
    cp if cp == 0x0373 -> True
    cp if cp == 0x0377 -> True
    cp if cp >= 0x037B && cp <= 0x037D -> True
    cp if cp == 0x0390 -> True
    cp if cp >= 0x03AC && cp <= 0x03CE -> True
    cp if cp >= 0x03D0 && cp <= 0x03D1 -> True
    cp if cp >= 0x03D5 && cp <= 0x03D7 -> True
    cp if cp == 0x03D9 -> True
    cp if cp == 0x03DB -> True
    cp if cp == 0x03DD -> True
    cp if cp == 0x03DF -> True
    cp if cp == 0x03E1 -> True
    cp if cp == 0x03E3 -> True
    cp if cp == 0x03E5 -> True
    cp if cp == 0x03E7 -> True
    cp if cp == 0x03E9 -> True
    cp if cp == 0x03EB -> True
    cp if cp == 0x03ED -> True
    cp if cp >= 0x03EF && cp <= 0x03F3 -> True
    cp if cp == 0x03F5 -> True
    cp if cp == 0x03F8 -> True
    cp if cp >= 0x03FB && cp <= 0x03FC -> True
    cp if cp >= 0x0430 && cp <= 0x045F -> True
    cp if cp == 0x0461 -> True
    cp if cp == 0x0463 -> True
    cp if cp == 0x0465 -> True
    cp if cp == 0x0467 -> True
    cp if cp == 0x0469 -> True
    cp if cp == 0x046B -> True
    cp if cp == 0x046D -> True
    cp if cp == 0x046F -> True
    cp if cp == 0x0471 -> True
    cp if cp == 0x0473 -> True
    cp if cp == 0x0475 -> True
    cp if cp == 0x0477 -> True
    cp if cp == 0x0479 -> True
    cp if cp == 0x047B -> True
    cp if cp == 0x047D -> True
    cp if cp == 0x047F -> True
    cp if cp == 0x0481 -> True
    cp if cp == 0x048B -> True
    cp if cp == 0x048D -> True
    cp if cp == 0x048F -> True
    cp if cp == 0x0491 -> True
    cp if cp == 0x0493 -> True
    cp if cp == 0x0495 -> True
    cp if cp == 0x0497 -> True
    cp if cp == 0x0499 -> True
    cp if cp == 0x049B -> True
    cp if cp == 0x049D -> True
    cp if cp == 0x049F -> True
    cp if cp == 0x04A1 -> True
    cp if cp == 0x04A3 -> True
    cp if cp == 0x04A5 -> True
    cp if cp == 0x04A7 -> True
    cp if cp == 0x04A9 -> True
    cp if cp == 0x04AB -> True
    cp if cp == 0x04AD -> True
    cp if cp == 0x04AF -> True
    cp if cp == 0x04B1 -> True
    cp if cp == 0x04B3 -> True
    cp if cp == 0x04B5 -> True
    cp if cp == 0x04B7 -> True
    cp if cp == 0x04B9 -> True
    cp if cp == 0x04BB -> True
    cp if cp == 0x04BD -> True
    cp if cp == 0x04BF -> True
    cp if cp == 0x04C2 -> True
    cp if cp == 0x04C4 -> True
    cp if cp == 0x04C6 -> True
    cp if cp == 0x04C8 -> True
    cp if cp == 0x04CA -> True
    cp if cp == 0x04CC -> True
    cp if cp >= 0x04CE && cp <= 0x04CF -> True
    cp if cp == 0x04D1 -> True
    cp if cp == 0x04D3 -> True
    cp if cp == 0x04D5 -> True
    cp if cp == 0x04D7 -> True
    cp if cp == 0x04D9 -> True
    cp if cp == 0x04DB -> True
    cp if cp == 0x04DD -> True
    cp if cp == 0x04DF -> True
    cp if cp == 0x04E1 -> True
    cp if cp == 0x04E3 -> True
    cp if cp == 0x04E5 -> True
    cp if cp == 0x04E7 -> True
    cp if cp == 0x04E9 -> True
    cp if cp == 0x04EB -> True
    cp if cp == 0x04ED -> True
    cp if cp == 0x04EF -> True
    cp if cp == 0x04F1 -> True
    cp if cp == 0x04F3 -> True
    cp if cp == 0x04F5 -> True
    cp if cp == 0x04F7 -> True
    cp if cp == 0x04F9 -> True
    cp if cp == 0x04FB -> True
    cp if cp == 0x04FD -> True
    cp if cp == 0x04FF -> True
    cp if cp == 0x0501 -> True
    cp if cp == 0x0503 -> True
    cp if cp == 0x0505 -> True
    cp if cp == 0x0507 -> True
    cp if cp == 0x0509 -> True
    cp if cp == 0x050B -> True
    cp if cp == 0x050D -> True
    cp if cp == 0x050F -> True
    cp if cp == 0x0511 -> True
    cp if cp == 0x0513 -> True
    cp if cp == 0x0515 -> True
    cp if cp == 0x0517 -> True
    cp if cp == 0x0519 -> True
    cp if cp == 0x051B -> True
    cp if cp == 0x051D -> True
    cp if cp == 0x051F -> True
    cp if cp == 0x0521 -> True
    cp if cp == 0x0523 -> True
    cp if cp == 0x0525 -> True
    cp if cp == 0x0527 -> True
    cp if cp == 0x0529 -> True
    cp if cp == 0x052B -> True
    cp if cp == 0x052D -> True
    cp if cp == 0x052F -> True
    cp if cp >= 0x0560 && cp <= 0x0588 -> True
    cp if cp >= 0x10D0 && cp <= 0x10FA -> True
    cp if cp >= 0x10FD && cp <= 0x10FF -> True
    cp if cp >= 0x13F8 && cp <= 0x13FD -> True
    cp if cp >= 0x1C80 && cp <= 0x1C88 -> True
    cp if cp == 0x1C8A -> True
    cp if cp >= 0x1D00 && cp <= 0x1D2B -> True
    cp if cp >= 0x1D6B && cp <= 0x1D77 -> True
    cp if cp >= 0x1D79 && cp <= 0x1D9A -> True
    cp if cp == 0x1E01 -> True
    cp if cp == 0x1E03 -> True
    cp if cp == 0x1E05 -> True
    cp if cp == 0x1E07 -> True
    cp if cp == 0x1E09 -> True
    cp if cp == 0x1E0B -> True
    cp if cp == 0x1E0D -> True
    cp if cp == 0x1E0F -> True
    cp if cp == 0x1E11 -> True
    cp if cp == 0x1E13 -> True
    cp if cp == 0x1E15 -> True
    cp if cp == 0x1E17 -> True
    cp if cp == 0x1E19 -> True
    cp if cp == 0x1E1B -> True
    cp if cp == 0x1E1D -> True
    cp if cp == 0x1E1F -> True
    cp if cp == 0x1E21 -> True
    cp if cp == 0x1E23 -> True
    cp if cp == 0x1E25 -> True
    cp if cp == 0x1E27 -> True
    cp if cp == 0x1E29 -> True
    cp if cp == 0x1E2B -> True
    cp if cp == 0x1E2D -> True
    cp if cp == 0x1E2F -> True
    cp if cp == 0x1E31 -> True
    cp if cp == 0x1E33 -> True
    cp if cp == 0x1E35 -> True
    cp if cp == 0x1E37 -> True
    cp if cp == 0x1E39 -> True
    cp if cp == 0x1E3B -> True
    cp if cp == 0x1E3D -> True
    cp if cp == 0x1E3F -> True
    cp if cp == 0x1E41 -> True
    cp if cp == 0x1E43 -> True
    cp if cp == 0x1E45 -> True
    cp if cp == 0x1E47 -> True
    cp if cp == 0x1E49 -> True
    cp if cp == 0x1E4B -> True
    cp if cp == 0x1E4D -> True
    cp if cp == 0x1E4F -> True
    cp if cp == 0x1E51 -> True
    cp if cp == 0x1E53 -> True
    cp if cp == 0x1E55 -> True
    cp if cp == 0x1E57 -> True
    cp if cp == 0x1E59 -> True
    cp if cp == 0x1E5B -> True
    cp if cp == 0x1E5D -> True
    cp if cp == 0x1E5F -> True
    cp if cp == 0x1E61 -> True
    cp if cp == 0x1E63 -> True
    cp if cp == 0x1E65 -> True
    cp if cp == 0x1E67 -> True
    cp if cp == 0x1E69 -> True
    cp if cp == 0x1E6B -> True
    cp if cp == 0x1E6D -> True
    cp if cp == 0x1E6F -> True
    cp if cp == 0x1E71 -> True
    cp if cp == 0x1E73 -> True
    cp if cp == 0x1E75 -> True
    cp if cp == 0x1E77 -> True
    cp if cp == 0x1E79 -> True
    cp if cp == 0x1E7B -> True
    cp if cp == 0x1E7D -> True
    cp if cp == 0x1E7F -> True
    cp if cp == 0x1E81 -> True
    cp if cp == 0x1E83 -> True
    cp if cp == 0x1E85 -> True
    cp if cp == 0x1E87 -> True
    cp if cp == 0x1E89 -> True
    cp if cp == 0x1E8B -> True
    cp if cp == 0x1E8D -> True
    cp if cp == 0x1E8F -> True
    cp if cp == 0x1E91 -> True
    cp if cp == 0x1E93 -> True
    cp if cp >= 0x1E95 && cp <= 0x1E9D -> True
    cp if cp == 0x1E9F -> True
    cp if cp == 0x1EA1 -> True
    cp if cp == 0x1EA3 -> True
    cp if cp == 0x1EA5 -> True
    cp if cp == 0x1EA7 -> True
    cp if cp == 0x1EA9 -> True
    cp if cp == 0x1EAB -> True
    cp if cp == 0x1EAD -> True
    cp if cp == 0x1EAF -> True
    cp if cp == 0x1EB1 -> True
    cp if cp == 0x1EB3 -> True
    cp if cp == 0x1EB5 -> True
    cp if cp == 0x1EB7 -> True
    cp if cp == 0x1EB9 -> True
    cp if cp == 0x1EBB -> True
    cp if cp == 0x1EBD -> True
    cp if cp == 0x1EBF -> True
    cp if cp == 0x1EC1 -> True
    cp if cp == 0x1EC3 -> True
    cp if cp == 0x1EC5 -> True
    cp if cp == 0x1EC7 -> True
    cp if cp == 0x1EC9 -> True
    cp if cp == 0x1ECB -> True
    cp if cp == 0x1ECD -> True
    cp if cp == 0x1ECF -> True
    cp if cp == 0x1ED1 -> True
    cp if cp == 0x1ED3 -> True
    cp if cp == 0x1ED5 -> True
    cp if cp == 0x1ED7 -> True
    cp if cp == 0x1ED9 -> True
    cp if cp == 0x1EDB -> True
    cp if cp == 0x1EDD -> True
    cp if cp == 0x1EDF -> True
    cp if cp == 0x1EE1 -> True
    cp if cp == 0x1EE3 -> True
    cp if cp == 0x1EE5 -> True
    cp if cp == 0x1EE7 -> True
    cp if cp == 0x1EE9 -> True
    cp if cp == 0x1EEB -> True
    cp if cp == 0x1EED -> True
    cp if cp == 0x1EEF -> True
    cp if cp == 0x1EF1 -> True
    cp if cp == 0x1EF3 -> True
    cp if cp == 0x1EF5 -> True
    cp if cp == 0x1EF7 -> True
    cp if cp == 0x1EF9 -> True
    cp if cp == 0x1EFB -> True
    cp if cp == 0x1EFD -> True
    cp if cp >= 0x1EFF && cp <= 0x1F07 -> True
    cp if cp >= 0x1F10 && cp <= 0x1F15 -> True
    cp if cp >= 0x1F20 && cp <= 0x1F27 -> True
    cp if cp >= 0x1F30 && cp <= 0x1F37 -> True
    cp if cp >= 0x1F40 && cp <= 0x1F45 -> True
    cp if cp >= 0x1F50 && cp <= 0x1F57 -> True
    cp if cp >= 0x1F60 && cp <= 0x1F67 -> True
    cp if cp >= 0x1F70 && cp <= 0x1F7D -> True
    cp if cp >= 0x1F80 && cp <= 0x1F87 -> True
    cp if cp >= 0x1F90 && cp <= 0x1F97 -> True
    cp if cp >= 0x1FA0 && cp <= 0x1FA7 -> True
    cp if cp >= 0x1FB0 && cp <= 0x1FB4 -> True
    cp if cp >= 0x1FB6 && cp <= 0x1FB7 -> True
    cp if cp == 0x1FBE -> True
    cp if cp >= 0x1FC2 && cp <= 0x1FC4 -> True
    cp if cp >= 0x1FC6 && cp <= 0x1FC7 -> True
    cp if cp >= 0x1FD0 && cp <= 0x1FD3 -> True
    cp if cp >= 0x1FD6 && cp <= 0x1FD7 -> True
    cp if cp >= 0x1FE0 && cp <= 0x1FE7 -> True
    cp if cp >= 0x1FF2 && cp <= 0x1FF4 -> True
    cp if cp >= 0x1FF6 && cp <= 0x1FF7 -> True
    cp if cp == 0x210A -> True
    cp if cp >= 0x210E && cp <= 0x210F -> True
    cp if cp == 0x2113 -> True
    cp if cp == 0x212F -> True
    cp if cp == 0x2134 -> True
    cp if cp == 0x2139 -> True
    cp if cp >= 0x213C && cp <= 0x213D -> True
    cp if cp >= 0x2146 && cp <= 0x2149 -> True
    cp if cp == 0x214E -> True
    cp if cp == 0x2184 -> True
    cp if cp >= 0x2C30 && cp <= 0x2C5F -> True
    cp if cp == 0x2C61 -> True
    cp if cp >= 0x2C65 && cp <= 0x2C66 -> True
    cp if cp == 0x2C68 -> True
    cp if cp == 0x2C6A -> True
    cp if cp == 0x2C6C -> True
    cp if cp == 0x2C71 -> True
    cp if cp >= 0x2C73 && cp <= 0x2C74 -> True
    cp if cp >= 0x2C76 && cp <= 0x2C7B -> True
    cp if cp == 0x2C81 -> True
    cp if cp == 0x2C83 -> True
    cp if cp == 0x2C85 -> True
    cp if cp == 0x2C87 -> True
    cp if cp == 0x2C89 -> True
    cp if cp == 0x2C8B -> True
    cp if cp == 0x2C8D -> True
    cp if cp == 0x2C8F -> True
    cp if cp == 0x2C91 -> True
    cp if cp == 0x2C93 -> True
    cp if cp == 0x2C95 -> True
    cp if cp == 0x2C97 -> True
    cp if cp == 0x2C99 -> True
    cp if cp == 0x2C9B -> True
    cp if cp == 0x2C9D -> True
    cp if cp == 0x2C9F -> True
    cp if cp == 0x2CA1 -> True
    cp if cp == 0x2CA3 -> True
    cp if cp == 0x2CA5 -> True
    cp if cp == 0x2CA7 -> True
    cp if cp == 0x2CA9 -> True
    cp if cp == 0x2CAB -> True
    cp if cp == 0x2CAD -> True
    cp if cp == 0x2CAF -> True
    cp if cp == 0x2CB1 -> True
    cp if cp == 0x2CB3 -> True
    cp if cp == 0x2CB5 -> True
    cp if cp == 0x2CB7 -> True
    cp if cp == 0x2CB9 -> True
    cp if cp == 0x2CBB -> True
    cp if cp == 0x2CBD -> True
    cp if cp == 0x2CBF -> True
    cp if cp == 0x2CC1 -> True
    cp if cp == 0x2CC3 -> True
    cp if cp == 0x2CC5 -> True
    cp if cp == 0x2CC7 -> True
    cp if cp == 0x2CC9 -> True
    cp if cp == 0x2CCB -> True
    cp if cp == 0x2CCD -> True
    cp if cp == 0x2CCF -> True
    cp if cp == 0x2CD1 -> True
    cp if cp == 0x2CD3 -> True
    cp if cp == 0x2CD5 -> True
    cp if cp == 0x2CD7 -> True
    cp if cp == 0x2CD9 -> True
    cp if cp == 0x2CDB -> True
    cp if cp == 0x2CDD -> True
    cp if cp == 0x2CDF -> True
    cp if cp == 0x2CE1 -> True
    cp if cp >= 0x2CE3 && cp <= 0x2CE4 -> True
    cp if cp == 0x2CEC -> True
    cp if cp == 0x2CEE -> True
    cp if cp == 0x2CF3 -> True
    cp if cp >= 0x2D00 && cp <= 0x2D25 -> True
    cp if cp == 0x2D27 -> True
    cp if cp == 0x2D2D -> True
    cp if cp == 0xA641 -> True
    cp if cp == 0xA643 -> True
    cp if cp == 0xA645 -> True
    cp if cp == 0xA647 -> True
    cp if cp == 0xA649 -> True
    cp if cp == 0xA64B -> True
    cp if cp == 0xA64D -> True
    cp if cp == 0xA64F -> True
    cp if cp == 0xA651 -> True
    cp if cp == 0xA653 -> True
    cp if cp == 0xA655 -> True
    cp if cp == 0xA657 -> True
    cp if cp == 0xA659 -> True
    cp if cp == 0xA65B -> True
    cp if cp == 0xA65D -> True
    cp if cp == 0xA65F -> True
    cp if cp == 0xA661 -> True
    cp if cp == 0xA663 -> True
    cp if cp == 0xA665 -> True
    cp if cp == 0xA667 -> True
    cp if cp == 0xA669 -> True
    cp if cp == 0xA66B -> True
    cp if cp == 0xA66D -> True
    cp if cp == 0xA681 -> True
    cp if cp == 0xA683 -> True
    cp if cp == 0xA685 -> True
    cp if cp == 0xA687 -> True
    cp if cp == 0xA689 -> True
    cp if cp == 0xA68B -> True
    cp if cp == 0xA68D -> True
    cp if cp == 0xA68F -> True
    cp if cp == 0xA691 -> True
    cp if cp == 0xA693 -> True
    cp if cp == 0xA695 -> True
    cp if cp == 0xA697 -> True
    cp if cp == 0xA699 -> True
    cp if cp == 0xA69B -> True
    cp if cp == 0xA723 -> True
    cp if cp == 0xA725 -> True
    cp if cp == 0xA727 -> True
    cp if cp == 0xA729 -> True
    cp if cp == 0xA72B -> True
    cp if cp == 0xA72D -> True
    cp if cp >= 0xA72F && cp <= 0xA731 -> True
    cp if cp == 0xA733 -> True
    cp if cp == 0xA735 -> True
    cp if cp == 0xA737 -> True
    cp if cp == 0xA739 -> True
    cp if cp == 0xA73B -> True
    cp if cp == 0xA73D -> True
    cp if cp == 0xA73F -> True
    cp if cp == 0xA741 -> True
    cp if cp == 0xA743 -> True
    cp if cp == 0xA745 -> True
    cp if cp == 0xA747 -> True
    cp if cp == 0xA749 -> True
    cp if cp == 0xA74B -> True
    cp if cp == 0xA74D -> True
    cp if cp == 0xA74F -> True
    cp if cp == 0xA751 -> True
    cp if cp == 0xA753 -> True
    cp if cp == 0xA755 -> True
    cp if cp == 0xA757 -> True
    cp if cp == 0xA759 -> True
    cp if cp == 0xA75B -> True
    cp if cp == 0xA75D -> True
    cp if cp == 0xA75F -> True
    cp if cp == 0xA761 -> True
    cp if cp == 0xA763 -> True
    cp if cp == 0xA765 -> True
    cp if cp == 0xA767 -> True
    cp if cp == 0xA769 -> True
    cp if cp == 0xA76B -> True
    cp if cp == 0xA76D -> True
    cp if cp == 0xA76F -> True
    cp if cp >= 0xA771 && cp <= 0xA778 -> True
    cp if cp == 0xA77A -> True
    cp if cp == 0xA77C -> True
    cp if cp == 0xA77F -> True
    cp if cp == 0xA781 -> True
    cp if cp == 0xA783 -> True
    cp if cp == 0xA785 -> True
    cp if cp == 0xA787 -> True
    cp if cp == 0xA78C -> True
    cp if cp == 0xA78E -> True
    cp if cp == 0xA791 -> True
    cp if cp >= 0xA793 && cp <= 0xA795 -> True
    cp if cp == 0xA797 -> True
    cp if cp == 0xA799 -> True
    cp if cp == 0xA79B -> True
    cp if cp == 0xA79D -> True
    cp if cp == 0xA79F -> True
    cp if cp == 0xA7A1 -> True
    cp if cp == 0xA7A3 -> True
    cp if cp == 0xA7A5 -> True
    cp if cp == 0xA7A7 -> True
    cp if cp == 0xA7A9 -> True
    cp if cp == 0xA7AF -> True
    cp if cp == 0xA7B5 -> True
    cp if cp == 0xA7B7 -> True
    cp if cp == 0xA7B9 -> True
    cp if cp == 0xA7BB -> True
    cp if cp == 0xA7BD -> True
    cp if cp == 0xA7BF -> True
    cp if cp == 0xA7C1 -> True
    cp if cp == 0xA7C3 -> True
    cp if cp == 0xA7C8 -> True
    cp if cp == 0xA7CA -> True
    cp if cp == 0xA7CD -> True
    cp if cp == 0xA7D1 -> True
    cp if cp == 0xA7D3 -> True
    cp if cp == 0xA7D5 -> True
    cp if cp == 0xA7D7 -> True
    cp if cp == 0xA7D9 -> True
    cp if cp == 0xA7DB -> True
    cp if cp == 0xA7F6 -> True
    cp if cp == 0xA7FA -> True
    cp if cp >= 0xAB30 && cp <= 0xAB5A -> True
    cp if cp >= 0xAB60 && cp <= 0xAB68 -> True
    cp if cp >= 0xAB70 && cp <= 0xABBF -> True
    cp if cp >= 0xFB00 && cp <= 0xFB06 -> True
    cp if cp >= 0xFB13 && cp <= 0xFB17 -> True
    cp if cp >= 0xFF41 && cp <= 0xFF5A -> True
    cp if cp >= 0x10428 && cp <= 0x1044F -> True
    cp if cp >= 0x104D8 && cp <= 0x104FB -> True
    cp if cp >= 0x10597 && cp <= 0x105A1 -> True
    cp if cp >= 0x105A3 && cp <= 0x105B1 -> True
    cp if cp >= 0x105B3 && cp <= 0x105B9 -> True
    cp if cp >= 0x105BB && cp <= 0x105BC -> True
    cp if cp >= 0x10CC0 && cp <= 0x10CF2 -> True
    cp if cp >= 0x10D70 && cp <= 0x10D85 -> True
    cp if cp >= 0x118C0 && cp <= 0x118DF -> True
    cp if cp >= 0x16E60 && cp <= 0x16E7F -> True
    cp if cp >= 0x1D41A && cp <= 0x1D433 -> True
    cp if cp >= 0x1D44E && cp <= 0x1D454 -> True
    cp if cp >= 0x1D456 && cp <= 0x1D467 -> True
    cp if cp >= 0x1D482 && cp <= 0x1D49B -> True
    cp if cp >= 0x1D4B6 && cp <= 0x1D4B9 -> True
    cp if cp == 0x1D4BB -> True
    cp if cp >= 0x1D4BD && cp <= 0x1D4C3 -> True
    cp if cp >= 0x1D4C5 && cp <= 0x1D4CF -> True
    cp if cp >= 0x1D4EA && cp <= 0x1D503 -> True
    cp if cp >= 0x1D51E && cp <= 0x1D537 -> True
    cp if cp >= 0x1D552 && cp <= 0x1D56B -> True
    cp if cp >= 0x1D586 && cp <= 0x1D59F -> True
    cp if cp >= 0x1D5BA && cp <= 0x1D5D3 -> True
    cp if cp >= 0x1D5EE && cp <= 0x1D607 -> True
    cp if cp >= 0x1D622 && cp <= 0x1D63B -> True
    cp if cp >= 0x1D656 && cp <= 0x1D66F -> True
    cp if cp >= 0x1D68A && cp <= 0x1D6A5 -> True
    cp if cp >= 0x1D6C2 && cp <= 0x1D6DA -> True
    cp if cp >= 0x1D6DC && cp <= 0x1D6E1 -> True
    cp if cp >= 0x1D6FC && cp <= 0x1D714 -> True
    cp if cp >= 0x1D716 && cp <= 0x1D71B -> True
    cp if cp >= 0x1D736 && cp <= 0x1D74E -> True
    cp if cp >= 0x1D750 && cp <= 0x1D755 -> True
    cp if cp >= 0x1D770 && cp <= 0x1D788 -> True
    cp if cp >= 0x1D78A && cp <= 0x1D78F -> True
    cp if cp >= 0x1D7AA && cp <= 0x1D7C2 -> True
    cp if cp >= 0x1D7C4 && cp <= 0x1D7C9 -> True
    cp if cp == 0x1D7CB -> True
    cp if cp >= 0x1DF00 && cp <= 0x1DF09 -> True
    cp if cp >= 0x1DF0B && cp <= 0x1DF1E -> True
    cp if cp >= 0x1DF25 && cp <= 0x1DF2A -> True
    cp if cp >= 0x1E922 && cp <= 0x1E943 -> True
    cp if cp >= 0x02B0 && cp <= 0x02C1 -> True
    cp if cp >= 0x02C6 && cp <= 0x02D1 -> True
    cp if cp >= 0x02E0 && cp <= 0x02E4 -> True
    cp if cp == 0x02EC -> True
    cp if cp == 0x02EE -> True
    cp if cp == 0x0374 -> True
    cp if cp == 0x037A -> True
    cp if cp == 0x0559 -> True
    cp if cp == 0x0640 -> True
    cp if cp >= 0x06E5 && cp <= 0x06E6 -> True
    cp if cp >= 0x07F4 && cp <= 0x07F5 -> True
    cp if cp == 0x07FA -> True
    cp if cp == 0x081A -> True
    cp if cp == 0x0824 -> True
    cp if cp == 0x0828 -> True
    cp if cp == 0x08C9 -> True
    cp if cp == 0x0971 -> True
    cp if cp == 0x0E46 -> True
    cp if cp == 0x0EC6 -> True
    cp if cp == 0x10FC -> True
    cp if cp == 0x17D7 -> True
    cp if cp == 0x1843 -> True
    cp if cp == 0x1AA7 -> True
    cp if cp >= 0x1C78 && cp <= 0x1C7D -> True
    cp if cp >= 0x1D2C && cp <= 0x1D6A -> True
    cp if cp == 0x1D78 -> True
    cp if cp >= 0x1D9B && cp <= 0x1DBF -> True
    cp if cp == 0x2071 -> True
    cp if cp == 0x207F -> True
    cp if cp >= 0x2090 && cp <= 0x209C -> True
    cp if cp >= 0x2C7C && cp <= 0x2C7D -> True
    cp if cp == 0x2D6F -> True
    cp if cp == 0x2E2F -> True
    cp if cp == 0x3005 -> True
    cp if cp >= 0x3031 && cp <= 0x3035 -> True
    cp if cp == 0x303B -> True
    cp if cp >= 0x309D && cp <= 0x309E -> True
    cp if cp >= 0x30FC && cp <= 0x30FE -> True
    cp if cp == 0xA015 -> True
    cp if cp >= 0xA4F8 && cp <= 0xA4FD -> True
    cp if cp == 0xA60C -> True
    cp if cp == 0xA67F -> True
    cp if cp >= 0xA69C && cp <= 0xA69D -> True
    cp if cp >= 0xA717 && cp <= 0xA71F -> True
    cp if cp == 0xA770 -> True
    cp if cp == 0xA788 -> True
    cp if cp >= 0xA7F2 && cp <= 0xA7F4 -> True
    cp if cp >= 0xA7F8 && cp <= 0xA7F9 -> True
    cp if cp == 0xA9CF -> True
    cp if cp == 0xA9E6 -> True
    cp if cp == 0xAA70 -> True
    cp if cp == 0xAADD -> True
    cp if cp >= 0xAAF3 && cp <= 0xAAF4 -> True
    cp if cp >= 0xAB5C && cp <= 0xAB5F -> True
    cp if cp == 0xAB69 -> True
    cp if cp == 0xFF70 -> True
    cp if cp >= 0xFF9E && cp <= 0xFF9F -> True
    cp if cp >= 0x10780 && cp <= 0x10785 -> True
    cp if cp >= 0x10787 && cp <= 0x107B0 -> True
    cp if cp >= 0x107B2 && cp <= 0x107BA -> True
    cp if cp == 0x10D4E -> True
    cp if cp == 0x10D6F -> True
    cp if cp >= 0x16B40 && cp <= 0x16B43 -> True
    cp if cp >= 0x16D40 && cp <= 0x16D42 -> True
    cp if cp >= 0x16D6B && cp <= 0x16D6C -> True
    cp if cp >= 0x16F93 && cp <= 0x16F9F -> True
    cp if cp >= 0x16FE0 && cp <= 0x16FE1 -> True
    cp if cp == 0x16FE3 -> True
    cp if cp >= 0x1AFF0 && cp <= 0x1AFF3 -> True
    cp if cp >= 0x1AFF5 && cp <= 0x1AFFB -> True
    cp if cp >= 0x1AFFD && cp <= 0x1AFFE -> True
    cp if cp >= 0x1E030 && cp <= 0x1E06D -> True
    cp if cp >= 0x1E137 && cp <= 0x1E13D -> True
    cp if cp == 0x1E4EB -> True
    cp if cp == 0x1E94B -> True
    cp if cp == 0x00AA -> True
    cp if cp == 0x00BA -> True
    cp if cp == 0x01BB -> True
    cp if cp >= 0x01C0 && cp <= 0x01C3 -> True
    cp if cp == 0x0294 -> True
    cp if cp >= 0x05D0 && cp <= 0x05EA -> True
    cp if cp >= 0x05EF && cp <= 0x05F2 -> True
    cp if cp >= 0x0620 && cp <= 0x063F -> True
    cp if cp >= 0x0641 && cp <= 0x064A -> True
    cp if cp >= 0x066E && cp <= 0x066F -> True
    cp if cp >= 0x0671 && cp <= 0x06D3 -> True
    cp if cp == 0x06D5 -> True
    cp if cp >= 0x06EE && cp <= 0x06EF -> True
    cp if cp >= 0x06FA && cp <= 0x06FC -> True
    cp if cp == 0x06FF -> True
    cp if cp == 0x0710 -> True
    cp if cp >= 0x0712 && cp <= 0x072F -> True
    cp if cp >= 0x074D && cp <= 0x07A5 -> True
    cp if cp == 0x07B1 -> True
    cp if cp >= 0x07CA && cp <= 0x07EA -> True
    cp if cp >= 0x0800 && cp <= 0x0815 -> True
    cp if cp >= 0x0840 && cp <= 0x0858 -> True
    cp if cp >= 0x0860 && cp <= 0x086A -> True
    cp if cp >= 0x0870 && cp <= 0x0887 -> True
    cp if cp >= 0x0889 && cp <= 0x088E -> True
    cp if cp >= 0x08A0 && cp <= 0x08C8 -> True
    cp if cp >= 0x0904 && cp <= 0x0939 -> True
    cp if cp == 0x093D -> True
    cp if cp == 0x0950 -> True
    cp if cp >= 0x0958 && cp <= 0x0961 -> True
    cp if cp >= 0x0972 && cp <= 0x0980 -> True
    cp if cp >= 0x0985 && cp <= 0x098C -> True
    cp if cp >= 0x098F && cp <= 0x0990 -> True
    cp if cp >= 0x0993 && cp <= 0x09A8 -> True
    cp if cp >= 0x09AA && cp <= 0x09B0 -> True
    cp if cp == 0x09B2 -> True
    cp if cp >= 0x09B6 && cp <= 0x09B9 -> True
    cp if cp == 0x09BD -> True
    cp if cp == 0x09CE -> True
    cp if cp >= 0x09DC && cp <= 0x09DD -> True
    cp if cp >= 0x09DF && cp <= 0x09E1 -> True
    cp if cp >= 0x09F0 && cp <= 0x09F1 -> True
    cp if cp == 0x09FC -> True
    cp if cp >= 0x0A05 && cp <= 0x0A0A -> True
    cp if cp >= 0x0A0F && cp <= 0x0A10 -> True
    cp if cp >= 0x0A13 && cp <= 0x0A28 -> True
    cp if cp >= 0x0A2A && cp <= 0x0A30 -> True
    cp if cp >= 0x0A32 && cp <= 0x0A33 -> True
    cp if cp >= 0x0A35 && cp <= 0x0A36 -> True
    cp if cp >= 0x0A38 && cp <= 0x0A39 -> True
    cp if cp >= 0x0A59 && cp <= 0x0A5C -> True
    cp if cp == 0x0A5E -> True
    cp if cp >= 0x0A72 && cp <= 0x0A74 -> True
    cp if cp >= 0x0A85 && cp <= 0x0A8D -> True
    cp if cp >= 0x0A8F && cp <= 0x0A91 -> True
    cp if cp >= 0x0A93 && cp <= 0x0AA8 -> True
    cp if cp >= 0x0AAA && cp <= 0x0AB0 -> True
    cp if cp >= 0x0AB2 && cp <= 0x0AB3 -> True
    cp if cp >= 0x0AB5 && cp <= 0x0AB9 -> True
    cp if cp == 0x0ABD -> True
    cp if cp == 0x0AD0 -> True
    cp if cp >= 0x0AE0 && cp <= 0x0AE1 -> True
    cp if cp == 0x0AF9 -> True
    cp if cp >= 0x0B05 && cp <= 0x0B0C -> True
    cp if cp >= 0x0B0F && cp <= 0x0B10 -> True
    cp if cp >= 0x0B13 && cp <= 0x0B28 -> True
    cp if cp >= 0x0B2A && cp <= 0x0B30 -> True
    cp if cp >= 0x0B32 && cp <= 0x0B33 -> True
    cp if cp >= 0x0B35 && cp <= 0x0B39 -> True
    cp if cp == 0x0B3D -> True
    cp if cp >= 0x0B5C && cp <= 0x0B5D -> True
    cp if cp >= 0x0B5F && cp <= 0x0B61 -> True
    cp if cp == 0x0B71 -> True
    cp if cp == 0x0B83 -> True
    cp if cp >= 0x0B85 && cp <= 0x0B8A -> True
    cp if cp >= 0x0B8E && cp <= 0x0B90 -> True
    cp if cp >= 0x0B92 && cp <= 0x0B95 -> True
    cp if cp >= 0x0B99 && cp <= 0x0B9A -> True
    cp if cp == 0x0B9C -> True
    cp if cp >= 0x0B9E && cp <= 0x0B9F -> True
    cp if cp >= 0x0BA3 && cp <= 0x0BA4 -> True
    cp if cp >= 0x0BA8 && cp <= 0x0BAA -> True
    cp if cp >= 0x0BAE && cp <= 0x0BB9 -> True
    cp if cp == 0x0BD0 -> True
    cp if cp >= 0x0C05 && cp <= 0x0C0C -> True
    cp if cp >= 0x0C0E && cp <= 0x0C10 -> True
    cp if cp >= 0x0C12 && cp <= 0x0C28 -> True
    cp if cp >= 0x0C2A && cp <= 0x0C39 -> True
    cp if cp == 0x0C3D -> True
    cp if cp >= 0x0C58 && cp <= 0x0C5A -> True
    cp if cp == 0x0C5D -> True
    cp if cp >= 0x0C60 && cp <= 0x0C61 -> True
    cp if cp == 0x0C80 -> True
    cp if cp >= 0x0C85 && cp <= 0x0C8C -> True
    cp if cp >= 0x0C8E && cp <= 0x0C90 -> True
    cp if cp >= 0x0C92 && cp <= 0x0CA8 -> True
    cp if cp >= 0x0CAA && cp <= 0x0CB3 -> True
    cp if cp >= 0x0CB5 && cp <= 0x0CB9 -> True
    cp if cp == 0x0CBD -> True
    cp if cp >= 0x0CDD && cp <= 0x0CDE -> True
    cp if cp >= 0x0CE0 && cp <= 0x0CE1 -> True
    cp if cp >= 0x0CF1 && cp <= 0x0CF2 -> True
    cp if cp >= 0x0D04 && cp <= 0x0D0C -> True
    cp if cp >= 0x0D0E && cp <= 0x0D10 -> True
    cp if cp >= 0x0D12 && cp <= 0x0D3A -> True
    cp if cp == 0x0D3D -> True
    cp if cp == 0x0D4E -> True
    cp if cp >= 0x0D54 && cp <= 0x0D56 -> True
    cp if cp >= 0x0D5F && cp <= 0x0D61 -> True
    cp if cp >= 0x0D7A && cp <= 0x0D7F -> True
    cp if cp >= 0x0D85 && cp <= 0x0D96 -> True
    cp if cp >= 0x0D9A && cp <= 0x0DB1 -> True
    cp if cp >= 0x0DB3 && cp <= 0x0DBB -> True
    cp if cp == 0x0DBD -> True
    cp if cp >= 0x0DC0 && cp <= 0x0DC6 -> True
    cp if cp >= 0x0E01 && cp <= 0x0E30 -> True
    cp if cp >= 0x0E32 && cp <= 0x0E33 -> True
    cp if cp >= 0x0E40 && cp <= 0x0E45 -> True
    cp if cp >= 0x0E81 && cp <= 0x0E82 -> True
    cp if cp == 0x0E84 -> True
    cp if cp >= 0x0E86 && cp <= 0x0E8A -> True
    cp if cp >= 0x0E8C && cp <= 0x0EA3 -> True
    cp if cp == 0x0EA5 -> True
    cp if cp >= 0x0EA7 && cp <= 0x0EB0 -> True
    cp if cp >= 0x0EB2 && cp <= 0x0EB3 -> True
    cp if cp == 0x0EBD -> True
    cp if cp >= 0x0EC0 && cp <= 0x0EC4 -> True
    cp if cp >= 0x0EDC && cp <= 0x0EDF -> True
    cp if cp == 0x0F00 -> True
    cp if cp >= 0x0F40 && cp <= 0x0F47 -> True
    cp if cp >= 0x0F49 && cp <= 0x0F6C -> True
    cp if cp >= 0x0F88 && cp <= 0x0F8C -> True
    cp if cp >= 0x1000 && cp <= 0x102A -> True
    cp if cp == 0x103F -> True
    cp if cp >= 0x1050 && cp <= 0x1055 -> True
    cp if cp >= 0x105A && cp <= 0x105D -> True
    cp if cp == 0x1061 -> True
    cp if cp >= 0x1065 && cp <= 0x1066 -> True
    cp if cp >= 0x106E && cp <= 0x1070 -> True
    cp if cp >= 0x1075 && cp <= 0x1081 -> True
    cp if cp == 0x108E -> True
    cp if cp >= 0x1100 && cp <= 0x1248 -> True
    cp if cp >= 0x124A && cp <= 0x124D -> True
    cp if cp >= 0x1250 && cp <= 0x1256 -> True
    cp if cp == 0x1258 -> True
    cp if cp >= 0x125A && cp <= 0x125D -> True
    cp if cp >= 0x1260 && cp <= 0x1288 -> True
    cp if cp >= 0x128A && cp <= 0x128D -> True
    cp if cp >= 0x1290 && cp <= 0x12B0 -> True
    cp if cp >= 0x12B2 && cp <= 0x12B5 -> True
    cp if cp >= 0x12B8 && cp <= 0x12BE -> True
    cp if cp == 0x12C0 -> True
    cp if cp >= 0x12C2 && cp <= 0x12C5 -> True
    cp if cp >= 0x12C8 && cp <= 0x12D6 -> True
    cp if cp >= 0x12D8 && cp <= 0x1310 -> True
    cp if cp >= 0x1312 && cp <= 0x1315 -> True
    cp if cp >= 0x1318 && cp <= 0x135A -> True
    cp if cp >= 0x1380 && cp <= 0x138F -> True
    cp if cp >= 0x1401 && cp <= 0x166C -> True
    cp if cp >= 0x166F && cp <= 0x167F -> True
    cp if cp >= 0x1681 && cp <= 0x169A -> True
    cp if cp >= 0x16A0 && cp <= 0x16EA -> True
    cp if cp >= 0x16F1 && cp <= 0x16F8 -> True
    cp if cp >= 0x1700 && cp <= 0x1711 -> True
    cp if cp >= 0x171F && cp <= 0x1731 -> True
    cp if cp >= 0x1740 && cp <= 0x1751 -> True
    cp if cp >= 0x1760 && cp <= 0x176C -> True
    cp if cp >= 0x176E && cp <= 0x1770 -> True
    cp if cp >= 0x1780 && cp <= 0x17B3 -> True
    cp if cp == 0x17DC -> True
    cp if cp >= 0x1820 && cp <= 0x1842 -> True
    cp if cp >= 0x1844 && cp <= 0x1878 -> True
    cp if cp >= 0x1880 && cp <= 0x1884 -> True
    cp if cp >= 0x1887 && cp <= 0x18A8 -> True
    cp if cp == 0x18AA -> True
    cp if cp >= 0x18B0 && cp <= 0x18F5 -> True
    cp if cp >= 0x1900 && cp <= 0x191E -> True
    cp if cp >= 0x1950 && cp <= 0x196D -> True
    cp if cp >= 0x1970 && cp <= 0x1974 -> True
    cp if cp >= 0x1980 && cp <= 0x19AB -> True
    cp if cp >= 0x19B0 && cp <= 0x19C9 -> True
    cp if cp >= 0x1A00 && cp <= 0x1A16 -> True
    cp if cp >= 0x1A20 && cp <= 0x1A54 -> True
    cp if cp >= 0x1B05 && cp <= 0x1B33 -> True
    cp if cp >= 0x1B45 && cp <= 0x1B4C -> True
    cp if cp >= 0x1B83 && cp <= 0x1BA0 -> True
    cp if cp >= 0x1BAE && cp <= 0x1BAF -> True
    cp if cp >= 0x1BBA && cp <= 0x1BE5 -> True
    cp if cp >= 0x1C00 && cp <= 0x1C23 -> True
    cp if cp >= 0x1C4D && cp <= 0x1C4F -> True
    cp if cp >= 0x1C5A && cp <= 0x1C77 -> True
    cp if cp >= 0x1CE9 && cp <= 0x1CEC -> True
    cp if cp >= 0x1CEE && cp <= 0x1CF3 -> True
    cp if cp >= 0x1CF5 && cp <= 0x1CF6 -> True
    cp if cp == 0x1CFA -> True
    cp if cp >= 0x2135 && cp <= 0x2138 -> True
    cp if cp >= 0x2D30 && cp <= 0x2D67 -> True
    cp if cp >= 0x2D80 && cp <= 0x2D96 -> True
    cp if cp >= 0x2DA0 && cp <= 0x2DA6 -> True
    cp if cp >= 0x2DA8 && cp <= 0x2DAE -> True
    cp if cp >= 0x2DB0 && cp <= 0x2DB6 -> True
    cp if cp >= 0x2DB8 && cp <= 0x2DBE -> True
    cp if cp >= 0x2DC0 && cp <= 0x2DC6 -> True
    cp if cp >= 0x2DC8 && cp <= 0x2DCE -> True
    cp if cp >= 0x2DD0 && cp <= 0x2DD6 -> True
    cp if cp >= 0x2DD8 && cp <= 0x2DDE -> True
    cp if cp == 0x3006 -> True
    cp if cp == 0x303C -> True
    cp if cp >= 0x3041 && cp <= 0x3096 -> True
    cp if cp == 0x309F -> True
    cp if cp >= 0x30A1 && cp <= 0x30FA -> True
    cp if cp == 0x30FF -> True
    cp if cp >= 0x3105 && cp <= 0x312F -> True
    cp if cp >= 0x3131 && cp <= 0x318E -> True
    cp if cp >= 0x31A0 && cp <= 0x31BF -> True
    cp if cp >= 0x31F0 && cp <= 0x31FF -> True
    cp if cp >= 0x3400 && cp <= 0x4DBF -> True
    cp if cp >= 0x4E00 && cp <= 0xA014 -> True
    cp if cp >= 0xA016 && cp <= 0xA48C -> True
    cp if cp >= 0xA4D0 && cp <= 0xA4F7 -> True
    cp if cp >= 0xA500 && cp <= 0xA60B -> True
    cp if cp >= 0xA610 && cp <= 0xA61F -> True
    cp if cp >= 0xA62A && cp <= 0xA62B -> True
    cp if cp == 0xA66E -> True
    cp if cp >= 0xA6A0 && cp <= 0xA6E5 -> True
    cp if cp == 0xA78F -> True
    cp if cp == 0xA7F7 -> True
    cp if cp >= 0xA7FB && cp <= 0xA801 -> True
    cp if cp >= 0xA803 && cp <= 0xA805 -> True
    cp if cp >= 0xA807 && cp <= 0xA80A -> True
    cp if cp >= 0xA80C && cp <= 0xA822 -> True
    cp if cp >= 0xA840 && cp <= 0xA873 -> True
    cp if cp >= 0xA882 && cp <= 0xA8B3 -> True
    cp if cp >= 0xA8F2 && cp <= 0xA8F7 -> True
    cp if cp == 0xA8FB -> True
    cp if cp >= 0xA8FD && cp <= 0xA8FE -> True
    cp if cp >= 0xA90A && cp <= 0xA925 -> True
    cp if cp >= 0xA930 && cp <= 0xA946 -> True
    cp if cp >= 0xA960 && cp <= 0xA97C -> True
    cp if cp >= 0xA984 && cp <= 0xA9B2 -> True
    cp if cp >= 0xA9E0 && cp <= 0xA9E4 -> True
    cp if cp >= 0xA9E7 && cp <= 0xA9EF -> True
    cp if cp >= 0xA9FA && cp <= 0xA9FE -> True
    cp if cp >= 0xAA00 && cp <= 0xAA28 -> True
    cp if cp >= 0xAA40 && cp <= 0xAA42 -> True
    cp if cp >= 0xAA44 && cp <= 0xAA4B -> True
    cp if cp >= 0xAA60 && cp <= 0xAA6F -> True
    cp if cp >= 0xAA71 && cp <= 0xAA76 -> True
    cp if cp == 0xAA7A -> True
    cp if cp >= 0xAA7E && cp <= 0xAAAF -> True
    cp if cp == 0xAAB1 -> True
    cp if cp >= 0xAAB5 && cp <= 0xAAB6 -> True
    cp if cp >= 0xAAB9 && cp <= 0xAABD -> True
    cp if cp == 0xAAC0 -> True
    cp if cp == 0xAAC2 -> True
    cp if cp >= 0xAADB && cp <= 0xAADC -> True
    cp if cp >= 0xAAE0 && cp <= 0xAAEA -> True
    cp if cp == 0xAAF2 -> True
    cp if cp >= 0xAB01 && cp <= 0xAB06 -> True
    cp if cp >= 0xAB09 && cp <= 0xAB0E -> True
    cp if cp >= 0xAB11 && cp <= 0xAB16 -> True
    cp if cp >= 0xAB20 && cp <= 0xAB26 -> True
    cp if cp >= 0xAB28 && cp <= 0xAB2E -> True
    cp if cp >= 0xABC0 && cp <= 0xABE2 -> True
    cp if cp >= 0xAC00 && cp <= 0xD7A3 -> True
    cp if cp >= 0xD7B0 && cp <= 0xD7C6 -> True
    cp if cp >= 0xD7CB && cp <= 0xD7FB -> True
    cp if cp >= 0xF900 && cp <= 0xFA6D -> True
    cp if cp >= 0xFA70 && cp <= 0xFAD9 -> True
    cp if cp == 0xFB1D -> True
    cp if cp >= 0xFB1F && cp <= 0xFB28 -> True
    cp if cp >= 0xFB2A && cp <= 0xFB36 -> True
    cp if cp >= 0xFB38 && cp <= 0xFB3C -> True
    cp if cp == 0xFB3E -> True
    cp if cp >= 0xFB40 && cp <= 0xFB41 -> True
    cp if cp >= 0xFB43 && cp <= 0xFB44 -> True
    cp if cp >= 0xFB46 && cp <= 0xFBB1 -> True
    cp if cp >= 0xFBD3 && cp <= 0xFD3D -> True
    cp if cp >= 0xFD50 && cp <= 0xFD8F -> True
    cp if cp >= 0xFD92 && cp <= 0xFDC7 -> True
    cp if cp >= 0xFDF0 && cp <= 0xFDFB -> True
    cp if cp >= 0xFE70 && cp <= 0xFE74 -> True
    cp if cp >= 0xFE76 && cp <= 0xFEFC -> True
    cp if cp >= 0xFF66 && cp <= 0xFF6F -> True
    cp if cp >= 0xFF71 && cp <= 0xFF9D -> True
    cp if cp >= 0xFFA0 && cp <= 0xFFBE -> True
    cp if cp >= 0xFFC2 && cp <= 0xFFC7 -> True
    cp if cp >= 0xFFCA && cp <= 0xFFCF -> True
    cp if cp >= 0xFFD2 && cp <= 0xFFD7 -> True
    cp if cp >= 0xFFDA && cp <= 0xFFDC -> True
    cp if cp >= 0x10000 && cp <= 0x1000B -> True
    cp if cp >= 0x1000D && cp <= 0x10026 -> True
    cp if cp >= 0x10028 && cp <= 0x1003A -> True
    cp if cp >= 0x1003C && cp <= 0x1003D -> True
    cp if cp >= 0x1003F && cp <= 0x1004D -> True
    cp if cp >= 0x10050 && cp <= 0x1005D -> True
    cp if cp >= 0x10080 && cp <= 0x100FA -> True
    cp if cp >= 0x10280 && cp <= 0x1029C -> True
    cp if cp >= 0x102A0 && cp <= 0x102D0 -> True
    cp if cp >= 0x10300 && cp <= 0x1031F -> True
    cp if cp >= 0x1032D && cp <= 0x10340 -> True
    cp if cp >= 0x10342 && cp <= 0x10349 -> True
    cp if cp >= 0x10350 && cp <= 0x10375 -> True
    cp if cp >= 0x10380 && cp <= 0x1039D -> True
    cp if cp >= 0x103A0 && cp <= 0x103C3 -> True
    cp if cp >= 0x103C8 && cp <= 0x103CF -> True
    cp if cp >= 0x10450 && cp <= 0x1049D -> True
    cp if cp >= 0x10500 && cp <= 0x10527 -> True
    cp if cp >= 0x10530 && cp <= 0x10563 -> True
    cp if cp >= 0x105C0 && cp <= 0x105F3 -> True
    cp if cp >= 0x10600 && cp <= 0x10736 -> True
    cp if cp >= 0x10740 && cp <= 0x10755 -> True
    cp if cp >= 0x10760 && cp <= 0x10767 -> True
    cp if cp >= 0x10800 && cp <= 0x10805 -> True
    cp if cp == 0x10808 -> True
    cp if cp >= 0x1080A && cp <= 0x10835 -> True
    cp if cp >= 0x10837 && cp <= 0x10838 -> True
    cp if cp == 0x1083C -> True
    cp if cp >= 0x1083F && cp <= 0x10855 -> True
    cp if cp >= 0x10860 && cp <= 0x10876 -> True
    cp if cp >= 0x10880 && cp <= 0x1089E -> True
    cp if cp >= 0x108E0 && cp <= 0x108F2 -> True
    cp if cp >= 0x108F4 && cp <= 0x108F5 -> True
    cp if cp >= 0x10900 && cp <= 0x10915 -> True
    cp if cp >= 0x10920 && cp <= 0x10939 -> True
    cp if cp >= 0x10980 && cp <= 0x109B7 -> True
    cp if cp >= 0x109BE && cp <= 0x109BF -> True
    cp if cp == 0x10A00 -> True
    cp if cp >= 0x10A10 && cp <= 0x10A13 -> True
    cp if cp >= 0x10A15 && cp <= 0x10A17 -> True
    cp if cp >= 0x10A19 && cp <= 0x10A35 -> True
    cp if cp >= 0x10A60 && cp <= 0x10A7C -> True
    cp if cp >= 0x10A80 && cp <= 0x10A9C -> True
    cp if cp >= 0x10AC0 && cp <= 0x10AC7 -> True
    cp if cp >= 0x10AC9 && cp <= 0x10AE4 -> True
    cp if cp >= 0x10B00 && cp <= 0x10B35 -> True
    cp if cp >= 0x10B40 && cp <= 0x10B55 -> True
    cp if cp >= 0x10B60 && cp <= 0x10B72 -> True
    cp if cp >= 0x10B80 && cp <= 0x10B91 -> True
    cp if cp >= 0x10C00 && cp <= 0x10C48 -> True
    cp if cp >= 0x10D00 && cp <= 0x10D23 -> True
    cp if cp >= 0x10D4A && cp <= 0x10D4D -> True
    cp if cp == 0x10D4F -> True
    cp if cp >= 0x10E80 && cp <= 0x10EA9 -> True
    cp if cp >= 0x10EB0 && cp <= 0x10EB1 -> True
    cp if cp >= 0x10EC2 && cp <= 0x10EC4 -> True
    cp if cp >= 0x10F00 && cp <= 0x10F1C -> True
    cp if cp == 0x10F27 -> True
    cp if cp >= 0x10F30 && cp <= 0x10F45 -> True
    cp if cp >= 0x10F70 && cp <= 0x10F81 -> True
    cp if cp >= 0x10FB0 && cp <= 0x10FC4 -> True
    cp if cp >= 0x10FE0 && cp <= 0x10FF6 -> True
    cp if cp >= 0x11003 && cp <= 0x11037 -> True
    cp if cp >= 0x11071 && cp <= 0x11072 -> True
    cp if cp == 0x11075 -> True
    cp if cp >= 0x11083 && cp <= 0x110AF -> True
    cp if cp >= 0x110D0 && cp <= 0x110E8 -> True
    cp if cp >= 0x11103 && cp <= 0x11126 -> True
    cp if cp == 0x11144 -> True
    cp if cp == 0x11147 -> True
    cp if cp >= 0x11150 && cp <= 0x11172 -> True
    cp if cp == 0x11176 -> True
    cp if cp >= 0x11183 && cp <= 0x111B2 -> True
    cp if cp >= 0x111C1 && cp <= 0x111C4 -> True
    cp if cp == 0x111DA -> True
    cp if cp == 0x111DC -> True
    cp if cp >= 0x11200 && cp <= 0x11211 -> True
    cp if cp >= 0x11213 && cp <= 0x1122B -> True
    cp if cp >= 0x1123F && cp <= 0x11240 -> True
    cp if cp >= 0x11280 && cp <= 0x11286 -> True
    cp if cp == 0x11288 -> True
    cp if cp >= 0x1128A && cp <= 0x1128D -> True
    cp if cp >= 0x1128F && cp <= 0x1129D -> True
    cp if cp >= 0x1129F && cp <= 0x112A8 -> True
    cp if cp >= 0x112B0 && cp <= 0x112DE -> True
    cp if cp >= 0x11305 && cp <= 0x1130C -> True
    cp if cp >= 0x1130F && cp <= 0x11310 -> True
    cp if cp >= 0x11313 && cp <= 0x11328 -> True
    cp if cp >= 0x1132A && cp <= 0x11330 -> True
    cp if cp >= 0x11332 && cp <= 0x11333 -> True
    cp if cp >= 0x11335 && cp <= 0x11339 -> True
    cp if cp == 0x1133D -> True
    cp if cp == 0x11350 -> True
    cp if cp >= 0x1135D && cp <= 0x11361 -> True
    cp if cp >= 0x11380 && cp <= 0x11389 -> True
    cp if cp == 0x1138B -> True
    cp if cp == 0x1138E -> True
    cp if cp >= 0x11390 && cp <= 0x113B5 -> True
    cp if cp == 0x113B7 -> True
    cp if cp == 0x113D1 -> True
    cp if cp == 0x113D3 -> True
    cp if cp >= 0x11400 && cp <= 0x11434 -> True
    cp if cp >= 0x11447 && cp <= 0x1144A -> True
    cp if cp >= 0x1145F && cp <= 0x11461 -> True
    cp if cp >= 0x11480 && cp <= 0x114AF -> True
    cp if cp >= 0x114C4 && cp <= 0x114C5 -> True
    cp if cp == 0x114C7 -> True
    cp if cp >= 0x11580 && cp <= 0x115AE -> True
    cp if cp >= 0x115D8 && cp <= 0x115DB -> True
    cp if cp >= 0x11600 && cp <= 0x1162F -> True
    cp if cp == 0x11644 -> True
    cp if cp >= 0x11680 && cp <= 0x116AA -> True
    cp if cp == 0x116B8 -> True
    cp if cp >= 0x11700 && cp <= 0x1171A -> True
    cp if cp >= 0x11740 && cp <= 0x11746 -> True
    cp if cp >= 0x11800 && cp <= 0x1182B -> True
    cp if cp >= 0x118FF && cp <= 0x11906 -> True
    cp if cp == 0x11909 -> True
    cp if cp >= 0x1190C && cp <= 0x11913 -> True
    cp if cp >= 0x11915 && cp <= 0x11916 -> True
    cp if cp >= 0x11918 && cp <= 0x1192F -> True
    cp if cp == 0x1193F -> True
    cp if cp == 0x11941 -> True
    cp if cp >= 0x119A0 && cp <= 0x119A7 -> True
    cp if cp >= 0x119AA && cp <= 0x119D0 -> True
    cp if cp == 0x119E1 -> True
    cp if cp == 0x119E3 -> True
    cp if cp == 0x11A00 -> True
    cp if cp >= 0x11A0B && cp <= 0x11A32 -> True
    cp if cp == 0x11A3A -> True
    cp if cp == 0x11A50 -> True
    cp if cp >= 0x11A5C && cp <= 0x11A89 -> True
    cp if cp == 0x11A9D -> True
    cp if cp >= 0x11AB0 && cp <= 0x11AF8 -> True
    cp if cp >= 0x11BC0 && cp <= 0x11BE0 -> True
    cp if cp >= 0x11C00 && cp <= 0x11C08 -> True
    cp if cp >= 0x11C0A && cp <= 0x11C2E -> True
    cp if cp == 0x11C40 -> True
    cp if cp >= 0x11C72 && cp <= 0x11C8F -> True
    cp if cp >= 0x11D00 && cp <= 0x11D06 -> True
    cp if cp >= 0x11D08 && cp <= 0x11D09 -> True
    cp if cp >= 0x11D0B && cp <= 0x11D30 -> True
    cp if cp == 0x11D46 -> True
    cp if cp >= 0x11D60 && cp <= 0x11D65 -> True
    cp if cp >= 0x11D67 && cp <= 0x11D68 -> True
    cp if cp >= 0x11D6A && cp <= 0x11D89 -> True
    cp if cp == 0x11D98 -> True
    cp if cp >= 0x11EE0 && cp <= 0x11EF2 -> True
    cp if cp == 0x11F02 -> True
    cp if cp >= 0x11F04 && cp <= 0x11F10 -> True
    cp if cp >= 0x11F12 && cp <= 0x11F33 -> True
    cp if cp == 0x11FB0 -> True
    cp if cp >= 0x12000 && cp <= 0x12399 -> True
    cp if cp >= 0x12480 && cp <= 0x12543 -> True
    cp if cp >= 0x12F90 && cp <= 0x12FF0 -> True
    cp if cp >= 0x13000 && cp <= 0x1342F -> True
    cp if cp >= 0x13441 && cp <= 0x13446 -> True
    cp if cp >= 0x13460 && cp <= 0x143FA -> True
    cp if cp >= 0x14400 && cp <= 0x14646 -> True
    cp if cp >= 0x16100 && cp <= 0x1611D -> True
    cp if cp >= 0x16800 && cp <= 0x16A38 -> True
    cp if cp >= 0x16A40 && cp <= 0x16A5E -> True
    cp if cp >= 0x16A70 && cp <= 0x16ABE -> True
    cp if cp >= 0x16AD0 && cp <= 0x16AED -> True
    cp if cp >= 0x16B00 && cp <= 0x16B2F -> True
    cp if cp >= 0x16B63 && cp <= 0x16B77 -> True
    cp if cp >= 0x16B7D && cp <= 0x16B8F -> True
    cp if cp >= 0x16D43 && cp <= 0x16D6A -> True
    cp if cp >= 0x16F00 && cp <= 0x16F4A -> True
    cp if cp == 0x16F50 -> True
    cp if cp >= 0x17000 && cp <= 0x187F7 -> True
    cp if cp >= 0x18800 && cp <= 0x18CD5 -> True
    cp if cp >= 0x18CFF && cp <= 0x18D08 -> True
    cp if cp >= 0x1B000 && cp <= 0x1B122 -> True
    cp if cp == 0x1B132 -> True
    cp if cp >= 0x1B150 && cp <= 0x1B152 -> True
    cp if cp == 0x1B155 -> True
    cp if cp >= 0x1B164 && cp <= 0x1B167 -> True
    cp if cp >= 0x1B170 && cp <= 0x1B2FB -> True
    cp if cp >= 0x1BC00 && cp <= 0x1BC6A -> True
    cp if cp >= 0x1BC70 && cp <= 0x1BC7C -> True
    cp if cp >= 0x1BC80 && cp <= 0x1BC88 -> True
    cp if cp >= 0x1BC90 && cp <= 0x1BC99 -> True
    cp if cp == 0x1DF0A -> True
    cp if cp >= 0x1E100 && cp <= 0x1E12C -> True
    cp if cp == 0x1E14E -> True
    cp if cp >= 0x1E290 && cp <= 0x1E2AD -> True
    cp if cp >= 0x1E2C0 && cp <= 0x1E2EB -> True
    cp if cp >= 0x1E4D0 && cp <= 0x1E4EA -> True
    cp if cp >= 0x1E5D0 && cp <= 0x1E5ED -> True
    cp if cp == 0x1E5F0 -> True
    cp if cp >= 0x1E7E0 && cp <= 0x1E7E6 -> True
    cp if cp >= 0x1E7E8 && cp <= 0x1E7EB -> True
    cp if cp >= 0x1E7ED && cp <= 0x1E7EE -> True
    cp if cp >= 0x1E7F0 && cp <= 0x1E7FE -> True
    cp if cp >= 0x1E800 && cp <= 0x1E8C4 -> True
    cp if cp >= 0x1EE00 && cp <= 0x1EE03 -> True
    cp if cp >= 0x1EE05 && cp <= 0x1EE1F -> True
    cp if cp >= 0x1EE21 && cp <= 0x1EE22 -> True
    cp if cp == 0x1EE24 -> True
    cp if cp == 0x1EE27 -> True
    cp if cp >= 0x1EE29 && cp <= 0x1EE32 -> True
    cp if cp >= 0x1EE34 && cp <= 0x1EE37 -> True
    cp if cp == 0x1EE39 -> True
    cp if cp == 0x1EE3B -> True
    cp if cp == 0x1EE42 -> True
    cp if cp == 0x1EE47 -> True
    cp if cp == 0x1EE49 -> True
    cp if cp == 0x1EE4B -> True
    cp if cp >= 0x1EE4D && cp <= 0x1EE4F -> True
    cp if cp >= 0x1EE51 && cp <= 0x1EE52 -> True
    cp if cp == 0x1EE54 -> True
    cp if cp == 0x1EE57 -> True
    cp if cp == 0x1EE59 -> True
    cp if cp == 0x1EE5B -> True
    cp if cp == 0x1EE5D -> True
    cp if cp == 0x1EE5F -> True
    cp if cp >= 0x1EE61 && cp <= 0x1EE62 -> True
    cp if cp == 0x1EE64 -> True
    cp if cp >= 0x1EE67 && cp <= 0x1EE6A -> True
    cp if cp >= 0x1EE6C && cp <= 0x1EE72 -> True
    cp if cp >= 0x1EE74 && cp <= 0x1EE77 -> True
    cp if cp >= 0x1EE79 && cp <= 0x1EE7C -> True
    cp if cp == 0x1EE7E -> True
    cp if cp >= 0x1EE80 && cp <= 0x1EE89 -> True
    cp if cp >= 0x1EE8B && cp <= 0x1EE9B -> True
    cp if cp >= 0x1EEA1 && cp <= 0x1EEA3 -> True
    cp if cp >= 0x1EEA5 && cp <= 0x1EEA9 -> True
    cp if cp >= 0x1EEAB && cp <= 0x1EEBB -> True
    cp if cp >= 0x20000 && cp <= 0x2A6DF -> True
    cp if cp >= 0x2A700 && cp <= 0x2B739 -> True
    cp if cp >= 0x2B740 && cp <= 0x2B81D -> True
    cp if cp >= 0x2B820 && cp <= 0x2CEA1 -> True
    cp if cp >= 0x2CEB0 && cp <= 0x2EBE0 -> True
    cp if cp >= 0x2EBF0 && cp <= 0x2EE5D -> True
    cp if cp >= 0x2F800 && cp <= 0x2FA1D -> True
    cp if cp >= 0x30000 && cp <= 0x3134A -> True
    cp if cp >= 0x31350 && cp <= 0x323AF -> True
    cp if cp >= 0x0300 && cp <= 0x036F -> True
    cp if cp >= 0x0483 && cp <= 0x0487 -> True
    cp if cp >= 0x0591 && cp <= 0x05BD -> True
    cp if cp == 0x05BF -> True
    cp if cp >= 0x05C1 && cp <= 0x05C2 -> True
    cp if cp >= 0x05C4 && cp <= 0x05C5 -> True
    cp if cp == 0x05C7 -> True
    cp if cp >= 0x0610 && cp <= 0x061A -> True
    cp if cp >= 0x064B && cp <= 0x065F -> True
    cp if cp == 0x0670 -> True
    cp if cp >= 0x06D6 && cp <= 0x06DC -> True
    cp if cp >= 0x06DF && cp <= 0x06E4 -> True
    cp if cp >= 0x06E7 && cp <= 0x06E8 -> True
    cp if cp >= 0x06EA && cp <= 0x06ED -> True
    cp if cp == 0x0711 -> True
    cp if cp >= 0x0730 && cp <= 0x074A -> True
    cp if cp >= 0x07A6 && cp <= 0x07B0 -> True
    cp if cp >= 0x07EB && cp <= 0x07F3 -> True
    cp if cp == 0x07FD -> True
    cp if cp >= 0x0816 && cp <= 0x0819 -> True
    cp if cp >= 0x081B && cp <= 0x0823 -> True
    cp if cp >= 0x0825 && cp <= 0x0827 -> True
    cp if cp >= 0x0829 && cp <= 0x082D -> True
    cp if cp >= 0x0859 && cp <= 0x085B -> True
    cp if cp >= 0x0897 && cp <= 0x089F -> True
    cp if cp >= 0x08CA && cp <= 0x08E1 -> True
    cp if cp >= 0x08E3 && cp <= 0x0902 -> True
    cp if cp == 0x093A -> True
    cp if cp == 0x093C -> True
    cp if cp >= 0x0941 && cp <= 0x0948 -> True
    cp if cp == 0x094D -> True
    cp if cp >= 0x0951 && cp <= 0x0957 -> True
    cp if cp >= 0x0962 && cp <= 0x0963 -> True
    cp if cp == 0x0981 -> True
    cp if cp == 0x09BC -> True
    cp if cp >= 0x09C1 && cp <= 0x09C4 -> True
    cp if cp == 0x09CD -> True
    cp if cp >= 0x09E2 && cp <= 0x09E3 -> True
    cp if cp == 0x09FE -> True
    cp if cp >= 0x0A01 && cp <= 0x0A02 -> True
    cp if cp == 0x0A3C -> True
    cp if cp >= 0x0A41 && cp <= 0x0A42 -> True
    cp if cp >= 0x0A47 && cp <= 0x0A48 -> True
    cp if cp >= 0x0A4B && cp <= 0x0A4D -> True
    cp if cp == 0x0A51 -> True
    cp if cp >= 0x0A70 && cp <= 0x0A71 -> True
    cp if cp == 0x0A75 -> True
    cp if cp >= 0x0A81 && cp <= 0x0A82 -> True
    cp if cp == 0x0ABC -> True
    cp if cp >= 0x0AC1 && cp <= 0x0AC5 -> True
    cp if cp >= 0x0AC7 && cp <= 0x0AC8 -> True
    cp if cp == 0x0ACD -> True
    cp if cp >= 0x0AE2 && cp <= 0x0AE3 -> True
    cp if cp >= 0x0AFA && cp <= 0x0AFF -> True
    cp if cp == 0x0B01 -> True
    cp if cp == 0x0B3C -> True
    cp if cp == 0x0B3F -> True
    cp if cp >= 0x0B41 && cp <= 0x0B44 -> True
    cp if cp == 0x0B4D -> True
    cp if cp >= 0x0B55 && cp <= 0x0B56 -> True
    cp if cp >= 0x0B62 && cp <= 0x0B63 -> True
    cp if cp == 0x0B82 -> True
    cp if cp == 0x0BC0 -> True
    cp if cp == 0x0BCD -> True
    cp if cp == 0x0C00 -> True
    cp if cp == 0x0C04 -> True
    cp if cp == 0x0C3C -> True
    cp if cp >= 0x0C3E && cp <= 0x0C40 -> True
    cp if cp >= 0x0C46 && cp <= 0x0C48 -> True
    cp if cp >= 0x0C4A && cp <= 0x0C4D -> True
    cp if cp >= 0x0C55 && cp <= 0x0C56 -> True
    cp if cp >= 0x0C62 && cp <= 0x0C63 -> True
    cp if cp == 0x0C81 -> True
    cp if cp == 0x0CBC -> True
    cp if cp == 0x0CBF -> True
    cp if cp == 0x0CC6 -> True
    cp if cp >= 0x0CCC && cp <= 0x0CCD -> True
    cp if cp >= 0x0CE2 && cp <= 0x0CE3 -> True
    cp if cp >= 0x0D00 && cp <= 0x0D01 -> True
    cp if cp >= 0x0D3B && cp <= 0x0D3C -> True
    cp if cp >= 0x0D41 && cp <= 0x0D44 -> True
    cp if cp == 0x0D4D -> True
    cp if cp >= 0x0D62 && cp <= 0x0D63 -> True
    cp if cp == 0x0D81 -> True
    cp if cp == 0x0DCA -> True
    cp if cp >= 0x0DD2 && cp <= 0x0DD4 -> True
    cp if cp == 0x0DD6 -> True
    cp if cp == 0x0E31 -> True
    cp if cp >= 0x0E34 && cp <= 0x0E3A -> True
    cp if cp >= 0x0E47 && cp <= 0x0E4E -> True
    cp if cp == 0x0EB1 -> True
    cp if cp >= 0x0EB4 && cp <= 0x0EBC -> True
    cp if cp >= 0x0EC8 && cp <= 0x0ECE -> True
    cp if cp >= 0x0F18 && cp <= 0x0F19 -> True
    cp if cp == 0x0F35 -> True
    cp if cp == 0x0F37 -> True
    cp if cp == 0x0F39 -> True
    cp if cp >= 0x0F71 && cp <= 0x0F7E -> True
    cp if cp >= 0x0F80 && cp <= 0x0F84 -> True
    cp if cp >= 0x0F86 && cp <= 0x0F87 -> True
    cp if cp >= 0x0F8D && cp <= 0x0F97 -> True
    cp if cp >= 0x0F99 && cp <= 0x0FBC -> True
    cp if cp == 0x0FC6 -> True
    cp if cp >= 0x102D && cp <= 0x1030 -> True
    cp if cp >= 0x1032 && cp <= 0x1037 -> True
    cp if cp >= 0x1039 && cp <= 0x103A -> True
    cp if cp >= 0x103D && cp <= 0x103E -> True
    cp if cp >= 0x1058 && cp <= 0x1059 -> True
    cp if cp >= 0x105E && cp <= 0x1060 -> True
    cp if cp >= 0x1071 && cp <= 0x1074 -> True
    cp if cp == 0x1082 -> True
    cp if cp >= 0x1085 && cp <= 0x1086 -> True
    cp if cp == 0x108D -> True
    cp if cp == 0x109D -> True
    cp if cp >= 0x135D && cp <= 0x135F -> True
    cp if cp >= 0x1712 && cp <= 0x1714 -> True
    cp if cp >= 0x1732 && cp <= 0x1733 -> True
    cp if cp >= 0x1752 && cp <= 0x1753 -> True
    cp if cp >= 0x1772 && cp <= 0x1773 -> True
    cp if cp >= 0x17B4 && cp <= 0x17B5 -> True
    cp if cp >= 0x17B7 && cp <= 0x17BD -> True
    cp if cp == 0x17C6 -> True
    cp if cp >= 0x17C9 && cp <= 0x17D3 -> True
    cp if cp == 0x17DD -> True
    cp if cp >= 0x180B && cp <= 0x180D -> True
    cp if cp == 0x180F -> True
    cp if cp >= 0x1885 && cp <= 0x1886 -> True
    cp if cp == 0x18A9 -> True
    cp if cp >= 0x1920 && cp <= 0x1922 -> True
    cp if cp >= 0x1927 && cp <= 0x1928 -> True
    cp if cp == 0x1932 -> True
    cp if cp >= 0x1939 && cp <= 0x193B -> True
    cp if cp >= 0x1A17 && cp <= 0x1A18 -> True
    cp if cp == 0x1A1B -> True
    cp if cp == 0x1A56 -> True
    cp if cp >= 0x1A58 && cp <= 0x1A5E -> True
    cp if cp == 0x1A60 -> True
    cp if cp == 0x1A62 -> True
    cp if cp >= 0x1A65 && cp <= 0x1A6C -> True
    cp if cp >= 0x1A73 && cp <= 0x1A7C -> True
    cp if cp == 0x1A7F -> True
    cp if cp >= 0x1AB0 && cp <= 0x1ABD -> True
    cp if cp >= 0x1ABF && cp <= 0x1ACE -> True
    cp if cp >= 0x1B00 && cp <= 0x1B03 -> True
    cp if cp == 0x1B34 -> True
    cp if cp >= 0x1B36 && cp <= 0x1B3A -> True
    cp if cp == 0x1B3C -> True
    cp if cp == 0x1B42 -> True
    cp if cp >= 0x1B6B && cp <= 0x1B73 -> True
    cp if cp >= 0x1B80 && cp <= 0x1B81 -> True
    cp if cp >= 0x1BA2 && cp <= 0x1BA5 -> True
    cp if cp >= 0x1BA8 && cp <= 0x1BA9 -> True
    cp if cp >= 0x1BAB && cp <= 0x1BAD -> True
    cp if cp == 0x1BE6 -> True
    cp if cp >= 0x1BE8 && cp <= 0x1BE9 -> True
    cp if cp == 0x1BED -> True
    cp if cp >= 0x1BEF && cp <= 0x1BF1 -> True
    cp if cp >= 0x1C2C && cp <= 0x1C33 -> True
    cp if cp >= 0x1C36 && cp <= 0x1C37 -> True
    cp if cp >= 0x1CD0 && cp <= 0x1CD2 -> True
    cp if cp >= 0x1CD4 && cp <= 0x1CE0 -> True
    cp if cp >= 0x1CE2 && cp <= 0x1CE8 -> True
    cp if cp == 0x1CED -> True
    cp if cp == 0x1CF4 -> True
    cp if cp >= 0x1CF8 && cp <= 0x1CF9 -> True
    cp if cp >= 0x1DC0 && cp <= 0x1DFF -> True
    cp if cp >= 0x20D0 && cp <= 0x20DC -> True
    cp if cp == 0x20E1 -> True
    cp if cp >= 0x20E5 && cp <= 0x20F0 -> True
    cp if cp >= 0x2CEF && cp <= 0x2CF1 -> True
    cp if cp == 0x2D7F -> True
    cp if cp >= 0x2DE0 && cp <= 0x2DFF -> True
    cp if cp >= 0x302A && cp <= 0x302D -> True
    cp if cp >= 0x3099 && cp <= 0x309A -> True
    cp if cp == 0xA66F -> True
    cp if cp >= 0xA674 && cp <= 0xA67D -> True
    cp if cp >= 0xA69E && cp <= 0xA69F -> True
    cp if cp >= 0xA6F0 && cp <= 0xA6F1 -> True
    cp if cp == 0xA802 -> True
    cp if cp == 0xA806 -> True
    cp if cp == 0xA80B -> True
    cp if cp >= 0xA825 && cp <= 0xA826 -> True
    cp if cp == 0xA82C -> True
    cp if cp >= 0xA8C4 && cp <= 0xA8C5 -> True
    cp if cp >= 0xA8E0 && cp <= 0xA8F1 -> True
    cp if cp == 0xA8FF -> True
    cp if cp >= 0xA926 && cp <= 0xA92D -> True
    cp if cp >= 0xA947 && cp <= 0xA951 -> True
    cp if cp >= 0xA980 && cp <= 0xA982 -> True
    cp if cp == 0xA9B3 -> True
    cp if cp >= 0xA9B6 && cp <= 0xA9B9 -> True
    cp if cp >= 0xA9BC && cp <= 0xA9BD -> True
    cp if cp == 0xA9E5 -> True
    cp if cp >= 0xAA29 && cp <= 0xAA2E -> True
    cp if cp >= 0xAA31 && cp <= 0xAA32 -> True
    cp if cp >= 0xAA35 && cp <= 0xAA36 -> True
    cp if cp == 0xAA43 -> True
    cp if cp == 0xAA4C -> True
    cp if cp == 0xAA7C -> True
    cp if cp == 0xAAB0 -> True
    cp if cp >= 0xAAB2 && cp <= 0xAAB4 -> True
    cp if cp >= 0xAAB7 && cp <= 0xAAB8 -> True
    cp if cp >= 0xAABE && cp <= 0xAABF -> True
    cp if cp == 0xAAC1 -> True
    cp if cp >= 0xAAEC && cp <= 0xAAED -> True
    cp if cp == 0xAAF6 -> True
    cp if cp == 0xABE5 -> True
    cp if cp == 0xABE8 -> True
    cp if cp == 0xABED -> True
    cp if cp == 0xFB1E -> True
    cp if cp >= 0xFE00 && cp <= 0xFE0F -> True
    cp if cp >= 0xFE20 && cp <= 0xFE2F -> True
    cp if cp == 0x101FD -> True
    cp if cp == 0x102E0 -> True
    cp if cp >= 0x10376 && cp <= 0x1037A -> True
    cp if cp >= 0x10A01 && cp <= 0x10A03 -> True
    cp if cp >= 0x10A05 && cp <= 0x10A06 -> True
    cp if cp >= 0x10A0C && cp <= 0x10A0F -> True
    cp if cp >= 0x10A38 && cp <= 0x10A3A -> True
    cp if cp == 0x10A3F -> True
    cp if cp >= 0x10AE5 && cp <= 0x10AE6 -> True
    cp if cp >= 0x10D24 && cp <= 0x10D27 -> True
    cp if cp >= 0x10D69 && cp <= 0x10D6D -> True
    cp if cp >= 0x10EAB && cp <= 0x10EAC -> True
    cp if cp >= 0x10EFC && cp <= 0x10EFF -> True
    cp if cp >= 0x10F46 && cp <= 0x10F50 -> True
    cp if cp >= 0x10F82 && cp <= 0x10F85 -> True
    cp if cp == 0x11001 -> True
    cp if cp >= 0x11038 && cp <= 0x11046 -> True
    cp if cp == 0x11070 -> True
    cp if cp >= 0x11073 && cp <= 0x11074 -> True
    cp if cp >= 0x1107F && cp <= 0x11081 -> True
    cp if cp >= 0x110B3 && cp <= 0x110B6 -> True
    cp if cp >= 0x110B9 && cp <= 0x110BA -> True
    cp if cp == 0x110C2 -> True
    cp if cp >= 0x11100 && cp <= 0x11102 -> True
    cp if cp >= 0x11127 && cp <= 0x1112B -> True
    cp if cp >= 0x1112D && cp <= 0x11134 -> True
    cp if cp == 0x11173 -> True
    cp if cp >= 0x11180 && cp <= 0x11181 -> True
    cp if cp >= 0x111B6 && cp <= 0x111BE -> True
    cp if cp >= 0x111C9 && cp <= 0x111CC -> True
    cp if cp == 0x111CF -> True
    cp if cp >= 0x1122F && cp <= 0x11231 -> True
    cp if cp == 0x11234 -> True
    cp if cp >= 0x11236 && cp <= 0x11237 -> True
    cp if cp == 0x1123E -> True
    cp if cp == 0x11241 -> True
    cp if cp == 0x112DF -> True
    cp if cp >= 0x112E3 && cp <= 0x112EA -> True
    cp if cp >= 0x11300 && cp <= 0x11301 -> True
    cp if cp >= 0x1133B && cp <= 0x1133C -> True
    cp if cp == 0x11340 -> True
    cp if cp >= 0x11366 && cp <= 0x1136C -> True
    cp if cp >= 0x11370 && cp <= 0x11374 -> True
    cp if cp >= 0x113BB && cp <= 0x113C0 -> True
    cp if cp == 0x113CE -> True
    cp if cp == 0x113D0 -> True
    cp if cp == 0x113D2 -> True
    cp if cp >= 0x113E1 && cp <= 0x113E2 -> True
    cp if cp >= 0x11438 && cp <= 0x1143F -> True
    cp if cp >= 0x11442 && cp <= 0x11444 -> True
    cp if cp == 0x11446 -> True
    cp if cp == 0x1145E -> True
    cp if cp >= 0x114B3 && cp <= 0x114B8 -> True
    cp if cp == 0x114BA -> True
    cp if cp >= 0x114BF && cp <= 0x114C0 -> True
    cp if cp >= 0x114C2 && cp <= 0x114C3 -> True
    cp if cp >= 0x115B2 && cp <= 0x115B5 -> True
    cp if cp >= 0x115BC && cp <= 0x115BD -> True
    cp if cp >= 0x115BF && cp <= 0x115C0 -> True
    cp if cp >= 0x115DC && cp <= 0x115DD -> True
    cp if cp >= 0x11633 && cp <= 0x1163A -> True
    cp if cp == 0x1163D -> True
    cp if cp >= 0x1163F && cp <= 0x11640 -> True
    cp if cp == 0x116AB -> True
    cp if cp == 0x116AD -> True
    cp if cp >= 0x116B0 && cp <= 0x116B5 -> True
    cp if cp == 0x116B7 -> True
    cp if cp == 0x1171D -> True
    cp if cp == 0x1171F -> True
    cp if cp >= 0x11722 && cp <= 0x11725 -> True
    cp if cp >= 0x11727 && cp <= 0x1172B -> True
    cp if cp >= 0x1182F && cp <= 0x11837 -> True
    cp if cp >= 0x11839 && cp <= 0x1183A -> True
    cp if cp >= 0x1193B && cp <= 0x1193C -> True
    cp if cp == 0x1193E -> True
    cp if cp == 0x11943 -> True
    cp if cp >= 0x119D4 && cp <= 0x119D7 -> True
    cp if cp >= 0x119DA && cp <= 0x119DB -> True
    cp if cp == 0x119E0 -> True
    cp if cp >= 0x11A01 && cp <= 0x11A0A -> True
    cp if cp >= 0x11A33 && cp <= 0x11A38 -> True
    cp if cp >= 0x11A3B && cp <= 0x11A3E -> True
    cp if cp == 0x11A47 -> True
    cp if cp >= 0x11A51 && cp <= 0x11A56 -> True
    cp if cp >= 0x11A59 && cp <= 0x11A5B -> True
    cp if cp >= 0x11A8A && cp <= 0x11A96 -> True
    cp if cp >= 0x11A98 && cp <= 0x11A99 -> True
    cp if cp >= 0x11C30 && cp <= 0x11C36 -> True
    cp if cp >= 0x11C38 && cp <= 0x11C3D -> True
    cp if cp == 0x11C3F -> True
    cp if cp >= 0x11C92 && cp <= 0x11CA7 -> True
    cp if cp >= 0x11CAA && cp <= 0x11CB0 -> True
    cp if cp >= 0x11CB2 && cp <= 0x11CB3 -> True
    cp if cp >= 0x11CB5 && cp <= 0x11CB6 -> True
    cp if cp >= 0x11D31 && cp <= 0x11D36 -> True
    cp if cp == 0x11D3A -> True
    cp if cp >= 0x11D3C && cp <= 0x11D3D -> True
    cp if cp >= 0x11D3F && cp <= 0x11D45 -> True
    cp if cp == 0x11D47 -> True
    cp if cp >= 0x11D90 && cp <= 0x11D91 -> True
    cp if cp == 0x11D95 -> True
    cp if cp == 0x11D97 -> True
    cp if cp >= 0x11EF3 && cp <= 0x11EF4 -> True
    cp if cp >= 0x11F00 && cp <= 0x11F01 -> True
    cp if cp >= 0x11F36 && cp <= 0x11F3A -> True
    cp if cp == 0x11F40 -> True
    cp if cp == 0x11F42 -> True
    cp if cp == 0x11F5A -> True
    cp if cp == 0x13440 -> True
    cp if cp >= 0x13447 && cp <= 0x13455 -> True
    cp if cp >= 0x1611E && cp <= 0x16129 -> True
    cp if cp >= 0x1612D && cp <= 0x1612F -> True
    cp if cp >= 0x16AF0 && cp <= 0x16AF4 -> True
    cp if cp >= 0x16B30 && cp <= 0x16B36 -> True
    cp if cp == 0x16F4F -> True
    cp if cp >= 0x16F8F && cp <= 0x16F92 -> True
    cp if cp == 0x16FE4 -> True
    cp if cp >= 0x1BC9D && cp <= 0x1BC9E -> True
    cp if cp >= 0x1CF00 && cp <= 0x1CF2D -> True
    cp if cp >= 0x1CF30 && cp <= 0x1CF46 -> True
    cp if cp >= 0x1D167 && cp <= 0x1D169 -> True
    cp if cp >= 0x1D17B && cp <= 0x1D182 -> True
    cp if cp >= 0x1D185 && cp <= 0x1D18B -> True
    cp if cp >= 0x1D1AA && cp <= 0x1D1AD -> True
    cp if cp >= 0x1D242 && cp <= 0x1D244 -> True
    cp if cp >= 0x1DA00 && cp <= 0x1DA36 -> True
    cp if cp >= 0x1DA3B && cp <= 0x1DA6C -> True
    cp if cp == 0x1DA75 -> True
    cp if cp == 0x1DA84 -> True
    cp if cp >= 0x1DA9B && cp <= 0x1DA9F -> True
    cp if cp >= 0x1DAA1 && cp <= 0x1DAAF -> True
    cp if cp >= 0x1E000 && cp <= 0x1E006 -> True
    cp if cp >= 0x1E008 && cp <= 0x1E018 -> True
    cp if cp >= 0x1E01B && cp <= 0x1E021 -> True
    cp if cp >= 0x1E023 && cp <= 0x1E024 -> True
    cp if cp >= 0x1E026 && cp <= 0x1E02A -> True
    cp if cp == 0x1E08F -> True
    cp if cp >= 0x1E130 && cp <= 0x1E136 -> True
    cp if cp == 0x1E2AE -> True
    cp if cp >= 0x1E2EC && cp <= 0x1E2EF -> True
    cp if cp >= 0x1E4EC && cp <= 0x1E4EF -> True
    cp if cp >= 0x1E5EE && cp <= 0x1E5EF -> True
    cp if cp >= 0x1E8D0 && cp <= 0x1E8D6 -> True
    cp if cp >= 0x1E944 && cp <= 0x1E94A -> True
    cp if cp >= 0xE0100 && cp <= 0xE01EF -> True
    cp if cp == 0x0903 -> True
    cp if cp == 0x093B -> True
    cp if cp >= 0x093E && cp <= 0x0940 -> True
    cp if cp >= 0x0949 && cp <= 0x094C -> True
    cp if cp >= 0x094E && cp <= 0x094F -> True
    cp if cp >= 0x0982 && cp <= 0x0983 -> True
    cp if cp >= 0x09BE && cp <= 0x09C0 -> True
    cp if cp >= 0x09C7 && cp <= 0x09C8 -> True
    cp if cp >= 0x09CB && cp <= 0x09CC -> True
    cp if cp == 0x09D7 -> True
    cp if cp == 0x0A03 -> True
    cp if cp >= 0x0A3E && cp <= 0x0A40 -> True
    cp if cp == 0x0A83 -> True
    cp if cp >= 0x0ABE && cp <= 0x0AC0 -> True
    cp if cp == 0x0AC9 -> True
    cp if cp >= 0x0ACB && cp <= 0x0ACC -> True
    cp if cp >= 0x0B02 && cp <= 0x0B03 -> True
    cp if cp == 0x0B3E -> True
    cp if cp == 0x0B40 -> True
    cp if cp >= 0x0B47 && cp <= 0x0B48 -> True
    cp if cp >= 0x0B4B && cp <= 0x0B4C -> True
    cp if cp == 0x0B57 -> True
    cp if cp >= 0x0BBE && cp <= 0x0BBF -> True
    cp if cp >= 0x0BC1 && cp <= 0x0BC2 -> True
    cp if cp >= 0x0BC6 && cp <= 0x0BC8 -> True
    cp if cp >= 0x0BCA && cp <= 0x0BCC -> True
    cp if cp == 0x0BD7 -> True
    cp if cp >= 0x0C01 && cp <= 0x0C03 -> True
    cp if cp >= 0x0C41 && cp <= 0x0C44 -> True
    cp if cp >= 0x0C82 && cp <= 0x0C83 -> True
    cp if cp == 0x0CBE -> True
    cp if cp >= 0x0CC0 && cp <= 0x0CC4 -> True
    cp if cp >= 0x0CC7 && cp <= 0x0CC8 -> True
    cp if cp >= 0x0CCA && cp <= 0x0CCB -> True
    cp if cp >= 0x0CD5 && cp <= 0x0CD6 -> True
    cp if cp == 0x0CF3 -> True
    cp if cp >= 0x0D02 && cp <= 0x0D03 -> True
    cp if cp >= 0x0D3E && cp <= 0x0D40 -> True
    cp if cp >= 0x0D46 && cp <= 0x0D48 -> True
    cp if cp >= 0x0D4A && cp <= 0x0D4C -> True
    cp if cp == 0x0D57 -> True
    cp if cp >= 0x0D82 && cp <= 0x0D83 -> True
    cp if cp >= 0x0DCF && cp <= 0x0DD1 -> True
    cp if cp >= 0x0DD8 && cp <= 0x0DDF -> True
    cp if cp >= 0x0DF2 && cp <= 0x0DF3 -> True
    cp if cp >= 0x0F3E && cp <= 0x0F3F -> True
    cp if cp == 0x0F7F -> True
    cp if cp >= 0x102B && cp <= 0x102C -> True
    cp if cp == 0x1031 -> True
    cp if cp == 0x1038 -> True
    cp if cp >= 0x103B && cp <= 0x103C -> True
    cp if cp >= 0x1056 && cp <= 0x1057 -> True
    cp if cp >= 0x1062 && cp <= 0x1064 -> True
    cp if cp >= 0x1067 && cp <= 0x106D -> True
    cp if cp >= 0x1083 && cp <= 0x1084 -> True
    cp if cp >= 0x1087 && cp <= 0x108C -> True
    cp if cp == 0x108F -> True
    cp if cp >= 0x109A && cp <= 0x109C -> True
    cp if cp == 0x1715 -> True
    cp if cp == 0x1734 -> True
    cp if cp == 0x17B6 -> True
    cp if cp >= 0x17BE && cp <= 0x17C5 -> True
    cp if cp >= 0x17C7 && cp <= 0x17C8 -> True
    cp if cp >= 0x1923 && cp <= 0x1926 -> True
    cp if cp >= 0x1929 && cp <= 0x192B -> True
    cp if cp >= 0x1930 && cp <= 0x1931 -> True
    cp if cp >= 0x1933 && cp <= 0x1938 -> True
    cp if cp >= 0x1A19 && cp <= 0x1A1A -> True
    cp if cp == 0x1A55 -> True
    cp if cp == 0x1A57 -> True
    cp if cp == 0x1A61 -> True
    cp if cp >= 0x1A63 && cp <= 0x1A64 -> True
    cp if cp >= 0x1A6D && cp <= 0x1A72 -> True
    cp if cp == 0x1B04 -> True
    cp if cp == 0x1B35 -> True
    cp if cp == 0x1B3B -> True
    cp if cp >= 0x1B3D && cp <= 0x1B41 -> True
    cp if cp >= 0x1B43 && cp <= 0x1B44 -> True
    cp if cp == 0x1B82 -> True
    cp if cp == 0x1BA1 -> True
    cp if cp >= 0x1BA6 && cp <= 0x1BA7 -> True
    cp if cp == 0x1BAA -> True
    cp if cp == 0x1BE7 -> True
    cp if cp >= 0x1BEA && cp <= 0x1BEC -> True
    cp if cp == 0x1BEE -> True
    cp if cp >= 0x1BF2 && cp <= 0x1BF3 -> True
    cp if cp >= 0x1C24 && cp <= 0x1C2B -> True
    cp if cp >= 0x1C34 && cp <= 0x1C35 -> True
    cp if cp == 0x1CE1 -> True
    cp if cp == 0x1CF7 -> True
    cp if cp >= 0x302E && cp <= 0x302F -> True
    cp if cp >= 0xA823 && cp <= 0xA824 -> True
    cp if cp == 0xA827 -> True
    cp if cp >= 0xA880 && cp <= 0xA881 -> True
    cp if cp >= 0xA8B4 && cp <= 0xA8C3 -> True
    cp if cp >= 0xA952 && cp <= 0xA953 -> True
    cp if cp == 0xA983 -> True
    cp if cp >= 0xA9B4 && cp <= 0xA9B5 -> True
    cp if cp >= 0xA9BA && cp <= 0xA9BB -> True
    cp if cp >= 0xA9BE && cp <= 0xA9C0 -> True
    cp if cp >= 0xAA2F && cp <= 0xAA30 -> True
    cp if cp >= 0xAA33 && cp <= 0xAA34 -> True
    cp if cp == 0xAA4D -> True
    cp if cp == 0xAA7B -> True
    cp if cp == 0xAA7D -> True
    cp if cp == 0xAAEB -> True
    cp if cp >= 0xAAEE && cp <= 0xAAEF -> True
    cp if cp == 0xAAF5 -> True
    cp if cp >= 0xABE3 && cp <= 0xABE4 -> True
    cp if cp >= 0xABE6 && cp <= 0xABE7 -> True
    cp if cp >= 0xABE9 && cp <= 0xABEA -> True
    cp if cp == 0xABEC -> True
    cp if cp == 0x11000 -> True
    cp if cp == 0x11002 -> True
    cp if cp == 0x11082 -> True
    cp if cp >= 0x110B0 && cp <= 0x110B2 -> True
    cp if cp >= 0x110B7 && cp <= 0x110B8 -> True
    cp if cp == 0x1112C -> True
    cp if cp >= 0x11145 && cp <= 0x11146 -> True
    cp if cp == 0x11182 -> True
    cp if cp >= 0x111B3 && cp <= 0x111B5 -> True
    cp if cp >= 0x111BF && cp <= 0x111C0 -> True
    cp if cp == 0x111CE -> True
    cp if cp >= 0x1122C && cp <= 0x1122E -> True
    cp if cp >= 0x11232 && cp <= 0x11233 -> True
    cp if cp == 0x11235 -> True
    cp if cp >= 0x112E0 && cp <= 0x112E2 -> True
    cp if cp >= 0x11302 && cp <= 0x11303 -> True
    cp if cp >= 0x1133E && cp <= 0x1133F -> True
    cp if cp >= 0x11341 && cp <= 0x11344 -> True
    cp if cp >= 0x11347 && cp <= 0x11348 -> True
    cp if cp >= 0x1134B && cp <= 0x1134D -> True
    cp if cp == 0x11357 -> True
    cp if cp >= 0x11362 && cp <= 0x11363 -> True
    cp if cp >= 0x113B8 && cp <= 0x113BA -> True
    cp if cp == 0x113C2 -> True
    cp if cp == 0x113C5 -> True
    cp if cp >= 0x113C7 && cp <= 0x113CA -> True
    cp if cp >= 0x113CC && cp <= 0x113CD -> True
    cp if cp == 0x113CF -> True
    cp if cp >= 0x11435 && cp <= 0x11437 -> True
    cp if cp >= 0x11440 && cp <= 0x11441 -> True
    cp if cp == 0x11445 -> True
    cp if cp >= 0x114B0 && cp <= 0x114B2 -> True
    cp if cp == 0x114B9 -> True
    cp if cp >= 0x114BB && cp <= 0x114BE -> True
    cp if cp == 0x114C1 -> True
    cp if cp >= 0x115AF && cp <= 0x115B1 -> True
    cp if cp >= 0x115B8 && cp <= 0x115BB -> True
    cp if cp == 0x115BE -> True
    cp if cp >= 0x11630 && cp <= 0x11632 -> True
    cp if cp >= 0x1163B && cp <= 0x1163C -> True
    cp if cp == 0x1163E -> True
    cp if cp == 0x116AC -> True
    cp if cp >= 0x116AE && cp <= 0x116AF -> True
    cp if cp == 0x116B6 -> True
    cp if cp == 0x1171E -> True
    cp if cp >= 0x11720 && cp <= 0x11721 -> True
    cp if cp == 0x11726 -> True
    cp if cp >= 0x1182C && cp <= 0x1182E -> True
    cp if cp == 0x11838 -> True
    cp if cp >= 0x11930 && cp <= 0x11935 -> True
    cp if cp >= 0x11937 && cp <= 0x11938 -> True
    cp if cp == 0x1193D -> True
    cp if cp == 0x11940 -> True
    cp if cp == 0x11942 -> True
    cp if cp >= 0x119D1 && cp <= 0x119D3 -> True
    cp if cp >= 0x119DC && cp <= 0x119DF -> True
    cp if cp == 0x119E4 -> True
    cp if cp == 0x11A39 -> True
    cp if cp >= 0x11A57 && cp <= 0x11A58 -> True
    cp if cp == 0x11A97 -> True
    cp if cp == 0x11C2F -> True
    cp if cp == 0x11C3E -> True
    cp if cp == 0x11CA9 -> True
    cp if cp == 0x11CB1 -> True
    cp if cp == 0x11CB4 -> True
    cp if cp >= 0x11D8A && cp <= 0x11D8E -> True
    cp if cp >= 0x11D93 && cp <= 0x11D94 -> True
    cp if cp == 0x11D96 -> True
    cp if cp >= 0x11EF5 && cp <= 0x11EF6 -> True
    cp if cp == 0x11F03 -> True
    cp if cp >= 0x11F34 && cp <= 0x11F35 -> True
    cp if cp >= 0x11F3E && cp <= 0x11F3F -> True
    cp if cp == 0x11F41 -> True
    cp if cp >= 0x1612A && cp <= 0x1612C -> True
    cp if cp >= 0x16F51 && cp <= 0x16F87 -> True
    cp if cp >= 0x16FF0 && cp <= 0x16FF1 -> True
    cp if cp >= 0x1D165 && cp <= 0x1D166 -> True
    cp if cp >= 0x1D16D && cp <= 0x1D172 -> True
    cp if cp >= 0x0030 && cp <= 0x0039 -> True
    cp if cp >= 0x0660 && cp <= 0x0669 -> True
    cp if cp >= 0x06F0 && cp <= 0x06F9 -> True
    cp if cp >= 0x07C0 && cp <= 0x07C9 -> True
    cp if cp >= 0x0966 && cp <= 0x096F -> True
    cp if cp >= 0x09E6 && cp <= 0x09EF -> True
    cp if cp >= 0x0A66 && cp <= 0x0A6F -> True
    cp if cp >= 0x0AE6 && cp <= 0x0AEF -> True
    cp if cp >= 0x0B66 && cp <= 0x0B6F -> True
    cp if cp >= 0x0BE6 && cp <= 0x0BEF -> True
    cp if cp >= 0x0C66 && cp <= 0x0C6F -> True
    cp if cp >= 0x0CE6 && cp <= 0x0CEF -> True
    cp if cp >= 0x0D66 && cp <= 0x0D6F -> True
    cp if cp >= 0x0DE6 && cp <= 0x0DEF -> True
    cp if cp >= 0x0E50 && cp <= 0x0E59 -> True
    cp if cp >= 0x0ED0 && cp <= 0x0ED9 -> True
    cp if cp >= 0x0F20 && cp <= 0x0F29 -> True
    cp if cp >= 0x1040 && cp <= 0x1049 -> True
    cp if cp >= 0x1090 && cp <= 0x1099 -> True
    cp if cp >= 0x17E0 && cp <= 0x17E9 -> True
    cp if cp >= 0x1810 && cp <= 0x1819 -> True
    cp if cp >= 0x1946 && cp <= 0x194F -> True
    cp if cp >= 0x19D0 && cp <= 0x19D9 -> True
    cp if cp >= 0x1A80 && cp <= 0x1A89 -> True
    cp if cp >= 0x1A90 && cp <= 0x1A99 -> True
    cp if cp >= 0x1B50 && cp <= 0x1B59 -> True
    cp if cp >= 0x1BB0 && cp <= 0x1BB9 -> True
    cp if cp >= 0x1C40 && cp <= 0x1C49 -> True
    cp if cp >= 0x1C50 && cp <= 0x1C59 -> True
    cp if cp >= 0xA620 && cp <= 0xA629 -> True
    cp if cp >= 0xA8D0 && cp <= 0xA8D9 -> True
    cp if cp >= 0xA900 && cp <= 0xA909 -> True
    cp if cp >= 0xA9D0 && cp <= 0xA9D9 -> True
    cp if cp >= 0xA9F0 && cp <= 0xA9F9 -> True
    cp if cp >= 0xAA50 && cp <= 0xAA59 -> True
    cp if cp >= 0xABF0 && cp <= 0xABF9 -> True
    cp if cp >= 0xFF10 && cp <= 0xFF19 -> True
    cp if cp >= 0x104A0 && cp <= 0x104A9 -> True
    cp if cp >= 0x10D30 && cp <= 0x10D39 -> True
    cp if cp >= 0x10D40 && cp <= 0x10D49 -> True
    cp if cp >= 0x11066 && cp <= 0x1106F -> True
    cp if cp >= 0x110F0 && cp <= 0x110F9 -> True
    cp if cp >= 0x11136 && cp <= 0x1113F -> True
    cp if cp >= 0x111D0 && cp <= 0x111D9 -> True
    cp if cp >= 0x112F0 && cp <= 0x112F9 -> True
    cp if cp >= 0x11450 && cp <= 0x11459 -> True
    cp if cp >= 0x114D0 && cp <= 0x114D9 -> True
    cp if cp >= 0x11650 && cp <= 0x11659 -> True
    cp if cp >= 0x116C0 && cp <= 0x116C9 -> True
    cp if cp >= 0x116D0 && cp <= 0x116E3 -> True
    cp if cp >= 0x11730 && cp <= 0x11739 -> True
    cp if cp >= 0x118E0 && cp <= 0x118E9 -> True
    cp if cp >= 0x11950 && cp <= 0x11959 -> True
    cp if cp >= 0x11BF0 && cp <= 0x11BF9 -> True
    cp if cp >= 0x11C50 && cp <= 0x11C59 -> True
    cp if cp >= 0x11D50 && cp <= 0x11D59 -> True
    cp if cp >= 0x11DA0 && cp <= 0x11DA9 -> True
    cp if cp >= 0x11F50 && cp <= 0x11F59 -> True
    cp if cp >= 0x16130 && cp <= 0x16139 -> True
    cp if cp >= 0x16A60 && cp <= 0x16A69 -> True
    cp if cp >= 0x16AC0 && cp <= 0x16AC9 -> True
    cp if cp >= 0x16B50 && cp <= 0x16B59 -> True
    cp if cp >= 0x16D70 && cp <= 0x16D79 -> True
    cp if cp >= 0x1CCF0 && cp <= 0x1CCF9 -> True
    cp if cp >= 0x1D7CE && cp <= 0x1D7FF -> True
    cp if cp >= 0x1E140 && cp <= 0x1E149 -> True
    cp if cp >= 0x1E2F0 && cp <= 0x1E2F9 -> True
    cp if cp >= 0x1E4F0 && cp <= 0x1E4F9 -> True
    cp if cp >= 0x1E5F1 && cp <= 0x1E5FA -> True
    cp if cp >= 0x1E950 && cp <= 0x1E959 -> True
    cp if cp >= 0x1FBF0 && cp <= 0x1FBF9 -> True
    _ -> False
  }
}

pub fn in_other_letter_digit(codepoint: Int) -> Bool {
  case codepoint {
    cp if cp == 0x01C5 -> True
    cp if cp == 0x01C8 -> True
    cp if cp == 0x01CB -> True
    cp if cp == 0x01F2 -> True
    cp if cp >= 0x1F88 && cp <= 0x1F8F -> True
    cp if cp >= 0x1F98 && cp <= 0x1F9F -> True
    cp if cp >= 0x1FA8 && cp <= 0x1FAF -> True
    cp if cp == 0x1FBC -> True
    cp if cp == 0x1FCC -> True
    cp if cp == 0x1FFC -> True
    cp if cp >= 0x0488 && cp <= 0x0489 -> True
    cp if cp == 0x1ABE -> True
    cp if cp >= 0x20DD && cp <= 0x20E0 -> True
    cp if cp >= 0x20E2 && cp <= 0x20E4 -> True
    cp if cp >= 0xA670 && cp <= 0xA672 -> True
    cp if cp >= 0x16EE && cp <= 0x16F0 -> True
    cp if cp >= 0x2160 && cp <= 0x2182 -> True
    cp if cp >= 0x2185 && cp <= 0x2188 -> True
    cp if cp == 0x3007 -> True
    cp if cp >= 0x3021 && cp <= 0x3029 -> True
    cp if cp >= 0x3038 && cp <= 0x303A -> True
    cp if cp >= 0xA6E6 && cp <= 0xA6EF -> True
    cp if cp >= 0x10140 && cp <= 0x10174 -> True
    cp if cp == 0x10341 -> True
    cp if cp == 0x1034A -> True
    cp if cp >= 0x103D1 && cp <= 0x103D5 -> True
    cp if cp >= 0x12400 && cp <= 0x1246E -> True
    cp if cp >= 0x00B2 && cp <= 0x00B3 -> True
    cp if cp == 0x00B9 -> True
    cp if cp >= 0x00BC && cp <= 0x00BE -> True
    cp if cp >= 0x09F4 && cp <= 0x09F9 -> True
    cp if cp >= 0x0B72 && cp <= 0x0B77 -> True
    cp if cp >= 0x0BF0 && cp <= 0x0BF2 -> True
    cp if cp >= 0x0C78 && cp <= 0x0C7E -> True
    cp if cp >= 0x0D58 && cp <= 0x0D5E -> True
    cp if cp >= 0x0D70 && cp <= 0x0D78 -> True
    cp if cp >= 0x0F2A && cp <= 0x0F33 -> True
    cp if cp >= 0x1369 && cp <= 0x137C -> True
    cp if cp >= 0x17F0 && cp <= 0x17F9 -> True
    cp if cp == 0x19DA -> True
    cp if cp == 0x2070 -> True
    cp if cp >= 0x2074 && cp <= 0x2079 -> True
    cp if cp >= 0x2080 && cp <= 0x2089 -> True
    cp if cp >= 0x2150 && cp <= 0x215F -> True
    cp if cp == 0x2189 -> True
    cp if cp >= 0x2460 && cp <= 0x249B -> True
    cp if cp >= 0x24EA && cp <= 0x24FF -> True
    cp if cp >= 0x2776 && cp <= 0x2793 -> True
    cp if cp == 0x2CFD -> True
    cp if cp >= 0x3192 && cp <= 0x3195 -> True
    cp if cp >= 0x3220 && cp <= 0x3229 -> True
    cp if cp >= 0x3248 && cp <= 0x324F -> True
    cp if cp >= 0x3251 && cp <= 0x325F -> True
    cp if cp >= 0x3280 && cp <= 0x3289 -> True
    cp if cp >= 0x32B1 && cp <= 0x32BF -> True
    cp if cp >= 0xA830 && cp <= 0xA835 -> True
    cp if cp >= 0x10107 && cp <= 0x10133 -> True
    cp if cp >= 0x10175 && cp <= 0x10178 -> True
    cp if cp >= 0x1018A && cp <= 0x1018B -> True
    cp if cp >= 0x102E1 && cp <= 0x102FB -> True
    cp if cp >= 0x10320 && cp <= 0x10323 -> True
    cp if cp >= 0x10858 && cp <= 0x1085F -> True
    cp if cp >= 0x10879 && cp <= 0x1087F -> True
    cp if cp >= 0x108A7 && cp <= 0x108AF -> True
    cp if cp >= 0x108FB && cp <= 0x108FF -> True
    cp if cp >= 0x10916 && cp <= 0x1091B -> True
    cp if cp >= 0x109BC && cp <= 0x109BD -> True
    cp if cp >= 0x109C0 && cp <= 0x109CF -> True
    cp if cp >= 0x109D2 && cp <= 0x109FF -> True
    cp if cp >= 0x10A40 && cp <= 0x10A48 -> True
    cp if cp >= 0x10A7D && cp <= 0x10A7E -> True
    cp if cp >= 0x10A9D && cp <= 0x10A9F -> True
    cp if cp >= 0x10AEB && cp <= 0x10AEF -> True
    cp if cp >= 0x10B58 && cp <= 0x10B5F -> True
    cp if cp >= 0x10B78 && cp <= 0x10B7F -> True
    cp if cp >= 0x10BA9 && cp <= 0x10BAF -> True
    cp if cp >= 0x10CFA && cp <= 0x10CFF -> True
    cp if cp >= 0x10E60 && cp <= 0x10E7E -> True
    cp if cp >= 0x10F1D && cp <= 0x10F26 -> True
    cp if cp >= 0x10F51 && cp <= 0x10F54 -> True
    cp if cp >= 0x10FC5 && cp <= 0x10FCB -> True
    cp if cp >= 0x11052 && cp <= 0x11065 -> True
    cp if cp >= 0x111E1 && cp <= 0x111F4 -> True
    cp if cp >= 0x1173A && cp <= 0x1173B -> True
    cp if cp >= 0x118EA && cp <= 0x118F2 -> True
    cp if cp >= 0x11C5A && cp <= 0x11C6C -> True
    cp if cp >= 0x11FC0 && cp <= 0x11FD4 -> True
    cp if cp >= 0x16B5B && cp <= 0x16B61 -> True
    cp if cp >= 0x16E80 && cp <= 0x16E96 -> True
    cp if cp >= 0x1D2C0 && cp <= 0x1D2D3 -> True
    cp if cp >= 0x1D2E0 && cp <= 0x1D2F3 -> True
    cp if cp >= 0x1D360 && cp <= 0x1D378 -> True
    cp if cp >= 0x1E8C7 && cp <= 0x1E8CF -> True
    cp if cp >= 0x1EC71 && cp <= 0x1ECAB -> True
    cp if cp >= 0x1ECAD && cp <= 0x1ECAF -> True
    cp if cp >= 0x1ECB1 && cp <= 0x1ECB4 -> True
    cp if cp >= 0x1ED01 && cp <= 0x1ED2D -> True
    cp if cp >= 0x1ED2F && cp <= 0x1ED3D -> True
    cp if cp >= 0x1F100 && cp <= 0x1F10C -> True
    _ -> False
  }
}

pub fn in_punctuation(codepoint: Int) -> Bool {
  case codepoint {
    cp if cp == 0x002D -> True
    cp if cp == 0x058A -> True
    cp if cp == 0x05BE -> True
    cp if cp == 0x1400 -> True
    cp if cp == 0x1806 -> True
    cp if cp >= 0x2010 && cp <= 0x2015 -> True
    cp if cp == 0x2E17 -> True
    cp if cp == 0x2E1A -> True
    cp if cp >= 0x2E3A && cp <= 0x2E3B -> True
    cp if cp == 0x2E40 -> True
    cp if cp == 0x2E5D -> True
    cp if cp == 0x301C -> True
    cp if cp == 0x3030 -> True
    cp if cp == 0x30A0 -> True
    cp if cp >= 0xFE31 && cp <= 0xFE32 -> True
    cp if cp == 0xFE58 -> True
    cp if cp == 0xFE63 -> True
    cp if cp == 0xFF0D -> True
    cp if cp == 0x10D6E -> True
    cp if cp == 0x10EAD -> True
    cp if cp == 0x0028 -> True
    cp if cp == 0x005B -> True
    cp if cp == 0x007B -> True
    cp if cp == 0x0F3A -> True
    cp if cp == 0x0F3C -> True
    cp if cp == 0x169B -> True
    cp if cp == 0x201A -> True
    cp if cp == 0x201E -> True
    cp if cp == 0x2045 -> True
    cp if cp == 0x207D -> True
    cp if cp == 0x208D -> True
    cp if cp == 0x2308 -> True
    cp if cp == 0x230A -> True
    cp if cp == 0x2329 -> True
    cp if cp == 0x2768 -> True
    cp if cp == 0x276A -> True
    cp if cp == 0x276C -> True
    cp if cp == 0x276E -> True
    cp if cp == 0x2770 -> True
    cp if cp == 0x2772 -> True
    cp if cp == 0x2774 -> True
    cp if cp == 0x27C5 -> True
    cp if cp == 0x27E6 -> True
    cp if cp == 0x27E8 -> True
    cp if cp == 0x27EA -> True
    cp if cp == 0x27EC -> True
    cp if cp == 0x27EE -> True
    cp if cp == 0x2983 -> True
    cp if cp == 0x2985 -> True
    cp if cp == 0x2987 -> True
    cp if cp == 0x2989 -> True
    cp if cp == 0x298B -> True
    cp if cp == 0x298D -> True
    cp if cp == 0x298F -> True
    cp if cp == 0x2991 -> True
    cp if cp == 0x2993 -> True
    cp if cp == 0x2995 -> True
    cp if cp == 0x2997 -> True
    cp if cp == 0x29D8 -> True
    cp if cp == 0x29DA -> True
    cp if cp == 0x29FC -> True
    cp if cp == 0x2E22 -> True
    cp if cp == 0x2E24 -> True
    cp if cp == 0x2E26 -> True
    cp if cp == 0x2E28 -> True
    cp if cp == 0x2E42 -> True
    cp if cp == 0x2E55 -> True
    cp if cp == 0x2E57 -> True
    cp if cp == 0x2E59 -> True
    cp if cp == 0x2E5B -> True
    cp if cp == 0x3008 -> True
    cp if cp == 0x300A -> True
    cp if cp == 0x300C -> True
    cp if cp == 0x300E -> True
    cp if cp == 0x3010 -> True
    cp if cp == 0x3014 -> True
    cp if cp == 0x3016 -> True
    cp if cp == 0x3018 -> True
    cp if cp == 0x301A -> True
    cp if cp == 0x301D -> True
    cp if cp == 0xFD3F -> True
    cp if cp == 0xFE17 -> True
    cp if cp == 0xFE35 -> True
    cp if cp == 0xFE37 -> True
    cp if cp == 0xFE39 -> True
    cp if cp == 0xFE3B -> True
    cp if cp == 0xFE3D -> True
    cp if cp == 0xFE3F -> True
    cp if cp == 0xFE41 -> True
    cp if cp == 0xFE43 -> True
    cp if cp == 0xFE47 -> True
    cp if cp == 0xFE59 -> True
    cp if cp == 0xFE5B -> True
    cp if cp == 0xFE5D -> True
    cp if cp == 0xFF08 -> True
    cp if cp == 0xFF3B -> True
    cp if cp == 0xFF5B -> True
    cp if cp == 0xFF5F -> True
    cp if cp == 0xFF62 -> True
    cp if cp == 0x0029 -> True
    cp if cp == 0x005D -> True
    cp if cp == 0x007D -> True
    cp if cp == 0x0F3B -> True
    cp if cp == 0x0F3D -> True
    cp if cp == 0x169C -> True
    cp if cp == 0x2046 -> True
    cp if cp == 0x207E -> True
    cp if cp == 0x208E -> True
    cp if cp == 0x2309 -> True
    cp if cp == 0x230B -> True
    cp if cp == 0x232A -> True
    cp if cp == 0x2769 -> True
    cp if cp == 0x276B -> True
    cp if cp == 0x276D -> True
    cp if cp == 0x276F -> True
    cp if cp == 0x2771 -> True
    cp if cp == 0x2773 -> True
    cp if cp == 0x2775 -> True
    cp if cp == 0x27C6 -> True
    cp if cp == 0x27E7 -> True
    cp if cp == 0x27E9 -> True
    cp if cp == 0x27EB -> True
    cp if cp == 0x27ED -> True
    cp if cp == 0x27EF -> True
    cp if cp == 0x2984 -> True
    cp if cp == 0x2986 -> True
    cp if cp == 0x2988 -> True
    cp if cp == 0x298A -> True
    cp if cp == 0x298C -> True
    cp if cp == 0x298E -> True
    cp if cp == 0x2990 -> True
    cp if cp == 0x2992 -> True
    cp if cp == 0x2994 -> True
    cp if cp == 0x2996 -> True
    cp if cp == 0x2998 -> True
    cp if cp == 0x29D9 -> True
    cp if cp == 0x29DB -> True
    cp if cp == 0x29FD -> True
    cp if cp == 0x2E23 -> True
    cp if cp == 0x2E25 -> True
    cp if cp == 0x2E27 -> True
    cp if cp == 0x2E29 -> True
    cp if cp == 0x2E56 -> True
    cp if cp == 0x2E58 -> True
    cp if cp == 0x2E5A -> True
    cp if cp == 0x2E5C -> True
    cp if cp == 0x3009 -> True
    cp if cp == 0x300B -> True
    cp if cp == 0x300D -> True
    cp if cp == 0x300F -> True
    cp if cp == 0x3011 -> True
    cp if cp == 0x3015 -> True
    cp if cp == 0x3017 -> True
    cp if cp == 0x3019 -> True
    cp if cp == 0x301B -> True
    cp if cp >= 0x301E && cp <= 0x301F -> True
    cp if cp == 0xFD3E -> True
    cp if cp == 0xFE18 -> True
    cp if cp == 0xFE36 -> True
    cp if cp == 0xFE38 -> True
    cp if cp == 0xFE3A -> True
    cp if cp == 0xFE3C -> True
    cp if cp == 0xFE3E -> True
    cp if cp == 0xFE40 -> True
    cp if cp == 0xFE42 -> True
    cp if cp == 0xFE44 -> True
    cp if cp == 0xFE48 -> True
    cp if cp == 0xFE5A -> True
    cp if cp == 0xFE5C -> True
    cp if cp == 0xFE5E -> True
    cp if cp == 0xFF09 -> True
    cp if cp == 0xFF3D -> True
    cp if cp == 0xFF5D -> True
    cp if cp == 0xFF60 -> True
    cp if cp == 0xFF63 -> True
    cp if cp == 0x005F -> True
    cp if cp >= 0x203F && cp <= 0x2040 -> True
    cp if cp == 0x2054 -> True
    cp if cp >= 0xFE33 && cp <= 0xFE34 -> True
    cp if cp >= 0xFE4D && cp <= 0xFE4F -> True
    cp if cp == 0xFF3F -> True
    cp if cp >= 0x0021 && cp <= 0x0023 -> True
    cp if cp >= 0x0025 && cp <= 0x0027 -> True
    cp if cp == 0x002A -> True
    cp if cp == 0x002C -> True
    cp if cp >= 0x002E && cp <= 0x002F -> True
    cp if cp >= 0x003A && cp <= 0x003B -> True
    cp if cp >= 0x003F && cp <= 0x0040 -> True
    cp if cp == 0x005C -> True
    cp if cp == 0x00A1 -> True
    cp if cp == 0x00A7 -> True
    cp if cp >= 0x00B6 && cp <= 0x00B7 -> True
    cp if cp == 0x00BF -> True
    cp if cp == 0x037E -> True
    cp if cp == 0x0387 -> True
    cp if cp >= 0x055A && cp <= 0x055F -> True
    cp if cp == 0x0589 -> True
    cp if cp == 0x05C0 -> True
    cp if cp == 0x05C3 -> True
    cp if cp == 0x05C6 -> True
    cp if cp >= 0x05F3 && cp <= 0x05F4 -> True
    cp if cp >= 0x0609 && cp <= 0x060A -> True
    cp if cp >= 0x060C && cp <= 0x060D -> True
    cp if cp == 0x061B -> True
    cp if cp >= 0x061D && cp <= 0x061F -> True
    cp if cp >= 0x066A && cp <= 0x066D -> True
    cp if cp == 0x06D4 -> True
    cp if cp >= 0x0700 && cp <= 0x070D -> True
    cp if cp >= 0x07F7 && cp <= 0x07F9 -> True
    cp if cp >= 0x0830 && cp <= 0x083E -> True
    cp if cp == 0x085E -> True
    cp if cp >= 0x0964 && cp <= 0x0965 -> True
    cp if cp == 0x0970 -> True
    cp if cp == 0x09FD -> True
    cp if cp == 0x0A76 -> True
    cp if cp == 0x0AF0 -> True
    cp if cp == 0x0C77 -> True
    cp if cp == 0x0C84 -> True
    cp if cp == 0x0DF4 -> True
    cp if cp == 0x0E4F -> True
    cp if cp >= 0x0E5A && cp <= 0x0E5B -> True
    cp if cp >= 0x0F04 && cp <= 0x0F12 -> True
    cp if cp == 0x0F14 -> True
    cp if cp == 0x0F85 -> True
    cp if cp >= 0x0FD0 && cp <= 0x0FD4 -> True
    cp if cp >= 0x0FD9 && cp <= 0x0FDA -> True
    cp if cp >= 0x104A && cp <= 0x104F -> True
    cp if cp == 0x10FB -> True
    cp if cp >= 0x1360 && cp <= 0x1368 -> True
    cp if cp == 0x166E -> True
    cp if cp >= 0x16EB && cp <= 0x16ED -> True
    cp if cp >= 0x1735 && cp <= 0x1736 -> True
    cp if cp >= 0x17D4 && cp <= 0x17D6 -> True
    cp if cp >= 0x17D8 && cp <= 0x17DA -> True
    cp if cp >= 0x1800 && cp <= 0x1805 -> True
    cp if cp >= 0x1807 && cp <= 0x180A -> True
    cp if cp >= 0x1944 && cp <= 0x1945 -> True
    cp if cp >= 0x1A1E && cp <= 0x1A1F -> True
    cp if cp >= 0x1AA0 && cp <= 0x1AA6 -> True
    cp if cp >= 0x1AA8 && cp <= 0x1AAD -> True
    cp if cp >= 0x1B4E && cp <= 0x1B4F -> True
    cp if cp >= 0x1B5A && cp <= 0x1B60 -> True
    cp if cp >= 0x1B7D && cp <= 0x1B7F -> True
    cp if cp >= 0x1BFC && cp <= 0x1BFF -> True
    cp if cp >= 0x1C3B && cp <= 0x1C3F -> True
    cp if cp >= 0x1C7E && cp <= 0x1C7F -> True
    cp if cp >= 0x1CC0 && cp <= 0x1CC7 -> True
    cp if cp == 0x1CD3 -> True
    cp if cp >= 0x2016 && cp <= 0x2017 -> True
    cp if cp >= 0x2020 && cp <= 0x2027 -> True
    cp if cp >= 0x2030 && cp <= 0x2038 -> True
    cp if cp >= 0x203B && cp <= 0x203E -> True
    cp if cp >= 0x2041 && cp <= 0x2043 -> True
    cp if cp >= 0x2047 && cp <= 0x2051 -> True
    cp if cp == 0x2053 -> True
    cp if cp >= 0x2055 && cp <= 0x205E -> True
    cp if cp >= 0x2CF9 && cp <= 0x2CFC -> True
    cp if cp >= 0x2CFE && cp <= 0x2CFF -> True
    cp if cp == 0x2D70 -> True
    cp if cp >= 0x2E00 && cp <= 0x2E01 -> True
    cp if cp >= 0x2E06 && cp <= 0x2E08 -> True
    cp if cp == 0x2E0B -> True
    cp if cp >= 0x2E0E && cp <= 0x2E16 -> True
    cp if cp >= 0x2E18 && cp <= 0x2E19 -> True
    cp if cp == 0x2E1B -> True
    cp if cp >= 0x2E1E && cp <= 0x2E1F -> True
    cp if cp >= 0x2E2A && cp <= 0x2E2E -> True
    cp if cp >= 0x2E30 && cp <= 0x2E39 -> True
    cp if cp >= 0x2E3C && cp <= 0x2E3F -> True
    cp if cp == 0x2E41 -> True
    cp if cp >= 0x2E43 && cp <= 0x2E4F -> True
    cp if cp >= 0x2E52 && cp <= 0x2E54 -> True
    cp if cp >= 0x3001 && cp <= 0x3003 -> True
    cp if cp == 0x303D -> True
    cp if cp == 0x30FB -> True
    cp if cp >= 0xA4FE && cp <= 0xA4FF -> True
    cp if cp >= 0xA60D && cp <= 0xA60F -> True
    cp if cp == 0xA673 -> True
    cp if cp == 0xA67E -> True
    cp if cp >= 0xA6F2 && cp <= 0xA6F7 -> True
    cp if cp >= 0xA874 && cp <= 0xA877 -> True
    cp if cp >= 0xA8CE && cp <= 0xA8CF -> True
    cp if cp >= 0xA8F8 && cp <= 0xA8FA -> True
    cp if cp == 0xA8FC -> True
    cp if cp >= 0xA92E && cp <= 0xA92F -> True
    cp if cp == 0xA95F -> True
    cp if cp >= 0xA9C1 && cp <= 0xA9CD -> True
    cp if cp >= 0xA9DE && cp <= 0xA9DF -> True
    cp if cp >= 0xAA5C && cp <= 0xAA5F -> True
    cp if cp >= 0xAADE && cp <= 0xAADF -> True
    cp if cp >= 0xAAF0 && cp <= 0xAAF1 -> True
    cp if cp == 0xABEB -> True
    cp if cp >= 0xFE10 && cp <= 0xFE16 -> True
    cp if cp == 0xFE19 -> True
    cp if cp == 0xFE30 -> True
    cp if cp >= 0xFE45 && cp <= 0xFE46 -> True
    cp if cp >= 0xFE49 && cp <= 0xFE4C -> True
    cp if cp >= 0xFE50 && cp <= 0xFE52 -> True
    cp if cp >= 0xFE54 && cp <= 0xFE57 -> True
    cp if cp >= 0xFE5F && cp <= 0xFE61 -> True
    cp if cp == 0xFE68 -> True
    cp if cp >= 0xFE6A && cp <= 0xFE6B -> True
    cp if cp >= 0xFF01 && cp <= 0xFF03 -> True
    cp if cp >= 0xFF05 && cp <= 0xFF07 -> True
    cp if cp == 0xFF0A -> True
    cp if cp == 0xFF0C -> True
    cp if cp >= 0xFF0E && cp <= 0xFF0F -> True
    cp if cp >= 0xFF1A && cp <= 0xFF1B -> True
    cp if cp >= 0xFF1F && cp <= 0xFF20 -> True
    cp if cp == 0xFF3C -> True
    cp if cp == 0xFF61 -> True
    cp if cp >= 0xFF64 && cp <= 0xFF65 -> True
    cp if cp >= 0x10100 && cp <= 0x10102 -> True
    cp if cp == 0x1039F -> True
    cp if cp == 0x103D0 -> True
    cp if cp == 0x1056F -> True
    cp if cp == 0x10857 -> True
    cp if cp == 0x1091F -> True
    cp if cp == 0x1093F -> True
    cp if cp >= 0x10A50 && cp <= 0x10A58 -> True
    cp if cp == 0x10A7F -> True
    cp if cp >= 0x10AF0 && cp <= 0x10AF6 -> True
    cp if cp >= 0x10B39 && cp <= 0x10B3F -> True
    cp if cp >= 0x10B99 && cp <= 0x10B9C -> True
    cp if cp >= 0x10F55 && cp <= 0x10F59 -> True
    cp if cp >= 0x10F86 && cp <= 0x10F89 -> True
    cp if cp >= 0x11047 && cp <= 0x1104D -> True
    cp if cp >= 0x110BB && cp <= 0x110BC -> True
    cp if cp >= 0x110BE && cp <= 0x110C1 -> True
    cp if cp >= 0x11140 && cp <= 0x11143 -> True
    cp if cp >= 0x11174 && cp <= 0x11175 -> True
    cp if cp >= 0x111C5 && cp <= 0x111C8 -> True
    cp if cp == 0x111CD -> True
    cp if cp == 0x111DB -> True
    cp if cp >= 0x111DD && cp <= 0x111DF -> True
    cp if cp >= 0x11238 && cp <= 0x1123D -> True
    cp if cp == 0x112A9 -> True
    cp if cp >= 0x113D4 && cp <= 0x113D5 -> True
    cp if cp >= 0x113D7 && cp <= 0x113D8 -> True
    cp if cp >= 0x1144B && cp <= 0x1144F -> True
    cp if cp >= 0x1145A && cp <= 0x1145B -> True
    cp if cp == 0x1145D -> True
    cp if cp == 0x114C6 -> True
    cp if cp >= 0x115C1 && cp <= 0x115D7 -> True
    cp if cp >= 0x11641 && cp <= 0x11643 -> True
    cp if cp >= 0x11660 && cp <= 0x1166C -> True
    cp if cp == 0x116B9 -> True
    cp if cp >= 0x1173C && cp <= 0x1173E -> True
    cp if cp == 0x1183B -> True
    cp if cp >= 0x11944 && cp <= 0x11946 -> True
    cp if cp == 0x119E2 -> True
    cp if cp >= 0x11A3F && cp <= 0x11A46 -> True
    cp if cp >= 0x11A9A && cp <= 0x11A9C -> True
    cp if cp >= 0x11A9E && cp <= 0x11AA2 -> True
    cp if cp >= 0x11B00 && cp <= 0x11B09 -> True
    cp if cp == 0x11BE1 -> True
    cp if cp >= 0x11C41 && cp <= 0x11C45 -> True
    cp if cp >= 0x11C70 && cp <= 0x11C71 -> True
    cp if cp >= 0x11EF7 && cp <= 0x11EF8 -> True
    cp if cp >= 0x11F43 && cp <= 0x11F4F -> True
    cp if cp == 0x11FFF -> True
    cp if cp >= 0x12470 && cp <= 0x12474 -> True
    cp if cp >= 0x12FF1 && cp <= 0x12FF2 -> True
    cp if cp >= 0x16A6E && cp <= 0x16A6F -> True
    cp if cp == 0x16AF5 -> True
    cp if cp >= 0x16B37 && cp <= 0x16B3B -> True
    cp if cp == 0x16B44 -> True
    cp if cp >= 0x16D6D && cp <= 0x16D6F -> True
    cp if cp >= 0x16E97 && cp <= 0x16E9A -> True
    cp if cp == 0x16FE2 -> True
    cp if cp == 0x1BC9F -> True
    cp if cp >= 0x1DA87 && cp <= 0x1DA8B -> True
    cp if cp == 0x1E5FF -> True
    cp if cp >= 0x1E95E && cp <= 0x1E95F -> True
    cp if cp == 0x00AB -> True
    cp if cp == 0x2018 -> True
    cp if cp >= 0x201B && cp <= 0x201C -> True
    cp if cp == 0x201F -> True
    cp if cp == 0x2039 -> True
    cp if cp == 0x2E02 -> True
    cp if cp == 0x2E04 -> True
    cp if cp == 0x2E09 -> True
    cp if cp == 0x2E0C -> True
    cp if cp == 0x2E1C -> True
    cp if cp == 0x2E20 -> True
    cp if cp == 0x00BB -> True
    cp if cp == 0x2019 -> True
    cp if cp == 0x201D -> True
    cp if cp == 0x203A -> True
    cp if cp == 0x2E03 -> True
    cp if cp == 0x2E05 -> True
    cp if cp == 0x2E0A -> True
    cp if cp == 0x2E0D -> True
    cp if cp == 0x2E1D -> True
    cp if cp == 0x2E21 -> True
    _ -> False
  }
}

pub fn in_symbol(codepoint: Int) -> Bool {
  case codepoint {
    cp if cp == 0x002B -> True
    cp if cp >= 0x003C && cp <= 0x003E -> True
    cp if cp == 0x007C -> True
    cp if cp == 0x007E -> True
    cp if cp == 0x00AC -> True
    cp if cp == 0x00B1 -> True
    cp if cp == 0x00D7 -> True
    cp if cp == 0x00F7 -> True
    cp if cp == 0x03F6 -> True
    cp if cp >= 0x0606 && cp <= 0x0608 -> True
    cp if cp == 0x2044 -> True
    cp if cp == 0x2052 -> True
    cp if cp >= 0x207A && cp <= 0x207C -> True
    cp if cp >= 0x208A && cp <= 0x208C -> True
    cp if cp == 0x2118 -> True
    cp if cp >= 0x2140 && cp <= 0x2144 -> True
    cp if cp == 0x214B -> True
    cp if cp >= 0x2190 && cp <= 0x2194 -> True
    cp if cp >= 0x219A && cp <= 0x219B -> True
    cp if cp == 0x21A0 -> True
    cp if cp == 0x21A3 -> True
    cp if cp == 0x21A6 -> True
    cp if cp == 0x21AE -> True
    cp if cp >= 0x21CE && cp <= 0x21CF -> True
    cp if cp == 0x21D2 -> True
    cp if cp == 0x21D4 -> True
    cp if cp >= 0x21F4 && cp <= 0x22FF -> True
    cp if cp >= 0x2320 && cp <= 0x2321 -> True
    cp if cp == 0x237C -> True
    cp if cp >= 0x239B && cp <= 0x23B3 -> True
    cp if cp >= 0x23DC && cp <= 0x23E1 -> True
    cp if cp == 0x25B7 -> True
    cp if cp == 0x25C1 -> True
    cp if cp >= 0x25F8 && cp <= 0x25FF -> True
    cp if cp == 0x266F -> True
    cp if cp >= 0x27C0 && cp <= 0x27C4 -> True
    cp if cp >= 0x27C7 && cp <= 0x27E5 -> True
    cp if cp >= 0x27F0 && cp <= 0x27FF -> True
    cp if cp >= 0x2900 && cp <= 0x2982 -> True
    cp if cp >= 0x2999 && cp <= 0x29D7 -> True
    cp if cp >= 0x29DC && cp <= 0x29FB -> True
    cp if cp >= 0x29FE && cp <= 0x2AFF -> True
    cp if cp >= 0x2B30 && cp <= 0x2B44 -> True
    cp if cp >= 0x2B47 && cp <= 0x2B4C -> True
    cp if cp == 0xFB29 -> True
    cp if cp == 0xFE62 -> True
    cp if cp >= 0xFE64 && cp <= 0xFE66 -> True
    cp if cp == 0xFF0B -> True
    cp if cp >= 0xFF1C && cp <= 0xFF1E -> True
    cp if cp == 0xFF5C -> True
    cp if cp == 0xFF5E -> True
    cp if cp == 0xFFE2 -> True
    cp if cp >= 0xFFE9 && cp <= 0xFFEC -> True
    cp if cp >= 0x10D8E && cp <= 0x10D8F -> True
    cp if cp == 0x1D6C1 -> True
    cp if cp == 0x1D6DB -> True
    cp if cp == 0x1D6FB -> True
    cp if cp == 0x1D715 -> True
    cp if cp == 0x1D735 -> True
    cp if cp == 0x1D74F -> True
    cp if cp == 0x1D76F -> True
    cp if cp == 0x1D789 -> True
    cp if cp == 0x1D7A9 -> True
    cp if cp == 0x1D7C3 -> True
    cp if cp >= 0x1EEF0 && cp <= 0x1EEF1 -> True
    cp if cp == 0x0024 -> True
    cp if cp >= 0x00A2 && cp <= 0x00A5 -> True
    cp if cp == 0x058F -> True
    cp if cp == 0x060B -> True
    cp if cp >= 0x07FE && cp <= 0x07FF -> True
    cp if cp >= 0x09F2 && cp <= 0x09F3 -> True
    cp if cp == 0x09FB -> True
    cp if cp == 0x0AF1 -> True
    cp if cp == 0x0BF9 -> True
    cp if cp == 0x0E3F -> True
    cp if cp == 0x17DB -> True
    cp if cp >= 0x20A0 && cp <= 0x20C0 -> True
    cp if cp == 0xA838 -> True
    cp if cp == 0xFDFC -> True
    cp if cp == 0xFE69 -> True
    cp if cp == 0xFF04 -> True
    cp if cp >= 0xFFE0 && cp <= 0xFFE1 -> True
    cp if cp >= 0xFFE5 && cp <= 0xFFE6 -> True
    cp if cp >= 0x11FDD && cp <= 0x11FE0 -> True
    cp if cp == 0x1E2FF -> True
    cp if cp == 0x1ECB0 -> True
    cp if cp == 0x005E -> True
    cp if cp == 0x0060 -> True
    cp if cp == 0x00A8 -> True
    cp if cp == 0x00AF -> True
    cp if cp == 0x00B4 -> True
    cp if cp == 0x00B8 -> True
    cp if cp >= 0x02C2 && cp <= 0x02C5 -> True
    cp if cp >= 0x02D2 && cp <= 0x02DF -> True
    cp if cp >= 0x02E5 && cp <= 0x02EB -> True
    cp if cp == 0x02ED -> True
    cp if cp >= 0x02EF && cp <= 0x02FF -> True
    cp if cp == 0x0375 -> True
    cp if cp >= 0x0384 && cp <= 0x0385 -> True
    cp if cp == 0x0888 -> True
    cp if cp == 0x1FBD -> True
    cp if cp >= 0x1FBF && cp <= 0x1FC1 -> True
    cp if cp >= 0x1FCD && cp <= 0x1FCF -> True
    cp if cp >= 0x1FDD && cp <= 0x1FDF -> True
    cp if cp >= 0x1FED && cp <= 0x1FEF -> True
    cp if cp >= 0x1FFD && cp <= 0x1FFE -> True
    cp if cp >= 0x309B && cp <= 0x309C -> True
    cp if cp >= 0xA700 && cp <= 0xA716 -> True
    cp if cp >= 0xA720 && cp <= 0xA721 -> True
    cp if cp >= 0xA789 && cp <= 0xA78A -> True
    cp if cp == 0xAB5B -> True
    cp if cp >= 0xAB6A && cp <= 0xAB6B -> True
    cp if cp >= 0xFBB2 && cp <= 0xFBC2 -> True
    cp if cp == 0xFF3E -> True
    cp if cp == 0xFF40 -> True
    cp if cp == 0xFFE3 -> True
    cp if cp >= 0x1F3FB && cp <= 0x1F3FF -> True
    cp if cp == 0x00A6 -> True
    cp if cp == 0x00A9 -> True
    cp if cp == 0x00AE -> True
    cp if cp == 0x00B0 -> True
    cp if cp == 0x0482 -> True
    cp if cp >= 0x058D && cp <= 0x058E -> True
    cp if cp >= 0x060E && cp <= 0x060F -> True
    cp if cp == 0x06DE -> True
    cp if cp == 0x06E9 -> True
    cp if cp >= 0x06FD && cp <= 0x06FE -> True
    cp if cp == 0x07F6 -> True
    cp if cp == 0x09FA -> True
    cp if cp == 0x0B70 -> True
    cp if cp >= 0x0BF3 && cp <= 0x0BF8 -> True
    cp if cp == 0x0BFA -> True
    cp if cp == 0x0C7F -> True
    cp if cp == 0x0D4F -> True
    cp if cp == 0x0D79 -> True
    cp if cp >= 0x0F01 && cp <= 0x0F03 -> True
    cp if cp == 0x0F13 -> True
    cp if cp >= 0x0F15 && cp <= 0x0F17 -> True
    cp if cp >= 0x0F1A && cp <= 0x0F1F -> True
    cp if cp == 0x0F34 -> True
    cp if cp == 0x0F36 -> True
    cp if cp == 0x0F38 -> True
    cp if cp >= 0x0FBE && cp <= 0x0FC5 -> True
    cp if cp >= 0x0FC7 && cp <= 0x0FCC -> True
    cp if cp >= 0x0FCE && cp <= 0x0FCF -> True
    cp if cp >= 0x0FD5 && cp <= 0x0FD8 -> True
    cp if cp >= 0x109E && cp <= 0x109F -> True
    cp if cp >= 0x1390 && cp <= 0x1399 -> True
    cp if cp == 0x166D -> True
    cp if cp == 0x1940 -> True
    cp if cp >= 0x19DE && cp <= 0x19FF -> True
    cp if cp >= 0x1B61 && cp <= 0x1B6A -> True
    cp if cp >= 0x1B74 && cp <= 0x1B7C -> True
    cp if cp >= 0x2100 && cp <= 0x2101 -> True
    cp if cp >= 0x2103 && cp <= 0x2106 -> True
    cp if cp >= 0x2108 && cp <= 0x2109 -> True
    cp if cp == 0x2114 -> True
    cp if cp >= 0x2116 && cp <= 0x2117 -> True
    cp if cp >= 0x211E && cp <= 0x2123 -> True
    cp if cp == 0x2125 -> True
    cp if cp == 0x2127 -> True
    cp if cp == 0x2129 -> True
    cp if cp == 0x212E -> True
    cp if cp >= 0x213A && cp <= 0x213B -> True
    cp if cp == 0x214A -> True
    cp if cp >= 0x214C && cp <= 0x214D -> True
    cp if cp == 0x214F -> True
    cp if cp >= 0x218A && cp <= 0x218B -> True
    cp if cp >= 0x2195 && cp <= 0x2199 -> True
    cp if cp >= 0x219C && cp <= 0x219F -> True
    cp if cp >= 0x21A1 && cp <= 0x21A2 -> True
    cp if cp >= 0x21A4 && cp <= 0x21A5 -> True
    cp if cp >= 0x21A7 && cp <= 0x21AD -> True
    cp if cp >= 0x21AF && cp <= 0x21CD -> True
    cp if cp >= 0x21D0 && cp <= 0x21D1 -> True
    cp if cp == 0x21D3 -> True
    cp if cp >= 0x21D5 && cp <= 0x21F3 -> True
    cp if cp >= 0x2300 && cp <= 0x2307 -> True
    cp if cp >= 0x230C && cp <= 0x231F -> True
    cp if cp >= 0x2322 && cp <= 0x2328 -> True
    cp if cp >= 0x232B && cp <= 0x237B -> True
    cp if cp >= 0x237D && cp <= 0x239A -> True
    cp if cp >= 0x23B4 && cp <= 0x23DB -> True
    cp if cp >= 0x23E2 && cp <= 0x2429 -> True
    cp if cp >= 0x2440 && cp <= 0x244A -> True
    cp if cp >= 0x249C && cp <= 0x24E9 -> True
    cp if cp >= 0x2500 && cp <= 0x25B6 -> True
    cp if cp >= 0x25B8 && cp <= 0x25C0 -> True
    cp if cp >= 0x25C2 && cp <= 0x25F7 -> True
    cp if cp >= 0x2600 && cp <= 0x266E -> True
    cp if cp >= 0x2670 && cp <= 0x2767 -> True
    cp if cp >= 0x2794 && cp <= 0x27BF -> True
    cp if cp >= 0x2800 && cp <= 0x28FF -> True
    cp if cp >= 0x2B00 && cp <= 0x2B2F -> True
    cp if cp >= 0x2B45 && cp <= 0x2B46 -> True
    cp if cp >= 0x2B4D && cp <= 0x2B73 -> True
    cp if cp >= 0x2B76 && cp <= 0x2B95 -> True
    cp if cp >= 0x2B97 && cp <= 0x2BFF -> True
    cp if cp >= 0x2CE5 && cp <= 0x2CEA -> True
    cp if cp >= 0x2E50 && cp <= 0x2E51 -> True
    cp if cp >= 0x2E80 && cp <= 0x2E99 -> True
    cp if cp >= 0x2E9B && cp <= 0x2EF3 -> True
    cp if cp >= 0x2F00 && cp <= 0x2FD5 -> True
    cp if cp >= 0x2FF0 && cp <= 0x2FFF -> True
    cp if cp == 0x3004 -> True
    cp if cp >= 0x3012 && cp <= 0x3013 -> True
    cp if cp == 0x3020 -> True
    cp if cp >= 0x3036 && cp <= 0x3037 -> True
    cp if cp >= 0x303E && cp <= 0x303F -> True
    cp if cp >= 0x3190 && cp <= 0x3191 -> True
    cp if cp >= 0x3196 && cp <= 0x319F -> True
    cp if cp >= 0x31C0 && cp <= 0x31E5 -> True
    cp if cp == 0x31EF -> True
    cp if cp >= 0x3200 && cp <= 0x321E -> True
    cp if cp >= 0x322A && cp <= 0x3247 -> True
    cp if cp == 0x3250 -> True
    cp if cp >= 0x3260 && cp <= 0x327F -> True
    cp if cp >= 0x328A && cp <= 0x32B0 -> True
    cp if cp >= 0x32C0 && cp <= 0x33FF -> True
    cp if cp >= 0x4DC0 && cp <= 0x4DFF -> True
    cp if cp >= 0xA490 && cp <= 0xA4C6 -> True
    cp if cp >= 0xA828 && cp <= 0xA82B -> True
    cp if cp >= 0xA836 && cp <= 0xA837 -> True
    cp if cp == 0xA839 -> True
    cp if cp >= 0xAA77 && cp <= 0xAA79 -> True
    cp if cp >= 0xFD40 && cp <= 0xFD4F -> True
    cp if cp == 0xFDCF -> True
    cp if cp >= 0xFDFD && cp <= 0xFDFF -> True
    cp if cp == 0xFFE4 -> True
    cp if cp == 0xFFE8 -> True
    cp if cp >= 0xFFED && cp <= 0xFFEE -> True
    cp if cp >= 0xFFFC && cp <= 0xFFFD -> True
    cp if cp >= 0x10137 && cp <= 0x1013F -> True
    cp if cp >= 0x10179 && cp <= 0x10189 -> True
    cp if cp >= 0x1018C && cp <= 0x1018E -> True
    cp if cp >= 0x10190 && cp <= 0x1019C -> True
    cp if cp == 0x101A0 -> True
    cp if cp >= 0x101D0 && cp <= 0x101FC -> True
    cp if cp >= 0x10877 && cp <= 0x10878 -> True
    cp if cp == 0x10AC8 -> True
    cp if cp == 0x1173F -> True
    cp if cp >= 0x11FD5 && cp <= 0x11FDC -> True
    cp if cp >= 0x11FE1 && cp <= 0x11FF1 -> True
    cp if cp >= 0x16B3C && cp <= 0x16B3F -> True
    cp if cp == 0x16B45 -> True
    cp if cp == 0x1BC9C -> True
    cp if cp >= 0x1CC00 && cp <= 0x1CCEF -> True
    cp if cp >= 0x1CD00 && cp <= 0x1CEB3 -> True
    cp if cp >= 0x1CF50 && cp <= 0x1CFC3 -> True
    cp if cp >= 0x1D000 && cp <= 0x1D0F5 -> True
    cp if cp >= 0x1D100 && cp <= 0x1D126 -> True
    cp if cp >= 0x1D129 && cp <= 0x1D164 -> True
    cp if cp >= 0x1D16A && cp <= 0x1D16C -> True
    cp if cp >= 0x1D183 && cp <= 0x1D184 -> True
    cp if cp >= 0x1D18C && cp <= 0x1D1A9 -> True
    cp if cp >= 0x1D1AE && cp <= 0x1D1EA -> True
    cp if cp >= 0x1D200 && cp <= 0x1D241 -> True
    cp if cp == 0x1D245 -> True
    cp if cp >= 0x1D300 && cp <= 0x1D356 -> True
    cp if cp >= 0x1D800 && cp <= 0x1D9FF -> True
    cp if cp >= 0x1DA37 && cp <= 0x1DA3A -> True
    cp if cp >= 0x1DA6D && cp <= 0x1DA74 -> True
    cp if cp >= 0x1DA76 && cp <= 0x1DA83 -> True
    cp if cp >= 0x1DA85 && cp <= 0x1DA86 -> True
    cp if cp == 0x1E14F -> True
    cp if cp == 0x1ECAC -> True
    cp if cp == 0x1ED2E -> True
    cp if cp >= 0x1F000 && cp <= 0x1F02B -> True
    cp if cp >= 0x1F030 && cp <= 0x1F093 -> True
    cp if cp >= 0x1F0A0 && cp <= 0x1F0AE -> True
    cp if cp >= 0x1F0B1 && cp <= 0x1F0BF -> True
    cp if cp >= 0x1F0C1 && cp <= 0x1F0CF -> True
    cp if cp >= 0x1F0D1 && cp <= 0x1F0F5 -> True
    cp if cp >= 0x1F10D && cp <= 0x1F1AD -> True
    cp if cp >= 0x1F1E6 && cp <= 0x1F202 -> True
    cp if cp >= 0x1F210 && cp <= 0x1F23B -> True
    cp if cp >= 0x1F240 && cp <= 0x1F248 -> True
    cp if cp >= 0x1F250 && cp <= 0x1F251 -> True
    cp if cp >= 0x1F260 && cp <= 0x1F265 -> True
    cp if cp >= 0x1F300 && cp <= 0x1F3FA -> True
    cp if cp >= 0x1F400 && cp <= 0x1F6D7 -> True
    cp if cp >= 0x1F6DC && cp <= 0x1F6EC -> True
    cp if cp >= 0x1F6F0 && cp <= 0x1F6FC -> True
    cp if cp >= 0x1F700 && cp <= 0x1F776 -> True
    cp if cp >= 0x1F77B && cp <= 0x1F7D9 -> True
    cp if cp >= 0x1F7E0 && cp <= 0x1F7EB -> True
    cp if cp == 0x1F7F0 -> True
    cp if cp >= 0x1F800 && cp <= 0x1F80B -> True
    cp if cp >= 0x1F810 && cp <= 0x1F847 -> True
    cp if cp >= 0x1F850 && cp <= 0x1F859 -> True
    cp if cp >= 0x1F860 && cp <= 0x1F887 -> True
    cp if cp >= 0x1F890 && cp <= 0x1F8AD -> True
    cp if cp >= 0x1F8B0 && cp <= 0x1F8BB -> True
    cp if cp >= 0x1F8C0 && cp <= 0x1F8C1 -> True
    cp if cp >= 0x1F900 && cp <= 0x1FA53 -> True
    cp if cp >= 0x1FA60 && cp <= 0x1FA6D -> True
    cp if cp >= 0x1FA70 && cp <= 0x1FA7C -> True
    cp if cp >= 0x1FA80 && cp <= 0x1FA89 -> True
    cp if cp >= 0x1FA8F && cp <= 0x1FAC6 -> True
    cp if cp >= 0x1FACE && cp <= 0x1FADC -> True
    cp if cp >= 0x1FADF && cp <= 0x1FAE9 -> True
    cp if cp >= 0x1FAF0 && cp <= 0x1FAF8 -> True
    cp if cp >= 0x1FB00 && cp <= 0x1FB92 -> True
    cp if cp >= 0x1FB94 && cp <= 0x1FBEF -> True
    _ -> False
  }
}

pub fn in_space(codepoint: Int) -> Bool {
  case codepoint {
    cp if cp == 0x0020 -> True
    cp if cp == 0x00A0 -> True
    cp if cp == 0x1680 -> True
    cp if cp >= 0x2000 && cp <= 0x200A -> True
    cp if cp == 0x202F -> True
    cp if cp == 0x205F -> True
    cp if cp == 0x3000 -> True
    _ -> False
  }
}

pub fn in_unassigned(codepoint: Int) -> Bool {
  case codepoint {
    cp if cp >= 0x0378 && cp <= 0x0379 -> True
    cp if cp >= 0x0380 && cp <= 0x0383 -> True
    cp if cp == 0x038B -> True
    cp if cp == 0x038D -> True
    cp if cp == 0x03A2 -> True
    cp if cp == 0x0530 -> True
    cp if cp >= 0x0557 && cp <= 0x0558 -> True
    cp if cp >= 0x058B && cp <= 0x058C -> True
    cp if cp == 0x0590 -> True
    cp if cp >= 0x05C8 && cp <= 0x05CF -> True
    cp if cp >= 0x05EB && cp <= 0x05EE -> True
    cp if cp >= 0x05F5 && cp <= 0x05FF -> True
    cp if cp == 0x070E -> True
    cp if cp >= 0x074B && cp <= 0x074C -> True
    cp if cp >= 0x07B2 && cp <= 0x07BF -> True
    cp if cp >= 0x07FB && cp <= 0x07FC -> True
    cp if cp >= 0x082E && cp <= 0x082F -> True
    cp if cp == 0x083F -> True
    cp if cp >= 0x085C && cp <= 0x085D -> True
    cp if cp == 0x085F -> True
    cp if cp >= 0x086B && cp <= 0x086F -> True
    cp if cp == 0x088F -> True
    cp if cp >= 0x0892 && cp <= 0x0896 -> True
    cp if cp == 0x0984 -> True
    cp if cp >= 0x098D && cp <= 0x098E -> True
    cp if cp >= 0x0991 && cp <= 0x0992 -> True
    cp if cp == 0x09A9 -> True
    cp if cp == 0x09B1 -> True
    cp if cp >= 0x09B3 && cp <= 0x09B5 -> True
    cp if cp >= 0x09BA && cp <= 0x09BB -> True
    cp if cp >= 0x09C5 && cp <= 0x09C6 -> True
    cp if cp >= 0x09C9 && cp <= 0x09CA -> True
    cp if cp >= 0x09CF && cp <= 0x09D6 -> True
    cp if cp >= 0x09D8 && cp <= 0x09DB -> True
    cp if cp == 0x09DE -> True
    cp if cp >= 0x09E4 && cp <= 0x09E5 -> True
    cp if cp >= 0x09FF && cp <= 0x0A00 -> True
    cp if cp == 0x0A04 -> True
    cp if cp >= 0x0A0B && cp <= 0x0A0E -> True
    cp if cp >= 0x0A11 && cp <= 0x0A12 -> True
    cp if cp == 0x0A29 -> True
    cp if cp == 0x0A31 -> True
    cp if cp == 0x0A34 -> True
    cp if cp == 0x0A37 -> True
    cp if cp >= 0x0A3A && cp <= 0x0A3B -> True
    cp if cp == 0x0A3D -> True
    cp if cp >= 0x0A43 && cp <= 0x0A46 -> True
    cp if cp >= 0x0A49 && cp <= 0x0A4A -> True
    cp if cp >= 0x0A4E && cp <= 0x0A50 -> True
    cp if cp >= 0x0A52 && cp <= 0x0A58 -> True
    cp if cp == 0x0A5D -> True
    cp if cp >= 0x0A5F && cp <= 0x0A65 -> True
    cp if cp >= 0x0A77 && cp <= 0x0A80 -> True
    cp if cp == 0x0A84 -> True
    cp if cp == 0x0A8E -> True
    cp if cp == 0x0A92 -> True
    cp if cp == 0x0AA9 -> True
    cp if cp == 0x0AB1 -> True
    cp if cp == 0x0AB4 -> True
    cp if cp >= 0x0ABA && cp <= 0x0ABB -> True
    cp if cp == 0x0AC6 -> True
    cp if cp == 0x0ACA -> True
    cp if cp >= 0x0ACE && cp <= 0x0ACF -> True
    cp if cp >= 0x0AD1 && cp <= 0x0ADF -> True
    cp if cp >= 0x0AE4 && cp <= 0x0AE5 -> True
    cp if cp >= 0x0AF2 && cp <= 0x0AF8 -> True
    cp if cp == 0x0B00 -> True
    cp if cp == 0x0B04 -> True
    cp if cp >= 0x0B0D && cp <= 0x0B0E -> True
    cp if cp >= 0x0B11 && cp <= 0x0B12 -> True
    cp if cp == 0x0B29 -> True
    cp if cp == 0x0B31 -> True
    cp if cp == 0x0B34 -> True
    cp if cp >= 0x0B3A && cp <= 0x0B3B -> True
    cp if cp >= 0x0B45 && cp <= 0x0B46 -> True
    cp if cp >= 0x0B49 && cp <= 0x0B4A -> True
    cp if cp >= 0x0B4E && cp <= 0x0B54 -> True
    cp if cp >= 0x0B58 && cp <= 0x0B5B -> True
    cp if cp == 0x0B5E -> True
    cp if cp >= 0x0B64 && cp <= 0x0B65 -> True
    cp if cp >= 0x0B78 && cp <= 0x0B81 -> True
    cp if cp == 0x0B84 -> True
    cp if cp >= 0x0B8B && cp <= 0x0B8D -> True
    cp if cp == 0x0B91 -> True
    cp if cp >= 0x0B96 && cp <= 0x0B98 -> True
    cp if cp == 0x0B9B -> True
    cp if cp == 0x0B9D -> True
    cp if cp >= 0x0BA0 && cp <= 0x0BA2 -> True
    cp if cp >= 0x0BA5 && cp <= 0x0BA7 -> True
    cp if cp >= 0x0BAB && cp <= 0x0BAD -> True
    cp if cp >= 0x0BBA && cp <= 0x0BBD -> True
    cp if cp >= 0x0BC3 && cp <= 0x0BC5 -> True
    cp if cp == 0x0BC9 -> True
    cp if cp >= 0x0BCE && cp <= 0x0BCF -> True
    cp if cp >= 0x0BD1 && cp <= 0x0BD6 -> True
    cp if cp >= 0x0BD8 && cp <= 0x0BE5 -> True
    cp if cp >= 0x0BFB && cp <= 0x0BFF -> True
    cp if cp == 0x0C0D -> True
    cp if cp == 0x0C11 -> True
    cp if cp == 0x0C29 -> True
    cp if cp >= 0x0C3A && cp <= 0x0C3B -> True
    cp if cp == 0x0C45 -> True
    cp if cp == 0x0C49 -> True
    cp if cp >= 0x0C4E && cp <= 0x0C54 -> True
    cp if cp == 0x0C57 -> True
    cp if cp >= 0x0C5B && cp <= 0x0C5C -> True
    cp if cp >= 0x0C5E && cp <= 0x0C5F -> True
    cp if cp >= 0x0C64 && cp <= 0x0C65 -> True
    cp if cp >= 0x0C70 && cp <= 0x0C76 -> True
    cp if cp == 0x0C8D -> True
    cp if cp == 0x0C91 -> True
    cp if cp == 0x0CA9 -> True
    cp if cp == 0x0CB4 -> True
    cp if cp >= 0x0CBA && cp <= 0x0CBB -> True
    cp if cp == 0x0CC5 -> True
    cp if cp == 0x0CC9 -> True
    cp if cp >= 0x0CCE && cp <= 0x0CD4 -> True
    cp if cp >= 0x0CD7 && cp <= 0x0CDC -> True
    cp if cp == 0x0CDF -> True
    cp if cp >= 0x0CE4 && cp <= 0x0CE5 -> True
    cp if cp == 0x0CF0 -> True
    cp if cp >= 0x0CF4 && cp <= 0x0CFF -> True
    cp if cp == 0x0D0D -> True
    cp if cp == 0x0D11 -> True
    cp if cp == 0x0D45 -> True
    cp if cp == 0x0D49 -> True
    cp if cp >= 0x0D50 && cp <= 0x0D53 -> True
    cp if cp >= 0x0D64 && cp <= 0x0D65 -> True
    cp if cp == 0x0D80 -> True
    cp if cp == 0x0D84 -> True
    cp if cp >= 0x0D97 && cp <= 0x0D99 -> True
    cp if cp == 0x0DB2 -> True
    cp if cp == 0x0DBC -> True
    cp if cp >= 0x0DBE && cp <= 0x0DBF -> True
    cp if cp >= 0x0DC7 && cp <= 0x0DC9 -> True
    cp if cp >= 0x0DCB && cp <= 0x0DCE -> True
    cp if cp == 0x0DD5 -> True
    cp if cp == 0x0DD7 -> True
    cp if cp >= 0x0DE0 && cp <= 0x0DE5 -> True
    cp if cp >= 0x0DF0 && cp <= 0x0DF1 -> True
    cp if cp >= 0x0DF5 && cp <= 0x0E00 -> True
    cp if cp >= 0x0E3B && cp <= 0x0E3E -> True
    cp if cp >= 0x0E5C && cp <= 0x0E80 -> True
    cp if cp == 0x0E83 -> True
    cp if cp == 0x0E85 -> True
    cp if cp == 0x0E8B -> True
    cp if cp == 0x0EA4 -> True
    cp if cp == 0x0EA6 -> True
    cp if cp >= 0x0EBE && cp <= 0x0EBF -> True
    cp if cp == 0x0EC5 -> True
    cp if cp == 0x0EC7 -> True
    cp if cp == 0x0ECF -> True
    cp if cp >= 0x0EDA && cp <= 0x0EDB -> True
    cp if cp >= 0x0EE0 && cp <= 0x0EFF -> True
    cp if cp == 0x0F48 -> True
    cp if cp >= 0x0F6D && cp <= 0x0F70 -> True
    cp if cp == 0x0F98 -> True
    cp if cp == 0x0FBD -> True
    cp if cp == 0x0FCD -> True
    cp if cp >= 0x0FDB && cp <= 0x0FFF -> True
    cp if cp == 0x10C6 -> True
    cp if cp >= 0x10C8 && cp <= 0x10CC -> True
    cp if cp >= 0x10CE && cp <= 0x10CF -> True
    cp if cp == 0x1249 -> True
    cp if cp >= 0x124E && cp <= 0x124F -> True
    cp if cp == 0x1257 -> True
    cp if cp == 0x1259 -> True
    cp if cp >= 0x125E && cp <= 0x125F -> True
    cp if cp == 0x1289 -> True
    cp if cp >= 0x128E && cp <= 0x128F -> True
    cp if cp == 0x12B1 -> True
    cp if cp >= 0x12B6 && cp <= 0x12B7 -> True
    cp if cp == 0x12BF -> True
    cp if cp == 0x12C1 -> True
    cp if cp >= 0x12C6 && cp <= 0x12C7 -> True
    cp if cp == 0x12D7 -> True
    cp if cp == 0x1311 -> True
    cp if cp >= 0x1316 && cp <= 0x1317 -> True
    cp if cp >= 0x135B && cp <= 0x135C -> True
    cp if cp >= 0x137D && cp <= 0x137F -> True
    cp if cp >= 0x139A && cp <= 0x139F -> True
    cp if cp >= 0x13F6 && cp <= 0x13F7 -> True
    cp if cp >= 0x13FE && cp <= 0x13FF -> True
    cp if cp >= 0x169D && cp <= 0x169F -> True
    cp if cp >= 0x16F9 && cp <= 0x16FF -> True
    cp if cp >= 0x1716 && cp <= 0x171E -> True
    cp if cp >= 0x1737 && cp <= 0x173F -> True
    cp if cp >= 0x1754 && cp <= 0x175F -> True
    cp if cp == 0x176D -> True
    cp if cp == 0x1771 -> True
    cp if cp >= 0x1774 && cp <= 0x177F -> True
    cp if cp >= 0x17DE && cp <= 0x17DF -> True
    cp if cp >= 0x17EA && cp <= 0x17EF -> True
    cp if cp >= 0x17FA && cp <= 0x17FF -> True
    cp if cp >= 0x181A && cp <= 0x181F -> True
    cp if cp >= 0x1879 && cp <= 0x187F -> True
    cp if cp >= 0x18AB && cp <= 0x18AF -> True
    cp if cp >= 0x18F6 && cp <= 0x18FF -> True
    cp if cp == 0x191F -> True
    cp if cp >= 0x192C && cp <= 0x192F -> True
    cp if cp >= 0x193C && cp <= 0x193F -> True
    cp if cp >= 0x1941 && cp <= 0x1943 -> True
    cp if cp >= 0x196E && cp <= 0x196F -> True
    cp if cp >= 0x1975 && cp <= 0x197F -> True
    cp if cp >= 0x19AC && cp <= 0x19AF -> True
    cp if cp >= 0x19CA && cp <= 0x19CF -> True
    cp if cp >= 0x19DB && cp <= 0x19DD -> True
    cp if cp >= 0x1A1C && cp <= 0x1A1D -> True
    cp if cp == 0x1A5F -> True
    cp if cp >= 0x1A7D && cp <= 0x1A7E -> True
    cp if cp >= 0x1A8A && cp <= 0x1A8F -> True
    cp if cp >= 0x1A9A && cp <= 0x1A9F -> True
    cp if cp >= 0x1AAE && cp <= 0x1AAF -> True
    cp if cp >= 0x1ACF && cp <= 0x1AFF -> True
    cp if cp == 0x1B4D -> True
    cp if cp >= 0x1BF4 && cp <= 0x1BFB -> True
    cp if cp >= 0x1C38 && cp <= 0x1C3A -> True
    cp if cp >= 0x1C4A && cp <= 0x1C4C -> True
    cp if cp >= 0x1C8B && cp <= 0x1C8F -> True
    cp if cp >= 0x1CBB && cp <= 0x1CBC -> True
    cp if cp >= 0x1CC8 && cp <= 0x1CCF -> True
    cp if cp >= 0x1CFB && cp <= 0x1CFF -> True
    cp if cp >= 0x1F16 && cp <= 0x1F17 -> True
    cp if cp >= 0x1F1E && cp <= 0x1F1F -> True
    cp if cp >= 0x1F46 && cp <= 0x1F47 -> True
    cp if cp >= 0x1F4E && cp <= 0x1F4F -> True
    cp if cp == 0x1F58 -> True
    cp if cp == 0x1F5A -> True
    cp if cp == 0x1F5C -> True
    cp if cp == 0x1F5E -> True
    cp if cp >= 0x1F7E && cp <= 0x1F7F -> True
    cp if cp == 0x1FB5 -> True
    cp if cp == 0x1FC5 -> True
    cp if cp >= 0x1FD4 && cp <= 0x1FD5 -> True
    cp if cp == 0x1FDC -> True
    cp if cp >= 0x1FF0 && cp <= 0x1FF1 -> True
    cp if cp == 0x1FF5 -> True
    cp if cp == 0x1FFF -> True
    cp if cp == 0x2065 -> True
    cp if cp >= 0x2072 && cp <= 0x2073 -> True
    cp if cp == 0x208F -> True
    cp if cp >= 0x209D && cp <= 0x209F -> True
    cp if cp >= 0x20C1 && cp <= 0x20CF -> True
    cp if cp >= 0x20F1 && cp <= 0x20FF -> True
    cp if cp >= 0x218C && cp <= 0x218F -> True
    cp if cp >= 0x242A && cp <= 0x243F -> True
    cp if cp >= 0x244B && cp <= 0x245F -> True
    cp if cp >= 0x2B74 && cp <= 0x2B75 -> True
    cp if cp == 0x2B96 -> True
    cp if cp >= 0x2CF4 && cp <= 0x2CF8 -> True
    cp if cp == 0x2D26 -> True
    cp if cp >= 0x2D28 && cp <= 0x2D2C -> True
    cp if cp >= 0x2D2E && cp <= 0x2D2F -> True
    cp if cp >= 0x2D68 && cp <= 0x2D6E -> True
    cp if cp >= 0x2D71 && cp <= 0x2D7E -> True
    cp if cp >= 0x2D97 && cp <= 0x2D9F -> True
    cp if cp == 0x2DA7 -> True
    cp if cp == 0x2DAF -> True
    cp if cp == 0x2DB7 -> True
    cp if cp == 0x2DBF -> True
    cp if cp == 0x2DC7 -> True
    cp if cp == 0x2DCF -> True
    cp if cp == 0x2DD7 -> True
    cp if cp == 0x2DDF -> True
    cp if cp >= 0x2E5E && cp <= 0x2E7F -> True
    cp if cp == 0x2E9A -> True
    cp if cp >= 0x2EF4 && cp <= 0x2EFF -> True
    cp if cp >= 0x2FD6 && cp <= 0x2FEF -> True
    cp if cp == 0x3040 -> True
    cp if cp >= 0x3097 && cp <= 0x3098 -> True
    cp if cp >= 0x3100 && cp <= 0x3104 -> True
    cp if cp == 0x3130 -> True
    cp if cp == 0x318F -> True
    cp if cp >= 0x31E6 && cp <= 0x31EE -> True
    cp if cp == 0x321F -> True
    cp if cp >= 0xA48D && cp <= 0xA48F -> True
    cp if cp >= 0xA4C7 && cp <= 0xA4CF -> True
    cp if cp >= 0xA62C && cp <= 0xA63F -> True
    cp if cp >= 0xA6F8 && cp <= 0xA6FF -> True
    cp if cp >= 0xA7CE && cp <= 0xA7CF -> True
    cp if cp == 0xA7D2 -> True
    cp if cp == 0xA7D4 -> True
    cp if cp >= 0xA7DD && cp <= 0xA7F1 -> True
    cp if cp >= 0xA82D && cp <= 0xA82F -> True
    cp if cp >= 0xA83A && cp <= 0xA83F -> True
    cp if cp >= 0xA878 && cp <= 0xA87F -> True
    cp if cp >= 0xA8C6 && cp <= 0xA8CD -> True
    cp if cp >= 0xA8DA && cp <= 0xA8DF -> True
    cp if cp >= 0xA954 && cp <= 0xA95E -> True
    cp if cp >= 0xA97D && cp <= 0xA97F -> True
    cp if cp == 0xA9CE -> True
    cp if cp >= 0xA9DA && cp <= 0xA9DD -> True
    cp if cp == 0xA9FF -> True
    cp if cp >= 0xAA37 && cp <= 0xAA3F -> True
    cp if cp >= 0xAA4E && cp <= 0xAA4F -> True
    cp if cp >= 0xAA5A && cp <= 0xAA5B -> True
    cp if cp >= 0xAAC3 && cp <= 0xAADA -> True
    cp if cp >= 0xAAF7 && cp <= 0xAB00 -> True
    cp if cp >= 0xAB07 && cp <= 0xAB08 -> True
    cp if cp >= 0xAB0F && cp <= 0xAB10 -> True
    cp if cp >= 0xAB17 && cp <= 0xAB1F -> True
    cp if cp == 0xAB27 -> True
    cp if cp == 0xAB2F -> True
    cp if cp >= 0xAB6C && cp <= 0xAB6F -> True
    cp if cp >= 0xABEE && cp <= 0xABEF -> True
    cp if cp >= 0xABFA && cp <= 0xABFF -> True
    cp if cp >= 0xD7A4 && cp <= 0xD7AF -> True
    cp if cp >= 0xD7C7 && cp <= 0xD7CA -> True
    cp if cp >= 0xD7FC && cp <= 0xD7FF -> True
    cp if cp >= 0xFA6E && cp <= 0xFA6F -> True
    cp if cp >= 0xFADA && cp <= 0xFAFF -> True
    cp if cp >= 0xFB07 && cp <= 0xFB12 -> True
    cp if cp >= 0xFB18 && cp <= 0xFB1C -> True
    cp if cp == 0xFB37 -> True
    cp if cp == 0xFB3D -> True
    cp if cp == 0xFB3F -> True
    cp if cp == 0xFB42 -> True
    cp if cp == 0xFB45 -> True
    cp if cp >= 0xFBC3 && cp <= 0xFBD2 -> True
    cp if cp >= 0xFD90 && cp <= 0xFD91 -> True
    cp if cp >= 0xFDC8 && cp <= 0xFDCE -> True
    cp if cp >= 0xFDD0 && cp <= 0xFDEF -> True
    cp if cp >= 0xFE1A && cp <= 0xFE1F -> True
    cp if cp == 0xFE53 -> True
    cp if cp == 0xFE67 -> True
    cp if cp >= 0xFE6C && cp <= 0xFE6F -> True
    cp if cp == 0xFE75 -> True
    cp if cp >= 0xFEFD && cp <= 0xFEFE -> True
    cp if cp == 0xFF00 -> True
    cp if cp >= 0xFFBF && cp <= 0xFFC1 -> True
    cp if cp >= 0xFFC8 && cp <= 0xFFC9 -> True
    cp if cp >= 0xFFD0 && cp <= 0xFFD1 -> True
    cp if cp >= 0xFFD8 && cp <= 0xFFD9 -> True
    cp if cp >= 0xFFDD && cp <= 0xFFDF -> True
    cp if cp == 0xFFE7 -> True
    cp if cp >= 0xFFEF && cp <= 0xFFF8 -> True
    cp if cp >= 0xFFFE && cp <= 0xFFFF -> True
    cp if cp == 0x1000C -> True
    cp if cp == 0x10027 -> True
    cp if cp == 0x1003B -> True
    cp if cp == 0x1003E -> True
    cp if cp >= 0x1004E && cp <= 0x1004F -> True
    cp if cp >= 0x1005E && cp <= 0x1007F -> True
    cp if cp >= 0x100FB && cp <= 0x100FF -> True
    cp if cp >= 0x10103 && cp <= 0x10106 -> True
    cp if cp >= 0x10134 && cp <= 0x10136 -> True
    cp if cp == 0x1018F -> True
    cp if cp >= 0x1019D && cp <= 0x1019F -> True
    cp if cp >= 0x101A1 && cp <= 0x101CF -> True
    cp if cp >= 0x101FE && cp <= 0x1027F -> True
    cp if cp >= 0x1029D && cp <= 0x1029F -> True
    cp if cp >= 0x102D1 && cp <= 0x102DF -> True
    cp if cp >= 0x102FC && cp <= 0x102FF -> True
    cp if cp >= 0x10324 && cp <= 0x1032C -> True
    cp if cp >= 0x1034B && cp <= 0x1034F -> True
    cp if cp >= 0x1037B && cp <= 0x1037F -> True
    cp if cp == 0x1039E -> True
    cp if cp >= 0x103C4 && cp <= 0x103C7 -> True
    cp if cp >= 0x103D6 && cp <= 0x103FF -> True
    cp if cp >= 0x1049E && cp <= 0x1049F -> True
    cp if cp >= 0x104AA && cp <= 0x104AF -> True
    cp if cp >= 0x104D4 && cp <= 0x104D7 -> True
    cp if cp >= 0x104FC && cp <= 0x104FF -> True
    cp if cp >= 0x10528 && cp <= 0x1052F -> True
    cp if cp >= 0x10564 && cp <= 0x1056E -> True
    cp if cp == 0x1057B -> True
    cp if cp == 0x1058B -> True
    cp if cp == 0x10593 -> True
    cp if cp == 0x10596 -> True
    cp if cp == 0x105A2 -> True
    cp if cp == 0x105B2 -> True
    cp if cp == 0x105BA -> True
    cp if cp >= 0x105BD && cp <= 0x105BF -> True
    cp if cp >= 0x105F4 && cp <= 0x105FF -> True
    cp if cp >= 0x10737 && cp <= 0x1073F -> True
    cp if cp >= 0x10756 && cp <= 0x1075F -> True
    cp if cp >= 0x10768 && cp <= 0x1077F -> True
    cp if cp == 0x10786 -> True
    cp if cp == 0x107B1 -> True
    cp if cp >= 0x107BB && cp <= 0x107FF -> True
    cp if cp >= 0x10806 && cp <= 0x10807 -> True
    cp if cp == 0x10809 -> True
    cp if cp == 0x10836 -> True
    cp if cp >= 0x10839 && cp <= 0x1083B -> True
    cp if cp >= 0x1083D && cp <= 0x1083E -> True
    cp if cp == 0x10856 -> True
    cp if cp >= 0x1089F && cp <= 0x108A6 -> True
    cp if cp >= 0x108B0 && cp <= 0x108DF -> True
    cp if cp == 0x108F3 -> True
    cp if cp >= 0x108F6 && cp <= 0x108FA -> True
    cp if cp >= 0x1091C && cp <= 0x1091E -> True
    cp if cp >= 0x1093A && cp <= 0x1093E -> True
    cp if cp >= 0x10940 && cp <= 0x1097F -> True
    cp if cp >= 0x109B8 && cp <= 0x109BB -> True
    cp if cp >= 0x109D0 && cp <= 0x109D1 -> True
    cp if cp == 0x10A04 -> True
    cp if cp >= 0x10A07 && cp <= 0x10A0B -> True
    cp if cp == 0x10A14 -> True
    cp if cp == 0x10A18 -> True
    cp if cp >= 0x10A36 && cp <= 0x10A37 -> True
    cp if cp >= 0x10A3B && cp <= 0x10A3E -> True
    cp if cp >= 0x10A49 && cp <= 0x10A4F -> True
    cp if cp >= 0x10A59 && cp <= 0x10A5F -> True
    cp if cp >= 0x10AA0 && cp <= 0x10ABF -> True
    cp if cp >= 0x10AE7 && cp <= 0x10AEA -> True
    cp if cp >= 0x10AF7 && cp <= 0x10AFF -> True
    cp if cp >= 0x10B36 && cp <= 0x10B38 -> True
    cp if cp >= 0x10B56 && cp <= 0x10B57 -> True
    cp if cp >= 0x10B73 && cp <= 0x10B77 -> True
    cp if cp >= 0x10B92 && cp <= 0x10B98 -> True
    cp if cp >= 0x10B9D && cp <= 0x10BA8 -> True
    cp if cp >= 0x10BB0 && cp <= 0x10BFF -> True
    cp if cp >= 0x10C49 && cp <= 0x10C7F -> True
    cp if cp >= 0x10CB3 && cp <= 0x10CBF -> True
    cp if cp >= 0x10CF3 && cp <= 0x10CF9 -> True
    cp if cp >= 0x10D28 && cp <= 0x10D2F -> True
    cp if cp >= 0x10D3A && cp <= 0x10D3F -> True
    cp if cp >= 0x10D66 && cp <= 0x10D68 -> True
    cp if cp >= 0x10D86 && cp <= 0x10D8D -> True
    cp if cp >= 0x10D90 && cp <= 0x10E5F -> True
    cp if cp == 0x10E7F -> True
    cp if cp == 0x10EAA -> True
    cp if cp >= 0x10EAE && cp <= 0x10EAF -> True
    cp if cp >= 0x10EB2 && cp <= 0x10EC1 -> True
    cp if cp >= 0x10EC5 && cp <= 0x10EFB -> True
    cp if cp >= 0x10F28 && cp <= 0x10F2F -> True
    cp if cp >= 0x10F5A && cp <= 0x10F6F -> True
    cp if cp >= 0x10F8A && cp <= 0x10FAF -> True
    cp if cp >= 0x10FCC && cp <= 0x10FDF -> True
    cp if cp >= 0x10FF7 && cp <= 0x10FFF -> True
    cp if cp >= 0x1104E && cp <= 0x11051 -> True
    cp if cp >= 0x11076 && cp <= 0x1107E -> True
    cp if cp >= 0x110C3 && cp <= 0x110CC -> True
    cp if cp >= 0x110CE && cp <= 0x110CF -> True
    cp if cp >= 0x110E9 && cp <= 0x110EF -> True
    cp if cp >= 0x110FA && cp <= 0x110FF -> True
    cp if cp == 0x11135 -> True
    cp if cp >= 0x11148 && cp <= 0x1114F -> True
    cp if cp >= 0x11177 && cp <= 0x1117F -> True
    cp if cp == 0x111E0 -> True
    cp if cp >= 0x111F5 && cp <= 0x111FF -> True
    cp if cp == 0x11212 -> True
    cp if cp >= 0x11242 && cp <= 0x1127F -> True
    cp if cp == 0x11287 -> True
    cp if cp == 0x11289 -> True
    cp if cp == 0x1128E -> True
    cp if cp == 0x1129E -> True
    cp if cp >= 0x112AA && cp <= 0x112AF -> True
    cp if cp >= 0x112EB && cp <= 0x112EF -> True
    cp if cp >= 0x112FA && cp <= 0x112FF -> True
    cp if cp == 0x11304 -> True
    cp if cp >= 0x1130D && cp <= 0x1130E -> True
    cp if cp >= 0x11311 && cp <= 0x11312 -> True
    cp if cp == 0x11329 -> True
    cp if cp == 0x11331 -> True
    cp if cp == 0x11334 -> True
    cp if cp == 0x1133A -> True
    cp if cp >= 0x11345 && cp <= 0x11346 -> True
    cp if cp >= 0x11349 && cp <= 0x1134A -> True
    cp if cp >= 0x1134E && cp <= 0x1134F -> True
    cp if cp >= 0x11351 && cp <= 0x11356 -> True
    cp if cp >= 0x11358 && cp <= 0x1135C -> True
    cp if cp >= 0x11364 && cp <= 0x11365 -> True
    cp if cp >= 0x1136D && cp <= 0x1136F -> True
    cp if cp >= 0x11375 && cp <= 0x1137F -> True
    cp if cp == 0x1138A -> True
    cp if cp >= 0x1138C && cp <= 0x1138D -> True
    cp if cp == 0x1138F -> True
    cp if cp == 0x113B6 -> True
    cp if cp == 0x113C1 -> True
    cp if cp >= 0x113C3 && cp <= 0x113C4 -> True
    cp if cp == 0x113C6 -> True
    cp if cp == 0x113CB -> True
    cp if cp == 0x113D6 -> True
    cp if cp >= 0x113D9 && cp <= 0x113E0 -> True
    cp if cp >= 0x113E3 && cp <= 0x113FF -> True
    cp if cp == 0x1145C -> True
    cp if cp >= 0x11462 && cp <= 0x1147F -> True
    cp if cp >= 0x114C8 && cp <= 0x114CF -> True
    cp if cp >= 0x114DA && cp <= 0x1157F -> True
    cp if cp >= 0x115B6 && cp <= 0x115B7 -> True
    cp if cp >= 0x115DE && cp <= 0x115FF -> True
    cp if cp >= 0x11645 && cp <= 0x1164F -> True
    cp if cp >= 0x1165A && cp <= 0x1165F -> True
    cp if cp >= 0x1166D && cp <= 0x1167F -> True
    cp if cp >= 0x116BA && cp <= 0x116BF -> True
    cp if cp >= 0x116CA && cp <= 0x116CF -> True
    cp if cp >= 0x116E4 && cp <= 0x116FF -> True
    cp if cp >= 0x1171B && cp <= 0x1171C -> True
    cp if cp >= 0x1172C && cp <= 0x1172F -> True
    cp if cp >= 0x11747 && cp <= 0x117FF -> True
    cp if cp >= 0x1183C && cp <= 0x1189F -> True
    cp if cp >= 0x118F3 && cp <= 0x118FE -> True
    cp if cp >= 0x11907 && cp <= 0x11908 -> True
    cp if cp >= 0x1190A && cp <= 0x1190B -> True
    cp if cp == 0x11914 -> True
    cp if cp == 0x11917 -> True
    cp if cp == 0x11936 -> True
    cp if cp >= 0x11939 && cp <= 0x1193A -> True
    cp if cp >= 0x11947 && cp <= 0x1194F -> True
    cp if cp >= 0x1195A && cp <= 0x1199F -> True
    cp if cp >= 0x119A8 && cp <= 0x119A9 -> True
    cp if cp >= 0x119D8 && cp <= 0x119D9 -> True
    cp if cp >= 0x119E5 && cp <= 0x119FF -> True
    cp if cp >= 0x11A48 && cp <= 0x11A4F -> True
    cp if cp >= 0x11AA3 && cp <= 0x11AAF -> True
    cp if cp >= 0x11AF9 && cp <= 0x11AFF -> True
    cp if cp >= 0x11B0A && cp <= 0x11BBF -> True
    cp if cp >= 0x11BE2 && cp <= 0x11BEF -> True
    cp if cp >= 0x11BFA && cp <= 0x11BFF -> True
    cp if cp == 0x11C09 -> True
    cp if cp == 0x11C37 -> True
    cp if cp >= 0x11C46 && cp <= 0x11C4F -> True
    cp if cp >= 0x11C6D && cp <= 0x11C6F -> True
    cp if cp >= 0x11C90 && cp <= 0x11C91 -> True
    cp if cp == 0x11CA8 -> True
    cp if cp >= 0x11CB7 && cp <= 0x11CFF -> True
    cp if cp == 0x11D07 -> True
    cp if cp == 0x11D0A -> True
    cp if cp >= 0x11D37 && cp <= 0x11D39 -> True
    cp if cp == 0x11D3B -> True
    cp if cp == 0x11D3E -> True
    cp if cp >= 0x11D48 && cp <= 0x11D4F -> True
    cp if cp >= 0x11D5A && cp <= 0x11D5F -> True
    cp if cp == 0x11D66 -> True
    cp if cp == 0x11D69 -> True
    cp if cp == 0x11D8F -> True
    cp if cp == 0x11D92 -> True
    cp if cp >= 0x11D99 && cp <= 0x11D9F -> True
    cp if cp >= 0x11DAA && cp <= 0x11EDF -> True
    cp if cp >= 0x11EF9 && cp <= 0x11EFF -> True
    cp if cp == 0x11F11 -> True
    cp if cp >= 0x11F3B && cp <= 0x11F3D -> True
    cp if cp >= 0x11F5B && cp <= 0x11FAF -> True
    cp if cp >= 0x11FB1 && cp <= 0x11FBF -> True
    cp if cp >= 0x11FF2 && cp <= 0x11FFE -> True
    cp if cp >= 0x1239A && cp <= 0x123FF -> True
    cp if cp == 0x1246F -> True
    cp if cp >= 0x12475 && cp <= 0x1247F -> True
    cp if cp >= 0x12544 && cp <= 0x12F8F -> True
    cp if cp >= 0x12FF3 && cp <= 0x12FFF -> True
    cp if cp >= 0x13456 && cp <= 0x1345F -> True
    cp if cp >= 0x143FB && cp <= 0x143FF -> True
    cp if cp >= 0x14647 && cp <= 0x160FF -> True
    cp if cp >= 0x1613A && cp <= 0x167FF -> True
    cp if cp >= 0x16A39 && cp <= 0x16A3F -> True
    cp if cp == 0x16A5F -> True
    cp if cp >= 0x16A6A && cp <= 0x16A6D -> True
    cp if cp == 0x16ABF -> True
    cp if cp >= 0x16ACA && cp <= 0x16ACF -> True
    cp if cp >= 0x16AEE && cp <= 0x16AEF -> True
    cp if cp >= 0x16AF6 && cp <= 0x16AFF -> True
    cp if cp >= 0x16B46 && cp <= 0x16B4F -> True
    cp if cp == 0x16B5A -> True
    cp if cp == 0x16B62 -> True
    cp if cp >= 0x16B78 && cp <= 0x16B7C -> True
    cp if cp >= 0x16B90 && cp <= 0x16D3F -> True
    cp if cp >= 0x16D7A && cp <= 0x16E3F -> True
    cp if cp >= 0x16E9B && cp <= 0x16EFF -> True
    cp if cp >= 0x16F4B && cp <= 0x16F4E -> True
    cp if cp >= 0x16F88 && cp <= 0x16F8E -> True
    cp if cp >= 0x16FA0 && cp <= 0x16FDF -> True
    cp if cp >= 0x16FE5 && cp <= 0x16FEF -> True
    cp if cp >= 0x16FF2 && cp <= 0x16FFF -> True
    cp if cp >= 0x187F8 && cp <= 0x187FF -> True
    cp if cp >= 0x18CD6 && cp <= 0x18CFE -> True
    cp if cp >= 0x18D09 && cp <= 0x1AFEF -> True
    cp if cp == 0x1AFF4 -> True
    cp if cp == 0x1AFFC -> True
    cp if cp == 0x1AFFF -> True
    cp if cp >= 0x1B123 && cp <= 0x1B131 -> True
    cp if cp >= 0x1B133 && cp <= 0x1B14F -> True
    cp if cp >= 0x1B153 && cp <= 0x1B154 -> True
    cp if cp >= 0x1B156 && cp <= 0x1B163 -> True
    cp if cp >= 0x1B168 && cp <= 0x1B16F -> True
    cp if cp >= 0x1B2FC && cp <= 0x1BBFF -> True
    cp if cp >= 0x1BC6B && cp <= 0x1BC6F -> True
    cp if cp >= 0x1BC7D && cp <= 0x1BC7F -> True
    cp if cp >= 0x1BC89 && cp <= 0x1BC8F -> True
    cp if cp >= 0x1BC9A && cp <= 0x1BC9B -> True
    cp if cp >= 0x1BCA4 && cp <= 0x1CBFF -> True
    cp if cp >= 0x1CCFA && cp <= 0x1CCFF -> True
    cp if cp >= 0x1CEB4 && cp <= 0x1CEFF -> True
    cp if cp >= 0x1CF2E && cp <= 0x1CF2F -> True
    cp if cp >= 0x1CF47 && cp <= 0x1CF4F -> True
    cp if cp >= 0x1CFC4 && cp <= 0x1CFFF -> True
    cp if cp >= 0x1D0F6 && cp <= 0x1D0FF -> True
    cp if cp >= 0x1D127 && cp <= 0x1D128 -> True
    cp if cp >= 0x1D1EB && cp <= 0x1D1FF -> True
    cp if cp >= 0x1D246 && cp <= 0x1D2BF -> True
    cp if cp >= 0x1D2D4 && cp <= 0x1D2DF -> True
    cp if cp >= 0x1D2F4 && cp <= 0x1D2FF -> True
    cp if cp >= 0x1D357 && cp <= 0x1D35F -> True
    cp if cp >= 0x1D379 && cp <= 0x1D3FF -> True
    cp if cp == 0x1D455 -> True
    cp if cp == 0x1D49D -> True
    cp if cp >= 0x1D4A0 && cp <= 0x1D4A1 -> True
    cp if cp >= 0x1D4A3 && cp <= 0x1D4A4 -> True
    cp if cp >= 0x1D4A7 && cp <= 0x1D4A8 -> True
    cp if cp == 0x1D4AD -> True
    cp if cp == 0x1D4BA -> True
    cp if cp == 0x1D4BC -> True
    cp if cp == 0x1D4C4 -> True
    cp if cp == 0x1D506 -> True
    cp if cp >= 0x1D50B && cp <= 0x1D50C -> True
    cp if cp == 0x1D515 -> True
    cp if cp == 0x1D51D -> True
    cp if cp == 0x1D53A -> True
    cp if cp == 0x1D53F -> True
    cp if cp == 0x1D545 -> True
    cp if cp >= 0x1D547 && cp <= 0x1D549 -> True
    cp if cp == 0x1D551 -> True
    cp if cp >= 0x1D6A6 && cp <= 0x1D6A7 -> True
    cp if cp >= 0x1D7CC && cp <= 0x1D7CD -> True
    cp if cp >= 0x1DA8C && cp <= 0x1DA9A -> True
    cp if cp == 0x1DAA0 -> True
    cp if cp >= 0x1DAB0 && cp <= 0x1DEFF -> True
    cp if cp >= 0x1DF1F && cp <= 0x1DF24 -> True
    cp if cp >= 0x1DF2B && cp <= 0x1DFFF -> True
    cp if cp == 0x1E007 -> True
    cp if cp >= 0x1E019 && cp <= 0x1E01A -> True
    cp if cp == 0x1E022 -> True
    cp if cp == 0x1E025 -> True
    cp if cp >= 0x1E02B && cp <= 0x1E02F -> True
    cp if cp >= 0x1E06E && cp <= 0x1E08E -> True
    cp if cp >= 0x1E090 && cp <= 0x1E0FF -> True
    cp if cp >= 0x1E12D && cp <= 0x1E12F -> True
    cp if cp >= 0x1E13E && cp <= 0x1E13F -> True
    cp if cp >= 0x1E14A && cp <= 0x1E14D -> True
    cp if cp >= 0x1E150 && cp <= 0x1E28F -> True
    cp if cp >= 0x1E2AF && cp <= 0x1E2BF -> True
    cp if cp >= 0x1E2FA && cp <= 0x1E2FE -> True
    cp if cp >= 0x1E300 && cp <= 0x1E4CF -> True
    cp if cp >= 0x1E4FA && cp <= 0x1E5CF -> True
    cp if cp >= 0x1E5FB && cp <= 0x1E5FE -> True
    cp if cp >= 0x1E600 && cp <= 0x1E7DF -> True
    cp if cp == 0x1E7E7 -> True
    cp if cp == 0x1E7EC -> True
    cp if cp == 0x1E7EF -> True
    cp if cp == 0x1E7FF -> True
    cp if cp >= 0x1E8C5 && cp <= 0x1E8C6 -> True
    cp if cp >= 0x1E8D7 && cp <= 0x1E8FF -> True
    cp if cp >= 0x1E94C && cp <= 0x1E94F -> True
    cp if cp >= 0x1E95A && cp <= 0x1E95D -> True
    cp if cp >= 0x1E960 && cp <= 0x1EC70 -> True
    cp if cp >= 0x1ECB5 && cp <= 0x1ED00 -> True
    cp if cp >= 0x1ED3E && cp <= 0x1EDFF -> True
    cp if cp == 0x1EE04 -> True
    cp if cp == 0x1EE20 -> True
    cp if cp == 0x1EE23 -> True
    cp if cp >= 0x1EE25 && cp <= 0x1EE26 -> True
    cp if cp == 0x1EE28 -> True
    cp if cp == 0x1EE33 -> True
    cp if cp == 0x1EE38 -> True
    cp if cp == 0x1EE3A -> True
    cp if cp >= 0x1EE3C && cp <= 0x1EE41 -> True
    cp if cp >= 0x1EE43 && cp <= 0x1EE46 -> True
    cp if cp == 0x1EE48 -> True
    cp if cp == 0x1EE4A -> True
    cp if cp == 0x1EE4C -> True
    cp if cp == 0x1EE50 -> True
    cp if cp == 0x1EE53 -> True
    cp if cp >= 0x1EE55 && cp <= 0x1EE56 -> True
    cp if cp == 0x1EE58 -> True
    cp if cp == 0x1EE5A -> True
    cp if cp == 0x1EE5C -> True
    cp if cp == 0x1EE5E -> True
    cp if cp == 0x1EE60 -> True
    cp if cp == 0x1EE63 -> True
    cp if cp >= 0x1EE65 && cp <= 0x1EE66 -> True
    cp if cp == 0x1EE6B -> True
    cp if cp == 0x1EE73 -> True
    cp if cp == 0x1EE78 -> True
    cp if cp == 0x1EE7D -> True
    cp if cp == 0x1EE7F -> True
    cp if cp == 0x1EE8A -> True
    cp if cp >= 0x1EE9C && cp <= 0x1EEA0 -> True
    cp if cp == 0x1EEA4 -> True
    cp if cp == 0x1EEAA -> True
    cp if cp >= 0x1EEBC && cp <= 0x1EEEF -> True
    cp if cp >= 0x1EEF2 && cp <= 0x1EFFF -> True
    cp if cp >= 0x1F02C && cp <= 0x1F02F -> True
    cp if cp >= 0x1F094 && cp <= 0x1F09F -> True
    cp if cp >= 0x1F0AF && cp <= 0x1F0B0 -> True
    cp if cp == 0x1F0C0 -> True
    cp if cp == 0x1F0D0 -> True
    cp if cp >= 0x1F0F6 && cp <= 0x1F0FF -> True
    cp if cp >= 0x1F1AE && cp <= 0x1F1E5 -> True
    cp if cp >= 0x1F203 && cp <= 0x1F20F -> True
    cp if cp >= 0x1F23C && cp <= 0x1F23F -> True
    cp if cp >= 0x1F249 && cp <= 0x1F24F -> True
    cp if cp >= 0x1F252 && cp <= 0x1F25F -> True
    cp if cp >= 0x1F266 && cp <= 0x1F2FF -> True
    cp if cp >= 0x1F6D8 && cp <= 0x1F6DB -> True
    cp if cp >= 0x1F6ED && cp <= 0x1F6EF -> True
    cp if cp >= 0x1F6FD && cp <= 0x1F6FF -> True
    cp if cp >= 0x1F777 && cp <= 0x1F77A -> True
    cp if cp >= 0x1F7DA && cp <= 0x1F7DF -> True
    cp if cp >= 0x1F7EC && cp <= 0x1F7EF -> True
    cp if cp >= 0x1F7F1 && cp <= 0x1F7FF -> True
    cp if cp >= 0x1F80C && cp <= 0x1F80F -> True
    cp if cp >= 0x1F848 && cp <= 0x1F84F -> True
    cp if cp >= 0x1F85A && cp <= 0x1F85F -> True
    cp if cp >= 0x1F888 && cp <= 0x1F88F -> True
    cp if cp >= 0x1F8AE && cp <= 0x1F8AF -> True
    cp if cp >= 0x1F8BC && cp <= 0x1F8BF -> True
    cp if cp >= 0x1F8C2 && cp <= 0x1F8FF -> True
    cp if cp >= 0x1FA54 && cp <= 0x1FA5F -> True
    cp if cp >= 0x1FA6E && cp <= 0x1FA6F -> True
    cp if cp >= 0x1FA7D && cp <= 0x1FA7F -> True
    cp if cp >= 0x1FA8A && cp <= 0x1FA8E -> True
    cp if cp >= 0x1FAC7 && cp <= 0x1FACD -> True
    cp if cp >= 0x1FADD && cp <= 0x1FADE -> True
    cp if cp >= 0x1FAEA && cp <= 0x1FAEF -> True
    cp if cp >= 0x1FAF9 && cp <= 0x1FAFF -> True
    cp if cp == 0x1FB93 -> True
    cp if cp >= 0x1FBFA && cp <= 0x1FFFF -> True
    cp if cp >= 0x2A6E0 && cp <= 0x2A6FF -> True
    cp if cp >= 0x2B73A && cp <= 0x2B73F -> True
    cp if cp >= 0x2B81E && cp <= 0x2B81F -> True
    cp if cp >= 0x2CEA2 && cp <= 0x2CEAF -> True
    cp if cp >= 0x2EBE1 && cp <= 0x2EBEF -> True
    cp if cp >= 0x2EE5E && cp <= 0x2F7FF -> True
    cp if cp >= 0x2FA1E && cp <= 0x2FFFF -> True
    cp if cp >= 0x3134B && cp <= 0x3134F -> True
    cp if cp >= 0x323B0 && cp <= 0xE0000 -> True
    cp if cp >= 0xE0002 && cp <= 0xE001F -> True
    cp if cp >= 0xE0080 && cp <= 0xE00FF -> True
    cp if cp >= 0xE01F0 && cp <= 0xEFFFF -> True
    cp if cp >= 0xFFFFE && cp <= 0xFFFFF -> True
    _ -> False
  }
}

pub fn in_control(codepoint: Int) -> Bool {
  case codepoint {
    cp if cp >= 0x0000 && cp <= 0x001F -> True
    cp if cp >= 0x007F && cp <= 0x009F -> True
    _ -> False
  }
}

pub fn in_noncharacter(codepoint: Int) -> Bool {
  case codepoint {
    cp if cp >= 0xFDD0 && cp <= 0xFDEF -> True
    cp if cp >= 0xFFFE && cp <= 0xFFFF -> True
    cp if cp >= 0x1FFFE && cp <= 0x1FFFF -> True
    cp if cp >= 0x2FFFE && cp <= 0x2FFFF -> True
    cp if cp >= 0x3FFFE && cp <= 0x3FFFF -> True
    cp if cp >= 0x4FFFE && cp <= 0x4FFFF -> True
    cp if cp >= 0x5FFFE && cp <= 0x5FFFF -> True
    cp if cp >= 0x6FFFE && cp <= 0x6FFFF -> True
    cp if cp >= 0x7FFFE && cp <= 0x7FFFF -> True
    cp if cp >= 0x8FFFE && cp <= 0x8FFFF -> True
    cp if cp >= 0x9FFFE && cp <= 0x9FFFF -> True
    cp if cp >= 0xAFFFE && cp <= 0xAFFFF -> True
    cp if cp >= 0xBFFFE && cp <= 0xBFFFF -> True
    cp if cp >= 0xCFFFE && cp <= 0xCFFFF -> True
    cp if cp >= 0xDFFFE && cp <= 0xDFFFF -> True
    cp if cp >= 0xEFFFE && cp <= 0xEFFFF -> True
    cp if cp >= 0xFFFFE && cp <= 0xFFFFF -> True
    _ -> False
  }
}
