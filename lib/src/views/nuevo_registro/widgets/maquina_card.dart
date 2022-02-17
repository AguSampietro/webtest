import 'package:flutter/material.dart';
import 'package:webtest/src/models/maquina.dart';
import 'package:webtest/src/services/preferences/app_preferences.dart';
import 'package:webtest/src/utils/enum_types.dart';
import 'package:webtest/src/utils/modal.dart';
import 'package:webtest/src/utils/utils.dart';

class MaquinaCard extends StatefulWidget {
  MaquinaCard({Key? key, required this.onRefresh}) : super(key: key);

  Function onRefresh;

  @override
  _MaquinaCardState createState() => _MaquinaCardState();
}

class _MaquinaCardState extends State<MaquinaCard> {
  final double radious = 5;

  @override
  Widget build(BuildContext context) {
    final prefs = AppPreferences();
    print('prefs.maquina: ${prefs.maquinaNombre}');
    String maq = (prefs.maquinaId.isEmpty)
        ? 'CONFIGURE UNA MAQUINA'
        : prefs.maquinaNombre;
    return Expanded(
      child: GestureDetector(
        onTap: prefs.usuarioTipo == UserType.OPERARIO
            ? () => Utils.snackBar(context,
                'No tiene permisos para modificar la maquina, contacte a un supervisor.')
            : () async {
                final prefs = AppPreferences();
                Maquina? maquina =
                    await Modal.seleccionarMaquina(context) as Maquina?;
                if (maquina != null) {
                  setState(() {
                    prefs.maquinaId = maquina.id!;
                    prefs.maquinaNombre = maquina.maquina!;
                    prefs.maquinaTipo = maquina.tipo!;
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
