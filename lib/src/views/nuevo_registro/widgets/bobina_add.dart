import 'package:flutter/material.dart';
import 'package:webtest/src/models/bobina.dart';
import 'package:webtest/src/utils/utils.dart';

class BobinaAdd extends StatelessWidget {
  BobinaAdd({
    Key? key,
    required this.onPressed,
    required this.bobina,
    required this.nro,
    required this.onChecked,
  }) : super(key: key);

  final void Function()? onPressed;
  final void Function(bool?)? onChecked;
  final Bobina bobina;
  final String nro;

  @override
  Widget build(BuildContext context) {
    bool selected = bobina.checked ?? false;

    return InkWell(
      onTap: onPressed,
      child: Container(
        height: Utils.cellHeight,
        padding: const EdgeInsets.only(right: 5),
        decoration: BoxDecoration(
          border: Utils.borderApp,
          //color: Colors.yellow[100],
        ),
        child: Row(
          children: [
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: const EdgeInsets.only(left: 1, top: 1),
                    child: Text(
                      nro,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Colors.black,
                      ),
                    ),
                  ),
                  Center(
                    child: Text(
                      bobina.nroSerie ?? '',
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w500,
                        color: Colors.black,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              width: 30,
              height: 30,
              child: Checkbox(
                value: selected,
                checkColor: Colors.white,
                fillColor: MaterialStateProperty.all(
                  selected ? Colors.green.shade500 : Colors.grey,
                ),
                shape: CircleBorder(),
                onChanged: onChecked,
              ),
            )
          ],
        ),
      ),
    );
  }
}
