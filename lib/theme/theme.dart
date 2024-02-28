import 'package:flutter/material.dart';

const lightColorScheme = ColorScheme(
    brightness: Brightness.light,
    primary: Color(0xFF416FDF),
    onPrimary: Color(0xFFFFFFFF),
    secondary: Color(0xFF6EAEE7),
    onSecondary: Color(0xFFFFFFFF),
    error: Color(0xFFBA1A1A),
    onError: Color(0xFFFFFFFF),
    background: Color(0xFFFCFDF6),
    onBackground: Color(0xFF1A1C18),
    shadow: Color(0xFF000000),
    outlineVariant: Color(0xFFC2C8BC),
    surface: Color(0xFFF9FAF3),
    onSurface: Color(0xFF1A1C18)
);


const darkThemeScheme = ColorScheme(
    brightness: Brightness.dark,
    primary: Color(0xFF416FDF),
    onPrimary: Color(0xFFFFFFFF),
    secondary: Color(0xFF6EAEE7),
    onSecondary: Color(0xFFFFFFFF),
    error: Color(0xFFBA1A1A),
    onError: Color(0xFFFFFFFF),
    background: Color(0xFFFCFDF6),
    onBackground: Color(0xFF1A1C18),
    shadow: Color(0xFF000000),
    outlineVariant: Color(0xFFC2C8BC),
    surface: Color(0xFFF9FAF3),
    onSurface: Color(0xFF1A1C18)
);

ThemeData lightMode = ThemeData(
  useMaterial3: true,
  brightness: Brightness.light,
  colorScheme: lightColorScheme,
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ButtonStyle(
      backgroundColor: MaterialStateProperty.all(Colors.lightBlueAccent),
      foregroundColor: MaterialStateProperty.all(Colors.lightBlueAccent),
      elevation: MaterialStateProperty.all(5.0),
      padding: MaterialStateProperty.all(
        const EdgeInsets.symmetric(horizontal: 20,vertical: 18)
      ),
      shape: MaterialStateProperty.all(
        RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16.0)
        )
      )
    )
  )
);

ThemeData darkMode = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorScheme: darkThemeScheme,
    elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
            backgroundColor: MaterialStateProperty.all(Colors.blueAccent),
            foregroundColor: MaterialStateProperty.all(Colors.blueAccent),
            elevation: MaterialStateProperty.all(5.0),
            padding: MaterialStateProperty.all(
                const EdgeInsets.symmetric(horizontal: 20,vertical: 18)
            ),
            shape: MaterialStateProperty.all(
                RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16.0)
                )
            )
        )
    )
);