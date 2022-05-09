import 'package:flutter/material.dart';

import 'package:numeric_keyboard/numeric_keyboard.dart';
import 'package:webtest/src/models/bobina.dart';
import 'package:webtest/src/models/deposito.dart';
import 'package:webtest/src/models/nro_serie.dart';

import 'package:webtest/src/models/producto.dart';
import 'package:webtest/src/models/fallo.dart';
import 'package:webtest/src/models/operario.dart';
import 'package:webtest/src/models/maquina.dart';
import 'package:webtest/src/services/preferences/app_preferences.dart';
import 'package:webtest/src/utils/enum_types.dart';
import 'package:webtest/src/utils/theme.dart';
import 'package:webtest/src/widgets/bobina/bobina_deposito_lista.dart';
import 'package:webtest/src/widgets/bobina/bobina_filtro.dart';
import 'package:webtest/src/widgets/bobina/bobina_lista.dart';
import 'package:webtest/src/widgets/bobina/bobina_nroserie_lista.dart';
import 'package:webtest/src/widgets/deposito/deposito_lista.dart';

import 'package:webtest/src/widgets/producto/producto_filtro.dart';
import 'package:webtest/src/widgets/producto/producto_lista.dart';
import 'package:webtest/src/widgets/cancel_button.dart';
import 'package:webtest/src/widgets/delete_button.dart';
import 'package:webtest/src/utils/utils.dart';
import 'package:webtest/src/widgets/accept_button.dart';
import 'package:webtest/src/widgets/fallo/fallo_filtro.dart';
import 'package:webtest/src/widgets/fallo/fallo_lista.dart';

import 'package:webtest/src/widgets/maquina/maquina_lista.dart';
import 'package:webtest/src/widgets/operario/operario_lista.dart';

