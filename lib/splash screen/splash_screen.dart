import 'dart:async';

import 'package:firebase_task/auth/signIn.dart';
import 'package:firebase_task/splash%20screen/splash_services.dart';
import 'package:flutter/material.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState
    SplashServices().islogin(context);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Row(),
          Image.asset(
            "images/tree.png",
            height: MediaQuery.of(context).size.height * .3,
            width: MediaQuery.of(context).size.width * .4,
          ),
          const Text(
            "Welcome for\n Visiting!!!",
            style: TextStyle(
                color: Colors.green, fontWeight: FontWeight.w600, fontSize: 18),
          ),
        ],
      ),
    );
  }
}
