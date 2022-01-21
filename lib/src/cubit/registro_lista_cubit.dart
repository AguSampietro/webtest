import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:webtest/src/models/operario.dart';
import 'package:webtest/src/models/registro_lista.dart';
import 'package:webtest/src/services/preferences/app_preferences.dart';
import 'package:webtest/src/utils/filtro_type.dart';

import 'package:webtest/src/utils/utils.dart';

part 'registro_lista_state.dart';

class RegistroListaCubit extends Cubit<RegistroListaState> {
  RegistroListaCubit() : super(RegistroListaInitial());

  Future<void> PRO_registros() async {
    try {
      final prefs = AppPreferences();
      emit(const RegistroListaLoading());
      print('API CUBIT - BUSCANDO REGISTROS');

      var url;
      var id = '';

      if (prefs.tipoFiltro == FiltrosType.OPERARIOS) {
        url = Uri.parse('${Utils.api_url}/PRO_registros_operario');
        id = prefs.operarioId;
      } else if (prefs.tipoFiltro == FiltrosType.MAQUINAS) {
        url = Uri.parse('${Utils.api_url}/PRO_registros_maquina');
        id = prefs.maquinaId;
      } else {
        emit(RegistroListaLoaded(registros: []));
        return;
      }

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
        List<RegistroLista> registros = registroListaFromJson(response.body);
        emit(RegistroListaLoaded(registros: registros));
      } else {
        emit(RegistroListaError('No existen registros'));
      }
    } catch (e) {
      emit(RegistroListaError(e.toString()));
    }
  }
}
