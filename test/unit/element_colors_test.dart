import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/pages/element_colors.dart';

void main() {
  group('ElementColors Tests', () {
    test('should have correct button color values', () {
      const expectedColor = Color.fromRGBO(111, 153, 215, 1);
      expect(ElementColors.buttonColor, equals(expectedColor));
      
      // Test individual RGB values
      expect(ElementColors.buttonColor.red, equals(111));
      expect(ElementColors.buttonColor.green, equals(153));
      expect(ElementColors.buttonColor.blue, equals(215));
      expect(ElementColors.buttonColor.opacity, equals(1.0));
    });

    test('should have correct background color values', () {
      const expectedColor = Color(0xFFEDE7F6);
      expect(ElementColors.backgroundColor, equals(expectedColor));
      
      // Test hex value
      expect(ElementColors.backgroundColor.value, equals(0xFFEDE7F6));
    });

    test('should have correct landing page background color', () {
      const expectedColor = Color.fromRGBO(64, 1, 106, 1);
      expect(ElementColors.backgroundColorForLandingPage, equals(expectedColor));
      
      expect(ElementColors.backgroundColorForLandingPage.red, equals(64));
      expect(ElementColors.backgroundColorForLandingPage.green, equals(1));
      expect(ElementColors.backgroundColorForLandingPage.blue, equals(106));
    });

    test('should have correct text colors', () {
      const expectedTextColor = Color.fromRGBO(116, 160, 255, 1);
      const expectedTextColor2 = Color.fromRGBO(255, 166, 254, 1);
      
      expect(ElementColors.textColor, equals(expectedTextColor));
      expect(ElementColors.textColor2, equals(expectedTextColor2));
    });

    test('should have correct hint text color', () {
      expect(ElementColors.hintTextColor, equals(Colors.black87));
    });

    test('should have correct border color', () {
      expect(ElementColors.borderColor, equals(Colors.black87));
    });

    test('should have correct border radius', () {
      expect(ElementColors.borderRadius, equals(15.0));
    });

    test('should have correct app bar color', () {
      const expectedColor = Color.fromRGBO(69, 21, 126, 1);
      expect(ElementColors.appBarColor, equals(expectedColor));
      
      expect(ElementColors.appBarColor.red, equals(69));
      expect(ElementColors.appBarColor.green, equals(21));
      expect(ElementColors.appBarColor.blue, equals(126));
    });

    test('should have correct reserved color', () {
      const expectedColor = Color.fromARGB(255, 169, 117, 247);
      expect(ElementColors.reservedColor, equals(expectedColor));
      
      expect(ElementColors.reservedColor.alpha, equals(255));
      expect(ElementColors.reservedColor.red, equals(169));
      expect(ElementColors.reservedColor.green, equals(117));
      expect(ElementColors.reservedColor.blue, equals(247));
    });

    test('should have different colors for different purposes', () {
      // Verify that different UI elements have distinct colors
      expect(ElementColors.buttonColor, isNot(equals(ElementColors.backgroundColor)));
      expect(ElementColors.textColor, isNot(equals(ElementColors.textColor2)));
      expect(ElementColors.appBarColor, isNot(equals(ElementColors.backgroundColor)));
    });

    test('should have consistent color formats', () {
      // All colors should be valid Color objects
      expect(ElementColors.buttonColor, isA<Color>());
      expect(ElementColors.backgroundColor, isA<Color>());
      expect(ElementColors.backgroundColorForLandingPage, isA<Color>());
      expect(ElementColors.textColor, isA<Color>());
      expect(ElementColors.textColor2, isA<Color>());
      expect(ElementColors.hintTextColor, isA<Color>());
      expect(ElementColors.borderColor, isA<Color>());
      expect(ElementColors.appBarColor, isA<Color>());
      expect(ElementColors.reservedColor, isA<Color>());
    });

    test('should have valid RGB values', () {
      // All RGB values should be in valid range (0-255)
      final colors = [
        ElementColors.buttonColor,
        ElementColors.backgroundColorForLandingPage,
        ElementColors.textColor,
        ElementColors.textColor2,
        ElementColors.appBarColor,
        ElementColors.reservedColor,
      ];

      for (final color in colors) {
        expect(color.red, greaterThanOrEqualTo(0));
        expect(color.red, lessThanOrEqualTo(255));
        expect(color.green, greaterThanOrEqualTo(0));
        expect(color.green, lessThanOrEqualTo(255));
        expect(color.blue, greaterThanOrEqualTo(0));
        expect(color.blue, lessThanOrEqualTo(255));
      }
    });

    test('should have valid opacity values', () {
      // All opacity values should be in valid range (0.0-1.0)
      final colors = [
        ElementColors.buttonColor,
        ElementColors.backgroundColorForLandingPage,
        ElementColors.textColor,
        ElementColors.textColor2,
        ElementColors.appBarColor,
        ElementColors.reservedColor,
      ];

      for (final color in colors) {
        expect(color.opacity, greaterThanOrEqualTo(0.0));
        expect(color.opacity, lessThanOrEqualTo(1.0));
      }
    });
  });
} 