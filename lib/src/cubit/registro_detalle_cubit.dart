import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:webtest/src/models/operario.dart';
import 'package:webtest/src/models/registro_produccion.dart';

import 'package:webtest/src/utils/utils.dart';

part 'registro_detalle_state.dart';

class RegistroDetalleCubit extends Cubit<RegistroDetalleState> {
  RegistroDetalleCubit() : super(RegistroDetalleInitial());

  Future<void> PRO_registro(String id) async {
    try {
      emit(const RegistroDetalleLoading());
      print('API CUBIT - BUSCANDO REGISTRO DETALLE');

      final url = Uri.parse('${Utils.api_url}/PRO_registro');

      final http.Response response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "id": id,
        }),
      );

      print('RESPONSE CODE ${response.statusCode} - ${response.body}');
      if (response.statusCode == 200) {
        RegistroProduccion registro = registroProFromJson(response.body);
        emit(RegistroDetalleLoaded(registro: registro));
      } else {
        emit(RegistroDetalleError('No se encontro el registro de produccion'));
      }
    } catch (e) {
      emit(RegistroDetalleError(e.toString()));
    }
  }
}
