import 'package:PDFY/utils/widgets/common_widget.dart';
import 'package:PDFY/utils/widgets/gradient_background_screen.dart';
import 'package:PDFY/utils/widgets/text_style_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';





class ForgetPassword extends StatefulWidget {
  const ForgetPassword({super.key});

  @override
  State<ForgetPassword> createState() => _ForgetpasswordState();
}

class _ForgetpasswordState extends State<ForgetPassword> {
  TextEditingController emailController = TextEditingController();
  forgotpassword(String email) async {
    if (email == "") {
      return Custom.customAlertBox(
          context, "Enter an Email To Reset Password");
    } else {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        Custom.customAlertBox(
            context, "Password reset email sent! Please check your inbox.");
      } on FirebaseAuthException catch (e) {
        Custom.customAlertBox(context, "Error sending reset email: ${e.message}");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: AppBars.defaultAppBar(),
        body: Center( // Wrap the Column with Center
          child: SingleChildScrollView( // Added for better responsiveness
            padding: const EdgeInsets.all(16.0), // Added some padding
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center, // Center content vertically
              children: [
                Custom.customTextField(emailController, "Email", Icons.mail, false,
                    TextInputType.emailAddress),
                const SizedBox(
                  height: 30,
                ),
                Custom.customButton(onPressed: () {
                  forgotpassword(emailController.text.toString());
                }, text: "Reset Password"),
              ],
            ),
          ),
        ),
      ),
    );
  }
}