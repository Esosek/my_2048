import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_fonts/google_fonts.dart';

import 'package:my_2048/screens/game_screen.dart';

final _theme = ThemeData.light().copyWith(
  iconTheme: const IconThemeData().copyWith(
    color: Colors.white,
    size: 35,
  ),
  textTheme: GoogleFonts.robotoTextTheme().copyWith(
    bodyMedium: GoogleFonts.robotoTextTheme().bodyMedium!.copyWith(
          color: Colors.white,
        ),
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
        theme: _theme,
        home: const GameScreen(),
      ),
    );
  }
}
