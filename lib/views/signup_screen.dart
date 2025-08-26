
import 'package:PDFY/utils/widgets/common_widget.dart';
import 'package:PDFY/utils/widgets/gradient_background_screen.dart';
import 'package:PDFY/utils/widgets/text_style_screen.dart';
import 'package:PDFY/views/login_page_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';


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
      Custom.customAlertBox(context, "Enter Required Fields");
    } else {
      UserCredential? usercredential;
      try {
        usercredential = await FirebaseAuth.instance
            .createUserWithEmailAndPassword(email: email, password: password);
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => const LoginPage()));
      } on FirebaseAuthException catch (ex) {
        return Custom.customAlertBox(context, ex.code.toString());
      }
    }
  }

  Widget build(BuildContext context) {
    return GradientBackground( 
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar:  AppBars.defaultAppBar(),
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
                Custom.customButton(
                  onPressed:() {
                  signUp(emailController.text.toString(), passwordController.text.toString());
                },   text: "Sign up",),
              ],
            ),
          ),
        ),
      ),
    );
  }
}