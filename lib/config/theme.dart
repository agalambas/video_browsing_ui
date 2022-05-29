import 'package:flutter/material.dart';

final theme = ThemeData(
  colorScheme: Palette.colorScheme,
  chipTheme: ChipThemeData(
    backgroundColor: Palette.grey,
    selectedColor: Palette.colorScheme.primary,
    labelStyle:
        _textTheme.labelSmall!.copyWith(color: Palette.colorScheme.onPrimary),
  ),
  appBarTheme: AppBarTheme(
    color: Colors.transparent,
    elevation: 0,
    foregroundColor: Palette.colorScheme.onSurface,
  ),
  dividerTheme: const DividerThemeData(
    color: Palette.lightGrey,
    thickness: 0.5,
    space: 0.5,
  ),
  textTheme: _textTheme,
);

TextTheme get _textTheme => const TextTheme(
      titleLarge: TextStyle(color: Palette.textColor),
      titleMedium: TextStyle(color: Palette.textColor),
      titleSmall: TextStyle(color: Palette.textColor),
      labelLarge: TextStyle(color: Palette.grey),
      labelMedium: TextStyle(color: Colors.white),
      labelSmall: TextStyle(color: Palette.grey),
      bodyLarge: TextStyle(color: Palette.textColor),
      bodyMedium: TextStyle(color: Palette.textColor),
      bodySmall: TextStyle(color: Palette.grey),
    );

InputDecoration customInputDecoration({
  String? label,
  required String hint,
}) =>
    InputDecoration(
      label: label == null
          ? null
          : Text(
              label,
              style: const TextStyle(color: Palette.grey),
            ),
      hintText: hint,
      hintStyle: const TextStyle(color: Palette.lightGrey),
      floatingLabelBehavior: FloatingLabelBehavior.always,
      enabledBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Palette.lightGrey),
      ),
      focusedBorder: const UnderlineInputBorder(
        borderSide: BorderSide(color: Palette.grey),
      ),
    );

abstract class Palette {
  static const textColor = Color(0xFF29394D);
  static const grey = Color(0xFF8497AD);
  static const lightGrey = Color(0xFFD2DCE8);

  static const colorScheme = ColorScheme.light(
    primary: Color(0xFF4499FF),
    secondary: Color(0xFFFFAE6C),
    onSecondary: Colors.white,
    onBackground: textColor,
    onSurface: textColor,
  );
}
