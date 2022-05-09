import 'dart:convert';

List<Deposito> depositosFromJson(String str) =>
    List<Deposito>.from(json.decode(str).map((x) => Deposito.fromJson(x)));

String depositosToJson(List<Deposito> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

String depositoToJson(Deposito data) => json.encode(data.toJson());

Map<String, dynamic> depositoMapToJson(Deposito data) => data.toJson();

class Deposito {
  Deposito({
    this.deposito,
    this.nombre,
  });

  String? deposito;
  String? nombre;

  factory Deposito.fromJson(Map<String, dynamic> json) => Deposito(
        deposito: json["DEPOSITO"],
        nombre: json["NOMBRE"],
      );

  Map<String, dynamic> toJson() => {
        "DEPOSITO": deposito,
        "NOMBRE": nombre,
      };
}
