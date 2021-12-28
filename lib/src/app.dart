import 'package:flutter/material.dart';
import 'package:webtest/src/views/home/home.dart';
import 'package:webtest/src/views/login/login.dart';

import 'package:webtest/src/views/nuevo_registro/nuevo_registro_view.dart';
import 'package:webtest/src/views/verificacion/verificacion.dart';

import 'views/settings/settings_controller.dart';
import 'views/settings/settings_view.dart';

class MyApp extends StatelessWidget {
  const MyApp({
    Key? key,
    required this.settingsController,
  }) : super(key: key);

  final SettingsController settingsController;

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: settingsController,
      builder: (BuildContext context, Widget? child) {
        return MaterialApp(
          restorationScopeId: 'app',
          theme: ThemeData(),
          darkTheme: ThemeData.dark(),
          themeMode: settingsController.themeMode,
          debugShowCheckedModeBanner: false,
          onGenerateRoute: (RouteSettings routeSettings) {
            return MaterialPageRoute<void>(
              settings: routeSettings,
              builder: (BuildContext context) {
                switch (routeSettings.name) {
                  case SettingsView.routeName:
                    return SettingsView(controller: settingsController);
                  case HomeView.routeName:
                    return const HomeView();
                  case NuevoRegistroView.routeName:
                    return const NuevoRegistroView();
                  case LoginView.routeName:
                    return const LoginView();
                  case VerificacionView.routeName:
                    return const VerificacionView();
                  default:
                    return const VerificacionView();
                }
              },
            );
          },
        );
      },
    );
  }
}
