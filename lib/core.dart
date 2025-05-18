import 'package:flutter/material.dart';

const kPrimaryColor = Color(0xFF4F46E5);
const kAccentColor  = Color(0xFF818CF8);
const kBgColor      = Colors.black;
const kTextColor    = Colors.white;

final orbiterTheme = ThemeData(
  primaryColor: kPrimaryColor,
  scaffoldBackgroundColor: kBgColor,
  colorScheme: ColorScheme.dark(primary: kPrimaryColor, secondary: kAccentColor),
  textTheme: const TextTheme(
    headlineMedium: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: kTextColor),
    bodyMedium    : TextStyle(fontSize: 16, color: kTextColor),
  ),
);

TextStyle get headingStyle => const TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: kTextColor);
TextStyle get bodyStyle    => const TextStyle(fontSize: 16, color: kTextColor);
