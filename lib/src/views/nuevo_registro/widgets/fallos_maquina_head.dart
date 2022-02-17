import 'package:flutter/material.dart';
import 'package:simple_tags/simple_tags.dart';
import 'package:webtest/src/utils/utils.dart';

class FallosMaquinaHead extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 1,
        right: 1,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Container(
              height: Utils.cellHeight,
              padding: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                border: Utils.borderApp,
                color: Colors.yellow[100],
              ),
              child: const Center(
                child: Text(
                  'FALLO',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Container(
              height: Utils.cellHeight,
              padding: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                border: Utils.borderApp,
                color: Colors.yellow[100],
              ),
              child: const Center(
                child: Text(
                  'TIEMPO',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              height: Utils.cellHeight,
              padding: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                border: Utils.borderApp,
                color: Colors.yellow[100],
              ),
              child: const Center(
                child: Text(
                  'OBSERVACIONES',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 1,
            child: Container(
              height: Utils.cellHeight,
              padding: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                border: Utils.borderApp,
                color: Colors.yellow[100],
              ),
              child: const Center(
                child: Text(
                  '*',
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
