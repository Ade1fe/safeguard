import 'package:flutter/material.dart';
import 'package:safeguard/theme/theme.dart';

class Layout extends StatelessWidget {
  final String imagePath;
  final Widget child;
  final double imageHeight;
  final EdgeInsetsGeometry? padding;
  final Color? backgroundColor;

  const Layout({
    super.key,
    required this.imagePath,
    required this.child,
    this.imageHeight = 200.0,
    this.padding,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: backgroundColor ?? AppColors.primary,
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Image.asset(imagePath, height: imageHeight, fit: BoxFit.cover),
          Expanded(
            child: SingleChildScrollView(
              padding: padding ?? const EdgeInsets.all(16.0),
              child: child,
            ),
          ),
        ],
      ),
    );
  }
}
