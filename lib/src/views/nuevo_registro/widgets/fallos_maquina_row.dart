import 'package:flutter/material.dart';
import 'package:simple_tags/simple_tags.dart';
import 'package:webtest/src/models/fallo_maquina_model.dart';
import 'package:webtest/src/utils/utils.dart';

class FallosMaquinaLista extends StatelessWidget {
  FallosMaquinaLista({
    required this.fallos,
    required this.onRefresh,
  });
  final List<FalloMaquina> fallos;
  final void Function() onRefresh;
  @override
  Widget build(BuildContext context) {
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
          return FallosMaquinaRow(
            fallo: fallos[index],
            onDelete: () {
              fallos.removeAt(index);
              // Scaffold.of(context).showSnackBar(
              //   SnackBar(
              //     content: Text('Fallo eliminado'),
              //   ),
              // );
              onRefresh();
            },
          );
        },
      ),
    );
  }
}

class FallosMaquinaRow extends StatelessWidget {
  FallosMaquinaRow({
    required this.fallo,
    required this.onDelete,
  });
  final FalloMaquina fallo;
  final void Function() onDelete;
  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 5,
        right: 5,
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
                  fallo.codigo! + ' - ' + fallo.nombre!,
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
          Expanded(
            flex: 1,
            child: Container(
              height: Utils.cellHeight,
              padding: const EdgeInsets.symmetric(horizontal: 5),
              decoration: BoxDecoration(
                border: Utils.borderApp,
              ),
              child: Center(
                child: GestureDetector(
                  onTap: onDelete,
                  child: const Icon(
                    Icons.delete,
                    color: Colors.red,
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

class FallosMaquinaTotalHoras extends StatelessWidget {
  FallosMaquinaTotalHoras({
    required this.fallos,
  });
  final List<FalloMaquina> fallos;

  @override
  Widget build(BuildContext context) {
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
        const SizedBox(width: 5)
      ],
    );
  }
}
