import 'package:firebase_task/Screens/phone_verification.dart';
import 'package:firebase_task/auth/signIn.dart';
import 'package:firebase_task/build_widgets.dart';
import 'package:firebase_task/utils/utilities.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';

class SignUp extends StatefulWidget {
  const SignUp({super.key});

  @override
  State<SignUp> createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  TextEditingController emailcontroller = TextEditingController();
  TextEditingController passwordcontroller = TextEditingController();
  TextEditingController conformpasswordcontroller = TextEditingController();
  bool Active = true;
  bool isActive = true;
  bool loading = false;
  FirebaseAuth auth = FirebaseAuth.instance;
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
              children: [
                SizedBox(
                  height: MediaQuery.of(context).size.height * .1,
                ),
                const CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 70,
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
                  "SignUp Below 👇",
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
                  validatr: (value) {
                    if (value == null || value.isEmpty) {
                      return "Enter Email";
                    } else if (!value.contains("@")) {
                      return "enter correct email";
                    } else {
                      return null;
                    }
                  },
                ),
                textformfield(
                  obsecure:
                      isActive == true ? isActive = false : isActive = true,
                  suffix: IconButton(
                      onPressed: () {
                        setState(() {});
                      },
                      icon: isActive == true
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
                const SizedBox(
                  height: 50,
                ),
                BuildButton(
                    loading: loading,
                    text: "Register",
                    ontap: () {
                      setState(() {
                        loading = true;
                      });
                      auth
                          .createUserWithEmailAndPassword(
                              email: emailcontroller.text.trim().toString(),
                              password:
                                  passwordcontroller.text.trim().toString())
                          .then((value) {
                        setState(() {
                          loading = false;
                        });
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => SignIn(),
                            ));
                        Utils()
                            .toastMessage("SignUp successfully", Colors.green);
                      }).onError((error, stackTrace) {
                        Utils().toastMessage("some error occurs", Colors.red);
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
                      "already have an account?",
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
                              builder: (context) => const SignIn(),
                            ));
                      },
                      child: const Text(
                        "Login",
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
