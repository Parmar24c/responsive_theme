//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//               CREATED BY NAYAN PARMAR  
//                      © 2025  
//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

import 'dart:ui';

import 'package:equatable/equatable.dart';
import 'package:responsive_theme/responsive_theme.dart';

class AppThemeData extends Equatable {
  const AppThemeData({
    required this.colors,
    required this.typography,
  });

  factory AppThemeData.regular(ThemeColor colors) => AppThemeData(
        colors: colors,
        typography: AppTypographyData.regular(),
      );
  final ThemeColor colors;
  final AppTypographyData typography;

  AppThemeData withColors(ThemeColor colors) {
    return AppThemeData(
      colors: colors,
      typography: typography,
    );
  }

  @override
  List<Object?> get props => [colors, typography];
}
