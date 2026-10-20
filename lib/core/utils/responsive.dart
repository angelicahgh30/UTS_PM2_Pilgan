import 'package:flutter/widgets.dart';

enum DeviceType { mobile, tablet, desktop }

class Responsive {
  final Size size;

  const Responsive._(this.size);

  factory Responsive.of(BuildContext context) =>
      Responsive._(MediaQuery.sizeOf(context));

  static const double tabletBreakpoint = 600;
  static const double desktopBreakpoint = 1024;

  DeviceType get deviceType {
    if (size.width >= desktopBreakpoint) return DeviceType.desktop;
    if (size.width >= tabletBreakpoint) return DeviceType.tablet;
    return DeviceType.mobile;
  }

  bool get isMobile => deviceType == DeviceType.mobile;
  bool get isWide => !isMobile;
  bool get isDesktop => deviceType == DeviceType.desktop;

  double get scale => (size.shortestSide / 400).clamp(0.85, 1.25);

  double sp(double value) => value * scale;
  double wp(double percent) => size.width * percent / 100;
  double hp(double percent) => size.height * percent / 100;

  TextStyle text(TextStyle? base) => (base ?? const TextStyle()).copyWith(
    fontSize: (base?.fontSize ?? 14) * scale,
  );

  double get pagePadding => isMobile ? sp(20) : sp(32);
  double get maxContentWidth => isDesktop ? 1080 : (isMobile ? 560 : 860);
}

extension ResponsiveContext on BuildContext {
  Responsive get responsive => Responsive.of(this);
}
