import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webtest/src/cubit/producto_cubit.dart';
import 'package:webtest/src/models/producto.dart';
import 'package:webtest/src/services/preferences/app_preferences.dart';

import 'package:webtest/src/utils/theme.dart';
import 'package:webtest/src/widgets/loading.dart';

class ProductoLista extends StatelessWidget {
  ProductoLista({required this.trabajando});

  final bool trabajando;
  @override
  Widget build(BuildContext context) {
    context.read<ProductoCubit>().PRO_productos('');

    return BlocConsumer<ProductoCubit, ProductoState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state == null) return Text('State error');

        if (state is ProductoInitial) {
          return const _MessageSearch(
              mensaje: 'Comenzando busqueda de bobinas');
        } else if (state is ProductoLoading) {
          return const _LoadingProducto();
        } else if (state is ProductoError) {
          return _MessageSearch(mensaje: state.message);
        } else if (state is ProductoLoaded) {
          List<Producto> productos = [];
          if (trabajando) {
            productos = _getProductosPorMaquina(state.productos);
          } else {
            productos = state.productos;
          }

          return Expanded(
            child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              primary: false,
              padding: const EdgeInsets.only(
                  bottom: kFloatingActionButtonMargin + 48),
              scrollDirection: Axis.vertical,
              itemCount: productos.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    productos[index].nombre!,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  subtitle: Text(
                    'Código: ${productos[index].codproducto!}',
                    style: const TextStyle(
                      fontSize: 16,
                      color: Colors.black45,
                    ),
                  ),
                  trailing: Text(
                    'Seleccionar',
                    style: TextStyle(
                      color: ThemeApp.modalSelectItem,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pop(productos[index]);
                  },
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(thickness: 1);
              },
            ),
          );
        } else {
          return const _MessageSearch(
              mensaje: 'Algo salio mal obteniendo los productos.');
        }
      },
    );
  }

  List<Producto> _getProductosPorMaquina(List<Producto> productos) {
    List<Producto> lista = [];
    final prefs = AppPreferences();

    if (prefs.maquinaNombre.contains('BUDIN')) {
      productos.forEach((element) {
        if (element.nombre!.contains('BUDIN')) {
          lista.add(element);
        }
      });
    } else if (prefs.maquinaNombre.contains('DULCE')) {
      productos.forEach((element) {
        if (element.nombre!.contains('DULCE')) {
          lista.add(element);
        }
      });
    } else {
      productos.forEach((element) {
        if (element.nombre!.contains('ROSCA') ||
            element.nombre!.contains('BIZCOCHUELO')) {
          lista.add(element);
        }
      });
    }
    return lista;
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

class _LoadingProducto extends StatelessWidget {
  const _LoadingProducto({
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
            text: 'Buscando maquinas',
            height: 3,
          ),
        ],
      ),
    );
  }
}
