import 'package:flutter/material.dart';

import 'package:webtest/src/services/preferences/app_preferences.dart';
import 'package:webtest/src/views/verificacion/verificacion.dart';

class LoginView extends StatefulWidget {
  static const routeName = '/login';

  const LoginView({
    Key? key,
  }) : super(key: key);

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  String _mail = '';
  String _clave = '';

  @override
  Widget build(BuildContext context) {
    final prefs = AppPreferences();
    final double widthScreen = MediaQuery.of(context).size.width;
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Theme.of(context).primaryColor,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Container(
            width: size.width,
            height: size.height,
            child: Column(
              children: [
                Expanded(flex: 1, child: Container()),
                Expanded(
                  flex: 2,
                  child: Container(
                    margin: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      shape: BoxShape.circle,
                    ),
                    child:
                        Image.asset('assets/images/logo_hores.png', width: 400),
                  ),
                ),
                Expanded(
                  flex: 1,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Container(
                        child: const Text(
                          'REGISTRO DE PRODUCCIÓN\nINGRESO DE USUARIO',
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 30,
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 3,
                  child: Column(
                    children: [
                      Container(
                        width: size.width * 0.7,
                        decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.all(Radius.circular(10)),
                        ),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                  border: Border(
                                      bottom: BorderSide(
                                          color: Colors.grey.shade300))),
                              child: TextField(
                                keyboardType: TextInputType.emailAddress,
                                onChanged: (text) {
                                  setState(() {
                                    _mail = text;
                                  });
                                },
                                decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.person),
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(
                                        color: Colors.grey.withOpacity(.8)),
                                    hintText: "Ingresá tu nombre de usuario"),
                              ),
                            ),
                            Container(
                              decoration: BoxDecoration(),
                              child: TextField(
                                onChanged: (text) {
                                  setState(() {
                                    _clave = text;
                                  });
                                },
                                obscureText: true,
                                decoration: InputDecoration(
                                    prefixIcon: const Icon(Icons.lock),
                                    border: InputBorder.none,
                                    hintStyle: TextStyle(
                                        color: Colors.grey.withOpacity(.8)),
                                    hintText: "Ingresá tu contraseña"),
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 20),
                      Center(
                        child: Column(
                          children: <Widget>[
                            GestureDetector(
                              onTap: () {
                                // LLAMA A LA API
                                if (_mail.isEmpty || _clave.isEmpty) {
                                  // ignore: deprecated_member_use
                                  scaffoldKey.currentState?.showSnackBar(
                                    const SnackBar(
                                      content: Text(
                                          'Debe ingreser sus credenciales de usuario'),
                                    ),
                                  );
                                } else {
                                  final prefs = AppPreferences();
                                  prefs.logged = true;
                                  Navigator.pushReplacementNamed(
                                      context, VerificacionView.routeName);
                                  // utils.modalLoading(context, 'VALIDANDO DATOS DEL USUARIO');
                                }
                              },
                              child: Container(
                                width: 250,
                                padding: const EdgeInsets.all(18),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(50),
                                  //color: Colors.deepPurple[900],
                                  border: Border.all(
                                    color: Colors.white,
                                    width: 1.5,
                                    style: BorderStyle.solid,
                                  ),
                                ),
                                child: const Center(
                                    child: Text(
                                  "INGRESAR",
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w700,
                                    fontSize: 18,
                                  ),
                                )),
                              ),
                            ),
                            const SizedBox(height: 20),
                            SizedBox(
                              width: size.width * 0.7,
                              child: TextButton(
                                onPressed: () {
                                  //Navigator.of(context).pushNamed('recupero');
                                },
                                child: const Text(
                                  "OLVIDE MI CLAVE",
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.w600),
                                ),
                              ),
                            ),
                            Container(
                              width: double.infinity,
                              margin: const EdgeInsets.symmetric(
                                vertical: 20,
                                horizontal: 80,
                              ),
                              child: const Center(
                                  child: Text(
                                "Todos los usuarios deben ser creados y gestionados desde el sistema Atila Online. Consulte con sus superiores en caso de no poseer credenciales de acceso.",
                                textAlign: TextAlign.center,
                                style: TextStyle(
                                    color: Colors.white,
                                    fontWeight: FontWeight.w300),
                              )),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                // Expanded(child: Container()),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
