import 'package:flutter/material.dart';
import 'package:simple_tags/simple_tags.dart';
import 'package:webtest/src/utils/utils.dart';

class BobinaLabel extends StatelessWidget {
  BobinaLabel({
    Key? key,
    required this.text,
  }) : super(key: key);

  final String text;

  @override
  Widget build(BuildContext context) {
    return Container(
      // margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      height: 50,
      decoration: BoxDecoration(
        border: Utils.borderApp,
        color: Colors.yellow[100],
      ),
      child: Row(
        children: [
          Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ],
      ),
    );
  }
}
