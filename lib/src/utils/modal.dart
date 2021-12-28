import 'package:flutter/material.dart';
import 'package:numeric_keyboard/numeric_keyboard.dart';
import 'package:webtest/src/models/bobina.dart';
import 'package:webtest/src/models/fallo.dart';
import 'package:webtest/src/models/operario.dart';
import 'package:webtest/src/models/maquina.dart';
import 'package:webtest/src/utils/theme.dart';
import 'package:webtest/src/widgets/cancel_button.dart';
import 'package:webtest/src/widgets/delete_button.dart';
import 'package:webtest/src/utils/utils.dart';
import 'package:webtest/src/widgets/accept_button.dart';

class Modal {
  static Future<String> addModal({context, String? title}) async {
    final double radious = 5;

    double alto = Utils.getAltoPantalla(context);
    double ancho = Utils.getAnchoPantalla(context);

    String _contador = '';

    print('alto: $alto');
    print('ancho: $ancho');

    String? result = await showDialog(
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
                onPressed: () => Navigator.pop(context, 'cancel'),
              ),
            ],
          ),
          contentPadding: const EdgeInsets.all(0),
          actions: [
            CancelButton(
              onPressed: () {
                Navigator.pop(context, 'cancel');
              },
              text: 'CANCELAR',
            ),
            DeleteButton(
              onPressed: () {
                Navigator.pop(context, 'delete');
              },
              text: 'BORRAR',
            ),
            AcceptButton(
              onPressed: () {
                Navigator.pop(context, _contador);
              },
              text: 'ACEPTAR',
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
                                children: [
                                  Container(
                                    width: ancho,
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 10, vertical: 20),
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: Colors.black, width: 1),
                                      color: Colors.black,
                                    ),
                                    child: Text(
                                      _contador == null ? '' : _contador,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 30,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  NumericKeyboard(
                                    onKeyboardTap: (String value) {
                                      setState(() {
                                        _contador = _contador + value;
                                      });
                                    },
                                    textColor: Colors.black,
                                    rightIcon: const Icon(
                                      Icons.backspace,
                                      color: Colors.red,
                                      size: 40,
                                    ),
                                    rightButtonFn: () {
                                      if (_contador.length > 0) {
                                        setState(() {
                                          _contador = _contador.substring(
                                              0, _contador.length - 1);
                                        });
                                      }
                                    },
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                  )
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
    ) as String;
    if (result == null || result == 'cancel') return '';

    return result.toString();
  }

  static Future<Maquina?> seleccionarMaquina(context) async {
    List<Maquina> maquinas = [
      Maquina(id: '1', nombre: 'Maquina 1'),
      Maquina(id: '2', nombre: 'Maquina 2'),
      Maquina(id: '3', nombre: 'Maquina 3'),
      Maquina(id: '4', nombre: 'Maquina 4'),
      Maquina(id: '5', nombre: 'Maquina 5'),
      Maquina(id: '6', nombre: 'Maquina 6'),
      Maquina(id: '7', nombre: 'Maquina 7'),
      Maquina(id: '8', nombre: 'Maquina 8'),
      Maquina(id: '9', nombre: 'Maquina 9'),
      Maquina(id: '10', nombre: 'Maquina 10'),
    ];

    Maquina? result = await showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return Material(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AppBar(
                    centerTitle: true,
                    backgroundColor:
                        ThemeApp.modalHeadColor, //Colors.pink[400],
                    elevation: 0,
                    automaticallyImplyLeading: false,
                    title: const Text(
                      'SELECCIONE UNA MAQUINA',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                    actions: [
                      IconButton(
                        iconSize: 34.0,
                        color: Colors.white,
                        icon: Icon(Icons.close),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.separated(
                      physics: const AlwaysScrollableScrollPhysics(),
                      shrinkWrap: true,
                      primary: false,
                      padding: const EdgeInsets.only(
                          bottom: kFloatingActionButtonMargin + 48),
                      scrollDirection: Axis.vertical,
                      itemCount: maquinas.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(maquinas[index].nombre!),
                          trailing: Text(
                            'Seleccionar',
                            style: TextStyle(
                              color: ThemeApp.modalSelectItem,
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).pop(maquinas[index]);
                          },
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider(thickness: 1);
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        });
    if (result == null) return null;

    return result;
  }

  static Future<Operario?> seleccionarOperario(context) async {
    List<Operario> operarios = [
      Operario(id: '1', nombre: 'Agustin Sampietro', clave: '111'),
      Operario(id: '2', nombre: 'Braian Reinaudo', clave: '222'),
      Operario(id: '3', nombre: 'Joaquin Siro', clave: '333'),
      Operario(id: '4', nombre: 'Facundo De La Colina', clave: '444'),
      Operario(id: '5', nombre: 'Agustin Fassio', clave: '555'),
      Operario(id: '6', nombre: 'Gaston Celiz', clave: '666'),
      Operario(id: '7', nombre: 'Martin Ballaman', clave: '777'),
    ];

    Operario? result = await showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return Material(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AppBar(
                    centerTitle: true,
                    backgroundColor: ThemeApp.modalHeadColor,
                    elevation: 0,
                    automaticallyImplyLeading: false,
                    title: const Text(
                      'SELECCIONE UN OPERARIO',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                    actions: [
                      IconButton(
                        iconSize: 34.0,
                        color: Colors.white,
                        icon: Icon(Icons.close),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.separated(
                      physics: const AlwaysScrollableScrollPhysics(),
                      shrinkWrap: true,
                      primary: false,
                      padding: const EdgeInsets.only(
                          bottom: kFloatingActionButtonMargin + 48),
                      scrollDirection: Axis.vertical,
                      itemCount: operarios.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(operarios[index].nombre!),
                          trailing: Text(
                            'Seleccionar',
                            style: TextStyle(
                              color: ThemeApp.modalSelectItem,
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).pop(operarios[index]);
                          },
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider(thickness: 1);
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        });
    if (result == null) return null;

    return result;
  }

  static Future<Bobina?> seleccionarBobina(context) async {
    List<Bobina> bobinas = [
      Bobina(id: '1', nombre: '26900/c/f/r/4'),
      Bobina(id: '2', nombre: '26700/c/f/r/3'),
      Bobina(id: '3', nombre: '35454/c/j/r/5'),
      Bobina(id: '4', nombre: '67890/c/f/r/6'),
      Bobina(id: '5', nombre: '34232/c/f/r/7'),
      Bobina(id: '6', nombre: '43433/c/f/r/8'),
      Bobina(id: '7', nombre: '11223/c/f/r/9'),
      Bobina(id: '8', nombre: '23434/c/f/r/1'),
    ];

    Bobina? result = await showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return Material(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AppBar(
                    centerTitle: true,
                    backgroundColor:
                        ThemeApp.modalHeadColor, //Colors.pink[400],
                    elevation: 0,
                    automaticallyImplyLeading: false,
                    title: const Text(
                      'SELECCIONE UNA BOBINA',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                    actions: [
                      IconButton(
                        iconSize: 34.0,
                        color: Colors.white,
                        icon: Icon(Icons.close),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.separated(
                      physics: const AlwaysScrollableScrollPhysics(),
                      shrinkWrap: true,
                      primary: false,
                      padding: const EdgeInsets.only(
                          bottom: kFloatingActionButtonMargin + 48),
                      scrollDirection: Axis.vertical,
                      itemCount: bobinas.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(bobinas[index].nombre!),
                          trailing: Text(
                            'Seleccionar',
                            style: TextStyle(
                              color: ThemeApp.modalSelectItem,
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).pop(bobinas[index]);
                          },
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider(thickness: 1);
                      },
                    ),
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 30),
                    child: DeleteButton(
                      text: '   ELIMINAR SELECCION   ',
                      onPressed: () {
                        Navigator.of(context).pop(Bobina(id: '', nombre: ''));
                      },
                    ),
                  )
                ],
              ),
            ),
          );
        });
    if (result == null) return null;

    return result;
  }

  static Future<Fallo?> seleccionarFallo(context) async {
    List<Fallo> fallos = [
      Fallo(codigo: 'C17', nombre: 'Fallo c17'),
      Fallo(codigo: 'C41', nombre: 'Fallo c41'),
      Fallo(codigo: 'C40', nombre: 'Fallo c40'),
      Fallo(codigo: 'A1', nombre: 'Fallo a1'),
      Fallo(codigo: 'B', nombre: 'Fallo b'),
      Fallo(codigo: 'C16', nombre: 'Fallo c16'),
    ];

    Fallo? result = await showGeneralDialog(
        context: context,
        barrierDismissible: true,
        barrierLabel:
            MaterialLocalizations.of(context).modalBarrierDismissLabel,
        barrierColor: Colors.black45,
        transitionDuration: const Duration(milliseconds: 200),
        pageBuilder: (BuildContext buildContext, Animation animation,
            Animation secondaryAnimation) {
          return Material(
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: Colors.white,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  AppBar(
                    centerTitle: true,
                    backgroundColor:
                        ThemeApp.modalHeadColor, //Colors.pink[400],
                    elevation: 0,
                    automaticallyImplyLeading: false,
                    title: const Text(
                      'SELECCIONE UN FALLO',
                      textAlign: TextAlign.start,
                      style: TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.w500,
                        fontSize: 20,
                      ),
                    ),
                    actions: [
                      IconButton(
                        iconSize: 34.0,
                        color: Colors.white,
                        icon: Icon(Icons.close),
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                      ),
                    ],
                  ),
                  Expanded(
                    child: ListView.separated(
                      physics: const AlwaysScrollableScrollPhysics(),
                      shrinkWrap: true,
                      primary: false,
                      padding: const EdgeInsets.only(
                          bottom: kFloatingActionButtonMargin + 48),
                      scrollDirection: Axis.vertical,
                      itemCount: fallos.length,
                      itemBuilder: (context, index) {
                        return ListTile(
                          title: Text(fallos[index].nombre!),
                          trailing: Text(
                            'Seleccionar',
                            style: TextStyle(
                              color: ThemeApp.modalSelectItem,
                            ),
                          ),
                          onTap: () {
                            Navigator.of(context).pop(fallos[index]);
                          },
                        );
                      },
                      separatorBuilder: (context, index) {
                        return const Divider(thickness: 1);
                      },
                    ),
                  ),
                ],
              ),
            ),
          );
        });
    if (result == null) return null;

    return result;
  }
}
