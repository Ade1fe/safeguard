import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:safeguard/components/layout.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safeguard/screens/auth/sign_up_page.dart';
import 'package:safeguard/screens/homepage/emergency_contact_setup_screen.dart';
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
          const SizedBox(height: 60),
          IconButton(
            icon: const Icon(Icons.arrow_back, color: AppColors.white),
            onPressed: () => Navigator.pop(context),
          ),

          // const Spacer(),
          Center(
            child: LogoText(
              fontSize: 54,
              fontWeight: FontWeight.w500,

              style: GoogleFonts.pacifico(fontSize: 54, color: AppColors.white),
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
              color: AppColors.white,
              height: 1.4,
            ),
          ),
          const SizedBox(height: 42),

          // Label
          Text(
            "Mobile Number",
            style: AppTextStyles.body.copyWith(
              fontSize: 12,
              color: AppColors.white,
            ),
          ),
          const SizedBox(height: 4),

          // Input field
          TextField(
            keyboardType: TextInputType.phone,
            style: AppTextStyles.body,
            cursorColor: AppColors.green,

            decoration: InputDecoration(
              hintText: 'Mobile Number',
              hintStyle: const TextStyle(color: AppColors.white),
              enabledBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.white),
              ),
              focusedBorder: UnderlineInputBorder(
                borderSide: BorderSide(color: AppColors.green, width: 2),
              ),
            ),
          ),

          const SizedBox(height: 30),

          // Login Button
          CustomButton(
            text: "Login",
            backgroundColor: AppColors.green,
            textColor: AppColors.white,
            borderColor: AppColors.green,
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (_) => EmergencyContactSetupScreen(),
                ),
              );
              // handle login
            },
          ),

          const SizedBox(height: 24),
          Center(
            child: Text.rich(
              TextSpan(
                text: "Don’t have an account? ",
                style: AppTextStyles.body.copyWith(color: AppColors.white),
                children: [
                  TextSpan(
                    text: "Sign up",
                    style: AppTextStyles.body.copyWith(
                      color: AppColors.green,
                      fontWeight: FontWeight.w600,
                    ),
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const SignUpPage()),
                        );
                      },
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
