import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:my_2048/screens/game_screen.dart';

final _theme = ThemeData.light().copyWith(
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color.fromARGB(255, 232, 226, 220),
  ),
);

void main() {
  runApp(const ProviderScope(child: MainApp()));
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ProviderScope(
      child: MaterialApp(
        theme: _theme.copyWith(
          cardTheme: const CardTheme().copyWith(
            color: const Color.fromARGB(255, 187, 172, 160),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(7),
            ),
          ),
          iconTheme: const IconThemeData().copyWith(
            color: _theme.colorScheme.onPrimary,
            size: 35,
          ),
          textTheme: GoogleFonts.robotoTextTheme().copyWith(
            labelLarge:
                GoogleFonts.robotoCondensedTextTheme().labelLarge!.copyWith(
                      color: const Color.fromARGB(255, 210, 202, 192),
                      fontSize: 24,
                    ),
            labelMedium:
                GoogleFonts.robotoCondensedTextTheme().labelMedium!.copyWith(
                      color: const Color.fromARGB(255, 210, 202, 192),
                      fontSize: 12,
                    ),
            bodyLarge: GoogleFonts.robotoTextTheme().bodyLarge!.copyWith(
                  color: _theme.colorScheme.onPrimary,
                  fontSize: 26,
                ),
            bodyMedium: GoogleFonts.robotoTextTheme().bodyMedium!.copyWith(
                  color: _theme.colorScheme.onPrimary,
                  fontSize: 18,
                ),
          ),
        ),
        home: const GameScreen(),
      ),
    );
  }
}
