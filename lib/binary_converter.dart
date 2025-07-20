/// A utility class for converting numbers between binary, octal, decimal, and hexadecimal systems.
///
/// This class provides static methods to perform common base conversions,
/// ensuring robust input validation and handling of common edge cases.
/// All methods that return a string representation of a number will return
/// uppercase letters for hexadecimal values (e.g., 'A' instead of 'a').
class BinaryConverter {
  //--- Static Lookup Maps for Direct Bit-to-Digit Conversions ---
  // These maps are used for efficient grouping/ungrouping of bits for Octal and Hexadecimal.

  /// Maps 3-bit binary strings to their corresponding octal digits (0-7).
  static const Map<String, String> _threeBitBinaryToOctalMap = {
    "000": "0",
    "001": "1",
    "010": "2",
    "011": "3",
    "100": "4",
    "101": "5",
    "110": "6",
    "111": "7",
  };

  /// Maps octal digits (0-7) to their corresponding 3-bit binary strings.
  static const Map<String, String> _octalToThreeBitBinaryMap = {
    "0": "000",
    "1": "001",
    "2": "010",
    "3": "011",
    "4": "100",
    "5": "101",
    "6": "110",
    "7": "111",
  };

  /// Maps 4-bit binary strings to their corresponding hexadecimal digits (0-9, A-F).
  static const Map<String, String> _fourBitBinaryToHexMap = {
    "0000": "0",
    "0001": "1",
    "0010": "2",
    "0011": "3",
    "0100": "4",
    "0101": "5",
    "0110": "6",
    "0111": "7",
    "1000": "8",
    "1001": "9",
    "1010": "A",
    "1011": "B",
    "1100": "C",
    "1101": "D",
    "1110": "E",
    "1111": "F",
  };

  /// Maps hexadecimal digits (0-9, A-F) to their corresponding 4-bit binary strings.
  static const Map<String, String> _hexToFourBitBinaryMap = {
    "0": "0000",
    "1": "0001",
    "2": "0010",
    "3": "0011",
    "4": "0100",
    "5": "0101",
    "6": "0110",
    "7": "0111",
    "8": "1000",
    "9": "1001",
    "A": "1010",
    "B": "1011",
    "C": "1100",
    "D": "1101",
    "E": "1110",
    "F": "1111",
  };

  /// Checks if the given [binaryString] contains only '0' and '1'.
  static bool _isValidBinary(String binaryString) {
    if (binaryString.trim().isEmpty) return false;
    for (int i = 0; i < binaryString.length; i++) {
      final char = binaryString[i];
      if (char != '0' && char != '1') return false;
    }
    return true;
  }

  /// Checks if the given [octalString] contains only digits '0' through '7'.
  static bool _isValidOctal(String octalString) {
    if (octalString.trim().isEmpty) return false;
    for (int i = 0; i < octalString.length; i++) {
      final char = octalString[i];
      if (char.codeUnitAt(0) < '0'.codeUnitAt(0) ||
          char.codeUnitAt(0) > '7'.codeUnitAt(0)) {
        return false;
      }
    }
    return true;
  }

  /// Checks if the given [hexString] contains valid hexadecimal characters (0-9, A-F, case-insensitive).
  static bool _isValidHexadecimal(String hexString) {
    if (hexString.trim().isEmpty) return false;
    final upperHexString = hexString.toUpperCase();
    for (int i = 0; i < upperHexString.length; i++) {
      final char = upperHexString[i];
      if (!(char.codeUnitAt(0) >= '0'.codeUnitAt(0) &&
              char.codeUnitAt(0) <= '9'.codeUnitAt(0)) ||
          (char.codeUnitAt(0) >= 'A'.codeUnitAt(0) &&
              char.codeUnitAt(0) <= 'F'.codeUnitAt(0))) {
        return false;
      }
    }
    return true;
  }

  static String _trimLeadingZeros(String binaryString) {
    if (binaryString == "0") return "0";
    final firstOneIndex = binaryString.indexOf('1');
    if (firstOneIndex == -1) return "0";
    return binaryString.substring(firstOneIndex);
  }

  // --- Public Conversion Methods ---
  /// Converts a binary string [binaryString] to its decimal (base-10) integer representation.
  ///
  /// Parameters:
  /// - [binaryString]: The binary string to convert. Must contain only '0' and '1'.
  ///
  /// Returns:
  /// An [int] representing the decimal value.
  ///
  /// Throws:
  /// - [ArgumentError]: If [binaryString] is empty, null, or contains invalid binary characters.
  static int binaryToDecimal(String binaryString) {
    if (!_isValidBinary(binaryString) || binaryString.trim().isEmpty) {
      throw ArgumentError(
        'Invalid binary string input. Must contain only "0" or "1".',
      );
    }
    return int.parse(binaryString, radix: 2);
  }

