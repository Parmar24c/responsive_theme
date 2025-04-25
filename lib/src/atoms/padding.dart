//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//               CREATED BY NAYAN PARMAR
//                      © 2025
//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

import 'package:flutter/material.dart';

final class Insets {
  const Insets._();

  static const double scale = 1;

  static double get zero => 0;
  static double get xxsmall4 => scale * 4;
  static double get xsmall8 => scale * 8;
  static double get small10 => scale * 10;
  static double get small12 => scale * 12;
  static double get medium16 => scale * 16;
  static double get medium18 => scale * 18;
  static double get medium20 => scale * 20;
  static double get large24 => scale * 24;
  static double get xlarge32 => scale * 32;
  static double get xxlarge40 => scale * 40;
  static double get xxxlarge66 => scale * 66;
  static double get xxxxlarge80 => scale * 80;
  static double custom(double val) => scale * val;
  static const double infinity = double.infinity;
}

extension PaddingX on double {
  EdgeInsetsGeometry get paddingAll => EdgeInsets.all(this);
  EdgeInsetsGeometry get paddingHorizontal =>
      EdgeInsets.symmetric(horizontal: this);
  EdgeInsetsGeometry get paddingVertical =>
      EdgeInsets.symmetric(vertical: this);
}
