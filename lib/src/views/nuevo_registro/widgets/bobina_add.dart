import 'package:flutter/material.dart';
import 'package:webtest/src/models/bobina.dart';
import 'package:webtest/src/utils/utils.dart';

class BobinaAdd extends StatelessWidget {
  BobinaAdd({
    Key? key,
    required this.onPressed,
    required this.bobina,
    required this.nro,
  }) : super(key: key);

  final void Function()? onPressed;
  final Bobina bobina;
  final String nro;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Container(
        height: 50,
        padding: const EdgeInsets.only(right: 5),
        decoration: BoxDecoration(
          border: Utils.borderApp,
          //color: Colors.yellow[100],
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              margin: const EdgeInsets.only(left: 2, top: 2),
              child: Text(
                nro,
                style: const TextStyle(
                  fontSize: 11,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
            Center(
              child: Text(
                bobina.nombre!,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
