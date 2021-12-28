import 'package:flutter/material.dart';
import 'package:webtest/src/utils/theme.dart';

class CancelButton extends StatelessWidget {
  const CancelButton({Key? key, required this.text, required this.onPressed})
      : super(key: key);

  final String text;
  final Function() onPressed;

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        onPressed();
      },
      style: ButtonStyle(
        backgroundColor: MaterialStateProperty.all(
          ThemeApp.cancelButtonColor,
        ),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 10,
          ),
        ),
        textStyle: MaterialStateProperty.all(
          const TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w600,
            color: Colors.black87,
          ),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
            side: BorderSide(
              color: ThemeApp.cancelButtonColor,
            ),
          ),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.black87,
        ),
      ),
    );
  }
}
