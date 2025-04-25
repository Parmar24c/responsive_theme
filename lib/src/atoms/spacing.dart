//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━
//               CREATED BY NAYAN PARMAR
//                      © 2025
//━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━━

import 'package:flutter/material.dart';
import 'padding.dart';

final class VGap extends StatelessWidget {
  const VGap._(this.size);

  factory VGap.xxsmall4() => VGap._(Insets.xxsmall4);
  factory VGap.xsmall8() => VGap._(Insets.xsmall8);
  factory VGap.small12() => VGap._(Insets.small12);
  factory VGap.medium16() => VGap._(Insets.medium16);
  factory VGap.large24() => VGap._(Insets.large24);
  factory VGap.xlarge32() => VGap._(Insets.xlarge32);
  factory VGap.xxlarge40() => VGap._(Insets.xxlarge40);
  factory VGap.xxxlarge66() => VGap._(Insets.xxxlarge66);
  factory VGap.xxxxlarge80() => VGap._(Insets.xxxxlarge80);
  factory VGap.custom(double size) => VGap._(Insets.custom(size));

  final double size;

  @override
  Widget build(BuildContext context) => SizedBox(height: size);
}

final class HGap extends StatelessWidget {
  const HGap._(this.size);

  factory HGap.xxsmall4() => HGap._(Insets.xxsmall4);
  factory HGap.xsmall8() => HGap._(Insets.xsmall8);
  factory HGap.small12() => HGap._(Insets.small12);
  factory HGap.medium16() => HGap._(Insets.medium16);
  factory HGap.medium20() => HGap._(Insets.medium20);
  factory HGap.large24() => HGap._(Insets.large24);
  factory HGap.xlarge32() => HGap._(Insets.xlarge32);
  factory HGap.xxlarge40() => HGap._(Insets.xxlarge40);
  factory HGap.xxxlarge66() => HGap._(Insets.xxxlarge66);
  factory HGap.xxxxlarge80() => HGap._(Insets.xxxxlarge80);
  factory HGap.custom(double size) => HGap._(Insets.custom(size));

  final double size;

  @override
  Widget build(BuildContext context) => SizedBox(width: size);
}
