import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:uni_link/components/firebase_dynamic_link.dart';
import 'package:uni_link/constants/category_enum.dart';
import 'package:uni_link/temp/user_card.dart';

class UserPage extends StatelessWidget {
  const UserPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
        child: Scaffold(
            appBar: AppBar(
              title: const Text('User List'),
            ),
            body: Center(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  'User Page',
                  style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
                ),
                Container(
                  child: ElevatedButton(
                    onPressed: () =>
                        FirebaseDynamicLinkServices.createDynamicLink(
                            true, 'user-page', Category.pants.name),
                    child: const Text('Copy Link For UserPage'),
                  ),
                ),
              ],
            ))));
  }
}
