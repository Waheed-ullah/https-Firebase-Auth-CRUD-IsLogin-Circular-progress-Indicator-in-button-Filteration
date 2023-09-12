import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_task/Screens/phone_verification.dart';
import 'package:firebase_task/auth/signIn.dart';
import 'package:firebase_task/splash%20screen/splash_screen.dart';
import 'package:flutter/material.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
        debugShowCheckedModeBanner: false, home: SplashScreen());
  }
}
