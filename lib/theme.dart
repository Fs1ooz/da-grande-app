import 'package:flutter/material.dart';

/// Palette ispirata al manuale "Da Grande": blu profondo, ciano energico,
/// accenti caldi (giallo/ambra) come la copertina.
class AppColors {
  static const Color ink = Color(0xFF0E1B3A); // blu notte
  static const Color deep = Color(0xFF152C5B);
  static const Color primary = Color(0xFF2E5BFF); // blu vivo
  static const Color cyan = Color(0xFF22C7E6); // ciano del logo
  static const Color amber = Color(0xFFFFC53D); // giallo copertina
  static const Color coral = Color(0xFFFF6B6B);
  static const Color mint = Color(0xFF34D399);
  static const Color surface = Color(0xFFF5F7FB);
  static const Color card = Colors.white;
  static const Color muted = Color(0xFF6B7591);

  /// Un colore per ciascuna tappa, per dare identita alla mappa del viaggio.
  static const List<Color> stageColors = [
    Color(0xFF2E5BFF), // ruota
    Color(0xFF7C5CFC), // ricordata
    Color(0xFF22C7E6), // riflessa
    Color(0xFFFFB020), // potenziale
    Color(0xFFFF8A3D), // programmata
    Color(0xFF34D399), // valori
    Color(0xFFFF6B6B), // miracolo
    Color(0xFF2E5BFF), // creata
  ];
}

ThemeData buildTheme() {
  final base = ThemeData(
    useMaterial3: true,
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.primary,
      primary: AppColors.primary,
      surface: AppColors.surface,
    ),
    scaffoldBackgroundColor: AppColors.surface,
  );

  return base.copyWith(
    textTheme: base.textTheme.apply(
      bodyColor: AppColors.ink,
      displayColor: AppColors.ink,
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      foregroundColor: AppColors.ink,
      centerTitle: false,
    ),
    cardTheme: CardThemeData(
      color: AppColors.card,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: EdgeInsets.zero,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: Colors.white,
      contentPadding:
          const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFFE1E6F0)),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: Color(0xFFE1E6F0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(14),
        borderSide: const BorderSide(color: AppColors.primary, width: 2),
      ),
      hintStyle: const TextStyle(color: AppColors.muted),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        backgroundColor: AppColors.primary,
        foregroundColor: Colors.white,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16)),
        textStyle:
            const TextStyle(fontSize: 16, fontWeight: FontWeight.w700),
      ),
    ),
  );
}
