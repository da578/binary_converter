# binary_converter

A lightweight Dart package providing utility functions for converting numbers between common numeral systems: binary, octal, decimal, and hexadecimal.

## Features

- Convert binary strings to decimal, octal, and hexadecimal.
- Convert decimal integers to binary, octal, and hexadecimal strings.
- Convert octal strings to binary and decimal.
- Convert hexadecimal strings to binary and decimal.
- Robust input validation for each conversion.

## Installation

Add `binary_conversion` to your `pubspec.yaml` file:

```yaml
dependencies:
  binary_conversion: ^0.0.1 # Replace with the latest version
```

Then, run `dart pub get` (or `flutter pub get`) in your project's root directory.

## Usage

Import the main library file:
```yaml
import 'package:binary_conversion/binary_conversion.dart'; // Or just binary_converter.dart if that's your main export
```

Here are some examples of how to use the BinaryConverter class:

```dart
void main() {
  // Binary to Decimal
  print('Binary "1011" to Decimal: ${BinaryConverter.binaryToDecimal("1011")}'); // Output: 11

  // Decimal to Binary
  print('Decimal 10 to Binary: ${BinaryConverter.decimalToBinary(10)}'); // Output: 1010

  // Binary to Octal
  print('Binary "110101" to Octal: ${BinaryConverter.binaryToOctal("110101")}'); // Output: 65

  // Octal to Binary
  print('Octal "72" to Binary: ${BinaryConverter.octalToBinary("72")}'); // Output: 111010

  // Binary to Hexadecimal
  print('Binary "11011110" to Hexadecimal: ${BinaryConverter.binaryToHexadecimal("11011110")}'); // Output: DE

  // Hexadecimal to Binary
  print('Hexadecimal "F5" to Binary: ${BinaryConverter.hexadecimalToBinary("F5")}'); // Output: 11110101

  // Decimal to Octal
  print('Decimal 25 to Octal: ${BinaryConverter.decimalToOctal(25)}'); // Output: 31

  // Octal to Decimal
  print('Octal "31" to Decimal: ${BinaryConverter.octalToDecimal("31")}'); // Output: 25

  // Decimal to Hexadecimal
  print('Decimal 255 to Hexadecimal: ${BinaryConverter.decimalToHexadecimal(255)}'); // Output: FF

  // Hexadecimal to Decimal
  print('Hexadecimal "FF" to Decimal: ${BinaryConverter.hexadecimalToDecimal("FF")}'); // Output: 255

  // Example of invalid input handling
  try {
    BinaryConverter.binaryToDecimal("1012");
  } catch (e) {
    print('Error: $e'); // Output: Error: Invalid argument(s): Invalid binary string input. Must contain only "0" or "1".
  }
}
```

## Running Tests

This package includes a comprehensive suite of unit tests to ensure the correctness of all conversion methods.

To run the tests:

1. Navigate to the root directory of the binary_conversion package in your terminal.
2. Run the following command:
    ```dart
    dart test
    ```
    (or flutter test if you're in a Flutter project that depends on this package).

## Contributing

Contributions are welcome! If you have suggestions for improvements or bug fixes, feel free to open an issue or submit a pull request on the [GitHub repository]().

## License
This package is distributed under the MIT License. See the [LICENSE](LICENSE) file for details.