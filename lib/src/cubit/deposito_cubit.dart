import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:webtest/src/models/deposito.dart';
import 'package:webtest/src/utils/utils.dart';
import 'package:http/http.dart' as http;

part 'deposito_state.dart';

class DepositoCubit extends Cubit<DepositoState> {
  DepositoCubit() : super(DepositoInitial());

  Future<void> PRO_depositos() async {
    try {
      emit(const DepositoLoading());
      print('API CUBIT - BUSCANDO DEPOSITOS');

      final url = Uri.parse('${Utils.api_url}/PRO_Depositos');

      final http.Response response = await http.get(
        url,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
      );
      print('RESPONSE CODE ${response.statusCode} - ${response.body}');
      if (response.statusCode == 200) {
        List<Deposito> depositos = depositosFromJson(response.body);
        emit(DepositoLoaded(depositos: depositos));
      } else {
        emit(DepositoError('No existen las depositos'));
      }
    } catch (e) {
      emit(DepositoError(e.toString()));
    }
  }
}
