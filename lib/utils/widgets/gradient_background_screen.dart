import 'package:flutter/material.dart';

/// 🌈 Minimal, reusable gradient background for all screens
class GradientBackground extends StatelessWidget {
  final Widget child;
  const GradientBackground({super.key, required this.child});

  @override
  Widget build(BuildContext context) {


    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            Color.fromARGB(255, 131, 149, 207), // very light sky blue
            Color.fromARGB(255, 142, 88, 181),      // pure white base
          ],
        ),
      ),
      child: child,
    );
  }
}
