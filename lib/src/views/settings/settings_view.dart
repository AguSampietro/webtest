import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_datetime_picker/flutter_datetime_picker.dart';
import 'package:webtest/src/models/codigo_caja.dart';
import 'package:webtest/src/models/deposito.dart';
import 'package:webtest/src/models/fech_hora.dart';
import 'package:webtest/src/models/maquina.dart';
import 'package:webtest/src/models/operario.dart';
import 'package:webtest/src/models/producto.dart';
import 'package:webtest/src/models/turno.dart';
import 'package:webtest/src/services/preferences/app_preferences.dart';
import 'package:webtest/src/utils/enum_types.dart';
import 'package:webtest/src/utils/utils.dart';
import 'package:webtest/src/views/verificacion/verificacion.dart';

import 'settings_controller.dart';
import 'package:webtest/src/utils/modal.dart';

class SettingsView extends StatefulWidget {
  const SettingsView({Key? key, required this.controller}) : super(key: key);

  static const routeName = '/settings';

  final SettingsController controller;

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  final prefs = AppPreferences();
  Maquina? _maquina = null;
  Operario? _operario = null;
  Producto? _producto = null;
  Deposito? _deposito = null;
  FechaHora? _fechaHora = null;
  Turno? _turno = null;
  Operario? _embaladoPor = null;
  CodigoCaja? _codigoCaja = null;
  String? dropdownValue = '';

