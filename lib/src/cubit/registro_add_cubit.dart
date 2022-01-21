import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:webtest/src/models/registro_produccion.dart';
import 'package:webtest/src/models/respuesta.dart';

import 'package:webtest/src/utils/utils.dart';

part 'registro_add_state.dart';

class RegistroAddCubit extends Cubit<RegistroAddState> {
  RegistroAddCubit() : super(RegistroAddInitial());

  Future<void> PRO_insertRegistro(RegistroProduccion reg) async {
    try {
      emit(const RegistroAddLoading());
      print('API CUBIT - INSERTANDO REGISTRO');

      final url = Uri.parse('${Utils.api_url}/PRO_insertRegistro');

      final http.Response response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(reg.toJson()),
      );

      print('RESPONSE CODE ${response.statusCode} - ${response.body}');
      if (response.statusCode == 200) {
        Respuesta res = respuestaFromJson(response.body);
        if (res.error == 'S') {
          emit(RegistroAddLoaded(mensaje: res.mensaje!, error: true));
        } else {
          emit(RegistroAddLoaded(mensaje: res.mensaje!, error: false));
        }
      } else {
        emit(RegistroAddError('Problemas cargando el registro'));
      }
    } catch (e) {
      emit(RegistroAddError(e.toString()));
    }
  }
}
