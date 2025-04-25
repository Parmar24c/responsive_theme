//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//               CREATED BY NAYAN PARMAR
//                      © 2025
//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

import 'package:flutter/material.dart';
import 'package:responsive_theme/responsive_theme.dart';

typedef ThemeColor = Map<String, Color>;

extension BuildContextX on BuildContext {
  ThemeColor get colors => AppTheme.maybeOf(this)?.colors ?? {};
  AppTypographyData? get textTheme => AppTheme.maybeOf(this)?.typography;
  bool get isDeviceThemeDark =>
      MediaQuery.platformBrightnessOf(this) == Brightness.dark;
}

extension Styles on Text {
  Text titleX64(BuildContext context) =>
      copyWith(style: context.textTheme?.titleX64);
  Text title32(BuildContext context) =>
      copyWith(style: context.textTheme?.title32);
  Text title24(BuildContext context) =>
      copyWith(style: context.textTheme?.title24);
  Text title18(BuildContext context) =>
      copyWith(style: context.textTheme?.title18);
  Text regular16(BuildContext context) =>
      copyWith(style: context.textTheme?.regular16);
  Text regular14(BuildContext context) =>
      copyWith(style: context.textTheme?.regular14);
  Text small13(BuildContext context) =>
      copyWith(style: context.textTheme?.small13);
  Text tiny12(BuildContext context) =>
      copyWith(style: context.textTheme?.tiny12);
}

extension CopyWith on Text {
  Text copyWith({
    String? data,
    TextStyle? style,
    TextAlign? textAlign,
    TextDirection? textDirection,
    Locale? locale,
    bool? softWrap,
    TextOverflow? overflow,
    int? maxLines,
    String? semanticsLabel,
  }) =>
      Text(
        data ?? this.data ?? "",
        style: style ?? this.style,
        textAlign: textAlign ?? this.textAlign,
        textDirection: textDirection ?? this.textDirection,
        locale: locale ?? this.locale,
        softWrap: softWrap ?? this.softWrap,
        overflow: overflow ?? this.overflow,
        maxLines: maxLines ?? this.maxLines,
        semanticsLabel: semanticsLabel ?? this.semanticsLabel,
      );
}