  /// Converts a binary string [binaryString] to its octal (base-8) string representation.
  ///
  /// The binary string is padded with leading zeros to make its length a multiple of 3,
  /// then grouped into 3-bit segments, each converted to an octal digit.
  /// Leading zeros in the final octal output are removed unless the result is "0".
  ///
  /// Parameters:
  /// - [binaryString]: The binary string to convert. Must contain only '0' and '1'.
  ///
  /// Returns:
  /// A [String] representing the octal value.
  ///
  /// Throws:
  /// - [ArgumentError]: If [binaryString] is empty, null, or contains invalid binary characters.
  static String binaryToOctal(String binaryString) {
    if (!_isValidBinary(binaryString) || binaryString.trim().isEmpty) {
      throw ArgumentError(
        'Invalid binary string input. Must contain only "0" or "1".',
      );
    }
    if (binaryString == "0") return "0";

    final StringBuffer octalStringBuilder = StringBuffer();
    int paddingNeeded = binaryString.length % 3;
    if (paddingNeeded != 0) {
      binaryString = '0' * (3 - paddingNeeded) + binaryString;
    }

    for (int i = 0; i < binaryString.length; i += 3) {
      final String threeBits = binaryString.substring(i, i + 3);
      final String? octalDigit = _threeBitBinaryToOctalMap[threeBits];
      if (octalDigit == null) {
        throw ArgumentError(
          'Internal error: Invalid 3-bit group "$threeBits" encountered.',
        );
      }
      octalStringBuilder.write(octalDigit);
    }

    return _trimLeadingZeros(octalStringBuilder.toString());
  }

  /// Converts a binary string [binaryString] to its hexadecimal (base-16) string representation.
  ///
  /// The binary string is padded with leading zeros to make its length a multiple of 4,
  /// then grouped into 4-bit segments, each converted to a hexadecimal digit.
  /// Leading zeros in the final hexadecimal output are removed unless the result is "0".
  ///
  /// Parameters:
  /// - [binaryString]: The binary string to convert. Must contain only '0' and '1'.
  ///
  /// Returns:
  /// A [String] representing the hexadecimal value.
  ///
  /// Throws:
  /// - [ArgumentError]: If [binaryString] is empty, null, or contains invalid binary characters.
  static String binaryToHexadecimal(String binaryString) {
    if (!_isValidBinary(binaryString) || binaryString.trim().isEmpty) {
      throw ArgumentError(
        'Invalid binary string input. Must contain only "0" or "1".',
      );
    }
    if (binaryString == "0") return "0";

    final StringBuffer hexStringBuilder = StringBuffer();
    int paddingNeeded = binaryString.length % 4;
    if (paddingNeeded != 0) {
      binaryString = '0' * (4 - paddingNeeded) + binaryString;
    }

    for (int i = 0; i < binaryString.length; i += 4) {
      final String fourBits = binaryString.substring(i, i + 4);
      final String? hexDigit = _fourBitBinaryToHexMap[fourBits];
      if (hexDigit == null) {
        throw ArgumentError(
          'Internal error: Invalid 4-bit group "$fourBits" encountered.',
        );
      }
      hexStringBuilder.write(hexDigit);
    }

    return _trimLeadingZeros(hexStringBuilder.toString());
  }

  /// Converts a decimal integer [decimalNumber] to its binary (base-2) string representation.
  ///
  /// Parameters:
  /// - [decimalNumber]: The non-negative decimal integer to convert.
  ///
  /// Returns:
  /// A [String] representing the binary value.
  ///
  /// Throws:
  /// - [ArgumentError]: If [decimalNumber] is negative.
  static String decimalToBinary(int decimalNumber) {
    if (decimalNumber < 0) {
      throw ArgumentError(
        'Decimal number cannot be negative for direct binary conversion.',
      );
    }
    // Dart's built-in toRadixString is efficient.
    return decimalNumber.toRadixString(2);
  }

  /// Converts a decimal integer [decimalNumber] to its octal (base-8) string representation.
  ///
  /// Parameters:
  /// - [decimalNumber]: The non-negative decimal integer to convert.
  ///
  /// Returns:
  /// A [String] representing the octal value.
  ///
  /// Throws:
  /// - [ArgumentError]: If [decimalNumber] is negative.
  static String decimalToOctal(int decimalNumber) {
    if (decimalNumber < 0) {
      throw ArgumentError(
        'Decimal number cannot be negative for direct octal conversion.',
      );
    }
    return decimalNumber.toRadixString(8);
  }

