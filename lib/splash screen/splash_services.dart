import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_task/Screens/home%20screen/home.dart';
import 'package:firebase_task/auth/signIn.dart';
import 'package:flutter/material.dart';

class SplashServices {
  void islogin(context) {
    final auth = FirebaseAuth.instance;
    final user = auth.currentUser;
    if (user != null) {
      Timer(Duration(seconds: 3), () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomeScreen(),
            ));
      });
    } else {
      Timer(Duration(seconds: 3), () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SignIn(),
            ));
      });
    }
  }
}
