import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:webtest/src/models/bobina.dart';

import 'package:webtest/src/utils/utils.dart';

part 'bobina_state.dart';

class BobinaCubit extends Cubit<BobinaState> {
  BobinaCubit() : super(BobinaInitial());

  Future<void> PRO_productos(String filtro) async {
    try {
      emit(const BobinaLoading());
      print('API CUBIT - BUSCANDO PRODUCTOS');

      final url = Uri.parse('${Utils.api_url}/PRO_productos');

      final http.Response response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "filtro": filtro,
        }),
      );
      print('RESPONSE CODE ${response.statusCode} - ${response.body}');
      if (response.statusCode == 200) {
        List<Bobina> bobinas = bobinasFromJson(response.body);
        emit(BobinaLoaded(bobinas: bobinas));
      } else {
        emit(BobinaError('No existen los bobinas'));
      }
    } catch (e) {
      emit(BobinaError(e.toString()));
    }
  }
}
