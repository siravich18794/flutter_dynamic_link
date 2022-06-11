import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';

import '../constants/category_enum.dart';

class CategoryTag extends StatelessWidget {
  final String tag;

  const CategoryTag({Key? key, required this.tag}) : super(key: key);

  Text getTag(String tag) {
    switch (tag) {
      case 'shirt':
        return Text('Shirt', style: TextStyle(color: Colors.white));
      case 'shoes':
        return Text('Shoes', style: TextStyle(color: Colors.white));
      case 'pants':
        return Text('Pants', style: TextStyle(color: Colors.white));
      default:
        return Text('Other', style: TextStyle(color: Colors.white));
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Icon(
          Icons.category_rounded,
          size: 20,
          color: Colors.blue,
        ),
        SizedBox(
          width: 5,
        ),
        Container(
          padding: EdgeInsets.all(5),
          decoration: BoxDecoration(
            color: Colors.blueAccent,
            borderRadius: BorderRadius.circular(5),
          ),
          child: getTag(tag),
        ),
      ],
    );
  }
}
