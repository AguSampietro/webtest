import 'dart:convert';

List<FalloMaquina> fallosMaquinasFromJson(String str) =>
    List<FalloMaquina>.from(
        json.decode(str).map((x) => FalloMaquina.fromJson(x)));

String fallosMaquinasToJson(List<FalloMaquina> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class FalloMaquina {
  FalloMaquina({
    this.codigo,
    this.nombre,
    this.tiempo,
    this.observaciones,
  });

  String? codigo;
  String? nombre;
  int? tiempo;
  String? observaciones;

  factory FalloMaquina.fromJson(Map<String, dynamic> json) => FalloMaquina(
        codigo: json["codigo"],
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
