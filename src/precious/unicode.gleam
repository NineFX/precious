import gleam/list
import gleam/regexp.{type Match, Options}
import gleam/string

const halfwidth_chars = "[\\x{FF01}-\\x{FFEF}]"

const space_chars = "[\\x{00A0}\\x{1680}\\x{2000}-\\x{200A}\\x{202F}\\x{205F}\\x{3000}]"

pub fn map_nonascii_space_to_ascii(s: String) -> String {
  let assert Ok(pattern) =
    regexp.compile(space_chars, with: Options(False, True))
  regexp.replace(each: pattern, in: s, with: " ")
}

pub fn width_map(s: String) -> String {
  let assert Ok(pattern) =
    regexp.compile(halfwidth_chars, with: Options(False, True))
  regexp.match_map(each: pattern, in: s, with: decompose)
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

pub fn in_extended_arabic_indic(codepoint: Int) -> Bool {
  0x06F0 <= codepoint && codepoint <= 0x06F9
}

@external(erlang, "unicode", "characters_to_nfkc_binary")
@external(javascript, "../precious_ffi.mjs", "nkfc")
pub fn nfkc(s: String) -> String

@external(erlang, "unicode", "characters_to_nfc_binary")
@external(javascript, "../precious_ffi.mjs", "nfc")
pub fn nfc(s: String) -> String

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
