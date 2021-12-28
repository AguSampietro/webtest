import 'package:flutter/material.dart';
import 'package:webtest/src/views/nuevo_registro/nuevo_registro_view.dart';

import 'package:webtest/src/views/nuevo_registro/widgets/maquina_card.dart';

import 'package:webtest/src/views/nuevo_registro/widgets/operario_card.dart';
import 'package:webtest/src/services/preferences/app_preferences.dart';

import '../settings/settings_view.dart';

class HomeView extends StatefulWidget {
  static const routeName = '/home';

  const HomeView({
    Key? key,
  }) : super(key: key);

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  Widget build(BuildContext context) {
    final prefs = AppPreferences();
    final double widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        title: const Text('HORES - REGISTRO DE PRODUCCION'),
        actions: [
          IconButton(
            icon: const Icon(Icons.settings),
            onPressed: () {
              Navigator.pushNamed(context, SettingsView.routeName)
                  .then((value) {
                setState(() {});
              });
            },
          ),
        ],
      ),
      body: Column(
        children: [
          SizedBox(height: 10),
          Row(
            children: [
              Container(
                  margin: const EdgeInsets.only(left: 10, right: 5),
                  child:
                      Image.asset('assets/images/logo_hores.png', width: 110)),
              MaquinaCard(),
              OperarioCard(),
            ],
          ),
          Expanded(
            child: Container(
              child: SingleChildScrollView(
                child: Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const Text('REGISTROS CARGADOS'),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.pushNamed(context, NuevoRegistroView.routeName)
              .then((value) {
            setState(() {});
          });
        },
        child: Icon(Icons.add),
      ),
    );
  }
}
