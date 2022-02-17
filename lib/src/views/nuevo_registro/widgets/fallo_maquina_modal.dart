import 'package:flutter/material.dart';
import 'package:numberpicker/numberpicker.dart';
import 'package:webtest/src/models/fallo_maquina_model.dart';
import 'package:webtest/src/models/fallo.dart';
import 'package:webtest/src/utils/sizes.dart';
import 'package:webtest/src/utils/utils.dart';
import 'package:webtest/src/widgets/accept_button.dart';
import 'package:webtest/src/widgets/cancel_button.dart';

class FalloMaquinaModal {
  static Future<FalloMaquina?> addModal(
      {context, String? title, Fallo? fallo}) async {
    double alto = Utils.getAltoPantalla(context);
    double ancho = Utils.getAnchoPantalla(context);

    int _minutes = 5;
    String _observaciones = '';

    FalloMaquina? result = await showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          titlePadding:
              const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
          title: Row(
            children: [
              const Spacer(),
              Text(title!),
              const Spacer(),
              IconButton(
                icon: const Icon(Icons.close),
                onPressed: () => Navigator.pop(context, null),
              ),
            ],
          ),
          contentPadding: const EdgeInsets.all(0),
          actions: [
            Row(
              children: [
                Expanded(
                  child: Container(
                    child: CancelButton(
                      onPressed: () {
                        Navigator.pop(context, null);
                      },
                      text: 'CANCELAR',
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: AcceptButton(
                      onPressed: () {
                        FalloMaquina falloMaquina = FalloMaquina();
                        falloMaquina.codigo = fallo!.codfallo;
                        falloMaquina.nombre = fallo.descripcion;
                        falloMaquina.tiempo = _minutes;
                        falloMaquina.observaciones = _observaciones;

                        Navigator.pop(context, falloMaquina);
                      },
                      text: 'ACEPTAR',
                    ),
                  ),
                ),
              ],
            ),
          ],
          content: StatefulBuilder(
            builder: (BuildContext context, StateSetter setState) {
              return Material(
                child: Container(
                  height: alto,
                  color: Colors.white,
                  child: Column(
                    children: [
                      Container(
                        child: Column(
                          children: [
                            Container(
                              width: ancho,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Container(
                                    width: ancho,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 10),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                        color: Colors.black,
                                        width: 1,
                                      ),
                                      color: Colors.black,
                                    ),
                                    child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          fallo!.descripcion!,
                                          textAlign: TextAlign.start,
                                          style: const TextStyle(
                                            fontSize: 22,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w700,
                                          ),
                                        ),
                                        Text(
                                          'Codigo: ' + fallo.codfallo!,
                                          textAlign: TextAlign.start,
                                          style: const TextStyle(
                                            fontSize: 16,
                                            color: Colors.white,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  Sizes.espacioAlto10,
                                  // TIEMPO
                                  Row(
                                    children: [
                                      Container(
                                        padding: const EdgeInsets.symmetric(
                                          horizontal: 20.0,
                                        ),
                                        child: const Text(
                                          'Tiempo:',
                                          style: TextStyle(
                                            fontSize: 16,
                                            color: Colors.black,
                                            fontWeight: FontWeight.w500,
                                          ),
                                        ),
                                      ),
                                      NumberPicker(
                                        value: _minutes,
                                        minValue: 5,
                                        step: 5,
                                        maxValue: 480,
                                        itemCount: 3,
                                        decoration: BoxDecoration(
                                          border: Border.all(
                                            color: Colors.black,
                                            width: 1,
                                          ),
                                          //color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(5),
                                        ),
                                        selectedTextStyle: const TextStyle(
                                          color: Colors.black,
                                          fontSize: 28,
                                          fontWeight: FontWeight.bold,
                                        ),
                                        onChanged: (value) {
                                          _minutes = value;
                                          setState(() {});
                                        },
                                      ),
                                    ],
                                  ),

                                  // OBSERVACIONES
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0,
                                    ),
                                    child: const Text(
                                      'Observaciones:',
                                      style: TextStyle(
                                        fontSize: 16,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  Container(
                                    padding: const EdgeInsets.symmetric(
                                      horizontal: 20.0,
                                      vertical: 5.0,
                                    ),
                                    child: TextField(
                                      onChanged: (text) {
                                        setState(() {
                                          _observaciones = text;
                                        });
                                      },
                                      keyboardType: TextInputType.multiline,
                                      maxLines: null,
                                      minLines: 4,
                                      decoration: const InputDecoration(
                                        hintText: "Ingresa una observacion",
                                        border: OutlineInputBorder(),
                                      ),
                                    ),
                                  ),
                                  Sizes.espacioAlto10,
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          ),
        );
      },
    ) as FalloMaquina?;

    return result ?? null;
  }
}
