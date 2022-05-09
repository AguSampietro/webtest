import 'dart:convert';
import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:webtest/src/models/operario.dart';
import 'package:webtest/src/models/supervisor.dart';

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
      log('RESPONSE CODE ${response.statusCode} - ${response.body}');
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

  Future<Operario> PRO_operario(String legajo) async {
    try {
      log('API CUBIT - BUSCANDO OPERARIO');

      final url = Uri.parse('${Utils.api_url}/PRO_operario');
      final http.Response response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "id": legajo,
        }),
      );

      log('RESPONSE CODE ${response.statusCode} - ${response.body}');
      if (response.statusCode == 200) {
        List<Operario> operarios = operariosFromJson(response.body);
        return operarios.first;
      } else {
        return Operario(legajo: '', nombre: '', clave: '');
      }
    } catch (e) {
      return Operario(legajo: '', nombre: '', clave: '');
    }
  }

  Future<Supervisor> PRO_supervisor(String legajo) async {
    try {
      log('API CUBIT - BUSCANDO SUPERVISOR');

      final url = Uri.parse('${Utils.api_url}/PRO_supervisor');
      final http.Response response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "id": legajo,
        }),
      );

      log('RESPONSE CODE ${response.statusCode} - ${response.body}');
      if (response.statusCode == 200) {
        List<Supervisor> operarios = supervisorFromJson(response.body);
        return operarios.first;
      } else {
        return Supervisor(
            id: '',
            nombre: '',
            claveacceso: '',
            claveSupervisor: '',
            quien: '');
      }
    } catch (e) {
      return Supervisor(
          id: '', nombre: '', claveacceso: '', claveSupervisor: '', quien: '');
    }
  }
}
