// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
// // import 'package:safeguard/screens/location_screen.dart'; // Assuming these paths are correct
// import 'package:safeguard/splash_screen.dart';
// import 'package:safeguard/theme/theme.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   try {
//     final directory = await getApplicationSupportDirectory();
//     print('Application Support Directory: ${directory.path}');
//   } catch (e) {
//     print('Error getting application support directory: $e');
//   }
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Safeguard',
//       theme: ThemeData(
//         primaryColor: AppColors.primary,
//         scaffoldBackgroundColor: AppColors.background,
//         textTheme: const TextTheme(bodyMedium: AppTextStyles.body),
//       ),
//       home: const SplashScreen(),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:path_provider/path_provider.dart';
// // import 'package:safeguard/screens/location_screen.dart'; // Assuming these paths are correct
// import 'package:safeguard/splash_screen.dart';
// import 'package:safeguard/theme/theme.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   try {
//     final directory = await getApplicationSupportDirectory();
//     print('Application Support Directory: ${directory.path}');
//   } catch (e) {
//     print('Error getting application support directory: $e');
//   }
//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Safeguard',
//       theme: ThemeData(
//         primaryColor: AppColors.white,
//         scaffoldBackgroundColor: AppColors.primary,
//         textTheme: const TextTheme(bodyMedium: AppTextStyles.body),
//       ),
//       home: const SplashScreen(),
//     );
//   }
// }
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:safeguard/splash_screen.dart';
// import 'package:safeguard/theme/theme.dart';

// void main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   try {
//     final directory = await getApplicationSupportDirectory();
//     print('Application Support Directory: ${directory.path}');
//   } catch (e) {
//     print('Error getting application support directory: $e');
//   }

//   // Set initial system overlay style
//   SystemChrome.setSystemUIOverlayStyle(
//     const SystemUiOverlayStyle(
//       statusBarColor: Colors.transparent,
//       statusBarIconBrightness: Brightness.light, // For Android
//       statusBarBrightness: Brightness.dark, // For iOS
//     ),
//   );

//   runApp(const MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       debugShowCheckedModeBanner: false,
//       title: 'Safeguard',
//       theme: ThemeData(
//         primaryColor: AppColors.white,
//         scaffoldBackgroundColor: AppColors.primary,
//         textTheme: const TextTheme(bodyMedium: AppTextStyles.body),
//       ),
//       builder: (context, child) {
//         return AnnotatedRegion<SystemUiOverlayStyle>(
//           value: const SystemUiOverlayStyle(
//             statusBarColor: Colors.transparent,
//             statusBarIconBrightness: Brightness.light, // Android
//             statusBarBrightness: Brightness.dark, // iOS
//           ),
//           child: child!,
//         );
//       },
//       home: const SplashScreen(),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:path_provider/path_provider.dart';
import 'package:safeguard/splash_screen.dart';
import 'package:safeguard/theme/theme.dart';
import 'package:firebase_core/firebase_core.dart'; // <--- Import Firebase Core

void main() async {
  WidgetsFlutterBinding.ensureInitialized(); // Ensure Flutter widgets are initialized

  // Initialize Firebase here
  try {
    await Firebase.initializeApp(
      // options: DefaultFirebaseOptions.currentPlatform, // Uncomment and use if you have firebase_options.dart
    );
    print('Firebase initialized successfully!');
  } catch (e) {
    print('Error initializing Firebase: $e');
    // You might want to show an error message to the user or log it more prominently
  }

  try {
    final directory = await getApplicationSupportDirectory();
    print('Application Support Directory: ${directory.path}');
  } catch (e) {
    print('Error getting application support directory: $e');
  }

  // Set initial system overlay style
  SystemChrome.setSystemUIOverlayStyle(
    const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light, // For Android
      statusBarBrightness: Brightness.dark, // For iOS
    ),
  );

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Safeguard',
      theme: ThemeData(
        primaryColor: AppColors.white,
        scaffoldBackgroundColor: AppColors.primary,
        textTheme: const TextTheme(bodyMedium: AppTextStyles.body),
      ),
      builder: (context, child) {
        return AnnotatedRegion<SystemUiOverlayStyle>(
          value: const SystemUiOverlayStyle(
            statusBarColor: Colors.transparent,
            statusBarIconBrightness: Brightness.light, // Android
            statusBarBrightness: Brightness.dark, // iOS
          ),
          child: child!,
        );
      },
      home: const SplashScreen(),
    );
  }
}
