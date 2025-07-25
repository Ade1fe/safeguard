import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safeguard/screens/auth/login_page.dart';
import 'package:safeguard/screens/auth/sign_up_page.dart';
import 'package:safeguard/widgets/custom_button.dart';
import 'package:safeguard/theme/theme.dart';
import 'package:safeguard/widgets/logo_text.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          // Background image
          Image.asset(
            'assets/background.jpg', // make sure this exists
            fit: BoxFit.cover,
          ),
          // Overlay with content
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Spacer(),
              const Spacer(),
              LogoText(
                fontSize: 60,
                fontWeight: FontWeight.w500,
                color: AppColors.white,
                style: GoogleFonts.pacifico(
                  fontSize: 60,
                  color: AppColors.white,
                ),
              ),
              const Spacer(),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 40.0),
                child: Column(
                  children: [
                    CustomButton(
                      text: "Login",
                      backgroundColor: AppColors.white,
                      textColor: AppColors.primary,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const LoginPage()),
                        );
                      },
                    ),
                    const SizedBox(height: 12),
                    CustomButton(
                      text: "Sign Up",
                      // icon: Icons.arrow_forward,
                      borderColor: AppColors.white,
                      textColor: AppColors.white,
                      borderWidth: 1,
                      backgroundColor: AppColors.transparent,
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (_) => const SignUpPage()),
                        );
                      },
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ],
      ),
    );
  }
}