class Modal {
  static Future<String?> seleccionarTipoFiltro(context) async {
    String? result = await showGeneralDialog(
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
                      'SELECCIONE TIPO DE FILTRO',
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
                    child: ListView(
                      children: <Widget>[
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ListTile(
                            title: const Text('OPERARIO'),
                            leading: const Icon(Icons.person_outline, size: 40),
                            onTap: () {
                              Navigator.of(context).pop(FiltrosType.OPERARIOS);
                            },
                            trailing: Text(
                              'Seleccionar',
                              style: TextStyle(
                                color: ThemeApp.modalSelectItem,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ListTile(
                            title: const Text('MAQUINA'),
                            leading: const Icon(Icons.build_circle_outlined,
                                size: 40),
                            onTap: () {
                              Navigator.of(context).pop(FiltrosType.MAQUINAS);
                            },
                            trailing: Text(
                              'Seleccionar',
                              style: TextStyle(
                                color: ThemeApp.modalSelectItem,
                              ),
                            ),
                          ),
                        ),
                        Container(
                          margin: const EdgeInsets.symmetric(
                              horizontal: 10, vertical: 5),
                          padding: const EdgeInsets.all(10),
                          decoration: BoxDecoration(
                            border: Border.all(color: Colors.grey),
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: ListTile(
                            title: const Text('PRODUCTO'),
                            leading: const Icon(Icons.calendar_today, size: 40),
                            onTap: () {
                              Navigator.of(context).pop(FiltrosType.PRODUCTOS);
                            },
                            trailing: Text(
                              'Seleccionar',
                              style: TextStyle(
                                color: ThemeApp.modalSelectItem,
                              ),
                            ),
                          ),
                        ),
                      ],
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
            Row(
              children: [
                Expanded(
                  child: Container(
                    child: CancelButton(
                      onPressed: () {
                        Navigator.pop(context, 'cancel');
                      },
                      text: 'CANCELAR',
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: DeleteButton(
                      onPressed: () {
                        Navigator.pop(context, 'delete');
                      },
                      text: 'BORRAR',
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: AcceptButton(
                      onPressed: () {
                        Navigator.pop(context, _contador);
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
                                        fontSize: 35,
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
                                  ),
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

  static Future<String> password({context, String? title}) async {
    final double radious = 5;

    double alto = Utils.getAltoPantalla(context);
    double ancho = Utils.getAnchoPantalla(context);

    String _contador = '';

    String _password = '';

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
            Row(
              children: [
                Expanded(
                  child: Container(
                    child: CancelButton(
                      onPressed: () {
                        Navigator.pop(context, 'cancel');
                      },
                      text: 'CANCELAR',
                    ),
                  ),
                ),
                Expanded(
                  child: Container(
                    child: AcceptButton(
                      onPressed: () {
                        Navigator.pop(context, _contador);
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
                                      _password,
                                      textAlign: TextAlign.center,
                                      style: const TextStyle(
                                        fontSize: 35,
                                        color: Colors.white,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ),
                                  NumericKeyboard(
                                    onKeyboardTap: (String value) {
                                      setState(() {
                                        _contador = _contador + value;

                                        _password = _contador;
                                        _password =
                                            _password.replaceAll('1', '*');
                                        _password =
                                            _password.replaceAll('2', '*');
                                        _password =
                                            _password.replaceAll('3', '*');
                                        _password =
                                            _password.replaceAll('4', '*');
                                        _password =
                                            _password.replaceAll('5', '*');
                                        _password =
                                            _password.replaceAll('6', '*');
                                        _password =
                                            _password.replaceAll('7', '*');
                                        _password =
                                            _password.replaceAll('8', '*');
                                        _password =
                                            _password.replaceAll('9', '*');
                                        _password =
                                            _password.replaceAll('0', '*');
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
                                          _password = _contador;

                                          _password = _contador;
                                          _password =
                                              _password.replaceAll('1', '*');
                                          _password =
                                              _password.replaceAll('2', '*');
                                          _password =
                                              _password.replaceAll('3', '*');
                                          _password =
                                              _password.replaceAll('4', '*');
                                          _password =
                                              _password.replaceAll('5', '*');
                                          _password =
                                              _password.replaceAll('6', '*');
                                          _password =
                                              _password.replaceAll('7', '*');
                                          _password =
                                              _password.replaceAll('8', '*');
                                          _password =
                                              _password.replaceAll('9', '*');
                                          _password =
                                              _password.replaceAll('0', '*');
                                        });
                                      }
                                    },
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                  ),
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
                mainAxisAlignment: MainAxisAlignment.start,
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
                  MaquinaLista(),
                ],
              ),
            ),
          );
        });
    if (result == null) return null;

    return result;
  }

  static Future<Operario?> seleccionarOperario(context) async {
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
                  OperarioLista(),
                ],
              ),
            ),
          );
        });
    if (result == null) return null;

    return result;
  }

  static Future<Deposito?> seleccionarDeposito(context) async {
    Deposito? result = await showGeneralDialog(
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AppBar(
                    centerTitle: true,
                    backgroundColor:
                        ThemeApp.modalHeadColor, //Colors.pink[400],
                    elevation: 0,
                    automaticallyImplyLeading: false,
                    title: const Text(
                      'SELECCIONE UN DEPOSITO',
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
                  DepositoLista(),
                ],
              ),
            ),
          );
        });
    if (result == null) return null;

    return result;
  }

  static Future<Bobina?> seleccionarBobinaPorDeposito(context) async {
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
                mainAxisAlignment: MainAxisAlignment.start,
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
                  BobinaFiltro(),
                  BobinaDepositoLista(trabajando: true),
                  Container(
                    margin: EdgeInsets.only(bottom: 30),
                    child: DeleteButton(
                      text: '   ELIMINAR SELECCION   ',
                      onPressed: () {
                        Navigator.of(context).pop(Bobina(
                          id: '',
                          codproducto: '',
                          nombre: '',
                          nroSerie: '',
                        ));
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

  static Future<NroSerie?> seleccionarNumeroSerie(
      context, String codigoProducto) async {
    NroSerie? result = await showGeneralDialog(
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AppBar(
                    centerTitle: true,
                    backgroundColor:
                        ThemeApp.modalHeadColor, //Colors.pink[400],
                    elevation: 0,
                    automaticallyImplyLeading: false,
                    title: const Text(
                      'SELECCIONE UN NUMERO DE SERIE',
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
                  BobinaNroSerieLista(
                    trabajando: true,
                    codProducto: codigoProducto,
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 30),
                    child: DeleteButton(
                      text: '   ELIMINAR SELECCION   ',
                      onPressed: () {
                        Navigator.of(context).pop(NroSerie(
                            codproducto: '', nombre: '', nroserie: ''));
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
                mainAxisAlignment: MainAxisAlignment.start,
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
                  BobinaFiltro(),
                  BobinaLista(
                    trabajando: false,
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
                  FalloFiltro(),
                  FalloLista(),
                ],
              ),
            ),
          );
        });
    if (result == null) return null;

    return result;
  }

  static Future<Producto?> seleccionarProducto(context, bool trabajando) async {
    final prefs = AppPreferences();

    Producto? result = await showGeneralDialog(
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
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  AppBar(
                    centerTitle: true,
                    backgroundColor:
                        ThemeApp.modalHeadColor, //Colors.pink[400],
                    elevation: 0,
                    automaticallyImplyLeading: false,
                    title: const Text(
                      'SELECCIONE UN PRODUCTO',
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
                  ProductoFiltro(),
                  if (trabajando)
                    Container(
                      color: Colors.blue,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 5),
                      margin: const EdgeInsets.symmetric(vertical: 5),
                      child: Text(
                        'Maquina seleccionada: ${prefs.maquinaNombre}',
                        style: const TextStyle(
                          color: Colors.white,
                        ),
                      ),
                    ),
                  ProductoLista(trabajando: trabajando),
                ],
              ),
            ),
          );
        });
    if (result == null) return null;

    return result;
  }
}