  @override
  Widget build(BuildContext context) {
    if (prefs.maquinaId.isEmpty) {
      _maquina = Maquina(id: '0', maquina: 'SELECCIONE UNA MAQUINA');
    } else {
      _maquina = Maquina(id: prefs.maquinaId, maquina: prefs.maquinaNombre);
    }

    if (prefs.operarioId.isEmpty) {
      _operario = Operario(legajo: '0', nombre: 'SELECCIONE UN OPERARIO');
    } else {
      _operario =
          Operario(legajo: prefs.operarioId, nombre: prefs.operarioNombre);
    }

    if (prefs.depositoId.isEmpty) {
      _deposito = Deposito(deposito: '0', nombre: 'SELECCIONE UN DEPOSITO');
    } else {
      _deposito =
          Deposito(deposito: prefs.depositoId, nombre: prefs.depositoNombre);
    }

    if (prefs.productoId.isEmpty) {
      _producto = Producto(codproducto: '0', nombre: 'SELECCIONE UN PRODUCTO');
    } else {
      _producto =
          Producto(codproducto: prefs.productoId, nombre: prefs.productoNombre);
    }

    if (prefs.fechaTurno.isEmpty) {
      _fechaHora = FechaHora(
          fecha: 'SELECCIONE FECHA Y HORA DE COMIENZO DEL TURNO', hora: '');
    } else {
      _fechaHora = FechaHora(fecha: prefs.fechaTurno, hora: prefs.horaTurno);
    }

    if (prefs.turnoCodigo.isEmpty) {
      _turno = Turno(nombre: 'SELECCIONE TURNO', codigo: '');
    } else {
      _turno = Turno(nombre: prefs.turnoNombre, codigo: prefs.turnoCodigo);
    }

    if (prefs.embaladoPorCodigo.isEmpty) {
      _embaladoPor =
          Operario(nombre: 'SELECCIONE ENCARGADO DEL EMBALAJE', legajo: '');
    } else {
      _embaladoPor = Operario(
          nombre: prefs.embaladoPorNombre, legajo: prefs.embaladoPorCodigo);
    }

    if (prefs.codigoCaja.isEmpty) {
      _codigoCaja = CodigoCaja(
          codigo: 'INGRESE CODIGO CAJA', nombre: 'INGRESE CODIGO CAJA');
    } else {
      _codigoCaja =
          CodigoCaja(codigo: prefs.codigoCaja, nombre: prefs.codigoCaja);
    }

    if (prefs.codigoCaja.isEmpty) {
      _codigoCaja = CodigoCaja(
          codigo: 'INGRESE CODIGO CAJA', nombre: 'INGRESE CODIGO CAJA');
    } else {
      _codigoCaja =
          CodigoCaja(codigo: prefs.codigoCaja, nombre: prefs.codigoCaja);
    }

    if (prefs.embaladoPorCodigo.isEmpty) {
      _embaladoPor =
          Operario(nombre: 'SELECCIONE ENCARGADO DEL EMBALAJE', legajo: '');
    } else {
      _embaladoPor = Operario(
          nombre: prefs.embaladoPorNombre, legajo: prefs.embaladoPorCodigo);
    }

    return Scaffold(
      appBar: AppBar(
        title: const Text('CONFIGURACION'),
      ),
      body: Column(
        children: [
          if (prefs.puedeConfigurar)
            Column(
              children: [
                Container(
                  margin: const EdgeInsets.all(10),
                  padding: const EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                    border: Border.all(color: Colors.grey),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Column(
                    children: [
                      // MAQUINAS
                      ListTile(
                        onTap: prefs.usuarioTipo == UserType.OPERARIO
                            ? _noPermisos
                            : () async {
                                final prefs = AppPreferences();
                                Maquina? maquina =
                                    await Modal.seleccionarMaquina(context);
                                if (maquina != null) {
                                  setState(() {
                                    _maquina = maquina;
                                    prefs.maquinaId = maquina.id!;
                                    prefs.maquinaNombre = maquina.maquina!;
                                    prefs.maquinaTipo = maquina.tipo!;
                                  });
                                }
                              },
                        leading: const Icon(
                          Icons.build_circle_outlined,
                          size: 40,
                        ),
                        title: _maquina == null
                            ? const Text('SELECCIONE UNA MAQUINA')
                            : Text(_maquina!.maquina!),
                        subtitle: const Text('Maquina configurada'),
                        trailing:
                            const Icon(Icons.arrow_drop_down_circle_outlined),
                      ),

                      const Divider(thickness: 1),

                      // DEPOSITOS
                      ListTile(
                        onTap: prefs.usuarioTipo == UserType.OPERARIO
                            ? _noPermisos
                            : () async {
                                final prefs = AppPreferences();
                                Deposito? deposito =
                                    await Modal.seleccionarDeposito(context);
                                if (deposito != null) {
                                  setState(() {
                                    _deposito = deposito;
                                    prefs.depositoId = deposito.deposito!;
                                    prefs.depositoNombre = deposito.nombre!;
                                  });
                                }
                              },
                        leading: const Icon(
                          Icons.factory_outlined,
                          size: 40,
                        ),
                        title: _deposito == null
                            ? const Text('SELECCIONE UN DEPOSITO')
                            : Text(_deposito!.nombre!),
                        subtitle: const Text('Deposito configurado'),
                        trailing:
                            const Icon(Icons.arrow_drop_down_circle_outlined),
                      ),

                      Divider(thickness: 1),

                      // PRODUCTO A PRODUCIR
                      ListTile(
                        onTap: prefs.usuarioTipo == UserType.OPERARIO
                            ? _noPermisos
                            : () async {
                                final prefs = AppPreferences();
                                Producto? producto =
                                    await Modal.seleccionarProducto(
                                        context, false);

                                if (producto != null) {
                                  setState(() {
                                    _producto = producto;
                                    prefs.productoId = producto.codproducto!;
                                    prefs.productoNombre = producto.nombre!;
                                  });
                                }
                              },
                        leading: const Icon(
                          Icons.add_box_outlined,
                          size: 40,
                        ),
                        title: _producto == null
                            ? const Text('SELECIONE UN PRODUCTO A PRODUCIR')
                            : Text(_producto!.nombre!),
                        subtitle: const Text('Producto configurado'),
                        trailing:
                            const Icon(Icons.arrow_drop_down_circle_outlined),
                      ),

                      const Divider(thickness: 1),

                      // OPERARIOS
                      ListTile(
                        onTap: prefs.usuarioTipo == UserType.OPERARIO
                            ? _noPermisos
                            : () async {
                                final prefs = AppPreferences();
                                Operario? operario =
                                    await Modal.seleccionarOperario(context);
                                if (operario != null) {
                                  setState(() {
                                    _operario = operario;
                                    prefs.operarioId = operario.legajo!;
                                    prefs.operarioNombre = operario.nombre!;
                                  });
                                }
                              },
                        leading: const Icon(
                          Icons.person_outline,
                          size: 40,
                        ),
                        title: _operario == null
                            ? const Text('SELECIONE UN OPERARIO')
                            : Text(_operario!.nombre!),
                        subtitle: const Text('Operario configurado'),
                        trailing:
                            const Icon(Icons.arrow_drop_down_circle_outlined),
                      ),

                      const Divider(thickness: 1),

                      // TURNO
                      Row(
                        children: [
                          Expanded(
                            child: ListTile(
                              onTap: prefs.usuarioTipo == UserType.OPERARIO
                                  ? _noPermisos
                                  : () async {
                                      final prefs = AppPreferences();
                                      String? _t = await selectTurno();

                                      if (_t != null) {
                                        _turno?.codigo = _t;
                                        prefs.turnoCodigo = _t;

                                        if (_t == 'manana') {
                                          _turno?.nombre = 'Mañana';
                                          prefs.turnoNombre = 'Mañana';
                                        } else if (_t == 'tarde') {
                                          _turno?.nombre = 'tarde';
                                          prefs.turnoNombre = 'Tarde';
                                        } else if (_t == 'noche') {
                                          _turno?.nombre = 'Noche';
                                          prefs.turnoNombre = 'Noche';
                                        }
                                      } else {
                                        _turno?.codigo = '';
                                        _turno?.nombre = 'SELECIONE TURNO';
                                        prefs.turnoCodigo = '';
                                        prefs.turnoNombre = 'SELECIONE TURNO';
                                      }
                                      setState(() {});
                                    },
                              leading: const Icon(
                                Icons.access_time_outlined,
                                size: 40,
                              ),
                              title: _producto == null
                                  ? const Text('SELECIONE TURNO')
                                  : Text(_turno!.nombre!),
                              subtitle: const Text('Turno configurado'),
                              trailing: const Icon(
                                  Icons.arrow_drop_down_circle_outlined),
                            ),
                          ),
                          Expanded(
                            child:
                                // FECHA Y HORA DEL TURNO
                                ListTile(
                              onTap: prefs.usuarioTipo == UserType.OPERARIO
                                  ? _noPermisos
                                  : () async {
                                      final prefs = AppPreferences();

                                      DatePicker.showDateTimePicker(
                                        context,
                                        showTitleActions: true,
                                        theme: DatePickerTheme(
                                          cancelStyle: const TextStyle(
                                              color: Colors.black87,
                                              fontSize: 24),
                                          doneStyle: const TextStyle(
                                              color: Colors.blue,
                                              fontSize: 24,
                                              fontWeight: FontWeight.bold),
                                          itemStyle: const TextStyle(
                                              color: Colors.black,
                                              fontSize: 24),
                                          backgroundColor: Colors.white,
                                          headerColor: Colors.grey.shade200,
                                          containerHeight: 350.0,
                                          titleHeight: 60.0,
                                          itemHeight: 50.0,
                                        ),
                                        locale: LocaleType.es,
                                        onConfirm: (date) {
                                          log('confirm ${date.toString()}');
                                          List<String> sel =
                                              Utils.convertirDDMMYYYYHS(date)
                                                  .split(' ');
                                          log(sel[0]);
                                          log(sel[1]);

                                          setState(() {
                                            _fechaHora?.fecha = sel[0];
                                            _fechaHora?.hora = sel[1];
                                            _fechaHora?.fechaAlta = date;

                                            prefs.fechaTurno = sel[0];
                                            prefs.horaTurno = sel[1];
                                            prefs.fechHoraTurno =
                                                date.toString();
                                          });
                                        },
                                        currentTime: DateTime.now(),
                                      );
                                    },
                              leading: const Icon(
                                Icons.calendar_month_outlined,
                                size: 40,
                              ),
                              title: _producto == null
                                  ? const Text(
                                      'SELECIONE FECHA Y HORA DE COMIENZO DEL TURNO')
                                  : Text(_fechaHora.toString()),
                              subtitle: const Text(
                                  'Fecha y hora configurada del turno'),
                              trailing: const Icon(
                                  Icons.arrow_drop_down_circle_outlined),
                            ),
                          ),
                        ],
                      ),

                      const Divider(thickness: 1),

                      // EMBALADO POR
                      Row(
                        children: [
                          Expanded(
                            child: ListTile(
                              onTap: prefs.usuarioTipo == UserType.OPERARIO
                                  ? _noPermisos
                                  : () async {
                                      final prefs = AppPreferences();
                                      Operario? operario =
                                          await Modal.seleccionarOperario(
                                              context) as Operario?;
                                      if (operario != null) {
                                        setState(() {
                                          _embaladoPor = operario;
                                          prefs.embaladoPorCodigo =
                                              operario.legajo!;
                                          prefs.embaladoPorNombre =
                                              operario.nombre!;
                                        });
                                      }
                                    },
                              leading: const Icon(
                                Icons.co_present_outlined,
                                size: 40,
                              ),
                              title: _embaladoPor == null
                                  ? const Text(
                                      'SELECCIONE ENCARGADO DEL EMBALAJE')
                                  : Text(_embaladoPor!.nombre!),
                              subtitle: const Text(
                                  'Encargado del embalaje configurado'),
                              trailing: const Icon(
                                  Icons.arrow_drop_down_circle_outlined),
                            ),
                          ),
                          Expanded(
                            child: // CODIGO CAJA
                                ListTile(
                              onTap: prefs.usuarioTipo == UserType.OPERARIO
                                  ? _noPermisos
                                  : () async {
                                      final prefs = AppPreferences();
                                      String result = await Modal.addModal(
                                          context: context,
                                          title: 'CODIGO CAJA');
                                      if (result.isNotEmpty) {
                                        if (result == 'delete') {
                                          _codigoCaja?.codigo = '';
                                          _codigoCaja?.nombre = '';
                                          prefs.codigoCaja = '';
                                        } else {
                                          _codigoCaja?.codigo = result;
                                          _codigoCaja?.nombre = result;
                                          prefs.codigoCaja = result;
                                        }
                                        setState(() {});
                                      }
                                    },
                              leading: const Icon(
                                Icons.numbers_outlined,
                                size: 40,
                              ),
                              title: _codigoCaja == null
                                  ? const Text('INGRESE CODIGO CAJA')
                                  : Text(_codigoCaja!.codigo!),
                              subtitle:
                                  const Text('Codigo de caja configurado'),
                              trailing: const Icon(
                                  Icons.arrow_drop_down_circle_outlined),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ],
            ),
          Container(
            margin: const EdgeInsets.all(10),
            padding: const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey),
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              children: [
                // CERRAR
                ListTile(
                  onTap: () async {
                    final prefs = AppPreferences();
                    prefs.logged = false;
                    prefs.operarioId = '';
                    prefs.operarioNombre = '';
                    // prefs.maquinaId = '';
                    // prefs.maquinaNombre = '';
                    // prefs.maquinaTipo = '';
                    // prefs.productoNombre = '';
                    // prefs.productoId = '';
                    Navigator.of(context)
                        .pushReplacementNamed(VerificacionView.routeName);
                  },
                  leading: const Icon(
                    Icons.logout,
                    size: 40,
                    color: Colors.red,
                  ),
                  title: const Text('CERRAR SESION'),
                  subtitle: const Text('Luego debe volver a iniciar sesion'),
                  //trailing: const Icon(Icons.arrow_drop_down_circle_outlined),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  void _noPermisos() {
    Utils.snackBar(
        context, 'No tiene permisos para modificar la configuracion');
  }

  Future<String?> selectTurno() async {
    var _style = TextStyle(fontSize: 24);
    return await showDialog<String?>(
        context: context,
        builder: (BuildContext context) {
          return SimpleDialog(
            title: Container(
              width: 500,
              padding: const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
              child: const Text(
                'Selecciona un turno',
                style: TextStyle(
                  fontSize: 26,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            children: <Widget>[
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, 'manana');
                },
                child: Container(
                  width: 500,
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  child: Text('Mañana', style: _style),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, 'tarde');
                },
                child: Container(
                  width: 500,
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  child: Text('Tarde', style: _style),
                ),
              ),
              SimpleDialogOption(
                onPressed: () {
                  Navigator.pop(context, 'noche');
                },
                child: Container(
                  width: 500,
                  padding:
                      const EdgeInsets.symmetric(vertical: 20, horizontal: 30),
                  child: Text('Noche', style: _style),
                ),
              ),
            ],
          );
        });
  }
}
