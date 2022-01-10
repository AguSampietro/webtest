import 'package:flutter/material.dart';

class LoadingSpinner extends StatelessWidget {
  final Color? color;
  final String? text;
  final double? height;
  LoadingSpinner({this.color, this.text, this.height});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Center(
          child: CircularProgressIndicator(
            valueColor: new AlwaysStoppedAnimation<Color>(color!),
          ),
        ),
        Align(
          alignment: FractionalOffset.center,
          child: Text(
            '${this.text}',
            style: TextStyle(
              fontSize: 15,
              fontWeight: FontWeight.w300,
              color: this.color,
            ),
          ),
          heightFactor: this.height,
        )
      ],
    );
  }
}
