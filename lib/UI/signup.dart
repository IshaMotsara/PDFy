
import 'package:flutter/material.dart';
import 'package:sagar_new_project/UI/login_page.dart';
import 'custom.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  signUp(String email, String password) async {
    if (email == "" && password == "") {
      Custom.CustomAlertBox(context, "Enter Required Fields");
    } else {
      UserCredential? usercredential;
      try {
        usercredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const LoginPage()));
      } on FirebaseAuthException catch (ex) {
        return Custom.CustomAlertBox(context, ex.code.toString());
      }
    }
  }

  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF2C333A),
      appBar: AppBar(
        centerTitle: true,
        backgroundColor: const Color(0xFF2C333A),
        elevation: 0,
        title: const Text("SignUp Page",
        
        style: TextStyle(
          color: Colors.white
        ),),
      ),
      body: Center( // Wrap the Column with Center
        child: SingleChildScrollView( // Added for better responsiveness
          padding: const EdgeInsets.all(16.0), // Added some padding
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center content vertically
            children: [
              Custom.customTextField(
                  emailController, "Email", Icons.mail, false, TextInputType.emailAddress),
              const SizedBox(height: 20), // Added spacing
              Custom.customTextField(passwordController, "Password", Icons.password, true,
                  TextInputType.text), // Corrected keyboard type
              const SizedBox(height: 30),
              Custom.customButton(() {
                signUp(emailController.text.toString(), passwordController.text.toString());
              }, "Sign up"),
            ],
          ),
        ),
      ),
    );
  }
}