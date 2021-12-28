import 'package:flutter/material.dart';
import 'package:webtest/src/utils/utils.dart';

class ContadorCard extends StatelessWidget {
  ContadorCard({
    Key? key,
    required this.onPressed,
    required this.value,
    required this.label,
  }) : super(key: key);

  final void Function()? onPressed;
  final String value;
  final String label;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: onPressed,
        child: Container(
          margin: const EdgeInsets.symmetric(horizontal: 5, vertical: 5),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(0),
            color: Colors.orange[100],
            border: Utils.borderApp,
          ),
          child: Row(
            children: [
              Text(
                label,
                style: const TextStyle(
                  fontSize: 16,
                ),
              ),
              Text(
                value.isEmpty ? '' : value,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
