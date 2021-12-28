import 'package:flutter/material.dart';
import 'package:simple_tags/simple_tags.dart';
import 'package:webtest/src/utils/utils.dart';

class AdhesivoAdd extends StatelessWidget {
  AdhesivoAdd({
    Key? key,
    required this.onPressed,
    required this.text,
  }) : super(key: key);

  final void Function()? onPressed;
  final String text;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 50,
        padding: const EdgeInsets.only(right: 5),
        decoration: BoxDecoration(
          border: Utils.borderApp,
        ),
        child: Center(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
        ),
      ),
    );
  }
}
