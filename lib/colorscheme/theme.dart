import "package:flutter/material.dart";

class MaterialTheme {
  final TextTheme textTheme;

  const MaterialTheme(this.textTheme);

  static ColorScheme lightScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff65558f),
      surfaceTint: Color(0xff65558f),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xffe9ddff),
      onPrimaryContainer: Color(0xff4d3d75),
      secondary: Color(0xff65558f),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xffe9ddff),
      onSecondaryContainer: Color(0xff4d3d75),
      tertiary: Color(0xff8b4a61),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xffffd9e3),
      onTertiaryContainer: Color(0xff6f3349),
      error: Color(0xff904a45),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffffdad7),
      onErrorContainer: Color(0xff73332f),
      surface: Color(0xfffdf7ff),
      onSurface: Color(0xff1c1b20),
      onSurfaceVariant: Color(0xff48454e),
      outline: Color(0xff79757f),
      outlineVariant: Color(0xffc9c4d0),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff322f35),
      inversePrimary: Color(0xffcfbdfe),
      primaryFixed: Color(0xffe9ddff),
      onPrimaryFixed: Color(0xff201047),
      primaryFixedDim: Color(0xffcfbdfe),
      onPrimaryFixedVariant: Color(0xff4d3d75),
      secondaryFixed: Color(0xffe9ddff),
      onSecondaryFixed: Color(0xff201047),
      secondaryFixedDim: Color(0xffcfbdfe),
      onSecondaryFixedVariant: Color(0xff4d3d75),
      tertiaryFixed: Color(0xffffd9e3),
      onTertiaryFixed: Color(0xff3a071e),
      tertiaryFixedDim: Color(0xffffb0c9),
      onTertiaryFixedVariant: Color(0xff6f3349),
      surfaceDim: Color(0xffded8e0),
      surfaceBright: Color(0xfffdf7ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff7f2fa),
      surfaceContainer: Color(0xfff2ecf4),
      surfaceContainerHigh: Color(0xffece6ee),
      surfaceContainerHighest: Color(0xffe6e1e9),
    );
  }

  ThemeData light() {
    return theme(lightScheme());
  }

  static ColorScheme lightMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff3c2d63),
      surfaceTint: Color(0xff65558f),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff74649f),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff3c2d63),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff74649f),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff5b2238),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff9c5870),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff5e2320),
      onError: Color(0xffffffff),
      errorContainer: Color(0xffa15853),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffdf7ff),
      onSurface: Color(0xff121016),
      onSurfaceVariant: Color(0xff37353e),
      outline: Color(0xff54515a),
      outlineVariant: Color(0xff6f6b75),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff322f35),
      inversePrimary: Color(0xffcfbdfe),
      primaryFixed: Color(0xff74649f),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff5b4c84),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff74649f),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff5b4c84),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff9c5870),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff804057),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffcac5cd),
      surfaceBright: Color(0xfffdf7ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff7f2fa),
      surfaceContainer: Color(0xffece6ee),
      surfaceContainerHigh: Color(0xffe0dbe3),
      surfaceContainerHighest: Color(0xffd5d0d8),
    );
  }

  ThemeData lightMediumContrast() {
    return theme(lightMediumContrastScheme());
  }

  static ColorScheme lightHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.light,
      primary: Color(0xff312259),
      surfaceTint: Color(0xff65558f),
      onPrimary: Color(0xffffffff),
      primaryContainer: Color(0xff4f4078),
      onPrimaryContainer: Color(0xffffffff),
      secondary: Color(0xff312259),
      onSecondary: Color(0xffffffff),
      secondaryContainer: Color(0xff4f4078),
      onSecondaryContainer: Color(0xffffffff),
      tertiary: Color(0xff4f182e),
      onTertiary: Color(0xffffffff),
      tertiaryContainer: Color(0xff72354c),
      onTertiaryContainer: Color(0xffffffff),
      error: Color(0xff511917),
      onError: Color(0xffffffff),
      errorContainer: Color(0xff763632),
      onErrorContainer: Color(0xffffffff),
      surface: Color(0xfffdf7ff),
      onSurface: Color(0xff000000),
      onSurfaceVariant: Color(0xff000000),
      outline: Color(0xff2d2b33),
      outlineVariant: Color(0xff4a4851),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xff322f35),
      inversePrimary: Color(0xffcfbdfe),
      primaryFixed: Color(0xff4f4078),
      onPrimaryFixed: Color(0xffffffff),
      primaryFixedDim: Color(0xff382960),
      onPrimaryFixedVariant: Color(0xffffffff),
      secondaryFixed: Color(0xff4f4078),
      onSecondaryFixed: Color(0xffffffff),
      secondaryFixedDim: Color(0xff382960),
      onSecondaryFixedVariant: Color(0xffffffff),
      tertiaryFixed: Color(0xff72354c),
      onTertiaryFixed: Color(0xffffffff),
      tertiaryFixedDim: Color(0xff571f35),
      onTertiaryFixedVariant: Color(0xffffffff),
      surfaceDim: Color(0xffbcb7bf),
      surfaceBright: Color(0xfffdf7ff),
      surfaceContainerLowest: Color(0xffffffff),
      surfaceContainerLow: Color(0xfff5eff7),
      surfaceContainer: Color(0xffe6e1e9),
      surfaceContainerHigh: Color(0xffd8d3da),
      surfaceContainerHighest: Color(0xffcac5cd),
    );
  }

  ThemeData lightHighContrast() {
    return theme(lightHighContrastScheme());
  }

  static ColorScheme darkScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffcfbdfe),
      surfaceTint: Color(0xffcfbdfe),
      onPrimary: Color(0xff36275d),
      primaryContainer: Color(0xff4d3d75),
      onPrimaryContainer: Color(0xffe9ddff),
      secondary: Color(0xffcfbdfe),
      onSecondary: Color(0xff36275d),
      secondaryContainer: Color(0xff4d3d75),
      onSecondaryContainer: Color(0xffe9ddff),
      tertiary: Color(0xffffb0c9),
      onTertiary: Color(0xff541d33),
      tertiaryContainer: Color(0xff6f3349),
      onTertiaryContainer: Color(0xffffd9e3),
      error: Color(0xffffb3ad),
      onError: Color(0xff571e1b),
      errorContainer: Color(0xff73332f),
      onErrorContainer: Color(0xffffdad7),
      surface: Color(0xff141318),
      onSurface: Color(0xffe6e1e9),
      onSurfaceVariant: Color(0xffc9c4d0),
      outline: Color(0xff938f99),
      outlineVariant: Color(0xff48454e),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe6e1e9),
      inversePrimary: Color(0xff65558f),
      primaryFixed: Color(0xffe9ddff),
      onPrimaryFixed: Color(0xff201047),
      primaryFixedDim: Color(0xffcfbdfe),
      onPrimaryFixedVariant: Color(0xff4d3d75),
      secondaryFixed: Color(0xffe9ddff),
      onSecondaryFixed: Color(0xff201047),
      secondaryFixedDim: Color(0xffcfbdfe),
      onSecondaryFixedVariant: Color(0xff4d3d75),
      tertiaryFixed: Color(0xffffd9e3),
      onTertiaryFixed: Color(0xff3a071e),
      tertiaryFixedDim: Color(0xffffb0c9),
      onTertiaryFixedVariant: Color(0xff6f3349),
      surfaceDim: Color(0xff141318),
      surfaceBright: Color(0xff3a383e),
      surfaceContainerLowest: Color(0xff0f0d13),
      surfaceContainerLow: Color(0xff1c1b20),
      surfaceContainer: Color(0xff211f24),
      surfaceContainerHigh: Color(0xff2b292f),
      surfaceContainerHighest: Color(0xff36343a),
    );
  }

  ThemeData dark() {
    return theme(darkScheme());
  }

  static ColorScheme darkMediumContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xffe3d6ff),
      surfaceTint: Color(0xffcfbdfe),
      onPrimary: Color(0xff2b1b52),
      primaryContainer: Color(0xff9887c5),
      onPrimaryContainer: Color(0xff000000),
      secondary: Color(0xffe3d6ff),
      onSecondary: Color(0xff2b1b52),
      secondaryContainer: Color(0xff9887c5),
      onSecondaryContainer: Color(0xff000000),
      tertiary: Color(0xffffd0dd),
      onTertiary: Color(0xff471228),
      tertiaryContainer: Color(0xffc57b93),
      onTertiaryContainer: Color(0xff000000),
      error: Color(0xffffd2ce),
      onError: Color(0xff481311),
      errorContainer: Color(0xffcc7b74),
      onErrorContainer: Color(0xff000000),
      surface: Color(0xff141318),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffe0dae5),
      outline: Color(0xffb5b0bb),
      outlineVariant: Color(0xff938f99),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe6e1e9),
      inversePrimary: Color(0xff4e3f77),
      primaryFixed: Color(0xffe9ddff),
      onPrimaryFixed: Color(0xff16033d),
      primaryFixedDim: Color(0xffcfbdfe),
      onPrimaryFixedVariant: Color(0xff3c2d63),
      secondaryFixed: Color(0xffe9ddff),
      onSecondaryFixed: Color(0xff16033d),
      secondaryFixedDim: Color(0xffcfbdfe),
      onSecondaryFixedVariant: Color(0xff3c2d63),
      tertiaryFixed: Color(0xffffd9e3),
      onTertiaryFixed: Color(0xff2b0013),
      tertiaryFixedDim: Color(0xffffb0c9),
      onTertiaryFixedVariant: Color(0xff5b2238),
      surfaceDim: Color(0xff141318),
      surfaceBright: Color(0xff46434a),
      surfaceContainerLowest: Color(0xff08070b),
      surfaceContainerLow: Color(0xff1e1d22),
      surfaceContainer: Color(0xff29272d),
      surfaceContainerHigh: Color(0xff343238),
      surfaceContainerHighest: Color(0xff3f3d43),
    );
  }

  ThemeData darkMediumContrast() {
    return theme(darkMediumContrastScheme());
  }

  static ColorScheme darkHighContrastScheme() {
    return const ColorScheme(
      brightness: Brightness.dark,
      primary: Color(0xfff5edff),
      surfaceTint: Color(0xffcfbdfe),
      onPrimary: Color(0xff000000),
      primaryContainer: Color(0xffcbb9fa),
      onPrimaryContainer: Color(0xff0f0033),
      secondary: Color(0xfff5edff),
      onSecondary: Color(0xff000000),
      secondaryContainer: Color(0xffcbb9fa),
      onSecondaryContainer: Color(0xff0f0033),
      tertiary: Color(0xffffebef),
      onTertiary: Color(0xff000000),
      tertiaryContainer: Color(0xfffeabc5),
      onTertiaryContainer: Color(0xff20000d),
      error: Color(0xffffecea),
      onError: Color(0xff000000),
      errorContainer: Color(0xffffaea7),
      onErrorContainer: Color(0xff220001),
      surface: Color(0xff141318),
      onSurface: Color(0xffffffff),
      onSurfaceVariant: Color(0xffffffff),
      outline: Color(0xfff4eef9),
      outlineVariant: Color(0xffc6c1cc),
      shadow: Color(0xff000000),
      scrim: Color(0xff000000),
      inverseSurface: Color(0xffe6e1e9),
      inversePrimary: Color(0xff4e3f77),
      primaryFixed: Color(0xffe9ddff),
      onPrimaryFixed: Color(0xff000000),
      primaryFixedDim: Color(0xffcfbdfe),
      onPrimaryFixedVariant: Color(0xff16033d),
      secondaryFixed: Color(0xffe9ddff),
      onSecondaryFixed: Color(0xff000000),
      secondaryFixedDim: Color(0xffcfbdfe),
      onSecondaryFixedVariant: Color(0xff16033d),
      tertiaryFixed: Color(0xffffd9e3),
      onTertiaryFixed: Color(0xff000000),
      tertiaryFixedDim: Color(0xffffb0c9),
      onTertiaryFixedVariant: Color(0xff2b0013),
      surfaceDim: Color(0xff141318),
      surfaceBright: Color(0xff524f55),
      surfaceContainerLowest: Color(0xff000000),
      surfaceContainerLow: Color(0xff211f24),
      surfaceContainer: Color(0xff322f35),
      surfaceContainerHigh: Color(0xff3d3a41),
      surfaceContainerHighest: Color(0xff48464c),
    );
  }

  ThemeData darkHighContrast() {
    return theme(darkHighContrastScheme());
  }


  ThemeData theme(ColorScheme colorScheme) => ThemeData(
     useMaterial3: true,
     brightness: colorScheme.brightness,
     colorScheme: colorScheme,
     textTheme: textTheme.apply(
       bodyColor: colorScheme.onSurface,
       displayColor: colorScheme.onSurface,
     ),
     scaffoldBackgroundColor: colorScheme.surface,
     canvasColor: colorScheme.surface,
  );


  List<ExtendedColor> get extendedColors => [
  ];
}

class ExtendedColor {
  final Color seed, value;
  final ColorFamily light;
  final ColorFamily lightHighContrast;
  final ColorFamily lightMediumContrast;
  final ColorFamily dark;
  final ColorFamily darkHighContrast;
  final ColorFamily darkMediumContrast;

  const ExtendedColor({
    required this.seed,
    required this.value,
    required this.light,
    required this.lightHighContrast,
    required this.lightMediumContrast,
    required this.dark,
    required this.darkHighContrast,
    required this.darkMediumContrast,
  });
}

class ColorFamily {
  const ColorFamily({
    required this.color,
    required this.onColor,
    required this.colorContainer,
    required this.onColorContainer,
  });

  final Color color;
  final Color onColor;
  final Color colorContainer;
  final Color onColorContainer;
}
