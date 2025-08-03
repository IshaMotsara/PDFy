import 'package:flutter/material.dart';
import 'package:sagar_new_project/UI/forget_password.dart';
import 'package:sagar_new_project/UI/profilescreen.dart';
import 'package:sagar_new_project/UI/signup.dart';
import 'custom.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  static var emailController;

  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  login(String email, String password) async {
    if (email == "" && password == "") {
      Custom.CustomAlertBox(context, "Enter Required Fields");
    } else {
      UserCredential? usercredential;
      try {
        usercredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);
        print("User created: ${usercredential.user?.uid}");
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => HomeScreen()));
        print("Navigated to profile screen");
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
        title: const Text("Login Page",
        style: TextStyle(
         color: Colors.white
        ),
        ),
      ),
      body: Center( // Wrap the Column with Center widget
        child: SingleChildScrollView( // Added SingleChildScrollView for better responsiveness
          padding: const EdgeInsets.all(16.0), // Added some padding
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, // Center content vertically
            children: [
              Custom.customTextField(
                  emailController, "Email", Icons.mail, false, TextInputType.emailAddress),
              const SizedBox(height: 20), // Added some spacing
              Custom.customTextField(passwordController, "Password", Icons.password, true,
                  TextInputType.text),
              const SizedBox(height: 30),
              Custom.customButton(() {
                login(emailController.text.toString(), passwordController.text.toString());
              }, "Login"),
              const SizedBox(height: 20), // Added some spacing
              const Text("Don't have an account?",
              style: TextStyle(
                color: Colors.white
              ),
              ),
              TextButton(
                  onPressed: () {
                    Navigator.push(
                        context, MaterialPageRoute(builder: (context) => SignUp()));
                  },
                  child: const Text("Sign up",
                  style: TextStyle(
                    color: Colors.yellow
                  ),)),
              const SizedBox(height: 10), // Added some spacing
              TextButton(
                  onPressed: () {
                    Navigator.push(context,
                        MaterialPageRoute(builder: (context) => const Forgetpassword()));
                  },
                  child: const Text("Forgot Password",
                  style: TextStyle(
                    color: Colors.yellow
                  ),)),
            ],
          ),
        ),
      ),
    );
  }
}