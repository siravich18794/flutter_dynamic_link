// ignore_for_file: avoid_print

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:uni_link/constants/category_enum.dart';
import 'package:uni_link/page/product_page.dart';

class FirebaseDynamicLinkServices {
  // when an app opens =>
  static Future<void> initDynamicLinks(BuildContext context) async {
    print('Init Dynamic Link +++');
    FirebaseDynamicLinks.instance.onLink
        .listen((PendingDynamicLinkData dynamicLinkData) {
      print("Pending Dynamic Link : ${dynamicLinkData.link}");
      print("Pending Dynamic Link Path : ${dynamicLinkData.link.path}");
      print(
          "Pending Dynamic Link Path : ${dynamicLinkData.link.queryParameters['category']}");

      //Navigator.pushNamed(context, dynamicLinkData.link.path);

      Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => ProductPage(
                    pageName: 'Men Page',
                    category: dynamicLinkData.link.queryParameters['category'],
                  )));
    }).onError((error) {
      print('onLink error');
      print(error.message);
    });

    // final PendingDynamicLinkData data =
    //     await FirebaseDynamicLinks.instance.getInitialLink();
  }

  static Future<void> createDynamicLink(
      bool short, String page, String category) async {
    if (page == "home-page") page = "";

    String dynamicLink = 'https://siravich.page.link';
    String link = '$dynamicLink/$page?category=$category';

    print(link);
    final DynamicLinkParameters parameters = DynamicLinkParameters(
      uriPrefix: dynamicLink,
      link: Uri.parse(link),
      androidParameters: const AndroidParameters(
        packageName: 'com.example.uni_link',
        minimumVersion: 0,
      ),
      iosParameters: IOSParameters(
        fallbackUrl: Uri.parse(dynamicLink),
        bundleId: 'com.example.uniLink',
        appStoreId: '123456789',
        minimumVersion: '1.0.1',
      ),
    );

    Uri url;
    if (short) {
      final ShortDynamicLink shortLink =
          await FirebaseDynamicLinks.instance.buildShortLink(parameters);
      url = shortLink.shortUrl;
    } else {
      url = await FirebaseDynamicLinks.instance.buildLink(parameters);
    }

    print('Dynamic Link : $url');
  }
}
