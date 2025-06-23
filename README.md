# precious

[![Package Version](https://img.shields.io/hexpm/v/precious)](https://hex.pm/packages/precious)
[![Hex Docs](https://img.shields.io/badge/hex-docs-ffaff3)](https://hexdocs.pm/precious/)

Precious is a port of [precis_i18n](https://github.com/byllyfish/precis_i18n) to Gleam.

To add Precious to your Gleam project:

```sh
gleam add precious@1
```

Here's some examples of how to call Precious in Gleam.

```gleam
import precious

pub fn main() {
  let profile = profile.username_case_preserved()
  let _ = profile.enforce("Juliet", profile) |> echo
  // Ok("Juliet")
  profile.enforce("E\u{0301}\u{0301}\u{0301}", profile) |> echo
  // Ok("\u{00C9}\u{0301}\u{0301}") or Ok("É́́")
  profile.enforce("", profile) |> echo
  // Error(Empty)
  profile.enforce(" J", profile) |> echo
  // Error(CategoryError(FreePVal(Spaces), 0))
}
```

Further documentation can be found at <https://hexdocs.pm/precious>.

## Gotchas

The Erlang lowercase and casemap functions don't implement the full Unicode
casing algorithm. 

```erlang
1> string:lowercase(<<"ΒόλοΣ"/utf8>>).
<<"βόλοσ"/utf8>>
2> string:casefold(<<"ΒόλοΣ"/utf8>>).
<<"βόλοσ"/utf8>>
```

The example above should generate `βόλος`. A future version of Precious may
implement the Unicode lowercase and casefold algorithms from scratch. This
also solves an issue where the underlying Erlang runtime uses a different
Unicode version than Precious

## Development

Only the Erlang target is currently supported.

```sh
gleam dev   # Run code generation against the Unicode spec (only needed once)
gleam build # Build precious
gleam test  # Run the tests
```

