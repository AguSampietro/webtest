import 'package:flutter/material.dart';
import 'package:webtest/src/utils/theme.dart';

class FinishButton extends StatelessWidget {
  const FinishButton({Key? key, required this.text, required this.onPressed})
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
          ThemeApp.finishButtonColor,
        ),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(
            horizontal: 30,
            vertical: 12,
          ),
        ),
        textStyle: MaterialStateProperty.all(
          const TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(5.0),
            side: BorderSide(
              color: ThemeApp.finishButtonColor,
            ),
          ),
        ),
      ),
      child: Text(text),
    );
  }
}
