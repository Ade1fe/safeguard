// import 'package:flutter/material.dart';
// import 'package:safeguard/theme/theme.dart';

// class CustomButton extends StatelessWidget {
//   final String text;
//   final VoidCallback onPressed;
//   final Color backgroundColor;
//   final Color textColor;
//   final bool isOutlined;
//   final double borderRadius;
//   final IconData? icon;
//   final Color? borderColor;
//   final double borderWidth;
//   final double? width;

//   const CustomButton({
//     super.key,
//     required this.text,
//     required this.onPressed,
//     this.backgroundColor = AppColors.white,
//     this.textColor = AppColors.primary,
//     this.isOutlined = false,
//     this.borderRadius = 12.0,
//     this.icon,
//     this.borderColor,
//     this.borderWidth = 1.5,
//     this.width,
//   });

//   @override
//   Widget build(BuildContext context) {
//     final Color resolvedBorderColor = borderColor ?? textColor;

//     final buttonChild = Row(
//       mainAxisAlignment: MainAxisAlignment.center,
//       mainAxisSize: MainAxisSize.max,
//       children: [
//         if (icon != null) ...[
//           Icon(icon, color: textColor),
//           const SizedBox(width: 8),
//         ],
//         Flexible(
//           child: Text(
//             text,
//             style: TextStyle(
//               color: textColor,
//               fontWeight: FontWeight.w600,
//               fontSize: 16,
//             ),
//             overflow: TextOverflow.ellipsis,
//             softWrap: false,
//           ),
//         ),
//       ],
//     );

//     return SizedBox(
//       width: width,
//       height: 50,
//       child: isOutlined
//           ? OutlinedButton(
//               onPressed: onPressed,
//               style: OutlinedButton.styleFrom(
//                 foregroundColor: textColor,
//                 side: BorderSide(
//                   color: resolvedBorderColor,
//                   width: borderWidth,
//                 ),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(borderRadius),
//                 ),
//               ),
//               child: buttonChild,
//             )
//           : ElevatedButton(
//               onPressed: onPressed,
//               style: ElevatedButton.styleFrom(
//                 backgroundColor: backgroundColor,
//                 foregroundColor: textColor,
//                 side: BorderSide(
//                   color: resolvedBorderColor,
//                   width: borderWidth,
//                 ),
//                 shape: RoundedRectangleBorder(
//                   borderRadius: BorderRadius.circular(borderRadius),
//                 ),
//               ),
//               child: buttonChild,
//             ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:safeguard/theme/theme.dart';

class CustomButton extends StatelessWidget {
  final String text;
  final VoidCallback? onPressed; // <--- Changed to nullable VoidCallback?
  final Color backgroundColor;
  final Color textColor;
  final bool isOutlined;
  final double borderRadius;
  final IconData? icon;
  final Color? borderColor;
  final double borderWidth;
  final double? width;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed, // <--- Changed to nullable
    this.backgroundColor = AppColors.white,
    this.textColor = AppColors.primary,
    this.isOutlined = false,
    this.borderRadius = 12.0,
    this.icon,
    this.borderColor,
    this.borderWidth = 1.5,
    this.width,
  });

  @override
  Widget build(BuildContext context) {
    final Color resolvedBorderColor = borderColor ?? textColor;
    final buttonChild = Row(
      mainAxisAlignment: MainAxisAlignment.center,
      mainAxisSize: MainAxisSize.max,
      children: [
        if (icon != null) ...[
          Icon(icon, color: textColor),
          const SizedBox(width: 8),
        ],
        Flexible(
          child: Text(
            text,
            style: TextStyle(
              color: textColor,
              fontWeight: FontWeight.w600,
              fontSize: 16,
            ),
            overflow: TextOverflow.ellipsis,
            softWrap: false,
          ),
        ),
      ],
    );

    return SizedBox(
      width: width,
      height: 50,
      child: isOutlined
          ? OutlinedButton(
              onPressed: onPressed, // Pass the nullable onPressed
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
              onPressed: onPressed, // Pass the nullable onPressed
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
