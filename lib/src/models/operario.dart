import 'dart:convert';

List<Operario> operariosFromJson(String str) =>
    List<Operario>.from(json.decode(str).map((x) => Operario.fromJson(x)));

String operarioToJson(List<Operario> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Operario {
  Operario({
    this.legajo,
    this.nombre,
    this.clave,
  });

  String? legajo;
  String? nombre;
  String? clave;

  factory Operario.fromJson(Map<String, dynamic> json) => Operario(
        legajo: json["LEGAJO"],
        nombre: json["NOMBRE"],
        clave: json["CLAVE"],
      );

  Map<String, dynamic> toJson() => {
        "LEGAJO": legajo,
        "NOMBRE": nombre,
        "CLAVE": clave,
      };
}
