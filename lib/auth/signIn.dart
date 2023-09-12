import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_task/Screens/phone_verification.dart';
import 'package:firebase_task/auth/SignUp.dart';
import 'package:firebase_task/Screens/home%20screen/home.dart';
import 'package:firebase_task/utils/utilities.dart';
import 'package:flutter/material.dart';

import '../../build_widgets.dart';

class SignIn extends StatefulWidget {
  const SignIn({super.key});

  @override
  State<SignIn> createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  bool active = true;
  FirebaseAuth auth = FirebaseAuth.instance;
  bool loading = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .1,
                ),
                const CircleAvatar(
                  radius: 70,
                  backgroundColor: Colors.white,
                  child: Icon(
                    Icons.person_2,
                    color: Color.fromARGB(255, 19, 160, 216),
                    size: 100,
                  ),
                ),
                SizedBox(
                  height: 15,
                ),
                const Text(
                  "Login Below 👇",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.w600,
                      fontSize: 18),
                ),
                const SizedBox(
                  height: 24,
                ),
                textformfield(
                  hint: "Email",
                  prefix: const Icon(
                    Icons.email,
                    color: Color.fromARGB(255, 19, 160, 216),
                  ),
                  textcontroller: emailcontroller,
                ),
                textformfield(
                  obsecure: active == true ? active = false : active = true,
                  suffix: IconButton(
                      onPressed: () {
                        setState(() {});
                      },
                      icon: active == true
                          ? const Icon(
                              Icons.visibility_off,
                              color: Color.fromARGB(255, 19, 160, 216),
                            )
                          : const Icon(
                              Icons.visibility,
                              color: Color.fromARGB(255, 19, 160, 216),
                            )),
                  hint: "Password",
                  textcontroller: passwordcontroller,
                  prefix: Icon(
                    Icons.lock,
                    color: Color.fromARGB(255, 19, 160, 216),
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                TextButton(
                    onPressed: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => PhoneVerification(),
                          ));
                    },
                    child: Text(
                      "Verify with phone number!",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                    )),
                const SizedBox(
                  height: 20,
                ),
                BuildButton(
                    text: "LogIn",
                    loading: loading,
                    ontap: () {
                      setState(() {
                        loading = true;
                      });
                      auth
                          .signInWithEmailAndPassword(
                              email: emailcontroller.text.trim().toString(),
                              password:
                                  passwordcontroller.text.trim().toString())
                          .then((value) {
                        setState(() {
                          loading = false;
                        });
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) => HomeScreen(),
                            ));
                        Utils()
                            .toastMessage("Login succesfully!", Colors.green);
                      }).onError((error, stackTrace) {
                        Utils().toastMessage(error.toString(), Colors.red);

                        setState(() {
                          loading = false;
                        });
                      });
                    },
                    width: MediaQuery.of(context).size.width * .7),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      "Don't have an account?",
                      style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.w600,
                          fontSize: 16),
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const SignUp(),
                            ));
                      },
                      child: const Text(
                        "SignUp",
                        style: TextStyle(
                            color: Color.fromARGB(255, 19, 160, 216),
                            fontWeight: FontWeight.w600,
                            fontSize: 16),
                      ),
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
