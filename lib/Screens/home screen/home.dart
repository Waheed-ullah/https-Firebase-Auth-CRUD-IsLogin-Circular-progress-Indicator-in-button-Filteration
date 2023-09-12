import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:firebase_task/Screens/home%20screen/post_screen.dart';
import 'package:firebase_task/auth/signIn.dart';
import 'package:firebase_task/build_widgets.dart';
import 'package:firebase_task/utils/utilities.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FirebaseAuth auth = FirebaseAuth.instance;
  var controller = TextEditingController();
  //to get data , key will be same as in post
  final ref = FirebaseDatabase.instance.ref("Post");
  var filtercontroller = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: const Color.fromARGB(255, 19, 160, 216),
        title: const Text("Home Screen"),
        centerTitle: true,
        actions: [
          IconButton(
              onPressed: () {
                auth.signOut().then((value) {
                  Utils().toastMessage("Logout successfully", Colors.green);
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const SignIn(),
                      ));
                }).onError((error, stackTrace) {
                  Utils().toastMessage("Logout failed", Colors.red);
                });
              },
              icon: const Icon(
                Icons.logout,
              ))
        ],
      ),
      //getting data by FirebaseAnimatedBuilder and StreamBuilder
      body: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
        const SizedBox(
          height: 30,
        ),
        const Text(
          "Welcome to\nHome Screen",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
        ),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10),
          child: textformfield(
            textcontroller: filtercontroller,
            hint: "Search",
            prefix: const Icon(
              Icons.search,
            ),
            onchange: (value) {
              setState(() {});
            },
          ),
        ),
        const SizedBox(
          height: 30,
        ),

// get data from firebase through FirebaseAnimatedBuilder
        Expanded(
          child: FirebaseAnimatedList(
            defaultChild: const Text(
              "loading...",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            query: ref,
            itemBuilder: (context, snapshot, animation, index) {
              var title = snapshot.child("title").value.toString();
              if (filtercontroller.text.isEmpty) {
                return ListTile(
                  title: Text(snapshot.child("title").value.toString()),
                  subtitle:
                      Text(snapshot.child("description").value.toString()),
                  trailing: PopupMenuButton(
                    icon: const Icon(
                      Icons.more_vert,
                    ),
                    itemBuilder: (context) {
                      return [
                        PopupMenuItem(
                            value: 1,
                            child: ListTile(
                              onTap: () {
                                Navigator.pop(context);
                                showMyDiolog(
                                    title,
                                    snapshot
                                        .child("description")
                                        .value
                                        .toString());
                              },
                              trailing: const Text("Edit"),
                              title: const Icon(
                                Icons.edit,
                              ),
                            )),
                        PopupMenuItem(
                            value: 2,
                            onTap: () {},
                            child: ListTile(
                              onTap: () {
                                Navigator.pop(context);
                                ref
                                    .child(snapshot
                                        .child("description")
                                        .value
                                        .toString())
                                    .remove()
                                    .then((value) {
                                  Utils().toastMessage(
                                      "Delete successfully", Colors.green);
                                }).onError((error, stackTrace) {
                                  Utils().toastMessage(
                                      error as String, Colors.red);
                                });
                              },
                              trailing: const Text("Delete"),
                              title: const Icon(
                                Icons.delete,
                              ),
                            ))
                      ];
                    },
                  ),
                );
              } else if (title
                  .toLowerCase()
                  .contains(filtercontroller.text.toLowerCase())) {
                return ListTile(
                  title: Text(snapshot.child("title").value.toString()),
                  subtitle:
                      Text(snapshot.child("description").value.toString()),
                );
              } else {
                return Container();
              }
            },
          ),
        ),

        // Expanded(
        //   child: StreamBuilder(
        //     stream: ref.onValue,
        //     builder: (context, AsyncSnapshot<DatabaseEvent> snapshot) {
        //       if (!snapshot.hasData) {
        //         return const Center(child: CircularProgressIndicator());
        //       } else if (snapshot.hasData) {
        //         Map<dynamic, dynamic> map =
        //             snapshot.data!.snapshot.value as dynamic;
        //         List<dynamic> list = [];
        //         list.clear();
        //         list = map.values.toList();

        //         return ListView.builder(
        //             itemCount: snapshot.data!.snapshot.children.length,
        //             itemBuilder: (context, index) {
        //               return ListTile(
        //                 title: Text(list[index]["title"]),
        //                 subtitle: Text(list[index]["description"]),
        //               );
        //             });
        //       } else {
        //         return const Text("some thing went wrong");
        //       }
        //     },
        //   ),
      ]),

      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color.fromARGB(255, 19, 160, 216),
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const PostScreen(),
              ));
        },
        child: const Center(child: Text("post")),
      ),
    );
  }

  showMyDiolog(String title, id) async {
    controller.text = title;
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text(
            "Update Data",
          ),
          content: textformfield(
            textcontroller: controller,
            hint: "Edit here",
          ),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                child: const Text("Cancel")),
            TextButton(
                onPressed: () {
                  ref
                      .child(id)
                      .update({"title": controller.text}).then((value) {
                    Navigator.pop(context);
                    Utils().toastMessage("update successfully", Colors.green);
                  }).onError((error, stackTrace) {
                    Utils().toastMessage(error as String, Colors.red);
                  });
                },
                child: const Text("Update"))
          ],
        );
      },
    );
  }
}
