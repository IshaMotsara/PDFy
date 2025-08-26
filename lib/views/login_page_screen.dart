import 'package:PDFY/utils/widgets/common_widget.dart';
import 'package:PDFY/utils/widgets/gradient_background_screen.dart';
import 'package:PDFY/utils/widgets/text_style_screen.dart';
import 'package:PDFY/views/forget_password_screen.dart';
import 'package:PDFY/views/home_screen.dart';
import 'package:PDFY/views/phoneauth_screen.dart';
import 'package:PDFY/views/signup_screen.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  login(String email, String password) async {
    if (email.isEmpty || password.isEmpty) {
      Custom.customAlertBox(context, "Enter Required Fields");
    } else {
      try {
        UserCredential usercredential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(email: email, password: password);

        print("User logged in: ${usercredential.user?.uid}");
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const HomeScreen()),
        );
      } on FirebaseAuthException catch (ex) {
        Custom.customAlertBox(context, ex.code.toString());
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return GradientBackground(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar:AppBars.defaultAppBar(),
          body: Center(
          child: SingleChildScrollView(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                // Email login fields
                Custom.customTextField(
                  emailController,
                  "Email",
                  Icons.mail,
                  false,
                  TextInputType.emailAddress,
                ),
                const SizedBox(height: 20),
                Custom.customTextField(
                  passwordController,
                  "Password",
                  Icons.password,
                  true,
                  TextInputType.text,
                ),
                const SizedBox(height: 30),

                // Email login button
                Custom.customButton(
                  onPressed: () {
                    login(
                      emailController.text.trim(),
                      passwordController.text.trim(),
                    );
                  },
                  text: "Login with Email",
                ),

                const SizedBox(height: 20),

                // Divider
                const Row(
                  children: [
                    Expanded(child: Divider(thickness: 1, color: Colors.white54)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 8.0),
                      child: Text("OR", style: AppTextStyles.body),
                    ),
                    Expanded(child: Divider(thickness: 1, color: Colors.white54)),
                  ],
                ),

                const SizedBox(height: 20),

                // Phone Auth button
                Custom.customButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const PhoneAuth()),
                    );
                  },
                  text: "Login with Phone Number",
                ),

                const SizedBox(height: 30),

                // Sign up and forgot password links
                const Text("Don't have an account?", style: AppTextStyles.body),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(builder: (context) => const SignUp()),
                    );
                  },
                  child: const Text("Sign up", style: AppTextStyles.button),
                ),
                TextButton(
                  onPressed: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ForgetPassword()),
                    );
                  },
                  child: const Text(
                    "Forgot Password",
                    style: AppTextStyles.button,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
