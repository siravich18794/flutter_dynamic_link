import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

class MyWidget extends StatefulWidget {
  const MyWidget({Key? key}) : super(key: key);

  @override
  State<MyWidget> createState() => _MyWidgetState();
}

class _MyWidgetState extends State<MyWidget> {
  final nameController = TextEditingController();
  final ageController = TextEditingController();
  final telController = TextEditingController();

  Future createUser(
      {required String name, required int age, required String tel}) async {
    final docUser = FirebaseFirestore.instance.collection('user-info').doc();

    final json = {'name': name, 'age': age, 'tel': tel};

    await docUser.set(json);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          padding: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          height: 100,
          child: TextField(
            controller: nameController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter your name',
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          height: 100,
          child: TextField(
            controller: ageController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter your age',
            ),
          ),
        ),
        Container(
          padding: EdgeInsets.all(10),
          width: MediaQuery.of(context).size.width,
          height: 100,
          child: TextField(
            controller: telController,
            decoration: InputDecoration(
              border: OutlineInputBorder(),
              hintText: 'Enter your phone number',
            ),
          ),
        ),
        Container(
          child: ElevatedButton(
            child: Text("Submit"),
            onPressed: () {
              createUser(
                  name: nameController.text,
                  age: int.parse(ageController.text),
                  tel: telController.text);

              showDialog(
                context: context,
                builder: (context) {
                  return AlertDialog(
                      // Retrieve the text the that user has entered by using the
                      // TextEditingController.
                      content: Text("Create User Successfully"));
                },
              );
            },
          ),
        )
        // Container(
        //     child: IconButton(
        //   icon: const Icon(
        //     Icons.copy,
        //     color: Colors.pink,
        //     size: 24.0,
        //     semanticLabel: 'Text to announce in accessibility modes',
        //   ),
        //   tooltip: 'Increase volume by 10',
        //   onPressed: () {
        //     setState(() {
        //       showDialog<String>(
        //           context: context,
        //           builder: (BuildContext context) {
        //             // _timer = Timer(Duration(seconds: 5), () {
        //             //   Navigator.of(context).pop();
        //             // });
        //             return AlertDialog(
        //               //title: const Text('AlertDialog Title'),
        //               content: const Text('Copy Successful'),
        //               actions: <Widget>[
        //                 TextButton(
        //                   onPressed: () => Navigator.pop(context, 'Cancel'),
        //                   child: const Text('Cancel'),
        //                 ),
        //                 TextButton(
        //                   onPressed: () => Navigator.pop(context, 'OK'),
        //                   child: const Text('OK'),
        //                 ),
        //               ],
        //             );
        //           });
        //     });
        //   },
        // )),
      ],
    );
  }
}
