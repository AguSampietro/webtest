import 'package:flutter/material.dart';
import 'package:webtest/src/models/deposito.dart';
import 'package:webtest/src/models/maquina.dart';
import 'package:webtest/src/services/preferences/app_preferences.dart';
import 'package:webtest/src/utils/enum_types.dart';
import 'package:webtest/src/utils/modal.dart';
import 'package:webtest/src/utils/utils.dart';

class DepositoCard extends StatefulWidget {
  DepositoCard({Key? key, required this.onRefresh}) : super(key: key);

  Function onRefresh;

  @override
  _DepositoCardState createState() => _DepositoCardState();
}

class _DepositoCardState extends State<DepositoCard> {
  final double radious = 5;

  @override
  Widget build(BuildContext context) {
    final prefs = AppPreferences();
    print('prefs.maquina: ${prefs.depositoNombre}');
    String maq = (prefs.depositoId.isEmpty)
        ? 'CONFIGURE UNA MAQUINA'
        : prefs.depositoNombre;
    return Expanded(
      child: GestureDetector(
        onTap: prefs.usuarioTipo == UserType.OPERARIO
            ? () => Utils.snackBar(context,
                'No tiene permisos para modificar la maquina, contacte a un supervisor.')
            : () async {
                final prefs = AppPreferences();
                Deposito? deposito =
                    await Modal.seleccionarDeposito(context) as Deposito?;
                if (deposito != null) {
                  setState(() {
                    prefs.depositoId = deposito.deposito!;
                    prefs.depositoNombre = deposito.nombre!;
                  });

                  widget.onRefresh();
                }
              },
        child: Container(
          height: 60,
          margin: const EdgeInsets.symmetric(horizontal: 1, vertical: 1),
          padding: const EdgeInsets.symmetric(horizontal: 5, vertical: 0),
          decoration: BoxDecoration(
            border: Utils.borderApp,
            color: Colors.grey[200],
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'MAQUINA UTILIZADA:',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              if (maq.isNotEmpty)
                Text(
                  maq,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                )
            ],
          ),
        ),
      ),
    );
  }
}
