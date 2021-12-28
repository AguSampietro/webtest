import 'package:shared_preferences/shared_preferences.dart';

class AppPreferences {
  // SINGLETON
  static final AppPreferences _instancia = new AppPreferences._internal();

  factory AppPreferences() {
    return _instancia;
  }

  AppPreferences._internal();

  // MAIN PROPERTY
  late SharedPreferences _prefs;

  initPreferences() async {
    this._prefs = await SharedPreferences.getInstance();
  }

  // SET & GET USUARIO

  bool get logged => this._prefs.getBool('ati_prod_logged') ?? false;
  set logged(bool value) => this._prefs.setBool('ati_prod_logged', value);

  String get usuarioId => this._prefs.getString('ati_prod_usuarioId') ?? '';
  set usuarioId(String value) =>
      this._prefs.setString('ati_prod_usuarioId', value);

  String get usuarioMail => this._prefs.getString('ati_prod_usuarioMail') ?? '';
  set usuarioMail(String value) =>
      this._prefs.setString('ati_prod_usuarioMail', value);

  String get usuarioNombre =>
      this._prefs.getString('ati_prod_usuarioNombre') ?? '';
  set usuarioNombre(String value) =>
      this._prefs.setString('ati_prod_usuarioNombre', value);

  String get usuarioTipo => this._prefs.getString('ati_prod_usuarioTipo') ?? '';
  set usuarioTipo(String value) =>
      this._prefs.setString('ati_prod_usuarioTipo', value);

  // SET & GET TEMPORARIOS

  String get operarioId => this._prefs.getString('ati_prod_operarioId') ?? '';
  set operarioId(String value) =>
      this._prefs.setString('ati_prod_operarioId', value);

  String get operarioNombre =>
      this._prefs.getString('ati_prod_operarioNombre') ?? '';
  set operarioNombre(String value) =>
      this._prefs.setString('ati_prod_operarioNombre', value);

  String get maquinaId => this._prefs.getString('ati_prod_maquinaId') ?? '';
  set maquinaId(String value) =>
      this._prefs.setString('ati_prod_maquinaId', value);

  String get maquinaNombre =>
      this._prefs.getString('ati_prod_maquinaNombre') ?? '';
  set maquinaNombre(String value) =>
      this._prefs.setString('ati_prod_maquinaNombre', value);
}
