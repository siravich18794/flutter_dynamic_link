// ignore_for_file: avoid_print

import 'package:firebase_dynamic_links/firebase_dynamic_links.dart';
import 'package:flutter/material.dart';
import 'package:uni_link/constants/category_enum.dart';
import 'package:uni_link/data/product_data.dart';
import 'package:uni_link/page/product_detail_page.dart';
import 'package:uni_link/page/product_page.dart';

class FirebaseDynamicLinkServices {
  static String capitalizeLetter(String letter) {
    return '${letter[0].toUpperCase()}${letter.substring(1)}';
  }

  // Handling when the app is opened
  static Future<void> initDynamicLinks(BuildContext context) async {
    print('Init Dynamic Link +++');

    // When the app terminates => Retrieve initial link
    final PendingDynamicLinkData? initialLink =
        await FirebaseDynamicLinks.instance.getInitialLink();

    if (initialLink != null) {
      handleDynamicLink(context, initialLink);
    }

    // When the app runs in background
    FirebaseDynamicLinks.instance.onLink
        .listen((PendingDynamicLinkData dynamicLinkData) {
      print("Pending Dynamic Link : ${dynamicLinkData.link}");
      print("Pending Dynamic Link Path : ${dynamicLinkData.link.path}");
      print(
          "Pending Dynamic Link Path : ${dynamicLinkData.link.queryParameters['category']}");

      handleDynamicLink(context, dynamicLinkData);
    }).onError((error) {
      print('onLink error');
      print(error.message);
    });
  }

  static void handleDynamicLink(
      BuildContext context, PendingDynamicLinkData dynamicLinkData) {
    Widget pageResult;

    if (dynamicLinkData.link.queryParameters['category'] != null &&
        dynamicLinkData.link.queryParameters['productId'] != null) {
      var specificProduct = ProductData.productList.firstWhere((element) =>
          element['id'] == dynamicLinkData.link.queryParameters['productId']);
      pageResult = ProductDetailPage(
        productName: specificProduct['name'],
        price: specificProduct['price'],
        imageUrl: specificProduct['imageUrl'],
        productId: specificProduct['id'],
        category: specificProduct['category'],
      );
    } else if (dynamicLinkData.link.queryParameters['category'] != null) {
      pageResult = ProductPage(
        pageName: dynamicLinkData.link.path
            .substring(1)
            .split('-')
            .map((e) => capitalizeLetter(e))
            .join(' '),
        category: dynamicLinkData.link.queryParameters['category'],
      );
    } else {
      pageResult = ProductPage(
        pageName: dynamicLinkData.link.path
            .substring(1)
            .split('-')
            .map((e) => capitalizeLetter(e))
            .join(' '),
      );
    }

    Navigator.push(
        context, MaterialPageRoute(builder: (context) => pageResult));
  }

  static Future<void> createDynamicLink(bool short, String page,
      [String? category, String? productId]) async {
    if (page == "home-page") page = "";

    String dynamicLink = 'https://siravich.page.link';

    String link;

    if (category != null && productId != null) {
      link = '$dynamicLink/$page?category=$category&productId=$productId';
    } else if (category != null) {
      link = '$dynamicLink/$page?category=$category';
    } else {
      link = '$dynamicLink/$page';
    }

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
