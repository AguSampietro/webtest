import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webtest/src/cubit/bobina_cubit.dart';

import 'package:webtest/src/utils/theme.dart';
import 'package:webtest/src/widgets/loading.dart';

class BobinaLista extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    context.read<BobinaCubit>().PRO_productos('');

    return BlocConsumer<BobinaCubit, BobinaState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state == null) return Text('State error');

        if (state is BobinaInitial) {
          return _MessageSearch(mensaje: 'Comenzando busqueda de bobinas');
        } else if (state is BobinaLoading) {
          return _LoadingBobina();
        } else if (state is BobinaError) {
          return _MessageSearch(mensaje: state.message);
        } else if (state is BobinaLoaded) {
          return Expanded(
            child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              primary: false,
              padding: const EdgeInsets.only(
                  bottom: kFloatingActionButtonMargin + 48),
              scrollDirection: Axis.vertical,
              itemCount: state.bobinas.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    state.bobinas[index].nombre!,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  subtitle: Text(
                    'Código: ${state.bobinas[index].codproducto!}',
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
                    Navigator.of(context).pop(state.bobinas[index]);
                  },
                );
              },
              separatorBuilder: (context, index) {
                return const Divider(thickness: 1);
              },
            ),
          );
        } else {
          return _MessageSearch(
              mensaje: 'Algo salio mal obteniendo las maquinas.');
        }
      },
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

class _LoadingBobina extends StatelessWidget {
  const _LoadingBobina({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          LoadingSpinner(
            color: Theme.of(context).primaryColor,
            text: 'Buscando maquinas',
            height: 3,
          ),
        ],
      ),
    );
  }
}
