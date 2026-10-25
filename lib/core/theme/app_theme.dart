import 'package:flutter/material.dart';

import '../invoicing/enums.dart';

class InvoxaColors {
  static const navy = Color(0xFF1B2A4A);
  static const navySoft = Color(0xFF243B67);
  static const emerald = Color(0xFF0E8F62);
  static const emeraldBright = Color(0xFF3DDC97);
  static const amber = Color(0xFF8A5A00);
  static const overdue = Color(0xFF9C2F2F);
  static const canvas = Color(0xFFF7F5F2);
  static const ink = Color(0xFF1A1D23);
  static const muted = Color(0xFF5C6570);
  static const line = Color(0xFFE4DFD8);
  static const darkCanvas = Color(0xFF10151C);
  static const darkCard = Color(0xFF1C2433);
  static const darkInk = Color(0xFFF4F1EC);
  static const darkMuted = Color(0xFFB7C0CE);
}

ThemeData invoxaTheme(Brightness brightness) {
  final dark = brightness == Brightness.dark;
  final scheme = ColorScheme(
    brightness: brightness,
    primary: dark ? const Color(0xFFD5DFF5) : InvoxaColors.navy,
    onPrimary: dark ? InvoxaColors.darkCanvas : Colors.white,
    secondary: dark ? InvoxaColors.emeraldBright : InvoxaColors.emerald,
    onSecondary: dark ? InvoxaColors.darkCanvas : Colors.white,
    error: InvoxaColors.overdue,
    onError: Colors.white,
    surface: dark ? InvoxaColors.darkCard : Colors.white,
    onSurface: dark ? InvoxaColors.darkInk : InvoxaColors.ink,
  );
  final base = ThemeData(
    useMaterial3: true,
    brightness: brightness,
    colorScheme: scheme,
    scaffoldBackgroundColor: dark ? InvoxaColors.darkCanvas : InvoxaColors.canvas,
    fontFamily: 'Inter',
    fontFamilyFallback: const ['Noto Sans'],
  );
  return base.copyWith(
    textTheme: base.textTheme.apply(
      bodyColor: scheme.onSurface,
      displayColor: scheme.onSurface,
      fontFamily: 'Inter',
      fontFamilyFallback: const ['Noto Sans'],
    ),
    appBarTheme: AppBarTheme(
      backgroundColor: dark ? InvoxaColors.darkCanvas : InvoxaColors.canvas,
      foregroundColor: scheme.onSurface,
      elevation: 0,
      centerTitle: false,
      titleTextStyle: TextStyle(
        fontFamily: 'Inter',
        fontFamilyFallback: const ['Noto Sans'],
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: scheme.onSurface,
      ),
    ),
    cardTheme: CardThemeData(
      color: scheme.surface,
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      margin: EdgeInsets.zero,
    ),
    inputDecorationTheme: InputDecorationTheme(
      filled: true,
      fillColor: dark ? const Color(0xFF151B26) : Colors.white,
      contentPadding: const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: dark ? const Color(0xFF2A3344) : InvoxaColors.line),
      ),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: dark ? const Color(0xFF2A3344) : InvoxaColors.line),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(16),
        borderSide: BorderSide(color: scheme.primary, width: 1.6),
      ),
      labelStyle: TextStyle(color: dark ? InvoxaColors.darkMuted : InvoxaColors.muted),
    ),
    filledButtonTheme: FilledButtonThemeData(
      style: FilledButton.styleFrom(
        minimumSize: const Size.fromHeight(52),
        backgroundColor: dark ? InvoxaColors.navySoft : InvoxaColors.navy,
        foregroundColor: Colors.white,
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        minimumSize: const Size.fromHeight(52),
        foregroundColor: scheme.onSurface,
        textStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
        side: BorderSide(color: dark ? const Color(0xFF2A3344) : InvoxaColors.line),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
      backgroundColor: dark ? InvoxaColors.darkCard : Colors.white,
      indicatorColor: dark ? const Color(0xFF2A3650) : const Color(0xFFE7EDF8),
      labelTextStyle: WidgetStateProperty.all(const TextStyle(fontSize: 12, fontWeight: FontWeight.w600)),
      height: 72,
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: dark ? InvoxaColors.emeraldBright : InvoxaColors.emerald,
      foregroundColor: dark ? InvoxaColors.darkCanvas : Colors.white,
      extendedTextStyle: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
    ),
    dividerColor: dark ? const Color(0xFF2A3344) : InvoxaColors.line,
    snackBarTheme: SnackBarThemeData(
      behavior: SnackBarBehavior.floating,
      backgroundColor: dark ? const Color(0xFF2A3344) : InvoxaColors.navy,
      contentTextStyle: const TextStyle(color: Colors.white),
    ),
  );
}

ThemeMode themeModeOf(ThemeChoice choice) => switch (choice) {
  ThemeChoice.light => ThemeMode.light,
  ThemeChoice.dark => ThemeMode.dark,
  ThemeChoice.system => ThemeMode.system,
};

Color statusColor(InvoiceStatus status, Brightness brightness) => switch (status) {
  InvoiceStatus.paid => brightness == Brightness.dark ? InvoxaColors.emeraldBright : InvoxaColors.emerald,
  InvoiceStatus.partial => InvoxaColors.amber,
  InvoiceStatus.overdue => InvoxaColors.overdue,
  InvoiceStatus.draft => brightness == Brightness.dark ? InvoxaColors.darkMuted : InvoxaColors.muted,
  InvoiceStatus.cancelled => brightness == Brightness.dark ? InvoxaColors.darkMuted : InvoxaColors.muted,
  InvoiceStatus.unpaid => brightness == Brightness.dark ? const Color(0xFFD5DFF5) : InvoxaColors.navy,
};
