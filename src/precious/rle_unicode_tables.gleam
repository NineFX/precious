import gleam/bit_array
import gleam/bool

/// Represents a compressed Unicode code point range lookup table
/// The bit array stores RLE-encoded segments in the format:
/// [1-bit: value][31-bits: length][1-bit: value][31-bits: length]...
pub type UnicodeRangeLookup {
  UnicodeRangeLookup(rle_data: BitArray, min_codepoint: Int, max_codepoint: Int)
}

/// Checks if a code point is within any of the ranges in the lookup table
pub fn contains(lookup: UnicodeRangeLookup, codepoint: Int) -> Bool {
  use <- bool.guard(
    when: codepoint < lookup.min_codepoint || codepoint > lookup.max_codepoint,
    return: False,
  )
  let relative_pos = codepoint - lookup.min_codepoint
  find_in_rle_bitarray(lookup.rle_data, relative_pos, 0, 0)
}

/// Walks through the RLE bit array to find if a position is included
fn find_in_rle_bitarray(
  rle_data: BitArray,
  target_pos: Int,
  current_pos: Int,
  byte_offset: Int,
) -> Bool {
  // Each segment is 32 bits (4 bytes): 1 bit value + 31 bits length
  case bit_array.slice(rle_data, byte_offset, 4) {
    Ok(segment_bytes) -> {
      case segment_bytes {
        <<value_bit:1, length:31>> -> {
          let segment_end = current_pos + length - 1
          case target_pos >= current_pos && target_pos <= segment_end {
            True -> value_bit == 1
            False ->
              find_in_rle_bitarray(
                rle_data,
                target_pos,
                current_pos + length,
                byte_offset + 4,
              )
          }
        }
        _ -> False
      }
    }
    Error(_) -> False
  }
}
