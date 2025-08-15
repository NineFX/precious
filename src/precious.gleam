import precious/profile

pub type Profile =
  profile.Profile

pub type EnforcementError =
  profile.EnforcementError

/// Get the Unicode version that this library is based on.
pub fn unicode_version() -> String {
  "16.0.0"
}

/// PRECIS Representing Usernames and Passwords, RFC 8265
/// Lowercased.
pub fn username_case_mapped() -> Profile {
  profile.username_case_mapped()
}

/// PRECIS Representing Usernames and Passwords, RFC 8265
/// Not lowercase, not case-preserving, and not case-mapped.
pub fn username_case_preserved() -> Profile {
  profile.username_case_preserved()
}

/// PRECIS Representing Nicknames, RFC 8266
/// A nickname is a memorable, human-friendly name in a communications
/// context or to set such a name for another entity such as a device,
/// account, contact, or website.  Such names are variously called
/// "nicknames" (e.g., in chat room applications), "display names" (e.g.,
/// in Internet mail), or "petnames".
pub fn nickname() -> Profile {
  profile.nickname()
}

/// PRECIS OpaqueString Profile, RFC 7613
/// The OpaqueString profile is designed for use with diverse character
/// strings that are used in network and application protocols. The
/// profile is intended to be broadly applicable for password-like
/// secrets and other opaque strings (such as URIs or directory strings)
/// that are not intended to be presented to users.
pub fn opaque_string() -> Profile {
  profile.opaque_string()
}

/// Enforcement entails applying all of the rules specified for a
/// particular string class, or profile thereof, to a single input
/// string, for the purpose of checking whether the string conforms to
/// all of the rules and thus determining if the string can be used in
/// a given protocol slot. (RFC 8264, Section 3)
pub fn enforce(
  str: String,
  profile: Profile,
) -> Result(String, EnforcementError) {
  profile.enforce(str, profile)
}
