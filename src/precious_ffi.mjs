import { Ok, Error } from "./gleam.mjs";

export function nfkc(string) {
  return string.normalize("NFKC");
}

export function nfc(string) {
  return string.normalize("NFC");
}

