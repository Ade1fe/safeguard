// import 'package:flutter/material.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:safeguard/theme/theme.dart';
// import 'package:safeguard/widgets/custom_button.dart';
// import 'package:safeguard/widgets/logo_text.dart';

// class LoginPage extends StatelessWidget {
//   const LoginPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: AppColors.white,
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
//           child: Column(
//             crossAxisAlignment: CrossAxisAlignment.start,
//             children: [
//               const SizedBox(height: 20),
//               IconButton(
//                 icon: const Icon(Icons.arrow_back, color: AppColors.green),
//                 onPressed: () => Navigator.pop(context),
//               ),

//               const Spacer(),
//               const Spacer(),

//               // Logo
//               Center(
//                 child: LogoText(
//                   fontSize: 54,
//                   fontWeight: FontWeight.w500,
//                   color: AppColors.green,
//                   style: GoogleFonts.pacifico(
//                     fontSize: 54,
//                     color: AppColors.green,
//                   ),
//                 ),
//               ),
//               const SizedBox(height: 100),

//               // Login title
//               Text(
//                 "Login",
//                 style: GoogleFonts.roboto(
//                   fontSize: 20,
//                   color: AppColors.green,
//                   fontWeight: FontWeight.w500,
//                 ),
//               ),
//               const SizedBox(height: 32),

//               // Greeting text
//               Text(
//                 "Hello there!\nWelcome Back",
//                 style: AppTextStyles.heading.copyWith(
//                   fontSize: 22,
//                   fontWeight: FontWeight.w500,
//                   color: Colors.black87,
//                   height: 1.4,
//                 ),
//               ),
//               const SizedBox(height: 42),

//               // Label
//               Text(
//                 "Mobile Number",
//                 style: AppTextStyles.body.copyWith(
//                   fontSize: 12,
//                   color: Colors.grey[700],
//                 ),
//               ),
//               const SizedBox(height: 4),

//               // Input field
//               TextField(
//                 keyboardType: TextInputType.phone,
//                 style: AppTextStyles.body,
//                 decoration: const InputDecoration(
//                   hintText: 'Mobile Number',
//                   hintStyle: TextStyle(color: Colors.grey),
//                   border: UnderlineInputBorder(),
//                 ),
//               ),

//               const SizedBox(height: 30),

//               // Login Button
//               CustomButton(
//                 text: "Login",
//                 backgroundColor: AppColors.green,
//                 textColor: AppColors.white,
//                 onPressed: () {
//                   // handle login
//                 },
//               ),

//               const SizedBox(height: 24),

//               // Footer link
//               Center(
//                 child: Text.rich(
//                   TextSpan(
//                     text: "Don’t have an account? ",
//                     style: AppTextStyles.body.copyWith(color: Colors.black54),
//                     children: [
//                       TextSpan(
//                         text: "Sign up",
//                         style: AppTextStyles.body.copyWith(
//                           color: AppColors.green,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:safeguard/components/layout.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safeguard/theme/theme.dart';
import 'package:safeguard/widgets/custom_button.dart';
import 'package:safeguard/widgets/logo_text.dart';

class LoginPage extends StatelessWidget {
  const LoginPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Layout(
      imagePath: 'assets/background.png',
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const SizedBox(height: 20),
          IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.green),
            onPressed: () => Navigator.pop(context),
          ),

          // const Spacer(),
          // const Spacer(),

          // Logo
          Center(
            child: LogoText(
              fontSize: 54,
              fontWeight: FontWeight.w500,
              color: AppColors.green,
              style: GoogleFonts.pacifico(fontSize: 54, color: AppColors.green),
            ),
          ),
          const SizedBox(height: 100),

          // Login title
          Text(
            "Login",
            style: GoogleFonts.roboto(
              fontSize: 20,
              color: AppColors.green,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 32),

          // Greeting text
          Text(
            "Hello there!\nWelcome Back",
            style: AppTextStyles.heading.copyWith(
              fontSize: 22,
              fontWeight: FontWeight.w500,
              color: Colors.black87,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 42),

          // Label
          Text(
            "Mobile Number",
            style: AppTextStyles.body.copyWith(
              fontSize: 12,
              color: Colors.grey[700],
            ),
          ),
          const SizedBox(height: 4),

          // Input field
          TextField(
            keyboardType: TextInputType.phone,
            style: AppTextStyles.body,
            decoration: const InputDecoration(
              hintText: 'Mobile Number',
              hintStyle: TextStyle(color: Colors.grey),
              border: UnderlineInputBorder(),
            ),
          ),

          const SizedBox(height: 30),

          // Login Button
          CustomButton(
            text: "Login",
            backgroundColor: AppColors.green,
            textColor: AppColors.white,
            onPressed: () {
              // handle login
            },
          ),

          const SizedBox(height: 24),

          // Footer link
          Center(
            child: Text.rich(
              TextSpan(
                text: "Don’t have an account? ",
                style: AppTextStyles.body.copyWith(color: Colors.black54),
                children: [
                  TextSpan(
                    text: "Sign up",
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.green,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),

      // Column(
      //   crossAxisAlignment: CrossAxisAlignment.start,
      //   children: [
      //     const Text(
      //       'Welcome Back!',
      //       style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
      //     ),
      //     const SizedBox(height: 20),
      //     TextField(
      //       decoration: InputDecoration(
      //         hintText: 'Email',
      //         border: OutlineInputBorder(),
      //       ),
      //     ),
      //     const SizedBox(height: 12),
      //     TextField(
      //       obscureText: true,
      //       decoration: InputDecoration(
      //         hintText: 'Password',
      //         border: OutlineInputBorder(),
      //       ),
      //     ),
      //     const SizedBox(height: 20),
      //     ElevatedButton(onPressed: () {}, child: const Text('Login')),
      //   ],
      // ),
    );
  }
}
