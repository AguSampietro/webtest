import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:webtest/src/cubit/producto_cubit.dart';

import 'package:webtest/src/utils/theme.dart';
import 'package:webtest/src/widgets/loading.dart';

class ProductoFiltro extends StatelessWidget {
  TextEditingController _filtroController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<ProductoCubit, ProductoState>(
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
                if (text.length > 2) {
                  context.read<ProductoCubit>().PRO_productos(text);
                }
              },
              decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                suffix: GestureDetector(
                  onTap: () {
                    _filtroController.text = "";
                    FocusScope.of(context).unfocus();
                    context.read<ProductoCubit>().PRO_productos('');
                  },
                  child: const Icon(Icons.cancel, color: Colors.black38),
                ),
                border: InputBorder.none,
                hintStyle: TextStyle(color: Colors.grey.withOpacity(.8)),
                hintText: "Ingresá un filtro de busqueda",
              ),
            ),
          ),
          trailing: ElevatedButton.icon(
            label: Text('QR Escaner'),
            icon: const Icon(
              Icons.qr_code_scanner,
              color: Colors.white,
            ),
            onPressed: () {
              FocusScope.of(context).unfocus();
              //context.read<BobinaCubit>().PRO_productos('');
            },
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
