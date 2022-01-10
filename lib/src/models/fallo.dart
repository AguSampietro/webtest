import 'dart:convert';

List<Fallo> falloFromJson(String str) =>
    List<Fallo>.from(json.decode(str).map((x) => Fallo.fromJson(x)));

String falloToJson(List<Fallo> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Fallo {
  Fallo({
    this.id,
    this.codfallo,
    this.descripcion,
  });

  String? id;
  String? codfallo;
  String? descripcion;

  factory Fallo.fromJson(Map<String, dynamic> json) => Fallo(
        id: json["ID"],
        codfallo: json["CODFALLO"],
        descripcion: json["DESCRIPCION"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "CODFALLO": codfallo,
        "DESCRIPCION": descripcion,
      };
}
