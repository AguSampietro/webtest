import 'package:flutter/material.dart';
import 'package:webtest/src/models/maquina.dart';
import 'package:webtest/src/models/operario.dart';
import 'package:webtest/src/services/preferences/app_preferences.dart';
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
      _maquina = Maquina(id: '0', nombre: 'SELECCIONE UNA MAQUINA');
    } else {
      _maquina = Maquina(id: prefs.maquinaId, nombre: prefs.maquinaNombre);
    }

    if (prefs.operarioId.isEmpty) {
      _operario = Operario(id: '0', nombre: 'SELECCIONE UN OPERARIO');
    } else {
      _operario = Operario(id: prefs.operarioId, nombre: prefs.operarioNombre);
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
                  onTap: () async {
                    final prefs = AppPreferences();
                    Maquina? maquina =
                        await Modal.seleccionarMaquina(context) as Maquina?;
                    if (maquina != null) {
                      setState(() {
                        _maquina = maquina;
                        prefs.maquinaId = maquina.id!;
                        prefs.maquinaNombre = maquina.nombre!;
                      });
                    }
                  },
                  leading: const Icon(
                    Icons.build_circle_outlined,
                    size: 40,
                  ),
                  title: _maquina == null
                      ? const Text('SELECCIONE UNA MAQUINA')
                      : Text(_maquina!.nombre!),
                  subtitle: const Text('Maquina configurada'),
                  trailing: const Icon(Icons.arrow_drop_down_circle_outlined),
                ),

                Divider(thickness: 1),

                // OPERARIOS
                ListTile(
                  onTap: () async {
                    final prefs = AppPreferences();
                    Operario? operario =
                        await Modal.seleccionarOperario(context) as Operario?;
                    if (operario != null) {
                      setState(() {
                        _operario = operario;
                        prefs.operarioId = operario.id!;
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
}