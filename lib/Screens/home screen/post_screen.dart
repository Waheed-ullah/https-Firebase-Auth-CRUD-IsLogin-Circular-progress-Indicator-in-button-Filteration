import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_task/build_widgets.dart';
import 'package:firebase_task/utils/utilities.dart';
import 'package:flutter/material.dart';

class PostScreen extends StatefulWidget {
  const PostScreen({super.key});

  @override
  State<PostScreen> createState() => _PostScreenState();
}

class _PostScreenState extends State<PostScreen> {
  TextEditingController textcontroller = TextEditingController();
  bool loading = false;
  final firebaseRef = FirebaseDatabase.instance.ref("Post");
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 19, 160, 216),
        title: const Text("Post Screen"),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30,
            ),
            const Text(
              "Write Post here!",
              textAlign: TextAlign.center,
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            const SizedBox(
              height: 30,
            ),
            textformfield(
              maxlines: 3,
              textcontroller: textcontroller,
              hint: "Write your post",
              // prefix: Icon(
              //   Icons.post_add,
              //   color: Color.fromARGB(255, 19, 160, 216),
              // ),
            ),
            const SizedBox(
              height: 20,
            ),
            BuildButton(
                text: "Post",
                loading: loading,
                ontap: () {
                  setState(() {
                    loading = true;
                  });
                  var id = DateTime.now().microsecondsSinceEpoch.toString();
                  firebaseRef.child(id).set({
                    "title": textcontroller.text.toString(),
                    "description": id
                  }).then((value) {
                    setState(() {
                      loading = false;
                    });
                    Utils().toastMessage("Post succesfully", Colors.green);
                    Navigator.pop(context);
                  }).onError((error, stackTrace) {
                    setState(() {
                      loading = false;
                    });
                    Utils().toastMessage("something went wrong", Colors.red);
                  });
                },
                width: double.infinity)
          ],
        ),
      ),
    );
  }
}
