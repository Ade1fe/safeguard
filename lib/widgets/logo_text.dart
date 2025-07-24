import 'package:flutter/material.dart';
import 'package:safeguard/theme/theme.dart';

class LogoText extends StatelessWidget {
  final double fontSize;
  final Color? color;
  final FontWeight fontWeight;
  final TextAlign textAlign;
  final TextStyle? style;

  const LogoText({
    super.key,
    this.fontSize = 28,
    this.color,
    this.fontWeight = FontWeight.bold,
    this.textAlign = TextAlign.center,
    this.style,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      'Safeguard',
      textAlign: textAlign,
      style:
          style ??
          TextStyle(
            fontSize: fontSize,
            fontWeight: fontWeight,
            color: color ?? AppColors.white,
            letterSpacing: 1.2,
          ),
    );
  }
}
