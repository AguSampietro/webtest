// import 'dart:convert';

// import 'package:bloc/bloc.dart';
// import 'package:equatable/equatable.dart';
// import 'package:http/http.dart' as http;

// import 'package:webtest/src/models/usuario.dart';
// import 'package:webtest/src/utils/utils.dart';

// part 'login_state.dart';

// class LoginCubit extends Cubit<LoginState> {
//   LoginCubit() : super(LoginInitial());

//   Future<void> obtenerDia(String user, String password) async {
//     try {
//       emit(const LoginLoading());
//       print('API CUBIT - BUSCANDO DIA DEL PLAN');

//       final url = Uri.parse('${Utils.api_url}/obtenerDia');

//       print(jsonEncode(<String, String>{
//         'usuario': user,
//         'clave': password,
//       }));
//       final http.Response response = await http.post(
//         url,
//         headers: <String, String>{
//           'Content-Type': 'application/json; charset=UTF-8',
//         },
//         body: jsonEncode(<String, String>{
//           'usuario': user,
//           'clave': password,
//         }),
//       );
//       print('RESPONSE CODE ${response.statusCode} - ${response.body}');
//       if (response.statusCode == 200) {
//         final u = Usuario.fromJson(jsonDecode(response.body));
//         emit(LoginLoaded(usuario: u));
//       } else {
//         emit(LoginError('No existe el usuario'));
//       }
//     } catch (e) {
//       emit(LoginError(e.toString()));
//     }
//   }
// }
