import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safeguard/theme/theme.dart';
import 'package:safeguard/widgets/custom_button.dart';

class SignUpPage extends StatelessWidget {
  const SignUpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Back icon
              IconButton(
                icon: const Icon(Icons.arrow_back, color: AppColors.green),
                onPressed: () => Navigator.pop(context),
              ),

              const SizedBox(height: 16),
              const Spacer(),
              const Spacer(),
              // Title
              Text(
                "Sign Up",
                style: GoogleFonts.roboto(
                  fontSize: 22,
                  color: AppColors.green,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 16),

              // Greeting
              Text(
                "Hello there !\nwelcome to you.",
                style: AppTextStyles.heading.copyWith(
                  fontSize: 24,
                  height: 1.4,
                  color: AppColors.primary,
                ),
              ),

              const SizedBox(height: 32),

              // Mobile
              _buildLabel("Mobile Number"),
              _buildInputField(
                hintText: "+44 4444 6786786",
                keyboardType: TextInputType.phone,
                underlineColor: AppColors.green,
              ),

              const SizedBox(height: 18),

              // Email
              _buildLabel("Email"),
              _buildInputField(
                hintText: "Enter email address",
                keyboardType: TextInputType.emailAddress,
              ),

              const SizedBox(height: 18),

              // Full Name
              _buildLabel("Full Name"),
              _buildInputField(hintText: "Enter full name"),

              const SizedBox(height: 18),

              // City
              _buildLabel("City"),
              _buildInputField(hintText: "Select city"),

              const SizedBox(height: 28),

              // Submit Button
              CustomButton(
                text: "SUBMIT",
                backgroundColor: AppColors.green,
                textColor: AppColors.white,
                onPressed: () {
                  // Submit logic
                },
              ),

              const SizedBox(height: 24),

              // Terms
              Text.rich(
                TextSpan(
                  text: "By registering with Safeguard, you agree to our ",
                  style: GoogleFonts.roboto(
                    color: AppColors.primary,
                    fontSize: 12,
                  ),
                  children: [
                    TextSpan(
                      text: "Term of Use",
                      style: TextStyle(color: AppColors.lightgreen),
                    ),
                    const TextSpan(text: " and our "),
                    TextSpan(
                      text: "Privacy Policy.",
                      style: TextStyle(color: AppColors.lightgreen),
                    ),
                  ],
                ),
              ),

              const SizedBox(height: 20),

              // Already have account
              Center(
                child: Text.rich(
                  TextSpan(
                    text: "I have an account ? ",
                    style: GoogleFonts.roboto(color: Colors.black54),
                    children: [
                      TextSpan(
                        text: "Sign In",
                        style: GoogleFonts.roboto(
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
        ),
      ),
    );
  }

  // Helper for label text
  Widget _buildLabel(String label) {
    return Text(
      label,
      style: GoogleFonts.roboto(fontSize: 12, color: AppColors.primary),
    );
  }

  // Helper for text field
  Widget _buildInputField({
    required String hintText,
    TextInputType? keyboardType,
    Color? underlineColor,
  }) {
    return TextField(
      keyboardType: keyboardType,
      style: AppTextStyles.body,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: Colors.grey),
        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: underlineColor ?? AppColors.primary),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: underlineColor ?? AppColors.green,
            width: 2,
          ),
        ),
      ),
    );
  }
}
