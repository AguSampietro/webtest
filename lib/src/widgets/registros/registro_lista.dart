import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:webtest/src/cubit/registro_lista_cubit.dart';

import 'package:webtest/src/models/registro_lista.dart';
import 'package:webtest/src/services/preferences/app_preferences.dart';
import 'package:webtest/src/utils/enum_types.dart';
import 'package:webtest/src/views/nuevo_registro/nuevo_registro_view.dart';

import 'package:webtest/src/views/registro/registro.dart';
import 'package:webtest/src/widgets/loading.dart';

class RegistrosLista extends StatelessWidget {
  RegistrosLista({required this.onRefresh});
  final Function onRefresh;
  @override
  Widget build(BuildContext context) {
    context.read<RegistroListaCubit>().PRO_registros();

    return BlocConsumer<RegistroListaCubit, RegistroListaState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state == null) return Text('State error');

        if (state is RegistroListaInitial) {
          return _MessageSearch(mensaje: 'Comenzando busqueda de registros');
        } else if (state is RegistroListaLoading) {
          return _LoadingRegistro();
        } else if (state is RegistroListaError) {
          return _MessageSearch(mensaje: state.message);
        } else if (state is RegistroListaLoaded) {
          return Container(
            child: Expanded(
              child: RefreshIndicator(
                onRefresh: () =>
                    context.read<RegistroListaCubit>().PRO_registros(),
                child: ListView.builder(
                  physics: const AlwaysScrollableScrollPhysics(),
                  shrinkWrap: true,
                  primary: false,
                  padding: const EdgeInsets.only(
                      bottom: kFloatingActionButtonMargin + 48),
                  scrollDirection: Axis.vertical,
                  itemCount: state.registros.length,
                  itemBuilder: (context, index) {
                    RegistroLista registro = state.registros[index];
                    return RegistroItem(
                      registro: registro,
                      onRefresh: onRefresh,
                    );
                  },
                ),
              ),
            ),
          );
        } else {
          return const _MessageSearch(
              mensaje:
                  'Algo salio mal obteniendo los registros de produccion.');
        }
      },
    );
  }
}

class RegistroItem extends StatelessWidget {
  const RegistroItem({
    Key? key,
    required this.registro,
    required this.onRefresh,
  }) : super(key: key);

  final RegistroLista registro;
  final Function onRefresh;

  @override
  Widget build(BuildContext context) {
    var _color = Colors.black54;
    if (registro.estado == RegistroType.CREADO) {
      _color = Colors.blue;
    } else if (registro.estado == RegistroType.PROCESADO) {
      _color = Colors.green;
    } else if (registro.estado == RegistroType.ANULADO) {
      _color = Colors.red;
    }

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      padding: const EdgeInsets.only(top: 15, bottom: 5, left: 5, right: 10),
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          ListTile(
            title: Text(
              '${registro.fecha!} ${registro.hora!}',
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            trailing: Container(
              margin: const EdgeInsets.only(top: 5, bottom: 3),
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              decoration: BoxDecoration(
                border: Border.all(color: _color),
                color: _color,
                borderRadius: BorderRadius.circular(20),
              ),
              child: Text(
                registro.estado!,
                style: const TextStyle(fontSize: 14, color: Colors.white),
              ),
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 15, right: 15, bottom: 6),
            child: Row(
              children: [
                Text('Cod Producto: ${registro.codProducto!}'),
                const Text('  -  '),
                Text('${registro.producto!}'),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 15, right: 15, bottom: 6),
            child: Row(
              children: [
                Text('Maquina: ${registro.maquina!}'),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 15, right: 15, bottom: 6),
            child: Row(
              children: [
                Text('Operario: ${registro.operario!}'),
                Text(' (${registro.legajoOperario!})'),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 15, right: 15, bottom: 6),
            child: Row(
              children: [
                Text('Contador Inicial: ${registro.contadorInicial!}'),
                const Text('  -  '),
                Text('Contador Final: ${registro.contadorFinal!}'),
                const Text('  -  '),
                Text('Lote: ${registro.lote!}'),
              ],
            ),
          ),
          Container(
            margin: const EdgeInsets.only(left: 15, right: 15, bottom: 6),
            child: Row(
              children: [
                Text(
                    'Cantidad de cajas fabricadas: ${registro.cantidadCajas!}'),
                const Text('  -  '),
                Text(
                    'Cantidad de moldes fabricados: ${registro.cantidadMoldes!}'),
              ],
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              if (registro.estado == RegistroType.CREADO)
                TextButton.icon(
                  onPressed: () {
                    final prefs = AppPreferences();
                    prefs.idRegistroEdit = registro.id!;

                    Navigator.pushNamed(context, NuevoRegistroView.routeName)
                        .then((value) {
                      onRefresh();
                    });
                  },
                  icon: const Icon(
                    Icons.edit,
                    size: 20,
                  ),
                  label: const Text('EDITAR REGISTRO'),
                ),
              TextButton.icon(
                onPressed: () {
                  Navigator.pushNamed(
                    context,
                    RegistroView.routeName,
                    arguments: registro.id,
                  ).then((value) {
                    onRefresh();
                  });
                },
                icon: const Icon(
                  Icons.info_outline,
                  size: 20,
                ),
                label: const Text('VER REGISTRO COMPLETO'),
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class _MessageSearch extends StatelessWidget {
  const _MessageSearch({
    Key? key,
    required this.mensaje,
  }) : super(key: key);

  final String? mensaje;

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          width: double.infinity,
          child: Text(
            mensaje!,
            textAlign: TextAlign.center,
          ),
        ),
      ],
    ));
  }
}

class _LoadingRegistro extends StatelessWidget {
  const _LoadingRegistro({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LoadingSpinner(
            color: Colors.blue,
            text: 'Buscando registros de produccion...',
            height: 3,
          ),
        ],
      ),
    );
  }
}
