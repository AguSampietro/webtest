import 'package:flutter/material.dart';
import 'package:webtest/src/models/maquina.dart';
import 'package:webtest/src/models/operario.dart';
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
    return Scaffold(
      appBar: AppBar(
        title: const Text('CONFIGURACION'),
      ),
      body: Column(
        children: [
          Container(
            margin: EdgeInsets.all(10),
            padding: EdgeInsets.only(left: 10),
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
                  trailing: const Icon(Icons.arrow_drop_down_circle_outlined),
                ),

                Divider(thickness: 1),

                // OPERARIOS
                ListTile(
                  onTap: prefs.usuarioTipo == UserType.OPERARIO
                      ? _noPermisos
                      : () async {
                          final prefs = AppPreferences();
                          Operario? operario =
                              await Modal.seleccionarOperario(context)
                                  as Operario?;
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
                  trailing: const Icon(Icons.arrow_drop_down_circle_outlined),
                ),
                Divider(thickness: 1),
                // OPERARIOS
                ListTile(
                  onTap: () async {
                    final prefs = AppPreferences();
                    prefs.logged = false;
                    prefs.operarioId = '';
                    prefs.operarioNombre = '';
                    // prefs.maquinaId = '';
                    // prefs.maquinaNombre = '';
                    // prefs.maquinaTipo = '';
                    prefs.productoNombre = '';
                    prefs.productoId = '';
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
}
