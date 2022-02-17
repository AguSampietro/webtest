import 'dart:convert';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:http/http.dart' as http;
import 'package:webtest/src/models/producto.dart';

import 'package:webtest/src/utils/utils.dart';

part 'producto_state.dart';

class ProductoCubit extends Cubit<ProductoState> {
  ProductoCubit() : super(ProductoInitial());

  Future<void> PRO_productos(String filtro) async {
    try {
      emit(const ProductoLoading());
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
        List<Producto> productos = productosFromJson(response.body);
        emit(ProductoLoaded(productos: productos));
      } else {
        emit(ProductoError('No existen los bobinas'));
      }
    } catch (e) {
      emit(ProductoError(e.toString()));
    }
  }
}
