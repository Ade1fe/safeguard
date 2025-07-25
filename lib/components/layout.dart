// import 'package:flutter/material.dart';
// import 'package:safeguard/theme/theme.dart';

// class Layout extends StatelessWidget {
//   final String imagePath;
//   final Widget child;
//   final double imageHeight;
//   final EdgeInsetsGeometry? padding;
//   final Color? backgroundColor;

//   const Layout({
//     super.key,
//     required this.imagePath,
//     required this.child,
//     this.imageHeight = 200.0,
//     this.padding,
//     this.backgroundColor,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: backgroundColor ?? AppColors.primary,
//       body: Column(
//         crossAxisAlignment: CrossAxisAlignment.stretch,
//         children: [
//           Image.asset(imagePath, height: imageHeight, fit: BoxFit.cover),
//           Expanded(
//             child: SingleChildScrollView(
//               padding: padding ?? const EdgeInsets.all(16.0),
//               child: child,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:safeguard/theme/theme.dart';

// class Layout extends StatelessWidget {
//   final String imagePath;
//   final Widget child;
//   final EdgeInsetsGeometry? padding;
//   final Color? backgroundColor;

//   const Layout({
//     super.key,
//     required this.imagePath,
//     required this.child,
//     this.padding,
//     this.backgroundColor,
//   });

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: backgroundColor ?? AppColors.primary,
//       body: Stack(
//         children: [
//           // Background image
//           Positioned.fill(child: Image.asset(imagePath, fit: BoxFit.contain)), the image should be at the top as a background

//           // Foreground content with optional padding
//           SingleChildScrollView(
//             padding: padding ?? const EdgeInsets.all(16.0),
//             child: SafeArea(child: child),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:safeguard/theme/theme.dart';

class Layout extends StatelessWidget {
  final String imagePath;
  final Widget child;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;
  final double?
  imageHeight; // Optional: to control the height of the background image

  const Layout({
    super.key,
    required this.imagePath,
    required this.child,
    this.padding,
    this.backgroundColor,
    this.imageHeight, // Added to constructor
  });

  @override
  Widget build(BuildContext context) {
    // Calculate a default image height if not provided, e.g., 35% of screen height
    final double effectiveImageHeight =
        imageHeight ?? MediaQuery.of(context).size.height * 0.35;

    return Scaffold(
      backgroundColor: backgroundColor ?? AppColors.primary,
      body: Stack(
        children: [
          // Background image positioned at the top
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height:
                effectiveImageHeight, // Set a specific height for the image area
            child: Image.asset(
              imagePath,
              fit:
                  BoxFit.contain, // Ensures the image covers the specified area
              alignment:
                  Alignment.topCenter, // Aligns the image to the top if cropped
            ),
          ),
          // Foreground content with optional padding
          // This content will overlay the image from the top,
          // allowing for a background effect.
          SingleChildScrollView(
            padding: padding ?? const EdgeInsets.all(16.0),
            child: SafeArea(child: child),
          ),
        ],
      ),
    );
  }
}
