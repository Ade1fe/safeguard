// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:safeguard/components/layout.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:safeguard/screens/auth/sign_up_page.dart';
// import 'package:safeguard/screens/homepage/emergency_contact_setup_screen.dart';
// import 'package:safeguard/theme/theme.dart';
// import 'package:safeguard/widgets/custom_button.dart';
// import 'package:safeguard/widgets/logo_text.dart';

// class LoginPage extends StatelessWidget {
//   const LoginPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Layout(
//       imagePath: 'assets/background.png',
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           const SizedBox(height: 60),
//           IconButton(
//             icon: const Icon(Icons.arrow_back, color: AppColors.white),
//             onPressed: () => Navigator.pop(context),
//           ),

//           // const Spacer(),
//           Center(
//             child: LogoText(
//               fontSize: 54,
//               fontWeight: FontWeight.w500,

//               style: GoogleFonts.pacifico(fontSize: 54, color: AppColors.white),
//             ),
//           ),
//           const SizedBox(height: 100),

//           // Login title
//           Text(
//             "Login",
//             style: GoogleFonts.roboto(
//               fontSize: 20,
//               color: AppColors.green,
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//           const SizedBox(height: 32),

//           // Greeting text
//           Text(
//             "Hello there!\nWelcome Back",
//             style: AppTextStyles.heading.copyWith(
//               fontSize: 22,
//               fontWeight: FontWeight.w500,
//               color: AppColors.white,
//               height: 1.4,
//             ),
//           ),
//           const SizedBox(height: 42),

//           // Label
//           Text(
//             "Mobile Number",
//             style: AppTextStyles.body.copyWith(
//               fontSize: 12,
//               color: AppColors.white,
//             ),
//           ),
//           const SizedBox(height: 4),

//           // Input field
//           TextField(
//             keyboardType: TextInputType.phone,
//             style: AppTextStyles.body,
//             cursorColor: AppColors.green,

//             decoration: InputDecoration(
//               hintText: 'Mobile Number',
//               hintStyle: const TextStyle(color: AppColors.white),
//               enabledBorder: UnderlineInputBorder(
//                 borderSide: BorderSide(color: AppColors.white),
//               ),
//               focusedBorder: UnderlineInputBorder(
//                 borderSide: BorderSide(color: AppColors.green, width: 2),
//               ),
//             ),
//           ),

//           const SizedBox(height: 30),

//           // Login Button
//           CustomButton(
//             text: "Login",
//             backgroundColor: AppColors.green,
//             textColor: AppColors.white,
//             borderColor: AppColors.green,
//             onPressed: () {
//               Navigator.push(
//                 context,
//                 MaterialPageRoute(
//                   builder: (_) => EmergencyContactSetupScreen(),
//                 ),
//               );
//               // handle login
//             },
//           ),

