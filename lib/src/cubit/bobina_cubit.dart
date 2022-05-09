import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:webtest/src/models/bobina.dart';
import 'package:webtest/src/models/nro_serie.dart';
import 'package:webtest/src/models/producto.dart';

import 'package:webtest/src/utils/utils.dart';

part 'bobina_state.dart';

class BobinaCubit extends Cubit<BobinaState> {
  BobinaCubit() : super(BobinaInitial());

  Future<void> PRO_productos(String filtro) async {
    try {
      emit(const BobinaLoading());
      print('API CUBIT - BUSCANDO PRODUCTOS');

      final url = Uri.parse('${Utils.api_url}/PRO_bobinas');

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

  Future<void> PRO_bobinasPorDeposito(String filtro, String deposito) async {
    try {
      emit(const BobinaLoading());
      print('API CUBIT - BUSCANDO BOBINAS POR DEPOSITO');

      final url = Uri.parse('${Utils.api_url}/PRO_bobinasPorDeposito');

      final http.Response response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{
          "filtro": filtro,
          "deposito": deposito,
        }),
      );
      print('RESPONSE CODE ${response.statusCode} - ${response.body}');
      if (response.statusCode == 200) {
        List<Bobina> bobinasDepo = bobinasFromJson(response.body);
        emit(BobinaLoaded(bobinasPorDeposito: bobinasDepo));
      } else {
        emit(const BobinaError('No existen los bobinas'));
      }
    } catch (e) {
      emit(BobinaError(e.toString()));
    }
  }

  Future<void> PRO_nroSerieProducto(String codigo, String deposito) async {
    try {
      emit(const BobinaLoading());
      print('API CUBIT - BUSCANDO NRO DE SERIE');

      final url = Uri.parse('${Utils.api_url}/PRO_nroSerieProducto');

      final http.Response response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{"id": codigo, "deposito": deposito}),
      );
      print('RESPONSE CODE ${response.statusCode} - ${response.body}');
      if (response.statusCode == 200) {
        List<NroSerie> nSeries = nroSerieFromJson(response.body);
        emit(BobinaLoaded(bobinasNroSerie: nSeries));
      } else {
        emit(const BobinaError('No existen los bobinas'));
      }
    } catch (e) {
      emit(BobinaError(e.toString()));
    }
  }
}
