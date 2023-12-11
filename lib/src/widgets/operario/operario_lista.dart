import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webtest/src/cubit/operario_cubit.dart';
import 'package:webtest/src/models/operario.dart';
import 'package:webtest/src/utils/theme.dart';
import 'package:webtest/src/widgets/loading.dart';

class OperarioLista extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //context.read<OperarioCubit>().PRO_operarios();

    return BlocConsumer<OperarioCubit, OperarioState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state == null) return Text('State error');

        if (state is OperarioInitial) {
          return _MessageSearch(mensaje: 'Comenzando busqueda de maquinas');
        } else if (state is OperarioLoading) {
          return _LoadingOperario();
        } else if (state is OperarioError) {
          return _MessageSearch(mensaje: state.message);
        } else if (state is OperarioLoaded) {
          return Expanded(
            child: RefreshIndicator(
              onRefresh: () => context.read<OperarioCubit>().PRO_operarios(),
              child: ListView.separated(
                physics: const AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                primary: false,
                padding: const EdgeInsets.only(
                    bottom: kFloatingActionButtonMargin + 48),
                scrollDirection: Axis.vertical,
                itemCount: state.operarios.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      state.operarios[index].nombre!,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    trailing: Text(
                      'Seleccionar',
                      style: TextStyle(
                        color: ThemeApp.modalSelectItem,
                      ),
                    ),
                    onTap: () {
                      Navigator.of(context).pop(state.operarios[index]);
                    },
                  );
                },
                separatorBuilder: (context, index) {
                  return const Divider(thickness: 1);
                },
              ),
            ),
          );
        } else {
          return _MessageSearch(
              mensaje: 'Algo salio mal obteniendo los operarios.');
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

class _LoadingOperario extends StatelessWidget {
  const _LoadingOperario({
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
            text: 'Buscando operarios',
            height: 3,
          ),
        ],
      ),
    );
  }
}
