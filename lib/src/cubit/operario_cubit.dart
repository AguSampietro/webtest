import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:webtest/src/models/operario.dart';

import 'package:webtest/src/utils/utils.dart';

part 'operario_state.dart';

class OperarioCubit extends Cubit<OperarioState> {
  OperarioCubit() : super(OperarioInitial());

  Future<void> PRO_operarios() async {
    try {
      emit(const OperarioLoading());
      print('API CUBIT - BUSCANDO OPERARIOS');

      final url = Uri.parse('${Utils.api_url}/PRO_operarios');

      final http.Response response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print('RESPONSE CODE ${response.statusCode} - ${response.body}');
      if (response.statusCode == 200) {
        List<Operario> maquinas = operariosFromJson(response.body);
        emit(OperarioLoaded(operarios: maquinas));
      } else {
        emit(OperarioError('No existen los operarios'));
      }
    } catch (e) {
      emit(OperarioError(e.toString()));
    }
  }
}
