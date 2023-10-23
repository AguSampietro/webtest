import 'dart:convert';

import 'package:webtest/src/models/nro_serie.dart';
import 'package:webtest/src/utils/utils.dart';
import 'package:http/http.dart' as http;

class ApiService {
  Future<List<NroSerie>?> PRO_bobinaPorNroSerieDeposito(
      String codigo, String deposito) async {
    List<NroSerie>? nSeries;
    try {
      final url = Uri.parse('${Utils.api_url}/PRO_bobinaPorNroSerieDeposito');

      final http.Response response = await http.post(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(<String, String>{"id": codigo, "deposito": deposito}),
      );
      print('RESPONSE CODE ${response.statusCode} - ${response.body}');
      if (response.statusCode == 200) {
        nSeries = nroSerieFromJson(response.body);
      } else {
        nSeries = null;
      }
    } catch (e) {
      nSeries = null;
    }
    return nSeries;
  }
}
