import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:sagar_new_project/Provider/count_provider.dart';
import 'package:sagar_new_project/UI/profilescreen.dart';
import 'package:provider/provider.dart';
  


  
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  print("🔹 Flutter binding initialized");

  await dotenv.load(fileName: ".env");
  print("🔹 .env loaded");
   // ✅ Load environment variables first
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
  print("🔹 runApp called"); // ✅ Launch app
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (_) => CountProvider(),
      child: const MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Flutter Demo',
        home: HomeScreen(),
      ),
    );
  }
}
