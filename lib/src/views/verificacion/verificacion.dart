import 'package:flutter/material.dart';
import 'package:webtest/src/views/home/home.dart';
import 'package:webtest/src/views/login/login.dart';
import 'package:webtest/src/services/preferences/app_preferences.dart';
import 'package:webtest/src/utils/theme.dart';

class VerificacionView extends StatefulWidget {
  static const routeName = '/verificacion';

  const VerificacionView({
    Key? key,
  }) : super(key: key);

  @override
  State<VerificacionView> createState() => _VerificacionViewState();
}

class _VerificacionViewState extends State<VerificacionView> {
  @override
  void initState() {
    super.initState();

    final prefs = AppPreferences();

    Future.delayed(Duration(seconds: 2), () {
      if (prefs.logged) {
        Navigator.of(context).pushReplacementNamed(HomeView.routeName);
      } else {
        Navigator.of(context).pushReplacementNamed(LoginView.routeName);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final prefs = AppPreferences();
    final double widthScreen = MediaQuery.of(context).size.width;
    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: Column(
          children: [
            Expanded(flex: 1, child: Container()),
            Expanded(
              flex: 4,
              child: Container(
                margin: const EdgeInsets.all(10),
                decoration: const BoxDecoration(
                  color: Colors.white,
                  shape: BoxShape.circle,
                ),
                child: Image.asset('assets/images/logo_hores.png', width: 400),
              ),
            ),
            Expanded(
              flex: 1,
              child: Container(
                child: const Text(
                  'REGISTRO DE PRODUCCIÓN',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 3,
              child: Column(
                children: [
                  Container(
                    margin: const EdgeInsets.only(top: 20, bottom: 20),
                    child: const CircularProgressIndicator(
                      valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
                    ),
                  ),
                  Container(
                    child: const Text(
                      'VALIDANDO DATOS LOCALES...',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.white,
                        fontWeight: FontWeight.w300,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              padding: const EdgeInsets.all(10),
              margin: const EdgeInsets.only(bottom: 20),
              width: 100,
              decoration: const BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.all(Radius.circular(10)),
              ),
              child: Image.asset(
                'assets/images/atila.png',
                width: 100,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
