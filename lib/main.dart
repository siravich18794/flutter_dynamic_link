import 'dart:async';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uni_link/components/firebase_dynamic_link.dart';
import 'package:uni_link/temp/about_page.dart';
import 'package:uni_link/temp/contact_page.dart';
import 'package:uni_link/page/product_page.dart';
import 'package:uni_link/temp/user_list_page.dart';
import 'package:url_launcher/url_launcher.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // iOS requires you run in release mode to test dynamic links ("flutter run --release").
  await Firebase.initializeApp();

  runApp(
    MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Dynamic Links',
        routes: <String, WidgetBuilder>{
          '/': (BuildContext context) => _MainScreen(),
          '/men-page': (BuildContext context) => ProductPage(
                pageName: 'Men Page',
              ),
          '/women-page': (BuildContext context) => ProductPage(
                pageName: 'Women Page',
              ),
          '/children-page': (BuildContext context) => ProductPage(
                pageName: 'Children Page',
              ),
        }),
  );
}

class _MainScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _MainScreenState();
}

class _MainScreenState extends State<_MainScreen> {
  @override
  void initState() {
    super.initState();
    FirebaseDynamicLinkServices.initDynamicLinks(context);
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Dynamic Links'),
        ),
        body: Builder(
          builder: (BuildContext context) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  ButtonBar(
                    alignment: MainAxisAlignment.center,
                    children: <Widget>[
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProductPage(
                                        pageName: 'Men Page',
                                      )));
                        },
                        child: const Text('Go to MenPage'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProductPage(
                                        pageName: 'Women Page',
                                      )));
                        },
                        child: const Text('Go to WomenPage'),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ProductPage(
                                        pageName: 'Children Page',
                                      )));
                        },
                        child: const Text('Go to ChildrenPage'),
                      ),
                    ],
                  ),
                  // InkWell(
                  //   onTap: () async {
                  //     if (_linkMessage != null) {
                  //       await launchUrl(Uri.parse(_linkMessage!));
                  //     }
                  //   },
                  //   onLongPress: () {
                  //     Clipboard.setData(ClipboardData(text: _linkMessage));
                  //     ScaffoldMessenger.of(context).showSnackBar(
                  //       const SnackBar(content: Text('Copied Link!')),
                  //     );
                  //   },
                  //   child: Text(
                  //     _linkMessage ?? '',
                  //     style: const TextStyle(color: Colors.blue),
                  //   ),
                  // ),
                  //Text(_linkMessage == null ? '' : _testString)
                ],
              ),
            );
          },
        ),
      ),
    );
  }
}
