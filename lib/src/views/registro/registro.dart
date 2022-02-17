import 'package:flutter/material.dart';
import 'package:webtest/src/services/preferences/app_preferences.dart';
import 'package:webtest/src/widgets/registros/registro_detalle.dart';

class RegistroView extends StatefulWidget {
  static const routeName = '/registro';

  const RegistroView({
    Key? key,
  }) : super(key: key);

  @override
  State<RegistroView> createState() => _RegistroViewState();
}

class _RegistroViewState extends State<RegistroView> {
  final prefs = AppPreferences();

  String _registroId = '';

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    _registroId = ModalRoute.of(context)!.settings.arguments as String;

    final double widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('REGISTRO DE PRODUCCION'),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Column(
            children: [
              RegistrosDetalleView(id: _registroId),
              const SizedBox(height: 100),
            ],
          ),
        ),
      ),
    );
  }
}
