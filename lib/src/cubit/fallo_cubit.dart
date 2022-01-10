import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:webtest/src/models/fallo.dart';
import 'package:webtest/src/models/operario.dart';

import 'package:webtest/src/utils/utils.dart';

part 'fallo_state.dart';

class FalloCubit extends Cubit<FalloState> {
  FalloCubit() : super(FalloInitial());

  Future<void> PRO_fallos(String filtro) async {
    try {
      emit(const FalloLoading());
      print('API CUBIT - BUSCANDO OPERARIOS');

      final url = Uri.parse('${Utils.api_url}/PRO_fallos');

      final http.Response response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(
          <String, String>{
            "filtro": filtro,
          },
        ),
      );
      print('RESPONSE CODE ${response.statusCode} - ${response.body}');
      if (response.statusCode == 200) {
        List<Fallo> fallos = falloFromJson(response.body);
        emit(FalloLoaded(fallos: fallos));
      } else {
        emit(FalloError('No existen los fallos'));
      }
    } catch (e) {
      emit(FalloError(e.toString()));
    }
  }
}
