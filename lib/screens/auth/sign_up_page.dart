// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:safeguard/components/layout.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:safeguard/screens/auth/login_page.dart';
// import 'package:safeguard/screens/homepage/emergency_contact_setup_screen.dart';
// import 'package:safeguard/theme/theme.dart';
// import 'package:safeguard/widgets/custom_button.dart';

// class SignUpPage extends StatelessWidget {
//   const SignUpPage({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return Layout(
//       imagePath: 'assets/background.png',
//       child: Column(
//         crossAxisAlignment: CrossAxisAlignment.start,
//         children: [
//           // Back icon
//           const SizedBox(height: 60),
//           IconButton(
//             icon: const Icon(Icons.arrow_back, color: AppColors.white),
//             onPressed: () => Navigator.pop(context),
//           ),
//           Text(
//             "Sign Up",
//             style: GoogleFonts.roboto(
//               fontSize: 22,
//               color: AppColors.green,
//               fontWeight: FontWeight.bold,
//             ),
//           ),

//           const SizedBox(height: 16),

//           // Greeting
//           Text(
//             "Hello there !\nwelcome to you.",
//             style: AppTextStyles.heading.copyWith(
//               fontSize: 24,
//               height: 1.4,
//               color: AppColors.white,
//             ),
//           ),

//           const SizedBox(height: 32),

//           // Mobile
//           _buildLabel("Mobile Number"),
//           _buildInputField(
//             hintText: "+44 4444 6786786",
//             keyboardType: TextInputType.phone,
//             // underlineColor: AppColors.green,
//           ),

//           const SizedBox(height: 18),

//           // Email
//           _buildLabel("Email"),
//           _buildInputField(
//             hintText: "Enter email address",
//             keyboardType: TextInputType.emailAddress,
//           ),

//           const SizedBox(height: 18),

//           // Full Name
//           _buildLabel("Full Name"),
//           _buildInputField(hintText: "Enter full name"),

//           const SizedBox(height: 18),

//           // City
//           _buildLabel("City"),
//           _buildInputField(hintText: "Select city"),

//           const SizedBox(height: 28),

//           // Submit Button
//           CustomButton(
//             text: "SUBMIT",
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

//           // Terms
//           Text.rich(
//             TextSpan(
//               text: "By registering with Safeguard, you agree to our ",
//               style: GoogleFonts.roboto(color: AppColors.white, fontSize: 12),
//               children: [
//                 TextSpan(
//                   text: "Term of Use",
//                   style: TextStyle(color: AppColors.lightgreen),
//                 ),
//                 const TextSpan(text: " and our "),
//                 TextSpan(
//                   text: "Privacy Policy.",
//                   style: TextStyle(color: AppColors.lightgreen),
//                 ),
//               ],
//             ),
//           ),

//           const SizedBox(height: 20),

//           Center(
//             child: Text.rich(
//               TextSpan(
//                 text: "I have an account ?  ",
//                 style: AppTextStyles.body.copyWith(color: AppColors.white),
//                 children: [
//                   TextSpan(
//                     text: "Sign In",
//                     style: AppTextStyles.body.copyWith(
//                       color: AppColors.green,
//                       fontWeight: FontWeight.w600,
//                     ),
//                     recognizer: TapGestureRecognizer()
//                       ..onTap = () {
//                         Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (_) => const LoginPage()),
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

//   Widget _buildLabel(String label) {
//     return Text(
//       label,
//       style: GoogleFonts.roboto(fontSize: 12, color: AppColors.white),
//     );
//   }

//   Widget _buildInputField({
//     required String hintText,
//     TextInputType? keyboardType,
//     Color? underlineColor,
//   }) {
//     return TextField(
//       keyboardType: keyboardType,
//       style: AppTextStyles.body.copyWith(
//         color: AppColors.white,
//       ), // ensure text is white too
//       cursorColor: AppColors.green, // <-- makes the cursor white
//       decoration: InputDecoration(
//         hintText: hintText,
//         hintStyle: const TextStyle(color: AppColors.white),
//         enabledBorder: UnderlineInputBorder(
//           borderSide: BorderSide(color: underlineColor ?? AppColors.white),
//         ),
//         focusedBorder: UnderlineInputBorder(
//           borderSide: BorderSide(
//             color: underlineColor ?? AppColors.green,
//             width: 2,
//           ),
//         ),
//       ),
//     );
//   }
// }

// import 'package:flutter/gestures.dart';
// import 'package:flutter/material.dart';
// import 'package:safeguard/components/layout.dart';
// import 'package:google_fonts/google_fonts.dart';
// import 'package:safeguard/screens/auth/login_page.dart';
// import 'package:safeguard/screens/homepage/emergency_contact_setup_screen.dart';
// import 'package:safeguard/theme/theme.dart';
// import 'package:safeguard/widgets/custom_button.dart';

