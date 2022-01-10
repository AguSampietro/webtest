import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webtest/src/cubit/fallo_cubit.dart';

import 'package:webtest/src/utils/theme.dart';
import 'package:webtest/src/widgets/loading.dart';

class FalloFiltro extends StatelessWidget {
  TextEditingController _filtroController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<FalloCubit, FalloState>(
      listener: (context, state) {},
      builder: (context, state) {
        return ListTile(
          title: Container(
            margin: EdgeInsets.only(left: 20, right: 20),
            decoration: BoxDecoration(
                border:
                    Border(bottom: BorderSide(color: Colors.grey.shade300))),
            child: TextField(
              controller: _filtroController,
              keyboardType: TextInputType.emailAddress,
              onChanged: (text) {
                if (text.length > 1) {
                  context.read<FalloCubit>().PRO_fallos(text);
                } else if (text.length == 0) {
                  context.read<FalloCubit>().PRO_fallos('');
                }
              },
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                suffix: GestureDetector(
                  onTap: () {
                    _filtroController.text = "";
                    FocusScope.of(context).unfocus();
                    context.read<FalloCubit>().PRO_fallos('');
                  },
                  child: const Icon(Icons.cancel, color: Colors.black38),
                ),
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.grey.withOpacity(.8)),
                hintText: "Ingresá un filtro de busqueda",
              ),
            ),
          ),
        );
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
            text: 'Buscando maquinas',
            height: 3,
          ),
        ],
      ),
    );
  }
}
