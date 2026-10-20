import 'package:flutter/material.dart';

class AppColors {
  AppColors._();

  static const primary = Color(0xFF1C2E5E);
  static const navy = Color(0xFF142247);
  static const accent = Color(0xFFF5B400);
  static const success = Color(0xFF16A34A);
  static const danger = Color(0xFFE5484D);
  static const warning = Color(0xFFF59E0B);

  static const background = Color(0xFFF4F5F9);
  static const surface = Colors.white;
  static const text = Color(0xFF0F172A);
  static const muted = Color(0xFF64748B);
  static const border = Color(0xFFE2E8F0);

  static const darkBackground = Color(0xFF0A1020);
  static const darkSurface = Color(0xFF121A2E);
  static const darkText = Color(0xFFE6EAF2);
  static const darkMuted = Color(0xFF94A3B8);
  static const darkBorder = Color(0xFF26324A);
  static const darkPrimary = Color(0xFF8FA6EE);
}

@immutable
class AppPalette extends ThemeExtension<AppPalette> {
  final Color muted;
  final Color border;
  final Color primarySoft;
  final Color success;
  final Color successSoft;
  final Color danger;
  final Color dangerSoft;
  final Color warning;
  final Color accent;
  final Color accentSoft;

  const AppPalette({
    required this.muted,
    required this.border,
    required this.primarySoft,
    required this.success,
    required this.successSoft,
    required this.danger,
    required this.dangerSoft,
    required this.warning,
    required this.accent,
    required this.accentSoft,
  });

  static const light = AppPalette(
    muted: AppColors.muted,
    border: AppColors.border,
    primarySoft: Color(0xFFE6EAF4),
    success: AppColors.success,
    successSoft: Color(0xFFE7F6EC),
    danger: AppColors.danger,
    dangerSoft: Color(0xFFFDECEC),
    warning: AppColors.warning,
    accent: AppColors.accent,
    accentSoft: Color(0xFFFFF5D6),
  );

  static const dark = AppPalette(
    muted: AppColors.darkMuted,
    border: AppColors.darkBorder,
    primarySoft: Color(0xFF1B2547),
    success: Color(0xFF3FCB74),
    successSoft: Color(0xFF12301F),
    danger: Color(0xFFFF6B6F),
    dangerSoft: Color(0xFF3A1A1D),
    warning: Color(0xFFFBBF24),
    accent: Color(0xFFFFC14D),
    accentSoft: Color(0xFF3A2E14),
  );

  @override
  AppPalette copyWith({
    Color? muted,
    Color? border,
    Color? primarySoft,
    Color? success,
    Color? successSoft,
    Color? danger,
    Color? dangerSoft,
    Color? warning,
    Color? accent,
    Color? accentSoft,
  }) {
    return AppPalette(
      muted: muted ?? this.muted,
      border: border ?? this.border,
      primarySoft: primarySoft ?? this.primarySoft,
      success: success ?? this.success,
      successSoft: successSoft ?? this.successSoft,
      danger: danger ?? this.danger,
      dangerSoft: dangerSoft ?? this.dangerSoft,
      warning: warning ?? this.warning,
      accent: accent ?? this.accent,
      accentSoft: accentSoft ?? this.accentSoft,
    );
  }

  @override
  AppPalette lerp(AppPalette? other, double t) {
    if (other == null) return this;
    return AppPalette(
      muted: Color.lerp(muted, other.muted, t)!,
      border: Color.lerp(border, other.border, t)!,
      primarySoft: Color.lerp(primarySoft, other.primarySoft, t)!,
      success: Color.lerp(success, other.success, t)!,
      successSoft: Color.lerp(successSoft, other.successSoft, t)!,
      danger: Color.lerp(danger, other.danger, t)!,
      dangerSoft: Color.lerp(dangerSoft, other.dangerSoft, t)!,
      warning: Color.lerp(warning, other.warning, t)!,
      accent: Color.lerp(accent, other.accent, t)!,
      accentSoft: Color.lerp(accentSoft, other.accentSoft, t)!,
    );
  }
}

extension AppPaletteContext on BuildContext {
  AppPalette get palette => Theme.of(this).extension<AppPalette>()!;
  ColorScheme get colors => Theme.of(this).colorScheme;
  TextTheme get texts => Theme.of(this).textTheme;
}
