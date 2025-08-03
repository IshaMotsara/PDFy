
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:sagar_new_project/UI/login_page.dart';
import 'package:sagar_new_project/UI/profilescreen.dart';

class Checkuser extends StatefulWidget {
  const Checkuser({super.key});

  @override
  State<Checkuser> createState() => _CheckuserState();
}

class _CheckuserState extends State<Checkuser> {
  @override
  void initState() {
    super.initState();
    _checkUser();
  }

  void _checkUser() async {
    final user = FirebaseAuth.instance.currentUser;
    print('Current user: $user');

    // Wait until the first frame is rendered before navigating
    WidgetsBinding.instance.addPostFrameCallback((_) {
      if (user != null) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => HomeScreen()),
        );
      } else {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginPage()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    // Show a loading indicator while checking
    return const Scaffold(
      body: Center(child: CircularProgressIndicator()),
    );
  }
}
