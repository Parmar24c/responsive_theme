//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//               CREATED BY NAYAN PARMAR  
//                      © 2025  
//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

import 'dart:ui' as ui;

import 'package:flutter/widgets.dart';
import 'package:responsive_theme/responsive_theme.dart';

class ColorConfig {
  final ThemeColor lightColors;
  final ThemeColor darkColors;

  const ColorConfig({required this.lightColors, required this.darkColors});
}

enum AppThemeMode {
  light,
  dark,
}

/// Updates automatically the [AppTheme] regarding the current [MediaQuery],
/// as soon as the Theme isn't overriden.
class AppResponsiveTheme extends StatelessWidget {
  const AppResponsiveTheme({
    required this.child,
    required this.config,
    super.key,
    this.themeMode,
  });

  final ColorConfig config;
  final AppThemeMode? themeMode;
  final Widget child;

  static AppThemeMode colorModeOf(BuildContext context) {
    final platformBrightness = MediaQuery.platformBrightnessOf(context);
    final useDarkTheme = platformBrightness == ui.Brightness.dark;
    if (useDarkTheme) {
      return AppThemeMode.dark;
    }
    return AppThemeMode.light;
  }

  @override
  Widget build(BuildContext context) {
    var theme = AppThemeData.regular(config.lightColors);

    /// Updating the colors for the current brightness
    final colorMode = this.themeMode ?? colorModeOf(context);
    switch (colorMode) {
      case AppThemeMode.dark:
        theme = theme.withColors(config.darkColors);
      case AppThemeMode.light:
        theme = theme.withColors(config.lightColors);
    }

    return AppTheme(
      data: theme,
      child: child,
    );
  }
}
