import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webtest/src/cubit/fallo_cubit.dart';

import 'package:webtest/src/utils/theme.dart';
import 'package:webtest/src/widgets/loading.dart';

class FalloLista extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //context.read<FalloCubit>().PRO_fallos('');

    return BlocConsumer<FalloCubit, FalloState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state == null) return Text('State error');

        if (state is FalloInitial) {
          return _MessageSearch(mensaje: 'Comenzando busqueda de bobinas');
        } else if (state is FalloLoading) {
          return _LoadingFallo();
        } else if (state is FalloError) {
          return _MessageSearch(mensaje: state.message);
        } else if (state is FalloLoaded) {
          return Expanded(
            child: ListView.separated(
              physics: const AlwaysScrollableScrollPhysics(),
              shrinkWrap: true,
              primary: false,
              padding: const EdgeInsets.only(
                  bottom: kFloatingActionButtonMargin + 48),
              scrollDirection: Axis.vertical,
              itemCount: state.fallos.length,
              itemBuilder: (context, index) {
                return ListTile(
                  leading: Container(
                    width: 90,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          state.fallos[index].codfallo!,
                          style: const TextStyle(
                            fontSize: 18,
                            color: Colors.black87,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        const Text(
                          'CODIGO',
                          style: TextStyle(
                            fontSize: 13,
                            color: Colors.black54,
                            fontWeight: FontWeight.w300,
                          ),
                        ),
                      ],
                    ),
                  ),
                  title: Text(
                    state.fallos[index].descripcion!,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  // subtitle: Text(
                  //   'Código: ${state.fallos[index].codfallo!}',
                  //   style: const TextStyle(
                  //     fontSize: 18,
                  //   ),
                  // ),
                  trailing: Text(
                    'Seleccionar',
                    style: TextStyle(
                      color: ThemeApp.modalSelectItem,
                    ),
                  ),
                  onTap: () {
                    Navigator.of(context).pop(state.fallos[index]);
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
              mensaje: 'Algo salio mal obteniendo los fallos.');
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

class _LoadingFallo extends StatelessWidget {
  const _LoadingFallo({
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
            text: 'Buscando fallos',
            height: 3,
          ),
        ],
      ),
    );
  }
}