// class SignUpPage extends StatefulWidget {
//   const SignUpPage({super.key});

//   @override
//   State<SignUpPage> createState() => _SignUpPageState();
// }

// class _SignUpPageState extends State<SignUpPage> {
//   final _formKey = GlobalKey<FormState>();
//   final _mobileController = TextEditingController();
//   final _emailController = TextEditingController();
//   final _nameController = TextEditingController();
//   final _cityController = TextEditingController();

//   @override
//   void dispose() {
//     _mobileController.dispose();
//     _emailController.dispose();
//     _nameController.dispose();
//     _cityController.dispose();
//     super.dispose();
//   }

//   void _submitForm() {
//     if (_formKey.currentState!.validate()) {
//       Navigator.push(
//         context,
//         MaterialPageRoute(builder: (_) => const EmergencyContactSetupScreen()),
//       );
//     } else {
//       ScaffoldMessenger.of(context).showSnackBar(
//         const SnackBar(content: Text("Please complete all fields")),
//       );
//     }
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Layout(
//       imagePath: 'assets/background.png',
//       child: Form(
//         key: _formKey,
//         child: Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             const SizedBox(height: 60),
//             IconButton(
//               icon: const Icon(Icons.arrow_back, color: AppColors.white),
//               onPressed: () => Navigator.pop(context),
//             ),
//             Text(
//               "Sign Up",
//               style: GoogleFonts.roboto(
//                 fontSize: 22,
//                 color: AppColors.green,
//                 fontWeight: FontWeight.bold,
//               ),
//             ),
//             const SizedBox(height: 16),
//             Text(
//               "Hello there!\nWelcome to you.",
//               style: AppTextStyles.heading.copyWith(
//                 fontSize: 24,
//                 height: 1.4,
//                 color: AppColors.white,
//               ),
//             ),
//             const SizedBox(height: 32),

//             // Mobile
//             _buildLabel("Mobile Number"),
//             _buildInputField(
//               controller: _mobileController,
//               hintText: "+44 4444 6786786",
//               keyboardType: TextInputType.phone,
//               validator: (value) =>
//                   value == null || value.isEmpty ? 'Enter mobile number' : null,
//             ),
//             const SizedBox(height: 18),

//             // Email
//             _buildLabel("Email"),
//             _buildInputField(
//               controller: _emailController,
//               hintText: "Enter email address",
//               keyboardType: TextInputType.emailAddress,
//               validator: (value) =>
//                   value == null || value.isEmpty ? 'Enter email' : null,
//             ),
//             const SizedBox(height: 18),

//             // Name
//             _buildLabel("Full Name"),
//             _buildInputField(
//               controller: _nameController,
//               hintText: "Enter full name",
//               validator: (value) =>
//                   value == null || value.isEmpty ? 'Enter name' : null,
//             ),
//             const SizedBox(height: 18),

//             // City
//             _buildLabel("City"),
//             _buildInputField(
//               controller: _cityController,
//               hintText: "Enter city",
//               validator: (value) =>
//                   value == null || value.isEmpty ? 'Enter city' : null,
//             ),
//             const SizedBox(height: 28),

//             CustomButton(
//               text: "SUBMIT",
//               backgroundColor: AppColors.green,
//               textColor: AppColors.white,
//               borderColor: AppColors.green,
//               onPressed: _submitForm,
//             ),

//             const SizedBox(height: 24),

//             Text.rich(
//               TextSpan(
//                 text: "By registering with Safeguard, you agree to our ",
//                 style: GoogleFonts.roboto(color: AppColors.white, fontSize: 12),
//                 children: [
//                   TextSpan(
//                     text: "Terms of Use",
//                     style: TextStyle(color: AppColors.lightgreen),
//                   ),
//                   const TextSpan(text: " and our "),
//                   TextSpan(
//                     text: "Privacy Policy",
//                     style: TextStyle(color: AppColors.lightgreen),
//                   ),
//                 ],
//               ),
//             ),
//             const SizedBox(height: 20),

//             Center(
//               child: Text.rich(
//                 TextSpan(
//                   text: "I have an account? ",
//                   style: AppTextStyles.body.copyWith(color: AppColors.white),
//                   children: [
//                     TextSpan(
//                       text: "Sign In",
//                       style: AppTextStyles.body.copyWith(
//                         color: AppColors.green,
//                         fontWeight: FontWeight.w600,
//                       ),
//                       recognizer: TapGestureRecognizer()
//                         ..onTap = () => Navigator.push(
//                           context,
//                           MaterialPageRoute(builder: (_) => const LoginPage()),
//                         ),
//                     ),
//                   ],
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }

