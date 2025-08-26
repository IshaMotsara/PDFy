import 'package:PDFY/viewmodels/media_processing_view_model.dart';
import 'package:PDFY/views/login_page_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:provider/provider.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  print("🔹 Flutter binding initialized");

  await dotenv.load(fileName: ".env");
  print("🔹 .env loaded");

  await Firebase.initializeApp(
    name: "Sagar",
    options: const FirebaseOptions(
      apiKey: "AIzaSyCTGQq_9RE_rqHuMl9YHhgO_0_pCIq81cQ",
      appId: "1:264220127924:android:007f4736efbc6d57111de1",
      messagingSenderId: "264220127924",
      projectId: "fir-tutorial1-d64ad",
    ),
  );
  print("🔹 Firebase initialized");

  runApp(const MyApp());
  print("🔹 runApp called");
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CountProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        theme: ThemeData(
          scaffoldBackgroundColor: Colors.white,
          primaryColor: const Color(0xFF3B82F6), // Sky Blue
          colorScheme: ColorScheme.fromSeed(
            seedColor: const Color(0xFF3B82F6),
            primary: const Color(0xFF3B82F6),
            secondary: const Color(0xFF6B7280),
            background: Colors.white,
          ),
          textTheme: const TextTheme(
            bodyLarge: TextStyle(color: Color(0xFF111827)),
            bodyMedium: TextStyle(color: Color(0xFF6B7280)),
            titleLarge: TextStyle(
              color: Color(0xFF111827),
              fontSize: 22,
              fontWeight: FontWeight.bold,
            ),
          ),
          inputDecorationTheme: const InputDecorationTheme(
            filled: true,
            fillColor: Colors.white,
            hintStyle: const TextStyle(color: Color(0xFF6B7280)),
            border: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(14)),
              borderSide: BorderSide(color: Color(0xFFE5E7EB)),
            ),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.all(Radius.circular(14)),
              borderSide: BorderSide(color: Color(0xFF3B82F6)),
            ),
          ),
          elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFF3B82F6),
              foregroundColor: Colors.white,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(14),
              ),
              padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 20),
              elevation: 2,
            ),
          ),
          textButtonTheme: TextButtonThemeData(
            style: TextButton.styleFrom(
              foregroundColor: const Color(0xFF6B7280),
            ),
          ),
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            elevation: 0,
            iconTheme: IconThemeData(color: Color(0xFF3B82F6)),
            titleTextStyle: TextStyle(
              color: Color(0xFF111827),
              fontSize: 20,
              fontWeight: FontWeight.w600,
            ),
          ),
        ),
        home: const LoginPage(),
      ),
    );
  }
}

