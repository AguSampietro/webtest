import 'package:flutter/material.dart';
import 'package:webtest/src/models/operario.dart';
import 'package:webtest/src/services/preferences/app_preferences.dart';
import 'package:webtest/src/utils/enum_types.dart';
import 'package:webtest/src/utils/utils.dart';
import 'package:webtest/src/utils/modal.dart';

class OperarioCard extends StatefulWidget {
  OperarioCard({Key? key}) : super(key: key);

  @override
  _OperarioCardState createState() => _OperarioCardState();
}

class _OperarioCardState extends State<OperarioCard> {
  final double radious = 5;

  @override
  Widget build(BuildContext context) {
    final prefs = AppPreferences();
    print('prefs.operario: ${prefs.operarioNombre}');
    String ope = (prefs.operarioId.isEmpty)
        ? 'CONFIGURE UN OPERARIO'
        : prefs.operarioNombre;
    return Expanded(
      child: GestureDetector(
        onTap: prefs.usuarioTipo == UserType.OPERARIO
            ? () => Utils.snackBar(
                context, 'No tiene permisos para modificar el operario')
            : () async {
                final prefs = AppPreferences();
                Operario? operario =
                    await Modal.seleccionarOperario(context) as Operario?;
                if (operario != null) {
                  setState(() {
                    prefs.operarioId = operario.legajo!;
                    prefs.operarioNombre = operario.nombre!;
                  });
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
                'OPERARIO EN TURNO: ',
                style: TextStyle(
                  fontSize: 16,
                ),
              ),
              Text(
                ope.isEmpty ? '' : ope,
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