//           const SizedBox(height: 24),
//           Center(
//             child: Text.rich(
//               TextSpan(
//                 text: "Don’t have an account? ",
//                 style: AppTextStyles.body.copyWith(color: AppColors.white),
//                 children: [
//                   TextSpan(
//                     text: "Sign up",
//                     style: AppTextStyles.body.copyWith(
//                       color: AppColors.green,
//                       fontWeight: FontWeight.w600,
//                     ),
//                     recognizer: TapGestureRecognizer()
//                       ..onTap = () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (_) => const SignUpPage()),
//                         );
//                       },
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safeguard/components/layout.dart';
import 'package:safeguard/screens/auth/sign_up_page.dart';
import 'package:safeguard/screens/homepage/home_page_screen.dart'; // Import your home screen
import 'package:safeguard/theme/theme.dart';
import 'package:safeguard/widgets/custom_button.dart';
import 'package:safeguard/widgets/logo_text.dart';
import 'package:firebase_auth/firebase_auth.dart'; // Import Firebase Auth

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false; // To manage loading state of the button

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _login() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        await FirebaseAuth.instance.signInWithEmailAndPassword(
          email: _emailController.text.trim(),
          password: _passwordController.text.trim(),
        );

        // If successful, navigate to the home screen
        if (mounted) {
          Navigator.pushReplacement(
            // Use pushReplacement to prevent going back to login
            context,
            MaterialPageRoute(
              builder: (_) => const HomeScreen(),
            ), // Pass initial empty list or fetch from user data
          );
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(const SnackBar(content: Text("Login successful!")));
        }
      } on FirebaseAuthException catch (e) {
        String message;
        if (e.code == 'user-not-found') {
          message = 'No user found for that email.';
        } else if (e.code == 'wrong-password') {
          message = 'Wrong password provided for that user.';
        } else if (e.code == 'invalid-email') {
          message = 'The email address is not valid.';
        } else {
          message = 'An error occurred: ${e.message}';
        }
        if (mounted) {
          ScaffoldMessenger.of(
            context,
          ).showSnackBar(SnackBar(content: Text(message)));
        }
      } catch (e) {
        if (mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(content: Text("An unexpected error occurred: $e")),
          );
        }
        debugPrint('Unexpected error during login: $e');
      } finally {
        if (mounted) {
          setState(() {
            _isLoading = false;
          });
        }
      }
    } else {
      if (mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Please enter your credentials")),
        );
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      imagePath: 'assets/background.png',
      backgroundColor: AppColors.primary, // Ensure background color is set
      child: SingleChildScrollView(
        // Wrap content in SingleChildScrollView for keyboard overflow
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20.0,
            ), // Apply horizontal padding here
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: MediaQuery.of(context).padding.top + 20),
                IconButton(
                  icon: const Icon(Icons.arrow_back, color: AppColors.white),
                  onPressed: () => Navigator.pop(context),
                ),
                Center(
                  child: LogoText(
                    fontSize: 54,
                    fontWeight: FontWeight.w500,
                    style: GoogleFonts.pacifico(
                      fontSize: 54,
                      color: AppColors.white,
                    ),
                  ),
                ),
                const SizedBox(height: 100),
                Text(
                  "Login",
                  style: GoogleFonts.roboto(
                    fontSize: 20,
                    color: AppColors.green,
                    fontWeight: FontWeight.w500,
                  ),
                ),
                const SizedBox(height: 32),
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
                _buildLabel("Email"), // Changed label to Email
                _buildInputField(
                  controller: _emailController,
                  hintText: "Enter your email",
                  keyboardType: TextInputType.emailAddress,
                ),
                const SizedBox(height: 18), // Added space for password field
                _buildLabel("Password"), // Added Password label
                _buildInputField(
                  controller: _passwordController,
                  hintText: "Enter your password",
                  obscureText: true, // Obscure text for password
                ),
                const SizedBox(height: 30),
                CustomButton(
                  text: _isLoading ? "LOGGING IN..." : "LOGIN",
                  backgroundColor: AppColors.green,
                  textColor: AppColors.white,
                  borderColor: AppColors.green,
                  onPressed: _isLoading
                      ? null
                      : _login, // Link to _login function
                ),
                const SizedBox(height: 24),
                Center(
                  child: Text.rich(
                    TextSpan(
                      text: "Don’t have an account? ",
                      style: AppTextStyles.body.copyWith(
                        color: AppColors.white,
                      ),
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
                                MaterialPageRoute(
                                  builder: (_) => const SignUpPage(),
                                ),
                              );
                            },
                        ),
                      ],
                    ),
                  ),
                ),
                const SizedBox(height: 20), // Bottom padding
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String label) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        label,
        style: GoogleFonts.roboto(fontSize: 12, color: AppColors.white),
      ),
    );
  }

  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    TextInputType? keyboardType,
    bool obscureText = false,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      obscureText: obscureText,
      style: AppTextStyles.body.copyWith(color: AppColors.white),
      cursorColor: AppColors.green,
      decoration: InputDecoration(
        hintText: hintText,
        hintStyle: const TextStyle(color: AppColors.white),
        enabledBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.white),
        ),
        focusedBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: AppColors.green, width: 2),
        ),
      ),
      validator: (value) {
        if (value == null || value.isEmpty) {
          return "This field cannot be empty";
        }
        if (keyboardType == TextInputType.emailAddress &&
            !value.contains('@')) {
          return "Please enter a valid email";
        }
        return null;
      },
    );
  }
}
