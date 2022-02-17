import 'dart:convert';

List<FalloMaquina> fallosMaquinasFromJson(String str) =>
    List<FalloMaquina>.from(
        json.decode(str).map((x) => FalloMaquina.fromJson(x)));

String fallosMaquinasToJson(List<FalloMaquina> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

List<dynamic> fallosMaquinasMapToJson(List<FalloMaquina> data) =>
    List<dynamic>.from(data.map((x) => x.toJson()));

class FalloMaquina {
  FalloMaquina({
    this.codigo,
    this.nombre,
    this.tiempo,
    this.observaciones,
    this.id,
    this.idRegistro,
    this.fallo,
  });

  String? codigo;
  String? nombre;
  int? tiempo;
  String? observaciones;
  String? id;
  String? idRegistro;
  String? fallo;

  factory FalloMaquina.fromJson(Map<String, dynamic> json) => FalloMaquina(
        id: json["id"],
        idRegistro: json["id_registro"],
        codigo: json["codigo"],
        fallo: json["fallo"],
        nombre: json["nombre"],
        tiempo: json["tiempo"],
        observaciones: json["observaciones"],
      );

  Map<String, dynamic> toJson() => {
        "codigo": codigo,
        "nombre": nombre,
        "tiempo": tiempo,
        "observaciones": observaciones,
      };
}
