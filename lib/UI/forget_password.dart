import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'custom.dart';

class Forgetpassword extends StatefulWidget {
  const Forgetpassword({super.key});

  @override
  State<Forgetpassword> createState() => _ForgetpasswordState();
}

class _ForgetpasswordState extends State<Forgetpassword> {
  TextEditingController emailController = TextEditingController();
  forgotpassword(String email) async {
    if (email == "") {
      return Custom.CustomAlertBox(
          context, "Enter an Email To Reset Password");
    } else {
      try {
        await FirebaseAuth.instance.sendPasswordResetEmail(email: email);
        Custom.CustomAlertBox(
            context, "Password reset email sent! Please check your inbox.");
      } on FirebaseAuthException catch (e) {
        Custom.CustomAlertBox(context, "Error sending reset email: ${e.message}");
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2C333A),
      appBar: AppBar(
        backgroundColor: const Color(0xFF2C333A),
        elevation: 0,
        title: const Text("Forget Password",
        style: TextStyle(
         color: Colors.white
        ),),
        centerTitle: true,
      ),
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
              Custom.customButton(() {
                forgotpassword(emailController.text.toString());
              }, "Reset Password"),
            ],
          ),
        ),
      ),
    );
  }
}