  /// Converts a decimal integer [decimalNumber] to its hexadecimal (base-16) string representation.
  ///
  /// Parameters:
  /// - [decimalNumber]: The non-negative decimal integer to convert.
  ///
  /// Returns:
  /// A [String] representing the hexadecimal value (uppercase).
  ///
  /// Throws:
  /// - [ArgumentError]: If [decimalNumber] is negative.
  static String decimalToHexadecimal(int decimalNumber) {
    if (decimalNumber < 0) {
      throw ArgumentError(
        'Decimal number cannot be negative for direct hexadecimal conversion.',
      );
    }
    return decimalNumber
        .toRadixString(16)
        .toUpperCase(); // Hex usually uses uppercase letters
  }

  /// Converts an octal string [octalString] to its binary (base-2) string representation.
  ///
  /// Each octal digit is converted to its 3-bit binary equivalent.
  /// Leading zeros in the final binary output are removed unless the result is "0".
  ///
  /// Parameters:
  /// - [octalString]: The octal string to convert. Must contain only digits '0' through '7'.
  ///
  /// Returns:
  /// A [String] representing the binary value.
  ///
  /// Throws:
  /// - [ArgumentError]: If [octalString] is empty, null, or contains invalid octal characters.
  static String octalToBinary(String octalString) {
    if (!_isValidOctal(octalString) || octalString.trim().isEmpty) {
      throw ArgumentError(
        'Invalid octal string input. Must contain digits "0-7".',
      );
    }
    if (octalString == "0") return "0";

    final StringBuffer binaryStringBuilder = StringBuffer();
    for (int i = 0; i < octalString.length; i++) {
      final String char = octalString[i];
      final String? threeBitsBinary = _octalToThreeBitBinaryMap[char];
      if (threeBitsBinary == null) {
        throw ArgumentError(
          'Internal error: Invalid octal digit "$char" encountered.',
        );
      }
      binaryStringBuilder.write(threeBitsBinary);
    }

    return _trimLeadingZeros(binaryStringBuilder.toString());
  }

  /// Converts an octal string [octalString] to its decimal (base-10) integer representation.
  ///
  /// Parameters:
  /// - [octalString]: The octal string to convert. Must contain only digits '0' through '7'.
  ///
  /// Returns:
  /// An [int] representing the decimal value.
  ///
  /// Throws:
  /// - [ArgumentError]: If [octalString] is empty, null, or contains invalid octal characters.
  static int octalToDecimal(String octalString) {
    if (!_isValidOctal(octalString) || octalString.trim().isEmpty) {
      throw ArgumentError(
        'Invalid octal string input. Must contain digits "0-7".',
      );
    }
    return int.parse(octalString, radix: 8);
  }

  /// Converts a hexadecimal string [hexString] to its binary (base-2) string representation.
  ///
  /// Each hexadecimal digit is converted to its 4-bit binary equivalent.
  /// Leading zeros in the final binary output are removed unless the result is "0".
  ///
  /// Parameters:
  /// - [hexString]: The hexadecimal string to convert. Must contain valid hex characters (0-9, A-F).
  ///
  /// Returns:
  /// A [String] representing the binary value.
  ///
  /// Throws:
  /// - [ArgumentError]: If [hexString] is empty, null, or contains invalid hexadecimal characters.
  static String hexadecimalToBinary(String hexString) {
    if (!_isValidHexadecimal(hexString) || hexString.trim().isEmpty) {
      throw ArgumentError(
        'Invalid hexadecimal string input. Must contain "0-9, A-F".',
      );
    }
    if (hexString == "0") return "0";

    final StringBuffer binaryStringBuilder = StringBuffer();
    final upperHexString = hexString
        .toUpperCase(); // Ensure uppercase for map lookup
    for (int i = 0; i < upperHexString.length; i++) {
      final String char = upperHexString[i];
      final String? fourBitsBinary = _hexToFourBitBinaryMap[char];
      if (fourBitsBinary == null) {
        throw ArgumentError(
          'Internal error: Invalid hex digit "$char" encountered.',
        );
      }
      binaryStringBuilder.write(fourBitsBinary);
    }

    return _trimLeadingZeros(binaryStringBuilder.toString());
  }

  /// Converts a hexadecimal string [hexString] to its decimal (base-10) integer representation.
  ///
  /// Parameters:
  /// - [hexString]: The hexadecimal string to convert. Must contain valid hex characters (0-9, A-F).
  ///
  /// Returns:
  /// An [int] representing the decimal value.
  ///
  /// Throws:
  /// - [ArgumentError]: If [hexString] is empty, null, or contains invalid hexadecimal characters.
  static int hexadecimalToDecimal(String hexString) {
    if (!_isValidHexadecimal(hexString) || hexString.trim().isEmpty) {
      throw ArgumentError(
        'Invalid hexadecimal string input. Must contain "0-9, A-F".',
      );
    }
    return int.parse(hexString, radix: 16);
  }
}
