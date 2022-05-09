// To parse this JSON data, do
//
//     final nroSerie = nroSerieFromJson(jsonString);

import 'dart:convert';

List<NroSerie> nroSerieFromJson(String str) =>
    List<NroSerie>.from(json.decode(str).map((x) => NroSerie.fromJson(x)));

String nroSerieToJson(List<NroSerie> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class NroSerie {
  NroSerie({
    this.nroserie,
    this.codproducto,
    this.nombre,
  });

  String? nroserie;
  String? codproducto;
  String? nombre;

  factory NroSerie.fromJson(Map<String, dynamic> json) => NroSerie(
        nroserie: json["NROSERIE"],
        codproducto: json["CODPRODUCTO"],
        nombre: json["NOMBRE"],
      );

  Map<String, dynamic> toJson() => {
        "NROSERIE": nroserie,
        "CODPRODUCTO": codproducto,
        "NOMBRE": nombre,
      };
}
