import 'package:flutter/material.dart';
import 'package:safeguard/theme/theme.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback onPressed;
  final Color backgroundColor;
  final Color textColor;
  final bool isOutlined;
  final double borderRadius;
  final IconData? icon;
  final Color? borderColor;
  final double borderWidth;

  const CustomButton({
    super.key,
    required this.text,
    required this.onPressed,
    this.backgroundColor = AppColors.white,
    this.textColor = AppColors.primary,
    this.isOutlined = false,
    this.borderRadius = 12.0,
    this.icon,
    this.borderColor,
    this.borderWidth = 1.5,
  });

  @override
  Widget build(BuildContext context) {
    final Color resolvedBorderColor = borderColor ?? textColor;

    final buttonChild = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.min,
      children: [
        if (icon != null) ...[
          Icon(icon, color: textColor),
          const SizedBox(width: 8),
        ],
        Text(
          text,
          style: TextStyle(
            color: textColor,
            fontWeight: FontWeight.w600,
            fontSize: 16,
          ),
        ),
      ],
    );

    return SizedBox(
      width: double.infinity,
      height: 50,
      child: isOutlined
          ? OutlinedButton(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(
                foregroundColor: textColor,
                side: BorderSide(
                  color: resolvedBorderColor,
                  width: borderWidth,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
              ),
              child: buttonChild,
            )
          : ElevatedButton(
              onPressed: onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: backgroundColor,
                foregroundColor: textColor,
                side: BorderSide(
                  color: resolvedBorderColor,
                  width: borderWidth,
                ),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
              ),
              child: buttonChild,
            ),
    );
  }
}
