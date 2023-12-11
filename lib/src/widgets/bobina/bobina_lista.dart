import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webtest/src/cubit/bobina_cubit.dart';
import 'package:webtest/src/models/bobina.dart';
import 'package:webtest/src/utils/theme.dart';
import 'package:webtest/src/widgets/loading.dart';

class BobinaLista extends StatelessWidget {
  BobinaLista({required this.trabajando});

  final bool trabajando;
  @override
  Widget build(BuildContext context) {
    context.read<BobinaCubit>().PRO_productos('');

    return BlocConsumer<BobinaCubit, BobinaState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state == null) return Text('State error');

        if (state is BobinaInitial) {
          return const _MessageSearch(
              mensaje: 'Comenzando busqueda de bobinas');
        } else if (state is BobinaLoading) {
          return const _LoadingBobina();
        } else if (state is BobinaError) {
          return _MessageSearch(mensaje: state.message);
        } else if (state is BobinaLoaded) {
          List<Bobina> bobinas = [];

          bobinas = state.bobinas!;

          return Expanded(
            child: ListView.separated(
              physics: const NeverScrollableScrollPhysics(),
              shrinkWrap: true,
              primary: false,
              padding: const EdgeInsets.only(
                  bottom: kFloatingActionButtonMargin + 48),
              scrollDirection: Axis.vertical,
              itemCount: bobinas.length,
              itemBuilder: (context, index) {
                return ListTile(
                  title: Text(
                    bobinas[index].nombre!,
                    style: const TextStyle(
                      fontSize: 20,
                    ),
                  ),
                  subtitle: Text(
                    'Código: ${bobinas[index].codproducto!}',
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
                    Navigator.of(context).pop(bobinas[index]);
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
              mensaje: 'Algo salio mal obteniendo las bobinas.');
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
            color: Colors.blue,
            text: 'Buscando maquinas',
            height: 3,
          ),
        ],
      ),
    );
  }
}
