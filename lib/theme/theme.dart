// import 'package:flutter/material.dart';

// class AppColors {
//   static const Color primary = Colors.black;
//   static const Color accent = Colors.orange;
//   static const Color white = Colors.white;
//   static const Color transparent = Colors.transparent;
//   static const Color background = Color(0xFFF2F2F2);
//   static const Color green = Color(0xFF004e64);
//   static const Color lightgreen = Color(0xFF00a5cf);
//   static const Color textPrimary = Color(0xFF212121); // Dark Grey
//   static const Color textSecondary = Color(0xFF757575);
// }

// class AppTextStyles {
//   static const TextStyle heading = TextStyle(
//     fontSize: 24,
//     fontWeight: FontWeight.bold,
//     color: AppColors.white,
//   );

//   static const TextStyle body = TextStyle(fontSize: 16, color: AppColors.white);

//   static const TextStyle button = TextStyle(
//     fontSize: 16,
//     fontWeight: FontWeight.w600,
//     color: AppColors.white,
//   );

//   static const TextStyle heading1 = TextStyle(
//     fontSize: 28,
//     fontWeight: FontWeight.bold,
//     color: AppColors.white,
//   );
//   static const TextStyle heading2 = TextStyle(
//     fontSize: 22,
//     fontWeight: FontWeight.w600,
//     color: AppColors.white,
//   );
//   // static const TextStyle body = TextStyle(
//   //   fontSize: 16,
//   //   color: AppColors.white,
//   // );
//   static const TextStyle bodyBold = TextStyle(
//     fontSize: 16,
//     fontWeight: FontWeight.bold,
//     color: AppColors.white,
//   );
// }

// class AppBorders {
//   static const double defaultRadius = 12.0;
//   static const BorderSide defaultBorder = BorderSide(
//     color: AppColors.accent,
//     width: 2,
//   );
// }

// class AppTheme {
//   static ThemeData get light => ThemeData(
//     brightness: Brightness.light,
//     primaryColor: AppColors.primary,
//     scaffoldBackgroundColor: AppColors.background,
//     textTheme: const TextTheme(bodyMedium: AppTextStyles.body),
//   );

//   static ThemeData get transparent => ThemeData(
//     brightness: Brightness.light,
//     primaryColor: AppColors.primary,
//     scaffoldBackgroundColor: AppColors.transparent,
//     appBarTheme: const AppBarTheme(
//       backgroundColor: Colors.transparent,
//       elevation: 0,
//       foregroundColor: AppColors.white,
//     ),
//     textButtonTheme: TextButtonThemeData(
//       style: TextButton.styleFrom(
//         foregroundColor: AppColors.white,
//         backgroundColor: Colors.transparent,
//         textStyle: AppTextStyles.button,
//       ),
//     ),
//     textTheme: const TextTheme(bodyMedium: TextStyle(color: AppColors.white)),
//   );
// }
import 'package:flutter/material.dart';

class AppColors {
  static const Color primary = Colors.black;
  static const Color accent = Colors.orange;
  static const Color white = Colors.white;
  static const Color transparent = Colors.transparent;
  static const Color background = Color(0xFFF2F2F2);
  static const Color green = Color(0xFF004e64);
  static const Color lightgreen = Color(0xFF00a5cf);
  static const Color textPrimary = Color(0xFF212121); // Dark Grey
  static const Color textSecondary = Color(0xFF757575); // Medium Grey
}

class AppTextStyles {
  static const TextStyle heading = TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );
  static const TextStyle body = TextStyle(fontSize: 16, color: AppColors.white);
  static const TextStyle button = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );
  static const TextStyle heading1 = TextStyle(
    fontSize: 28,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );
  static const TextStyle heading2 = TextStyle(
    fontSize: 22,
    fontWeight: FontWeight.w600,
    color: AppColors.white,
  );
  static const TextStyle bodyBold = TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.bold,
    color: AppColors.white,
  );
}

class AppBorders {
  static const double defaultRadius = 12.0;
  static const BorderSide defaultBorder = BorderSide(
    color: AppColors.accent,
    width: 2,
  );
}

class AppTheme {
  static ThemeData get light => ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.background,
    textTheme: const TextTheme(bodyMedium: AppTextStyles.body),
  );
  static ThemeData get transparent => ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.primary,
    scaffoldBackgroundColor: AppColors.transparent,
    appBarTheme: const AppBarTheme(
      backgroundColor: Colors.transparent,
      elevation: 0,
      foregroundColor: AppColors.white,
    ),
    textButtonTheme: TextButtonThemeData(
      style: TextButton.styleFrom(
        foregroundColor: AppColors.white,
        backgroundColor: Colors.transparent,
        textStyle: AppTextStyles.button,
      ),
    ),
    textTheme: const TextTheme(bodyMedium: TextStyle(color: AppColors.white)),
  );
}
