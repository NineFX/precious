import gleam/list
import gleam/string
import precious/unicode

pub fn width_map(s: String) -> String {
  map(s, fn(cp) {
    case halfwidth_cp(cp) {
      True -> decompose(cp)
      False -> cp
    }
  })
}

fn halfwidth_cp(codepoint: Int) -> Bool {
  case codepoint {
    cp if cp >= 0xFF01 && cp <= 0xFFEF -> True
    _ -> False
  }
}

fn decompose(codepoint_value: Int) -> Int {
  let assert Ok(codepoint) = string.utf_codepoint(codepoint_value)
  let normalized = [codepoint] |> string.from_utf_codepoints |> unicode.nfkc
  case string.to_utf_codepoints(normalized) {
    [normalized_codepoint] -> string.utf_codepoint_to_int(normalized_codepoint)
    _ -> codepoint_value
  }
}

pub fn map_nonascii_space_to_ascii(s: String) -> String {
  map(s, fn(cp) {
    case is_non_ascii_space_codepoint(cp) {
      True -> 32
      False -> cp
    }
  })
}

fn is_non_ascii_space_codepoint(codepoint: Int) {
  codepoint == 0x00A0
  || codepoint == 0x1680
  || { codepoint >= 0x2000 && codepoint <= 0x200A }
  || codepoint == 0x202F
  || codepoint == 0x205F
  || codepoint == 0x3000
}

pub fn is_space_codepoint(codepoint: Int) {
  codepoint == 32 || is_non_ascii_space_codepoint(codepoint)
}

pub fn map(over string: String, with fun: fn(Int) -> Int) {
  string
  |> string.to_utf_codepoints
  |> list.map(fn(cp) {
    let cp_int = string.utf_codepoint_to_int(cp)
    let mapped_cp_int = fun(cp_int)
    let assert Ok(cp) = string.utf_codepoint(mapped_cp_int)
    cp
  })
  |> string.from_utf_codepoints
}