//   Widget _buildLabel(String label) {
//     return Text(
//       label,
//       style: GoogleFonts.roboto(fontSize: 12, color: AppColors.white),
//     );
//   }

//   Widget _buildInputField({
//     required TextEditingController controller,
//     required String hintText,
//     TextInputType? keyboardType,
//     String? Function(String?)? validator,
//   }) {
//     return TextFormField(
//       controller: controller,
//       keyboardType: keyboardType,
//       validator: validator,
//       style: AppTextStyles.body.copyWith(color: AppColors.white),
//       cursorColor: AppColors.green,
//       decoration: InputDecoration(
//         hintText: hintText,
//         hintStyle: const TextStyle(color: AppColors.white),
//         enabledBorder: UnderlineInputBorder(
//           borderSide: BorderSide(color: AppColors.white),
//         ),
//         focusedBorder: UnderlineInputBorder(
//           borderSide: BorderSide(color: AppColors.green, width: 2),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:safeguard/components/layout.dart';
import 'package:safeguard/screens/auth/login_page.dart';
import 'package:safeguard/screens/homepage/emergency_contact_setup_screen.dart';
import 'package:safeguard/theme/theme.dart';
import 'package:safeguard/widgets/custom_button.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  final _formKey = GlobalKey<FormState>();
  final _mobileController = TextEditingController();
  final _emailController = TextEditingController();
  final _nameController = TextEditingController();
  final _cityController = TextEditingController();

  @override
  void dispose() {
    _mobileController.dispose();
    _emailController.dispose();
    _nameController.dispose();
    _cityController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      Navigator.push(
        context,
        MaterialPageRoute(builder: (_) => const EmergencyContactSetupScreen()),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please complete all fields")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Layout(
      imagePath: 'assets/background.png',
      backgroundColor: AppColors.primary,
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(height: MediaQuery.of(context).padding.top + 20),
              IconButton(
                icon: const Icon(Icons.arrow_back, color: AppColors.white),
                onPressed: () => Navigator.pop(context),
              ),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Sign Up",
                      style: GoogleFonts.roboto(
                        fontSize: 22,
                        color: AppColors.green,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      "Hello there!\nwelcome to you.",
                      style: AppTextStyles.heading.copyWith(
                        fontSize: 24,
                        height: 1.4,
                        color: AppColors.white,
                      ),
                    ),
                    const SizedBox(height: 32),
                    _buildLabel("Mobile Number"),
                    _buildInputField(
                      controller: _mobileController,
                      hintText: "+44 4444 6786786",
                      keyboardType: TextInputType.phone,
                    ),
                    const SizedBox(height: 18),
                    _buildLabel("Email"),
                    _buildInputField(
                      controller: _emailController,
                      hintText: "Enter email address",
                      keyboardType: TextInputType.emailAddress,
                    ),
                    const SizedBox(height: 18),
                    _buildLabel("Full Name"),
                    _buildInputField(
                      controller: _nameController,
                      hintText: "Enter full name",
                    ),
                    const SizedBox(height: 18),
                    _buildLabel("City"),
                    _buildInputField(
                      controller: _cityController,
                      hintText: "Select city",
                    ),
                    const SizedBox(height: 28),
                    CustomButton(
                      text: "SUBMIT",
                      backgroundColor: AppColors.green,
                      textColor: AppColors.white,
                      borderColor: AppColors.green,
                      onPressed: _submitForm,
                    ),
                    const SizedBox(height: 24),
                    Text.rich(
                      TextSpan(
                        text:
                            "By registering with Safeguard, you agree to our ",
                        style: GoogleFonts.roboto(
                          color: AppColors.white,
                          fontSize: 12,
                        ),
                        children: [
                          TextSpan(
                            text: "Term of Use",
                            style: const TextStyle(color: AppColors.lightgreen),
                          ),
                          const TextSpan(text: " and our "),
                          TextSpan(
                            text: "Privacy Policy.",
                            style: const TextStyle(color: AppColors.lightgreen),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 20),
                    Center(
                      child: Text.rich(
                        TextSpan(
                          text: "I have an account?  ",
                          style: AppTextStyles.body.copyWith(
                            color: AppColors.white,
                          ),
                          children: [
                            TextSpan(
                              text: "Sign In",
                              style: AppTextStyles.body.copyWith(
                                color: AppColors.green,
                                fontWeight: FontWeight.w600,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (_) => const LoginPage(),
                                    ),
                                  );
                                },
                            ),
                          ],
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                  ],
                ),
              ),
            ],
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
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
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
        return null;
      },
    );
  }
}
