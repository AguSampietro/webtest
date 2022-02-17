import 'package:flutter/material.dart';
import 'package:webtest/src/utils/theme.dart';

class DeleteButton extends StatelessWidget {
  const DeleteButton({Key? key, required this.text, required this.onPressed})
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
          ThemeApp.deleteButtonColor,
        ),
        padding: MaterialStateProperty.all(
          const EdgeInsets.symmetric(
            horizontal: 15,
            vertical: 20,
          ),
        ),
        textStyle: MaterialStateProperty.all(
          const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        shape: MaterialStateProperty.all<RoundedRectangleBorder>(
          RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(0.0),
            side: BorderSide(
              color: ThemeApp.deleteButtonColor,
            ),
          ),
        ),
      ),
      child: Text(
        text,
        style: TextStyle(
          color: Colors.white,
        ),
      ),
    );
  }
}
