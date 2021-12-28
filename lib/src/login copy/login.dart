// import 'package:flutter/material.dart';
// import 'package:webtest/src/nuevo_registro/nuevo_registro_view.dart';

// import 'package:webtest/src/nuevo_registro/widgets/maquina_card.dart';

// import 'package:webtest/src/nuevo_registro/widgets/operario_card.dart';
// import 'package:webtest/src/services/preferences/app_preferences.dart';

// import '../settings/settings_view.dart';

// class LoginView extends StatefulWidget {
//   static const routeName = '/login';

//   const LoginView({
//     Key? key,
//   }) : super(key: key);

//   @override
//   State<LoginView> createState() => _LoginViewState();
// }

// class _LoginViewState extends State<LoginView> {
//   @override
//   Widget build(BuildContext context) {
//     final prefs = AppPreferences();
//     final double widthScreen = MediaQuery.of(context).size.width;
//     return Scaffold(
//       body: SafeArea(
//         child: Column(
//           children: [
//             SizedBox(height: 10),
//             Row(
//               children: [
//                 Container(
//                     margin: const EdgeInsets.only(left: 10, right: 5),
//                     child: Image.asset('assets/images/logo_hores.png',
//                         width: 110)),
//                 MaquinaCard(),
//                 OperarioCard(),
//               ],
//             ),
//             Expanded(
//               child: Container(
//                 child: SingleChildScrollView(
//                   child: Container(
//                     child: Column(
//                       mainAxisAlignment: MainAxisAlignment.center,
//                       crossAxisAlignment: CrossAxisAlignment.center,
//                       children: [
//                         const Text('REGISTROS CARGADOS'),
//                       ],
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }
