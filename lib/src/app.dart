import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:provider/provider.dart';
import 'package:webtest/src/cubit/bobina_cubit.dart';
import 'package:webtest/src/cubit/producto_cubit.dart';
import 'package:webtest/src/cubit/fallo_cubit.dart';
import 'package:webtest/src/cubit/maquina_cubit.dart';
import 'package:webtest/src/cubit/operario_cubit.dart';
import 'package:webtest/src/cubit/registro_add_cubit.dart';
import 'package:webtest/src/cubit/registro_detalle_cubit.dart';
import 'package:webtest/src/cubit/registro_lista_cubit.dart';
import 'package:webtest/src/views/home/home.dart';
import 'package:webtest/src/views/login/login.dart';

import 'package:webtest/src/views/nuevo_registro/nuevo_registro_view.dart';
import 'package:webtest/src/views/registro/registro.dart';
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
    return MultiProvider(
      providers: [
        BlocProvider<MaquinaCubit>(
          create: (BuildContext context) => MaquinaCubit()..PRO_maquinas(),
        ),
        BlocProvider<OperarioCubit>(
          create: (BuildContext context) => OperarioCubit()..PRO_operarios(),
        ),
        BlocProvider<ProductoCubit>(
          create: (BuildContext context) => ProductoCubit()..PRO_productos(''),
        ),
        BlocProvider<BobinaCubit>(
          create: (BuildContext context) => BobinaCubit(),
        ),
        BlocProvider<FalloCubit>(
          create: (BuildContext context) => FalloCubit()..PRO_fallos(''),
        ),
        BlocProvider<RegistroListaCubit>(
          create: (BuildContext context) => RegistroListaCubit(),
        ),
        BlocProvider<RegistroAddCubit>(
          create: (BuildContext context) => RegistroAddCubit(),
        ),
        BlocProvider<RegistroDetalleCubit>(
          create: (BuildContext context) => RegistroDetalleCubit(),
        ),
      ],
      child: AnimatedBuilder(
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
                    case RegistroView.routeName:
                      return const RegistroView();
                    default:
                      return const VerificacionView();
                  }
                },
              );
            },
          );
        },
      ),
    );
  }
}
