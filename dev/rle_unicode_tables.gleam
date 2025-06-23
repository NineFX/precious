/// Unicode Range Lookup Module with RLE-Compressed Bit Arrays
///
/// This module provides efficient Unicode code point range lookup using
/// run-length encoding (RLE) stored directly in bit arrays.
///
/// ## Bit Array Structure:
///
/// The RLE data is stored as a sequence of 32-bit segments:
/// ```
/// [1-bit: included][31-bits: length][1-bit: included][31-bits: length]...
/// ```
///
/// **Segment Format:**
/// - Bit 0: Value (1 = included in range, 0 = excluded from range)
/// - Bits 1-31: Run length (max 2,147,483,647 consecutive code points)
/// - Each segment represents exactly one contiguous run of included/excluded points
/// - Segments are stored sequentially with no padding or alignment gaps
///
/// **Example - ASCII letters (A-Z: 65-90, a-z: 97-122):**
/// ```
/// Segment 1: <<0:1, 65:31>>   // Code points 0-64: excluded (65 chars)
/// Segment 2: <<1:1, 26:31>>   // Code points 65-90: included (A-Z, 26 chars)  
/// Segment 3: <<0:1, 6:31>>    // Code points 91-96: excluded (6 chars)
/// Segment 4: <<1:1, 26:31>>   // Code points 97-122: included (a-z, 26 chars)
/// Total: 16 bytes (4 segments × 4 bytes each)
/// ```
///
/// **Lookup Algorithm:**
/// 1. Convert absolute code point to relative position within min-max range
/// 2. Walk through segments, tracking cumulative position
/// 3. When target position falls within a segment, return that segment's value
/// 4. Time complexity: O(segments), where segments << total range size
///
/// ## Benefits of this approach:
///
/// **Space Efficiency:**
/// - Compresses long runs of consecutive included/excluded code points
/// - Only 4 bytes per RLE segment vs 1 bit per code point in naive approach
/// - Excellent for Unicode ranges which often have sparse, clustered patterns
/// - Example: ASCII letters (A-Z, a-z) = 16 bytes vs 16+ bytes uncompressed
///
/// **Memory Layout:**
/// - Direct bit array storage with predictable 32-bit segment alignment
/// - No pointer indirection or heap fragmentation from nested data structures
/// - Cache-friendly sequential access pattern during lookups
///
/// **Performance:**
/// - Fast lookup via direct bit manipulation (no string parsing)
/// - Linear search through segments, but segment count << total range size
/// - Automatic range merging eliminates overlapping/adjacent ranges
/// - Single allocation for entire lookup table
///
/// **Practical Advantages:**
/// - Perfect for Unicode character classes (letters, digits, punctuation, etc.)
/// - Handles sparse ranges efficiently (e.g., mathematical symbols)
/// - Scales well from small ranges (single chars) to large blocks (entire scripts)
/// - Deterministic memory usage: exactly 4 bytes × number of runs
/// 
import gleam/bit_array
import gleam/bool
import gleam/int
import gleam/list
import precious/rle_unicode_tables.{type UnicodeRangeLookup, UnicodeRangeLookup}

/// Minimum valid Unicode code point
const min_unicode_codepoint = 0

/// Maximum valid Unicode code point (U+10FFFF)
const max_unicode_codepoint = 1_114_111

