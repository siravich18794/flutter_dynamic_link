import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:uni_link/constants/category_enum.dart';

import '../components/firebase_dynamic_link.dart';

class ContactPage extends StatelessWidget {
  const ContactPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
          appBar: AppBar(
            title: const Text('Contact Page'),
          ),
          body: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'Contact Page',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Container(
                child: ElevatedButton(
                  onPressed: () =>
                      FirebaseDynamicLinkServices.createDynamicLink(
                          false, 'contact-page', Category.shirt.name),
                  child: const Text('Copy Link For ContactPage'),
                ),
              ),
            ],
          ))),
    );
  }
}
