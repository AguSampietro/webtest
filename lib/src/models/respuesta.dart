// To parse this JSON data, do
//
//     final respuesta = respuestaFromJson(jsonString);

import 'dart:convert';

Respuesta respuestaFromJson(String str) => Respuesta.fromJson(json.decode(str));

String respuestaToJson(Respuesta data) => json.encode(data.toJson());

class Respuesta {
  Respuesta({
    this.mensaje,
    this.error,
  });

  String? mensaje;
  String? error;

  factory Respuesta.fromJson(Map<String, dynamic> json) => Respuesta(
        mensaje: json["mensaje"],
        error: json["error"],
      );

  Map<String, dynamic> toJson() => {
        "mensaje": mensaje,
        "error": error,
      };
}
