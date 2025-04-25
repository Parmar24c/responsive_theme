//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//               CREATED BY NAYAN PARMAR  
//                      © 2025  
//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

import "package:flutter/material.dart";
import 'package:responsive_theme/responsive_theme.dart';

enum AppTextLevel {
  titleX64,
  title32,
  title24,
  title18,
  regular16,
  regular14,
  small13,
  tiny12,
}

class Txt extends StatelessWidget {
  const Txt(
    this.text, {
    super.key,
    this.color,
    this.fontSize,
    this.maxLines,
    this.level = AppTextLevel.regular14,
    this.isUnderLine,
    this.style,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.semanticsLabel,
    this.fontWeight,
  });

  const Txt.titleX(
    this.text, {
    super.key,
    this.color,
    this.fontSize,
    this.maxLines,
    this.isUnderLine,
    this.style,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.semanticsLabel,
    this.fontWeight,
  }) : level = AppTextLevel.titleX64;

  const Txt.title32(
    this.text, {
    super.key,
    this.color,
    this.fontSize,
    this.maxLines,
    this.isUnderLine,
    this.style,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.semanticsLabel,
    this.fontWeight,
  }) : level = AppTextLevel.title32;

  const Txt.title24(
    this.text, {
    super.key,
    this.color,
    this.fontSize,
    this.maxLines,
    this.isUnderLine,
    this.style,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.semanticsLabel,
    this.fontWeight,
  }) : level = AppTextLevel.title24;

  const Txt.title18(
    this.text, {
    super.key,
    this.color,
    this.fontSize,
    this.maxLines,
    this.isUnderLine,
    this.style,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.semanticsLabel,
    this.fontWeight,
  }) : level = AppTextLevel.title18;

  const Txt.regular16(
    this.text, {
    super.key,
    this.color,
    this.fontSize,
    this.maxLines,
    this.isUnderLine,
    this.style,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.semanticsLabel,
    this.fontWeight,
  }) : level = AppTextLevel.regular16;

  const Txt.regular14(
    this.text, {
    super.key,
    this.color,
    this.fontSize,
    this.maxLines,
    this.isUnderLine,
    this.style,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.semanticsLabel,
    this.fontWeight,
  }) : level = AppTextLevel.regular14;

  const Txt.small13(
    this.text, {
    super.key,
    this.color,
    this.fontSize,
    this.maxLines,
    this.isUnderLine,
    this.style,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.semanticsLabel,
    this.fontWeight,
  }) : level = AppTextLevel.small13;

  const Txt.tiny12(
    this.text, {
    super.key,
    this.color,
    this.fontSize,
    this.maxLines,
    this.isUnderLine,
    this.style,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.semanticsLabel,
    this.fontWeight,
  }) : level = AppTextLevel.tiny12;

const Txt.appbar(
    this.text, {
    super.key,
    this.color,
    this.fontSize,
    this.maxLines,
    this.isUnderLine,
    this.style,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.semanticsLabel,
    this.fontWeight,
  }) : level = AppTextLevel.title18;

const Txt.button(
    this.text, {
    super.key,
    this.color,
    this.fontSize,
    this.maxLines,
    this.isUnderLine,
    this.style,
    this.textAlign,
    this.textDirection,
    this.locale,
    this.softWrap,
    this.overflow,
    this.semanticsLabel,
    this.fontWeight,
  }) : level = AppTextLevel.regular16;

  final String? text;
  final AppTextLevel level;
  final Color? color;
  final double? fontSize;
  final FontWeight? fontWeight;
  final int? maxLines;
  final bool? isUnderLine;
  final TextStyle? style;
  final TextAlign? textAlign;
  final TextDirection? textDirection;
  final Locale? locale;
  final bool? softWrap;
  final TextOverflow? overflow;
  final String? semanticsLabel;

  TextStyle? getStyle(AppThemeData? theme) => switch (level) {
        AppTextLevel.titleX64 => theme?.typography.titleX64,
        AppTextLevel.title32 => theme?.typography.title32,
        AppTextLevel.title24 => theme?.typography.title24,
        AppTextLevel.title18 => theme?.typography.title18,
        AppTextLevel.regular16 => theme?.typography.regular16,
        AppTextLevel.regular14 => theme?.typography.regular14,
        AppTextLevel.small13 => theme?.typography.small13,
        AppTextLevel.tiny12 => theme?.typography.tiny12,
      };

  @override
  Widget build(BuildContext context) {
    final theme = AppTheme.maybeOf(context);
    final defaultStyle = getStyle(theme);

    return Text(
      text ?? '',
      textAlign: textAlign,
      style: defaultStyle
          ?.copyWith(
            color: color,
            fontSize: fontSize,
            fontWeight: fontWeight,
            decoration: isUnderLine ?? false ? TextDecoration.underline : null,
            decorationColor: color,
        fontFamily: "Poppins"
          )
          .merge(style),
      maxLines: maxLines,
      textDirection: textDirection ?? this.textDirection,
      locale: locale ?? this.locale,
      softWrap: softWrap ?? this.softWrap,
      semanticsLabel: semanticsLabel ?? this.semanticsLabel,
    );
  }
}
