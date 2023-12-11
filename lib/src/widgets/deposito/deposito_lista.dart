import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webtest/src/cubit/deposito_cubit.dart';
import 'package:webtest/src/utils/theme.dart';
import 'package:webtest/src/widgets/loading.dart';

class DepositoLista extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    //context.read<DepositoCubit>().PRO_Depositos();

    return BlocConsumer<DepositoCubit, DepositoState>(
      listener: (context, state) {},
      builder: (context, state) {
        if (state == null) return Text('State error');

        if (state is DepositoInitial) {
          return _MessageSearch(mensaje: 'Comenzando busqueda de depositos');
        } else if (state is DepositoLoading) {
          return _LoadingDeposito();
        } else if (state is DepositoError) {
          return _MessageSearch(mensaje: state.message);
        } else if (state is DepositoLoaded) {
          return Expanded(
            child: RefreshIndicator(
              onRefresh: () => context.read<DepositoCubit>().PRO_depositos(),
              child: ListView.separated(
                physics: const AlwaysScrollableScrollPhysics(),
                shrinkWrap: true,
                primary: false,
                padding: const EdgeInsets.only(
                    bottom: kFloatingActionButtonMargin + 48),
                scrollDirection: Axis.vertical,
                itemCount: state.depositos.length,
                itemBuilder: (context, index) {
                  return ListTile(
                    title: Text(
                      state.depositos[index].nombre!,
                      style: const TextStyle(
                        fontSize: 20,
                      ),
                    ),
                    subtitle: Text(
                      'Codigo: ${state.depositos[index].deposito!}',
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
                      Navigator.of(context).pop(state.depositos[index]);
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
          return const _MessageSearch(
              mensaje: 'Algo salio mal obteniendo las depositos.');
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

class _LoadingDeposito extends StatelessWidget {
  const _LoadingDeposito({
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
            text: 'Buscando Depositos',
            height: 3,
          ),
        ],
      ),
    );
  }
}
