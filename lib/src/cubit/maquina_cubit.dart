import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:webtest/src/models/maquina.dart';

import 'package:webtest/src/utils/utils.dart';

part 'maquina_state.dart';

class MaquinaCubit extends Cubit<MaquinaState> {
  MaquinaCubit() : super(MaquinaInitial());

  Future<void> PRO_maquinas() async {
    try {
      emit(const MaquinaLoading());
      print('API CUBIT - BUSCANDO MAQUINAS');

      final url = Uri.parse('${Utils.api_url}/PRO_maquinas');

      final http.Response response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print('RESPONSE CODE ${response.statusCode} - ${response.body}');
      if (response.statusCode == 200) {
        List<Maquina> maquinas = maquinasFromJson(response.body);
        emit(MaquinaLoaded(maquinas: maquinas));
      } else {
        emit(MaquinaError('No existen las maquinas'));
      }
    } catch (e) {
      emit(MaquinaError(e.toString()));
    }
  }
}