/// Creates a Unicode range lookup table from a list of code point ranges
/// Each range is represented as a tuple of (start, end) inclusive
pub fn from_ranges(
  ranges: List(#(Int, Int)),
) -> Result(UnicodeRangeLookup, String) {
  use <- bool.guard(when: list.is_empty(ranges), return: Error("Empty ranges"))

  // Find the overall min and max code points
  let #(min_codepoint, max_codepoint) = calculate_range_bounds(ranges)

  // Validate code points are in valid Unicode range
  use <- bool.guard(
    when: min_codepoint < min_unicode_codepoint
      || max_codepoint > max_unicode_codepoint,
    return: Error("Codepoints must be in range 0-1,114,111"),
  )

  // Create RLE bit array from the ranges
  let rle_data = create_rle_bitarray(ranges, min_codepoint, max_codepoint)

  Ok(UnicodeRangeLookup(
    rle_data: rle_data,
    min_codepoint: min_codepoint,
    max_codepoint: max_codepoint,
  ))
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

/// Creates an RLE-encoded bit array from ranges
fn create_rle_bitarray(
  ranges: List(#(Int, Int)),
  min_cp: Int,
  max_cp: Int,
) -> BitArray {
  // Create transition points: each range start gets +1, each range end+1 gets -1
  let transitions =
    ranges
    |> list.flat_map(fn(range) { [#(range.0, 1), #(range.1 + 1, -1)] })
    |> list.sort(fn(a, b) { int.compare(a.0, b.0) })
    |> merge_transitions([])

  // Convert transitions to RLE segments and encode as bit array
  let segments = transitions_to_segments(transitions, min_cp, max_cp, 0, [])
  encode_segments_to_bitarray(list.reverse(segments))
}

/// Merges transitions at the same position by summing their deltas
fn merge_transitions(
  transitions: List(#(Int, Int)),
  acc: List(#(Int, Int)),
) -> List(#(Int, Int)) {
  case transitions {
    [] -> list.reverse(acc)
    [first] -> list.reverse([first, ..acc])
    [a, b, ..rest] -> {
      case a.0 == b.0 {
        True -> {
          let merged = #(a.0, a.1 + b.1)
          merge_transitions([merged, ..rest], acc)
        }
        False -> merge_transitions([b, ..rest], [a, ..acc])
      }
    }
  }
}

/// Converts transition points to RLE segments
fn transitions_to_segments(
  transitions: List(#(Int, Int)),
  min_cp: Int,
  max_cp: Int,
  current_count: Int,
  acc: List(#(Bool, Int)),
) -> List(#(Bool, Int)) {
  case transitions {
    [] -> {
      // Handle final segment to max_cp
      case current_count > 0 && min_cp <= max_cp {
        True -> [#(True, max_cp - min_cp + 1), ..acc]
        False ->
          case min_cp <= max_cp {
            True -> [#(False, max_cp - min_cp + 1), ..acc]
            False -> acc
          }
      }
    }
    [#(pos, delta), ..rest] -> {
      case pos > min_cp {
        True -> {
          // Create segment from min_cp to pos-1
          case current_count > 0 {
            True -> {
              let new_acc = [#(True, pos - min_cp), ..acc]
              let new_count = current_count + delta
              transitions_to_segments(rest, pos, max_cp, new_count, new_acc)
            }
            False -> {
              let new_acc = [#(False, pos - min_cp), ..acc]
              let new_count = current_count + delta
              transitions_to_segments(rest, pos, max_cp, new_count, new_acc)
            }
          }
        }
        False -> {
          // Transition is at or before current position
          let new_count = current_count + delta
          transitions_to_segments(
            rest,
            int.max(min_cp, pos),
            max_cp,
            new_count,
            acc,
          )
        }
      }
    }
  }
}

/// Encodes RLE segments into a bit array
/// Format: [1-bit: included][31-bits: length] repeated
fn encode_segments_to_bitarray(segments: List(#(Bool, Int))) -> BitArray {
  segments
  |> list.fold(<<>>, fn(acc, segment) {
    let #(value, length) = segment
    let value_bit = case value {
      True -> 1
      False -> 0
    }
    // Store as: 1 bit for value + 31 bits for length (max ~2B codepoints)
    bit_array.append(acc, <<value_bit:1, length:31>>)
  })
}

/// Returns the range of code points covered by this lookup table
pub fn get_range(lookup: UnicodeRangeLookup) -> #(Int, Int) {
  #(lookup.min_codepoint, lookup.max_codepoint)
}

/// Returns the size of the RLE data in bytes
pub fn size_bytes(lookup: UnicodeRangeLookup) -> Int {
  bit_array.byte_size(lookup.rle_data)
}

/// Returns the number of RLE segments
pub fn segment_count(lookup: UnicodeRangeLookup) -> Int {
  bit_array.byte_size(lookup.rle_data) / 4
}

/// Returns the compression ratio compared to an uncompressed bit array
pub fn compression_ratio(lookup: UnicodeRangeLookup) -> Float {
  let total_codepoints = lookup.max_codepoint - lookup.min_codepoint + 1
  let compressed_bytes = bit_array.byte_size(lookup.rle_data)
  let uncompressed_bytes = { total_codepoints + 7 } / 8

  case uncompressed_bytes > 0 {
    True -> int.to_float(compressed_bytes) /. int.to_float(uncompressed_bytes)
    False -> 1.0
  }
}

/// Debug function to decode and show the RLE segments
pub fn debug_segments(lookup: UnicodeRangeLookup) -> List(#(Bool, Int)) {
  decode_rle_segments(lookup.rle_data, 0, [])
  |> list.reverse()
}

/// Decodes RLE segments from the bit array for debugging
fn decode_rle_segments(
  rle_data: BitArray,
  byte_offset: Int,
  acc: List(#(Bool, Int)),
) -> List(#(Bool, Int)) {
  case bit_array.slice(rle_data, byte_offset, 4) {
    Ok(segment_bytes) -> {
      case segment_bytes {
        <<value_bit:1, length:31>> -> {
          let value = value_bit == 1
          let new_acc = [#(value, length), ..acc]
          decode_rle_segments(rle_data, byte_offset + 4, new_acc)
        }
        _ -> acc
      }
    }
    Error(_) -> acc
  }
}
