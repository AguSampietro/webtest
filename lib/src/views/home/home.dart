import 'package:flutter/material.dart';
import 'package:webtest/src/models/maquina.dart';
import 'package:webtest/src/models/operario.dart';
import 'package:webtest/src/utils/filtro_type.dart';
import 'package:webtest/src/utils/modal.dart';
import 'package:webtest/src/utils/utils.dart';
import 'package:webtest/src/views/nuevo_registro/nuevo_registro_view.dart';

import 'package:webtest/src/views/nuevo_registro/widgets/maquina_card.dart';

import 'package:webtest/src/views/nuevo_registro/widgets/operario_card.dart';
import 'package:webtest/src/services/preferences/app_preferences.dart';
import 'package:webtest/src/widgets/registros/registro_lista.dart';

import '../settings/settings_view.dart';

class HomeView extends StatefulWidget {
  static const routeName = '/home';

  const HomeView({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  final prefs = AppPreferences();
  Maquina? _maquina = null;
  Operario? _operario = null;
  String _tipoFiltro = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (prefs.tipoFiltro == FiltrosType.MAQUINAS) {
      _tipoFiltro = 'Maquina';
    } else if (prefs.tipoFiltro == FiltrosType.OPERARIOS) {
      _tipoFiltro = 'Operario';
    } else if (prefs.tipoFiltro == FiltrosType.FECHAS) {
      _tipoFiltro = 'Fecha';
    } else {
      _tipoFiltro = 'Seleccione un filtro';
    }

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

    final double widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('HORES - REGISTRO DE PRODUCCION'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, SettingsView.routeName)
                  .then((value) {
                setState(() {});
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          Container(
            height: 80,
            width: widthScreen,
            child: Row(
              children: [
                Expanded(
                  flex: 2,
                  child: Card(
                    child: ListTile(
                      onTap: () async {
                        final prefs = AppPreferences();
                        String? tipoFiltro =
                            await Modal.seleccionarTipoFiltro(context);
                        if (tipoFiltro != null) {
                          setState(() {
                            prefs.tipoFiltro = tipoFiltro;
                          });
                        }
                      },
                      title: const Text(
                        'filtrar por:',
                        style: TextStyle(
                          fontSize: 13,
                          color: Colors.grey,
                        ),
                      ),
                      subtitle: Text(
                        _tipoFiltro,
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      trailing:
                          const Icon(Icons.arrow_drop_down_circle_outlined),
                    ),
                  ),
                ),
                if (prefs.tipoFiltro == FiltrosType.OPERARIOS)
                  _buildFiltroOperario(context),
                if (prefs.tipoFiltro == FiltrosType.MAQUINAS)
                  _buildFiltrMaquina(context),
                if (prefs.tipoFiltro == FiltrosType.FECHAS)
                  _buildFiltroFecha(context),
              ],
            ),
          ),
          const Divider(color: Colors.grey, thickness: 1),
          RegistrosLista(),
          const Divider(color: Colors.grey, thickness: 1),
          Container(
            margin: EdgeInsets.only(top: 5, bottom: 30),
            child: ElevatedButton.icon(
              onPressed: () {
                Navigator.pushNamed(context, NuevoRegistroView.routeName)
                    .then((value) {
                  setState(() {});
                });
              },
              icon: const Icon(
                Icons.add,
                size: 30,
              ),
              label: const Text('NUEVO REGISTRO'),
              style: ElevatedButton.styleFrom(
                primary: Theme.of(context).primaryColor,
                padding: const EdgeInsets.symmetric(
                  horizontal: 30,
                  vertical: 10,
                ),
                textStyle: const TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildFiltroOperario(BuildContext context) {
    return Expanded(
      flex: 4,
      child: Card(
        child: ListTile(
          onTap: () async {
            final prefs = AppPreferences();
            Operario? operario = await Modal.seleccionarOperario(context);
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
      ),
    );
  }

  Widget _buildFiltrMaquina(BuildContext context) {
    return Expanded(
      flex: 4,
      child: Card(
        child: ListTile(
          onTap: () async {
            final prefs = AppPreferences();
            Maquina? maquina = await Modal.seleccionarMaquina(context);
            if (maquina != null) {
              setState(() {
                _maquina = maquina;
                prefs.maquinaId = maquina.id!;
                prefs.maquinaNombre = maquina.maquina!;
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
      ),
    );
  }

  Widget _buildFiltroFecha(BuildContext context) {
    return Expanded(
      flex: 4,
      child: Card(
        child: ListTile(
          onTap: () async {
            Utils.snackBar(context, 'En desarrollo');
          },
          leading: const Icon(
            Icons.calendar_today,
            size: 40,
          ),
          title: const Text('SELECIONE UNA FECHA'),
          subtitle: const Text('Fecha seleccionada'),
          trailing: const Icon(Icons.arrow_drop_down_circle_outlined),
        ),
      ),
    );
  }
}
