import 'package:flutter/material.dart';
import 'package:webtest/src/utils/utils.dart';

class InfoGrid extends StatelessWidget {
  const InfoGrid({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Container();
  }

  static Widget cell({required String label, required int flex}) {
    return Expanded(
      flex: flex,
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
        decoration: BoxDecoration(
          border: Utils.borderApp,
          color: Colors.grey[200],
        ),
        child: Row(
          children: [
            Spacer(),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
              child: Text(
                label,
                textAlign: TextAlign.center,
                style: const TextStyle(
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Spacer(),
          ],
        ),
      ),
    );
  }

  static Widget head({required String label, required int flex}) {
    return Expanded(
      flex: flex,
      child: Container(
        height: 50,
        padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
        decoration: BoxDecoration(
          border: Utils.borderApp,
          color: Colors.yellow[300],
        ),
        child: Center(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 2, vertical: 2),
            child: Text(
              label,
              textAlign: TextAlign.center,
              style: const TextStyle(fontWeight: FontWeight.w600),
            ),
          ),
        ),
      ),
    );
  }
}
