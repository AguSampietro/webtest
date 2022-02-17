import 'package:flutter/material.dart';
import 'package:simple_tags/simple_tags.dart';
import 'package:webtest/src/utils/utils.dart';

class ControlesRow extends StatelessWidget {
  ControlesRow({
    Key? key,
    required this.onPressed1,
    required this.onPressed2,
    required this.label,
    required this.nro1,
    required this.nro2,
  }) : super(key: key);

  final void Function()? onPressed1;
  final void Function()? onPressed2;
  final String label;
  final String nro1;
  final String nro2;

  @override
  Widget build(BuildContext context) {
    //final double altoCelda = 45.0;
    return Container(
      padding: const EdgeInsets.only(
        left: 1,
        right: 1,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 2,
            child: Container(
              height: Utils.cellHeight,
              padding: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                border: Utils.borderApp,
                color: Colors.yellow[100],
              ),
              child: Center(
                child: Text(
                  label,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: onPressed1,
              child: Container(
                height: Utils.cellHeight,
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                decoration: BoxDecoration(
                  border: Utils.borderApp,
                ),
                child: Center(child: Text(nro1)),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: InkWell(
              onTap: onPressed2,
              child: Container(
                height: Utils.cellHeight,
                padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
                decoration: BoxDecoration(
                  border: Utils.borderApp,
                ),
                child: Center(child: Text(nro2)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
