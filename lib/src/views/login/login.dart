import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:provider/src/provider.dart';
import 'package:webtest/src/cubit/operario_cubit.dart';
import 'package:webtest/src/models/operario.dart';
import 'package:webtest/src/models/supervisor.dart';

import 'package:webtest/src/services/preferences/app_preferences.dart';
import 'package:webtest/src/utils/enum_types.dart';
import 'package:webtest/src/utils/utils.dart';
import 'package:webtest/src/views/verificacion/verificacion.dart';
import 'package:webtest/src/widgets/accept_button.dart';
import 'package:webtest/src/widgets/cancel_button.dart';

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
  final _formKeySupervisor = GlobalKey<FormState>();
  final _formKeyOperario = GlobalKey<FormState>();

  String _claveSuper = '';
  String _legajo = '';

  @override
  void setState(VoidCallback fn) {
    // TODO: implement setState
    super.setState(fn);
    final prefs = AppPreferences();
    prefs.puedeProcesar = false;
    prefs.puedeConfigurar = false;
  }

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
                      Center(
                        child: Column(
                          children: <Widget>[
                            _loginOperarios(context, size),
                            const SizedBox(height: 10),
                            _loginSupervisor(context, size),
                            const SizedBox(height: 10),
                            _loginEncargado(context, size),
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

  Widget _loginOperarios(BuildContext context, Size size) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Stack(
                  children: <Widget>[
                    Form(
                      key: _formKeyOperario,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const Text(
                            'Ingrese sus credenciales, las cuales son su legajo.\nTendra acceso a todos los registros generados por su usuario.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 40),
                          Container(
                            width: size.width * 0.7,
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                                border: Border(
                                    bottom: BorderSide(
                                        color: Colors.grey.shade300))),
                            child: TextField(
                              keyboardType: TextInputType.number,
                              onChanged: (text) {
                                setState(() {
                                  _legajo = text;
                                });
                              },
                              decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.person),
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                      color: Colors.grey.withOpacity(.8)),
                                  hintText: "Ingresá tu legajo de operario"),
                            ),
                          ),
                          // Container(
                          //   padding: EdgeInsets.all(8.0),
                          //   width: size.width * 0.7,
                          //   decoration: BoxDecoration(),
                          //   child: TextField(
                          //     onChanged: (text) {
                          //       setState(() {
                          //         _clave = text;
                          //       });
                          //     },
                          //     obscureText: true,
                          //     keyboardType: TextInputType.number,
                          //     decoration: InputDecoration(
                          //         prefixIcon: const Icon(Icons.lock),
                          //         border: InputBorder.none,
                          //         hintStyle: TextStyle(
                          //             color: Colors.grey.withOpacity(.8)),
                          //         hintText: "Ingresá tu contraseña"),
                          //   ),
                          // ),
                          const SizedBox(height: 40),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  child: CancelButton(
                                    onPressed: () {
                                      Navigator.pop(context, 'cancel');
                                    },
                                    text: 'CANCELAR',
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  child: AcceptButton(
                                    onPressed: () async {
                                      // LLAMA A LA API
                                      if (_legajo.isEmpty) {
                                        // ignore: deprecated_member_use
                                        Utils.snackBar(context,
                                            'Debe ingreser sus credenciales de usuario');
                                      } else {
                                        final prefs = AppPreferences();
                                        prefs.logged = false;
                                        Operario operario = await context
                                            .read<OperarioCubit>()
                                            .PRO_operario(_legajo);

                                        if (operario.legajo! == _legajo) {
                                          prefs.logged = true;
                                          prefs.usuarioTipo = UserType.OPERARIO;
                                          prefs.tipoFiltro =
                                              FiltrosType.OPERARIOS;
                                          prefs.operarioId = operario.legajo!;
                                          prefs.operarioNombre =
                                              operario.nombre!;

                                          prefs.puedeProcesar = false;
                                          prefs.puedeConfigurar = false;

                                          Navigator.pushReplacementNamed(
                                              context,
                                              VerificacionView.routeName);
                                        } else {
                                          Utils.snackBar(context,
                                              'No se encontro el operario');
                                        }

                                        // utils.modalLoading(context, 'VALIDANDO DATOS DEL USUARIO');
                                      }
                                    },
                                    text: 'INGRESAR',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            });
      },
      child: Container(
        width: 520,
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
          // child: Text(
          //   "INGRESAR COMO OPERARIO",
          //   textAlign: TextAlign.center,
          //   style: TextStyle(
          //     color: Colors.white,
          //     fontWeight: FontWeight.w700,
          //     fontSize: 18,
          //   ),
          // ),
          child: ListTile(
            leading: Icon(
              FontAwesomeIcons.hardHat,
              color: Colors.white,
              size: 40,
            ),
            title: Text(
              "INGRESAR COMO OPERARIO",
              textAlign: TextAlign.center,
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _loginSupervisor(BuildContext context, Size size) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Stack(
                  children: <Widget>[
                    Form(
                      key: _formKeySupervisor,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const Text(
                            'Ingrese sus clave de supervisor.\nTendra acceso a todos los registros generados por los operarios.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 40),
                          Container(
                            width: size.width * 0.7,
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.grey.shade300,
                                ),
                              ),
                            ),
                            child: TextField(
                              keyboardType: TextInputType.emailAddress,
                              onChanged: (text) {
                                setState(() {
                                  _claveSuper = text;
                                });
                              },
                              decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.person),
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                      color: Colors.grey.withOpacity(.8)),
                                  hintText: "Ingresá tu clave de supervsor"),
                            ),
                          ),
                          const SizedBox(height: 40),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  child: CancelButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    text: 'CANCELAR',
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  child: AcceptButton(
                                    onPressed: () async {
                                      // LLAMA A LA API
                                      if (_claveSuper.isEmpty) {
                                        Utils.snackBar(context,
                                            'Debe ingreser sus credenciales de usuario');
                                      } else {
                                        final prefs = AppPreferences();
                                        prefs.logged = false;

                                        Supervisor operario = await context
                                            .read<OperarioCubit>()
                                            .PRO_supervisor(_claveSuper);

                                        if (operario.claveacceso! ==
                                                _claveSuper &&
                                            operario.nombre!.contains('-PR')) {
                                          prefs.puedeProcesar = true;
                                          prefs.puedeConfigurar = false;
                                          Navigator.pushReplacementNamed(
                                              context,
                                              VerificacionView.routeName);
                                        } else {
                                          Utils.snackBar(context,
                                              'No se encontro el supervisor');
                                        }
                                      }
                                    },
                                    text: 'INGRESAR',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            });
      },
      child: Container(
        width: 520,
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
        // child: const Center(
        //   child: Text(
        //     "INGRESAR COMO SUPERVISOR",
        //     textAlign: TextAlign.center,
        //     style: TextStyle(
        //       color: Colors.white,
        //       fontWeight: FontWeight.w700,
        //       fontSize: 18,
        //     ),
        //   ),
        // ),
        child: const ListTile(
          leading: Icon(
            FontAwesomeIcons.userCheck,
            color: Colors.white,
            size: 40,
          ),
          title: Text(
            "INGRESAR COMO SUPERVISOR",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }

  Widget _loginEncargado(BuildContext context, Size size) {
    return GestureDetector(
      onTap: () {
        showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                content: Stack(
                  children: <Widget>[
                    Form(
                      key: _formKeySupervisor,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[
                          const Text(
                            'Ingrese sus clave de encargado.\nTendra acceso a todos los registros generados por los operarios y la configuracion del sistema.',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 20,
                            ),
                          ),
                          const SizedBox(height: 40),
                          Container(
                            width: size.width * 0.7,
                            padding: EdgeInsets.all(8),
                            decoration: BoxDecoration(
                              border: Border(
                                bottom: BorderSide(
                                  color: Colors.grey.shade300,
                                ),
                              ),
                            ),
                            child: TextField(
                              keyboardType: TextInputType.emailAddress,
                              onChanged: (text) {
                                setState(() {
                                  _claveSuper = text;
                                });
                              },
                              decoration: InputDecoration(
                                  prefixIcon: const Icon(Icons.person),
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                      color: Colors.grey.withOpacity(.8)),
                                  hintText: "Ingresá tu clave de supervsor"),
                            ),
                          ),
                          const SizedBox(height: 40),
                          Row(
                            children: [
                              Expanded(
                                child: Container(
                                  child: CancelButton(
                                    onPressed: () {
                                      Navigator.of(context).pop();
                                    },
                                    text: 'CANCELAR',
                                  ),
                                ),
                              ),
                              Expanded(
                                child: Container(
                                  child: AcceptButton(
                                    onPressed: () async {
                                      // LLAMA A LA API
                                      if (_claveSuper.isEmpty) {
                                        Utils.snackBar(context,
                                            'Debe ingreser sus credenciales de usuario');
                                      } else {
                                        final prefs = AppPreferences();
                                        prefs.logged = false;
                                        Supervisor operario = await context
                                            .read<OperarioCubit>()
                                            .PRO_supervisor(_claveSuper);

                                        if (operario.claveacceso! ==
                                            _claveSuper) {
                                          prefs.logged = true;
                                          prefs.usuarioTipo =
                                              UserType.ENCARGADO;

                                          prefs.puedeProcesar = true;
                                          prefs.puedeConfigurar = true;

                                          Navigator.pushReplacementNamed(
                                              context,
                                              VerificacionView.routeName);
                                        } else {
                                          Utils.snackBar(context,
                                              'No se encontro el supervisor');
                                        }
                                      }
                                    },
                                    text: 'INGRESAR',
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            });
      },
      child: Container(
        width: 520,
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
        // child: const Center(
        //   child: Text(
        //     "INGRESAR COMO SUPERVISOR",
        //     textAlign: TextAlign.center,
        //     style: TextStyle(
        //       color: Colors.white,
        //       fontWeight: FontWeight.w700,
        //       fontSize: 18,
        //     ),
        //   ),
        // ),
        child: const ListTile(
          leading: Icon(
            FontAwesomeIcons.userTie,
            color: Colors.white,
            size: 40,
          ),
          title: Text(
            "INGRESAR COMO ENCARGADO",
            textAlign: TextAlign.center,
            style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
