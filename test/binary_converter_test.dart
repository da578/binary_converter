import 'package:binary_converter/binary_converter.dart';
import 'package:test/test.dart';

void main() {
  group('BinaryConverter', () {
    // --- Test Binary to Decimal ---
    group('binaryToDecimal', () {
      test('should convert valid binary strings to decimal', () {
        expect(BinaryConverter.binaryToDecimal('0'), 0);
        expect(BinaryConverter.binaryToDecimal('1'), 1);
        expect(BinaryConverter.binaryToDecimal('10'), 2);
        expect(BinaryConverter.binaryToDecimal('1011'), 11);
        expect(BinaryConverter.binaryToDecimal('11111111'), 255);
        expect(
          BinaryConverter.binaryToDecimal('10000000000000000000000000000000'),
          2147483648,
        ); // Large number
      });

      test('should throw ArgumentError for invalid binary strings', () {
        expect(
          () => BinaryConverter.binaryToDecimal('102'),
          throwsA(isA<ArgumentError>()),
        );
        expect(
          () => BinaryConverter.binaryToDecimal('abc'),
          throwsA(isA<ArgumentError>()),
        );
        expect(
          () => BinaryConverter.binaryToDecimal(''),
          throwsA(isA<ArgumentError>()),
        );
        expect(
          () => BinaryConverter.binaryToDecimal(' '),
          throwsA(isA<ArgumentError>()),
        );
        expect(
          () => BinaryConverter.binaryToDecimal('1 0'),
          throwsA(isA<ArgumentError>()),
        );
      });
    });

    // --- Test Decimal to Binary ---
    group('decimalToBinary', () {
      test('should convert valid decimal integers to binary strings', () {
        expect(BinaryConverter.decimalToBinary(0), '0');
        expect(BinaryConverter.decimalToBinary(1), '1');
        expect(BinaryConverter.decimalToBinary(2), '10');
        expect(BinaryConverter.decimalToBinary(11), '1011');
        expect(BinaryConverter.decimalToBinary(255), '11111111');
        expect(
          BinaryConverter.decimalToBinary(2147483648),
          '10000000000000000000000000000000',
        );
      });

      test(
        'should throw ArgumentError for negative decimal numbers',
        () => {
          expect(
            () => BinaryConverter.decimalToBinary(-1),
            throwsA(isA<ArgumentError>()),
          ),
          expect(
            () => BinaryConverter.decimalToBinary(-100),
            throwsA(isA<ArgumentError>()),
          ),
        },
      );
    });

    // --- Test Binary to Octal ---
    group('binaryToOctal', () {
      test('should convert valid binary strings to octal', () {
        expect(BinaryConverter.binaryToOctal('0'), '0');
        expect(BinaryConverter.binaryToOctal('1'), '1');
        expect(BinaryConverter.binaryToOctal('101'), '5');
        expect(BinaryConverter.binaryToOctal('110101'), '65');
        expect(
          BinaryConverter.binaryToOctal('100000000'),
          '400',
        ); // No padding needed
        expect(
          BinaryConverter.binaryToOctal('1011010'),
          '132',
        ); // Padding needed
        expect(BinaryConverter.binaryToOctal('111111111111'), '7777');
      });

      test('should throw ArgumentError for invalid binary strings', () {
        expect(
          () => BinaryConverter.binaryToOctal('102'),
          throwsA(isA<ArgumentError>()),
        );
        expect(
          () => BinaryConverter.binaryToOctal(''),
          throwsA(isA<ArgumentError>()),
        );
      });
    });

    // --- Test Octal to Binary ---
    group('octalToBinary', () {
      test('should convert valid octal strings to binary', () {
        expect(BinaryConverter.octalToBinary('0'), '0');
        expect(BinaryConverter.octalToBinary('1'), '1');
        expect(BinaryConverter.octalToBinary('5'), '101');
        expect(BinaryConverter.octalToBinary('65'), '110101');
        expect(BinaryConverter.octalToBinary('400'), '100000000');
        expect(BinaryConverter.octalToBinary('7777'), '111111111111');
      });

      test('should throw ArgumentError for invalid octal strings', () {
        expect(
          () => BinaryConverter.octalToBinary('8'),
          throwsA(isA<ArgumentError>()),
        );
        expect(
          () => BinaryConverter.octalToBinary('129'),
          throwsA(isA<ArgumentError>()),
        );
        expect(
          () => BinaryConverter.octalToBinary(''),
          throwsA(isA<ArgumentError>()),
        );
      });
    });

    // --- Test Binary to Hexadecimal ---
    group('binaryToHexadecimal', () {
      test('should convert valid binary strings to hexadecimal', () {
        expect(BinaryConverter.binaryToHexadecimal('0'), '0');
        expect(BinaryConverter.binaryToHexadecimal('1'), '1');
        expect(BinaryConverter.binaryToHexadecimal('1010'), 'A');
        expect(BinaryConverter.binaryToHexadecimal('1111'), 'F');
        expect(BinaryConverter.binaryToHexadecimal('11011110'), 'DE');
        expect(
          BinaryConverter.binaryToHexadecimal('1011010111001101'),
          'B5CD',
        ); // No padding
        expect(
          BinaryConverter.binaryToHexadecimal('101101011100110'),
          '5AC6',
        ); // Padding needed
      });

      test('should throw ArgumentError for invalid binary strings', () {
        expect(
          () => BinaryConverter.binaryToHexadecimal('102'),
          throwsA(isA<ArgumentError>()),
        );
        expect(
          () => BinaryConverter.binaryToHexadecimal(''),
          throwsA(isA<ArgumentError>()),
        );
      });
    });

    // --- Test Hexadecimal to Binary ---
    group('hexadecimalToBinary', () {
      test('should convert valid hexadecimal strings to binary', () {
        expect(BinaryConverter.hexadecimalToBinary('0'), '0');
        expect(BinaryConverter.hexadecimalToBinary('1'), '1');
        expect(BinaryConverter.hexadecimalToBinary('A'), '1010');
        expect(BinaryConverter.hexadecimalToBinary('F'), '1111');
        expect(BinaryConverter.hexadecimalToBinary('DE'), '11011110');
        expect(BinaryConverter.hexadecimalToBinary('B5CD'), '1011010111001101');
        expect(
          BinaryConverter.hexadecimalToBinary('a'),
          '1010',
        ); // Case-insensitive
        expect(
          BinaryConverter.hexadecimalToBinary('f'),
          '1111',
        ); // Case-insensitive
      });

      test('should throw ArgumentError for invalid hexadecimal strings', () {
        expect(
          () => BinaryConverter.hexadecimalToBinary('G'),
          throwsA(isA<ArgumentError>()),
        );
        expect(
          () => BinaryConverter.hexadecimalToBinary('12Z'),
          throwsA(isA<ArgumentError>()),
        );
        expect(
          () => BinaryConverter.hexadecimalToBinary(''),
          throwsA(isA<ArgumentError>()),
        );
      });
    });

    // --- Test Decimal to Octal ---
    group('decimalToOctal', () {
      test('should convert valid decimal integers to octal strings', () {
        expect(BinaryConverter.decimalToOctal(0), '0');
        expect(BinaryConverter.decimalToOctal(1), '1');
        expect(BinaryConverter.decimalToOctal(8), '10');
        expect(BinaryConverter.decimalToOctal(25), '31');
        expect(BinaryConverter.decimalToOctal(63), '77');
      });

      test(
        'should throw ArgumentError for negative decimal numbers',
        () => expect(
          () => BinaryConverter.decimalToOctal(-1),
          throwsA(isA<ArgumentError>()),
        ),
      );
    });

    // --- Test Octal to Decimal ---
    group('octalToDecimal', () {
      test('should convert valid octal strings to decimal', () {
        expect(BinaryConverter.octalToDecimal('0'), 0);
        expect(BinaryConverter.octalToDecimal('1'), 1);
        expect(BinaryConverter.octalToDecimal('10'), 8);
        expect(BinaryConverter.octalToDecimal('31'), 25);
        expect(BinaryConverter.octalToDecimal('77'), 63);
      });

      test('should throw ArgumentError for invalid octal strings', () {
        expect(
          () => BinaryConverter.octalToDecimal('8'),
          throwsA(isA<ArgumentError>()),
        );
        expect(
          () => BinaryConverter.octalToDecimal('129'),
          throwsA(isA<ArgumentError>()),
        );
        expect(
          () => BinaryConverter.octalToDecimal(''),
          throwsA(isA<ArgumentError>()),
        );
      });
    });

    // --- Test Decimal to Hexadecimal ---
    group('decimalToHexadecimal', () {
      test('should convert valid decimal integers to hexadecimal strings', () {
        expect(BinaryConverter.decimalToHexadecimal(0), '0');
        expect(BinaryConverter.decimalToHexadecimal(1), '1');
        expect(BinaryConverter.decimalToHexadecimal(10), 'A');
        expect(BinaryConverter.decimalToHexadecimal(15), 'F');
        expect(BinaryConverter.decimalToHexadecimal(255), 'FF');
        expect(BinaryConverter.decimalToHexadecimal(256), '100');
      });

      test(
        'should throw ArgumentError for negative decimal numbers',
        () => expect(
          () => BinaryConverter.decimalToHexadecimal(-1),
          throwsA(isA<ArgumentError>()),
        ),
      );
    });

    // --- Test Hexadecimal to Decimal ---
    group('hexadecimalToDecimal', () {
      test('should convert valid hexadecimal strings to decimal', () {
        expect(BinaryConverter.hexadecimalToDecimal('0'), 0);
        expect(BinaryConverter.hexadecimalToDecimal('1'), 1);
        expect(BinaryConverter.hexadecimalToDecimal('A'), 10);
        expect(BinaryConverter.hexadecimalToDecimal('F'), 15);
        expect(BinaryConverter.hexadecimalToDecimal('FF'), 255);
        expect(BinaryConverter.hexadecimalToDecimal('100'), 256);
        expect(
          BinaryConverter.hexadecimalToDecimal('a'),
          10,
        ); // Case-insensitive
        expect(
          BinaryConverter.hexadecimalToDecimal('f'),
          15,
        ); // Case-insensitive
      });

      test('should throw ArgumentError for invalid hexadecimal strings', () {
        expect(
          () => BinaryConverter.hexadecimalToDecimal('G'),
          throwsA(isA<ArgumentError>()),
        );
        expect(
          () => BinaryConverter.hexadecimalToDecimal('12Z'),
          throwsA(isA<ArgumentError>()),
        );
        expect(
          () => BinaryConverter.hexadecimalToDecimal(''),
          throwsA(isA<ArgumentError>()),
        );
      });
    });
  });
}
