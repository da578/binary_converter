# Changelog

All notable changes to this project will be documented in this file.

The format is based on [Keep a Changelog](https://keepachangelog.com/en/1.0.0/), and this project adheres to [Semantic Versioning](https://semver.org/spec/v2.0.0.html).

## 0.0.1 - 2025-07-20

### Added

- Initial release of the `binary_conversion` package.
- Implemented `BinaryConverter` class with comprehensive methods for:
  - Binary to Decimal, Octal, Hexadecimal conversions.
  - Decimal to Binary, Octal, Hexadecimal conversions.
  - Octal to Binary, Decimal conversions.
  - Hexadecimal to Binary, Decimal conversions.
- Included robust input validation for all conversion methods.
- Utilized Dart's built-in `int.parse(radix:)` and `int.toRadixString()` for efficient decimal conversions.
Implemented custom logic for direct binary-to-octal/hexadecimal and vice-versa conversions using bit grouping.