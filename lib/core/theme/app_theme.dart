import 'package:flutter/material.dart';

import 'app_colors.dart';

class AppTheme {
  AppTheme._();

  static const fontFamily = 'PlusJakartaSans';

  static ThemeData get light => _build(
    brightness: Brightness.light,
    palette: AppPalette.light,
    primary: AppColors.primary,
    background: AppColors.background,
    surface: AppColors.surface,
    text: AppColors.text,
  );

  static ThemeData get dark => _build(
    brightness: Brightness.dark,
    palette: AppPalette.dark,
    primary: AppColors.darkPrimary,
    background: AppColors.darkBackground,
    surface: AppColors.darkSurface,
    text: AppColors.darkText,
  );

  static ThemeData _build({
    required Brightness brightness,
    required AppPalette palette,
    required Color primary,
    required Color background,
    required Color surface,
    required Color text,
  }) {
    final scheme = ColorScheme(
      brightness: brightness,
      primary: primary,
      onPrimary: brightness == Brightness.light ? Colors.white : AppColors.navy,
      primaryContainer: palette.primarySoft,
      onPrimaryContainer: primary,
      secondary: palette.accent,
      onSecondary: AppColors.text,
      error: palette.danger,
      onError: Colors.white,
      surface: surface,
      onSurface: text,
      onSurfaceVariant: palette.muted,
      outline: palette.border,
      outlineVariant: palette.border,
    );

    final textTheme = TextTheme(
      headlineLarge: TextStyle(
        fontSize: 30,
        fontWeight: FontWeight.w800,
        height: 1.2,
      ),
      headlineMedium: TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.w800,
        height: 1.25,
      ),
      headlineSmall: TextStyle(
        fontSize: 20,
        fontWeight: FontWeight.w700,
        height: 1.3,
      ),
      titleLarge: TextStyle(fontSize: 18, fontWeight: FontWeight.w700),
      titleMedium: TextStyle(
        fontSize: 16,
        fontWeight: FontWeight.w700,
        height: 1.4,
      ),
      titleSmall: TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
      bodyLarge: TextStyle(fontSize: 16, height: 1.5),
      bodyMedium: TextStyle(fontSize: 14, height: 1.5),
      bodySmall: TextStyle(fontSize: 12, height: 1.4),
      labelLarge: TextStyle(fontSize: 15, fontWeight: FontWeight.w700),
      labelMedium: TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
      labelSmall: TextStyle(
        fontSize: 11,
        fontWeight: FontWeight.w600,
        letterSpacing: 0.3,
      ),
    ).apply(fontFamily: fontFamily, bodyColor: text, displayColor: text);

    final radius = BorderRadius.circular(12);

    return ThemeData(
      useMaterial3: true,
      brightness: brightness,
      colorScheme: scheme,
      fontFamily: fontFamily,
      textTheme: textTheme,
      scaffoldBackgroundColor: background,
      extensions: [palette],
      appBarTheme: AppBarTheme(
        backgroundColor: background,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        scrolledUnderElevation: 0,
        centerTitle: false,
        foregroundColor: text,
        titleTextStyle: textTheme.titleLarge,
      ),
      cardTheme: CardThemeData(
        color: surface,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        margin: EdgeInsets.zero,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(color: palette.border),
        ),
      ),
      filledButtonTheme: FilledButtonThemeData(
        style: FilledButton.styleFrom(
          backgroundColor: primary,
          foregroundColor: scheme.onPrimary,
          disabledBackgroundColor: palette.border,
          shape: RoundedRectangleBorder(borderRadius: radius),
          textStyle: textTheme.labelLarge,
        ),
      ),
      outlinedButtonTheme: OutlinedButtonThemeData(
        style: OutlinedButton.styleFrom(
          foregroundColor: primary,
          side: BorderSide(color: primary, width: 1.5),
          shape: RoundedRectangleBorder(borderRadius: radius),
          textStyle: textTheme.labelLarge,
        ),
      ),
      textButtonTheme: TextButtonThemeData(
        style: TextButton.styleFrom(
          foregroundColor: primary,
          textStyle: textTheme.labelLarge,
        ),
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        fillColor: brightness == Brightness.light
            ? const Color(0xFFF8FAFC)
            : const Color(0xFF0F1828),
        hintStyle: TextStyle(color: palette.muted),
        prefixIconColor: palette.muted,
        suffixIconColor: palette.muted,
        border: OutlineInputBorder(
          borderRadius: radius,
          borderSide: BorderSide(color: palette.border),
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: radius,
          borderSide: BorderSide(color: palette.border),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: radius,
          borderSide: BorderSide(color: primary, width: 1.8),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: radius,
          borderSide: BorderSide(color: palette.danger),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderRadius: radius,
          borderSide: BorderSide(color: palette.danger, width: 1.8),
        ),
      ),
      navigationBarTheme: NavigationBarThemeData(
        backgroundColor: surface,
        surfaceTintColor: Colors.transparent,
        indicatorColor: palette.primarySoft,
        elevation: 0,
        labelTextStyle: WidgetStateProperty.resolveWith(
          (states) => textTheme.labelMedium!.copyWith(
            color: states.contains(WidgetState.selected)
                ? primary
                : palette.muted,
          ),
        ),
        iconTheme: WidgetStateProperty.resolveWith(
          (states) => IconThemeData(
            color: states.contains(WidgetState.selected)
                ? primary
                : palette.muted,
          ),
        ),
      ),
      navigationRailTheme: NavigationRailThemeData(
        backgroundColor: surface,
        indicatorColor: palette.primarySoft,
        selectedIconTheme: IconThemeData(color: primary),
        unselectedIconTheme: IconThemeData(color: palette.muted),
        selectedLabelTextStyle: textTheme.labelMedium!.copyWith(color: primary),
        unselectedLabelTextStyle: textTheme.labelMedium!.copyWith(
          color: palette.muted,
        ),
      ),
      dialogTheme: DialogThemeData(
        backgroundColor: surface,
        surfaceTintColor: Colors.transparent,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        titleTextStyle: textTheme.headlineSmall,
        contentTextStyle: textTheme.bodyMedium!.copyWith(color: palette.muted),
      ),
      snackBarTheme: SnackBarThemeData(
        behavior: SnackBarBehavior.floating,
        backgroundColor: text,
        contentTextStyle: textTheme.bodyMedium!.copyWith(color: background),
        shape: RoundedRectangleBorder(borderRadius: radius),
      ),
      dividerTheme: DividerThemeData(color: palette.border, thickness: 1),
      progressIndicatorTheme: ProgressIndicatorThemeData(
        color: primary,
        linearTrackColor: palette.primarySoft,
      ),
    );
  }
}
