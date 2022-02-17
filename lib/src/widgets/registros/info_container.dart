import 'package:flutter/material.dart';
import 'package:webtest/src/utils/utils.dart';

class InfoContainer extends StatelessWidget {
  const InfoContainer({
    Key? key,
    required this.label,
    required this.value,
  }) : super(key: key);

  final String label;
  final String value;

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Container(
        height: 60,
        margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
        padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
        decoration: BoxDecoration(
          border: Utils.borderApp,
          color: Colors.grey[200],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              label,
              style: const TextStyle(fontSize: 14),
            ),
            if (value.isNotEmpty)
              Text(
                value,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                ),
              )
          ],
        ),
      ),
    );
  }

  static Widget titulo({required String label, required int flex}) {
    return Expanded(
      flex: flex,
      child: Container(
        height: 50,
        margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
        padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 2),
        decoration: BoxDecoration(
          border: Utils.borderApp,
          color: Colors.yellow[300],
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
                  fontSize: 18,
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

  static Widget bobinaTitulo({required String label}) {
    return Container(
      height: 60,
      width: 110,
      margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
        border: Utils.borderApp,
        color: Colors.grey[200],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  static Widget bobinaDetalle({required String nro, required String value}) {
    return Expanded(
      child: Container(
        height: 60,
        margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
        padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 2),
        decoration: BoxDecoration(
          border: Utils.borderApp,
          //color: Colors.grey[200],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              nro,
              style: const TextStyle(fontSize: 12),
            ),
            const Spacer(),
            Text(
              value,
              style: const TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }

  static Widget adhesivoTitulo({required String label}) {
    return Container(
      height: 40,
      width: 170,
      margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
      padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 2),
      decoration: BoxDecoration(
        border: Utils.borderApp,
        color: Colors.grey[200],
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style: const TextStyle(fontSize: 13, fontWeight: FontWeight.w600),
          ),
        ],
      ),
    );
  }

  static Widget adhesivoDetalle({required String value}) {
    return Expanded(
      child: Container(
        height: 40,
        margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
        padding: const EdgeInsets.symmetric(horizontal: 1, vertical: 2),
        decoration: BoxDecoration(
          border: Utils.borderApp,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Spacer(),
            Text(
              value,
              style: const TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
              ),
            ),
            const Spacer(),
          ],
        ),
      ),
    );
  }
}
