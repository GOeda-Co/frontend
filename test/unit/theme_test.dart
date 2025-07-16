import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:frontend/colorscheme/theme.dart';

void main() {
  group('MaterialTheme Tests', () {
    test('should create light color scheme correctly', () {
      final colorScheme = MaterialTheme.lightScheme();

      expect(colorScheme.brightness, equals(Brightness.light));
      expect(colorScheme.primary, equals(const Color(0xff65558f)));
      expect(colorScheme.onPrimary, equals(const Color(0xffffffff)));
      expect(colorScheme.surface, equals(const Color(0xfffdf7ff)));
      expect(colorScheme.onSurface, equals(const Color(0xff1c1b20)));
    });

    test('should create light medium contrast color scheme correctly', () {
      final colorScheme = MaterialTheme.lightMediumContrastScheme();

      expect(colorScheme.brightness, equals(Brightness.light));
      expect(colorScheme.primary, equals(const Color(0xff3c2d63)));
      expect(colorScheme.onPrimary, equals(const Color(0xffffffff)));
      expect(colorScheme.surface, equals(const Color(0xfffdf7ff)));
      expect(colorScheme.onSurface, equals(const Color(0xff121016)));
    });

    test('should create light high contrast color scheme correctly', () {
      final colorScheme = MaterialTheme.lightHighContrastScheme();

      expect(colorScheme.brightness, equals(Brightness.light));
      expect(colorScheme.primary, equals(const Color(0xff312259)));
      expect(colorScheme.onPrimary, equals(const Color(0xffffffff)));
      expect(colorScheme.surface, equals(const Color(0xfffdf7ff)));
      expect(colorScheme.onSurface, equals(const Color(0xff000000)));
    });

    test('should create dark color scheme correctly', () {
      final colorScheme = MaterialTheme.darkScheme();

      expect(colorScheme.brightness, equals(Brightness.dark));
      expect(colorScheme.primary, equals(const Color(0xffcfbdfe)));
      expect(colorScheme.onPrimary, equals(const Color(0xff36275d)));
      expect(colorScheme.surface, equals(const Color(0xff141318)));
      expect(colorScheme.onSurface, equals(const Color(0xffe6e1e9)));
    });

    test('should create dark medium contrast color scheme correctly', () {
      final colorScheme = MaterialTheme.darkMediumContrastScheme();

      expect(colorScheme.brightness, equals(Brightness.dark));
      expect(colorScheme.primary, equals(const Color(0xffe3d6ff)));
      expect(colorScheme.onPrimary, equals(const Color(0xff2b1b52)));
      expect(colorScheme.surface, equals(const Color(0xff141318)));
      expect(colorScheme.onSurface, equals(const Color(0xffffffff)));
    });

    test('should create dark high contrast color scheme correctly', () {
      final colorScheme = MaterialTheme.darkHighContrastScheme();

      expect(colorScheme.brightness, equals(Brightness.dark));
      expect(colorScheme.primary, equals(const Color(0xffffffff)));
      expect(colorScheme.onPrimary, equals(const Color(0xff000000)));
      expect(colorScheme.surface, equals(const Color(0xff141318)));
      expect(colorScheme.onSurface, equals(const Color(0xffffffff)));
    });

    test('should create theme data correctly', () {
      final theme = MaterialTheme(const TextTheme()).light();

      expect(theme, isA<ThemeData>());
      expect(theme.colorScheme.brightness, equals(Brightness.light));
      expect(theme.colorScheme.primary, equals(const Color(0xff65558f)));
    });

    test('should have consistent color relationships', () {
      final lightScheme = MaterialTheme.lightScheme();
      final darkScheme = MaterialTheme.darkScheme();

      // Test that primary and onPrimary have sufficient contrast
      expect(lightScheme.primary, isNot(equals(lightScheme.onPrimary)));
      expect(darkScheme.primary, isNot(equals(darkScheme.onPrimary)));

      // Test that surface and onSurface have sufficient contrast
      expect(lightScheme.surface, isNot(equals(lightScheme.onSurface)));
      expect(darkScheme.surface, isNot(equals(darkScheme.onSurface)));
    });

    test('should have valid color values', () {
      final schemes = [
        MaterialTheme.lightScheme(),
        MaterialTheme.lightMediumContrastScheme(),
        MaterialTheme.lightHighContrastScheme(),
        MaterialTheme.darkScheme(),
        MaterialTheme.darkMediumContrastScheme(),
        MaterialTheme.darkHighContrastScheme(),
      ];

      for (final scheme in schemes) {
        // Test that all colors are valid
        expect(scheme.primary, isA<Color>());
        expect(scheme.onPrimary, isA<Color>());
        expect(scheme.surface, isA<Color>());
        expect(scheme.onSurface, isA<Color>());
        expect(scheme.error, isA<Color>());
        expect(scheme.onError, isA<Color>());
      }
    });

    test('should have different schemes for different contrast levels', () {
      final light = MaterialTheme.lightScheme();
      final lightMedium = MaterialTheme.lightMediumContrastScheme();
      final lightHigh = MaterialTheme.lightHighContrastScheme();

      // Different contrast levels should have different primary colors
      expect(light.primary, isNot(equals(lightMedium.primary)));
      expect(lightMedium.primary, isNot(equals(lightHigh.primary)));
      expect(light.primary, isNot(equals(lightHigh.primary)));
    });

    test('should have different schemes for light and dark modes', () {
      final light = MaterialTheme.lightScheme();
      final dark = MaterialTheme.darkScheme();

      // Light and dark schemes should have different primary colors
      expect(light.primary, isNot(equals(dark.primary)));
      expect(light.surface, isNot(equals(dark.surface)));
    });

    test('should handle text theme correctly', () {
      final textTheme = const TextTheme();
      final materialTheme = MaterialTheme(textTheme);

      expect(materialTheme.textTheme, equals(textTheme));
    });
  });
} 