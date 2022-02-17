import 'package:flutter/material.dart';
import 'package:simple_tags/simple_tags.dart';
import 'package:webtest/src/models/fallo_maquina_model.dart';
import 'package:webtest/src/utils/utils.dart';

class FallosDetail extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container();
  }

  static Widget header(BuildContext context) {
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
        ],
      ),
    );
  }

  static Widget list({
    required BuildContext context,
    required List<FalloMaquina> fallos,
  }) {
    if (fallos.length == 0) {
      return Container(
        height: 450,
        child: const Padding(
          padding: EdgeInsets.all(15.0),
          child: Center(
            child: Text('No hay fallos cargados'),
          ),
        ),
      );
    }
    return Container(
      height: 450,
      child: ListView.builder(
        itemCount: fallos.length,
        shrinkWrap: true,
        itemBuilder: (context, index) {
          FalloMaquina fallo = fallos[index];
          return row(context: context, fallo: fallos[index]);
        },
      ),
    );
  }

  static Widget row({
    required BuildContext context,
    required FalloMaquina fallo,
  }) {
    return Container(
      padding: const EdgeInsets.only(
        left: 1,
        right: 1,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Expanded(
            flex: 4,
            child: Container(
              height: Utils.cellHeight,
              padding: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                border: Utils.borderApp,
              ),
              child: Center(
                child: Text(
                  fallo.codigo! + ' - ' + fallo.fallo!,
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w500,
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
              ),
              child: Center(
                child: Text(
                  fallo.tiempo!.toString() + '\'',
                  textAlign: TextAlign.center,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black,
                  ),
                ),
              ),
            ),
          ),
          Expanded(
            flex: 5,
            child: Container(
              //height: altoCelda,
              constraints: BoxConstraints(
                minHeight: Utils.cellHeight,
              ),
              padding: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                border: Utils.borderApp,
              ),
              child: Center(
                child: Text(
                  fallo.observaciones!,
                  textAlign: TextAlign.start,
                  style: const TextStyle(
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

  static Widget hours({
    required BuildContext context,
    required List<FalloMaquina> fallos,
  }) {
    int? minutos = 0;
    int? horasMin = 480;

    if (fallos.length > 0) {
      minutos = fallos.map((fallo) => fallo.tiempo).reduce((a, b) => a! + b!);
    }
    int time = horasMin - minutos!;

    final duration = Duration(minutes: time);
    final zero = DateTime(minutos);
    final dateTime = zero.add(duration);

    return Row(
      mainAxisAlignment: MainAxisAlignment.end,
      children: [
        Container(
          height: Utils.cellHeight,
          width: 300,
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            border: Utils.borderApp,
          ),
          child: Row(
            children: [
              const Text(
                'HORAS TRABAJADAS: ',
                textAlign: TextAlign.start,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
              Text(
                dateTime.hour.toString() +
                    'h ' +
                    dateTime.minute.toString() +
                    'min',
                textAlign: TextAlign.start,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(width: 1)
      ],
    );
  }
}
