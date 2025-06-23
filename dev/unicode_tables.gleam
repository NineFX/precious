import gleam/bit_array
import gleam/bool
import gleam/int
import gleam/list

/// Minimum valid Unicode code point
const min_unicode_codepoint = 0

/// Maximum valid Unicode code point (U+10FFFF)
const max_unicode_codepoint = 1_114_111

/// Represents a Unicode code point range lookup table
pub type UnicodeRangeLookup {
  UnicodeRangeLookup(
    bit_array: BitArray,
    min_codepoint: Int,
    max_codepoint: Int,
  )
}

/// Creates a Unicode range lookup table from a list of code point ranges
/// Each range is represented as a tuple of (start, end) inclusive
pub fn from_ranges(
  ranges: List(#(Int, Int)),
) -> Result(UnicodeRangeLookup, String) {
  use <- bool.guard(
    when: list.is_empty(ranges),
    return: Error("Cannot create lookup from empty ranges"),
  )

  // Find the overall min and max code points
  let #(min_codepoint, max_codepoint) = calculate_range_bounds(ranges)

  // Validate code points are in valid Unicode range
  use <- bool.guard(
    when: min_codepoint < min_unicode_codepoint
      || max_codepoint > max_unicode_codepoint,
    return: Error("Code points must be in range 0-1114111"),
  )

  let size = max_codepoint - min_codepoint + 1

  // Create a bit array filled with zeros (8 bits per byte)
  let byte_size = { size + 7 } / 8
  // Round up division
  let empty_bits =
    bit_array.from_string("")
    |> bit_array.append(<<0:size({ byte_size * 8 })>>)

  // Set bits for each range
  let populated_bits =
    ranges
    |> list.fold(empty_bits, fn(acc_bits, range) {
      set_range_bits(acc_bits, range.0, range.1, min_codepoint, size)
    })

  Ok(UnicodeRangeLookup(
    bit_array: populated_bits,
    min_codepoint: min_codepoint,
    max_codepoint: max_codepoint,
  ))
}

/// Creates a simple lookup table from a single range
pub fn from_range(start: Int, end: Int) -> Result(UnicodeRangeLookup, String) {
  from_ranges([#(start, end)])
}

/// Sets bits in the bit array for a given range using bit manipulation
fn set_range_bits(
  bits: BitArray,
  start: Int,
  end: Int,
  offset: Int,
  total_size: Int,
) -> BitArray {
  // Create a new bit array with the range bits set
  list.range(start, end)
  |> list.fold(bits, fn(acc_bits, codepoint) {
    let bit_index = codepoint - offset
    use <- bool.guard(
      when: bit_index < 0 || bit_index >= total_size,
      return: acc_bits,
    )
    set_bit_at_index(acc_bits, bit_index)
  })
}

/// Sets a single bit at the given index (helper function)
fn set_bit_at_index(bits: BitArray, index: Int) -> BitArray {
  let byte_index = index / 8
  let bit_offset = index % 8

  case bit_array.slice(bits, byte_index, 1) {
    Ok(target_byte) -> {
      case target_byte {
        <<byte_val:int>> -> {
          // Set the bit in the target byte using bitwise OR
          let mask = int.bitwise_shift_left(1, 7 - bit_offset)
          let new_byte_val = int.bitwise_or(byte_val, mask)
          let new_byte = <<new_byte_val:int>>

          // Reconstruct the bit array with the modified byte
          case bit_array.slice(bits, 0, byte_index) {
            Ok(before) -> {
              case
                bit_array.slice(
                  bits,
                  byte_index + 1,
                  bit_array.byte_size(bits) - byte_index - 1,
                )
              {
                Ok(after) ->
                  bit_array.append(before, bit_array.append(new_byte, after))
                Error(_) -> bit_array.append(before, new_byte)
              }
            }
            Error(_) -> bits
          }
        }
        _ -> bits
      }
    }
    Error(_) -> bits
  }
}

/// Checks if a code point is within any of the ranges in the lookup table
pub fn contains(lookup: UnicodeRangeLookup, codepoint: Int) -> Bool {
  use <- bool.guard(
    when: codepoint < lookup.min_codepoint || codepoint > lookup.max_codepoint,
    return: False,
  )

  let index = codepoint - lookup.min_codepoint
  // Check if the bit at the calculated index is set
  is_bit_set(lookup.bit_array, index)
}

/// Checks if a bit is set at a given index in the bit array
fn is_bit_set(bits: BitArray, index: Int) -> Bool {
  let byte_index = index / 8
  let bit_offset = index % 8

  case bit_array.slice(bits, byte_index, 1) {
    Ok(byte_slice) -> {
      // Convert byte to integer and check if bit is set
      case byte_slice {
        <<byte_val:int>> -> {
          let mask = int.bitwise_shift_left(1, 7 - bit_offset)
          // Big-endian bit ordering
          int.bitwise_and(byte_val, mask) != 0
        }
        _ -> False
      }
    }
    Error(_) -> False
  }
}

/// Returns the range of code points covered by this lookup table
pub fn get_range(lookup: UnicodeRangeLookup) -> #(Int, Int) {
  #(lookup.min_codepoint, lookup.max_codepoint)
}

/// Returns the size of the lookup table in bytes
pub fn size(lookup: UnicodeRangeLookup) -> Int {
  bit_array.byte_size(lookup.bit_array)
}

/// Calculates the overall min and max code points from a list of ranges
fn calculate_range_bounds(ranges: List(#(Int, Int))) -> #(Int, Int) {
  let min_codepoint =
    ranges
    |> list.map(fn(range) { range.0 })
    |> list.fold(max_unicode_codepoint, fn(acc, val) {
      case val < acc {
        True -> val
        False -> acc
      }
    })

  let max_codepoint =
    ranges
    |> list.map(fn(range) { range.1 })
    |> list.fold(min_unicode_codepoint, fn(acc, val) {
      case val > acc {
        True -> val
        False -> acc
      }
    })

  #(min_codepoint, max_codepoint)
}
