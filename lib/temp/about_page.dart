import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:uni_link/constants/category_enum.dart';

import '../components/firebase_dynamic_link.dart';

class AboutPage extends StatelessWidget {
  const AboutPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
          appBar: AppBar(
            title: const Text('About Page'),
          ),
          body: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                'About Page',
                style: TextStyle(fontSize: 30, fontWeight: FontWeight.bold),
              ),
              Container(
                child: ElevatedButton(
                  onPressed: () =>
                      FirebaseDynamicLinkServices.createDynamicLink(
                          true, 'about-page', Category.shirt.name),
                  child: const Text('Copy Link For AboutPage'),
                ),
              ),
            ],
          ))),
    );
  }
}
