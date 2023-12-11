import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webtest/src/cubit/maquina_cubit.dart';
import 'package:webtest/src/models/maquina.dart';
import 'package:webtest/src/utils/theme.dart';
import 'package:webtest/src/widgets/loading.dart';

class MaquinaLista extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //context.read<MaquinaCubit>().PRO_maquinas();

    return BlocConsumer<MaquinaCubit, MaquinaState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state == null) return Text('State error');

        if (state is MaquinaInitial) {
          return _MessageSearch(mensaje: 'Comenzando busqueda de maquinas');
        } else if (state is MaquinaLoading) {
          return _LoadingMaquina();
        } else if (state is MaquinaError) {
          return _MessageSearch(mensaje: state.message);
        } else if (state is MaquinaLoaded) {
          return Expanded(
            child: RefreshIndicator(
              onRefresh: () => context.read<MaquinaCubit>().PRO_maquinas(),
              child: ListView.separated(
                physics: const AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                primary: false,
                padding: const EdgeInsets.only(
                    bottom: kFloatingActionButtonMargin + 48),
                scrollDirection: Axis.vertical,
                itemCount: state.maquinas.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      state.maquinas[index].maquina!,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    subtitle: Text(
                      'Tipo: ${state.maquinas[index].tipo!}',
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
                      Navigator.of(context).pop(state.maquinas[index]);
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

class _LoadingMaquina extends StatelessWidget {
  const _LoadingMaquina({
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
