import 'dart:convert';

List<Supervisor> supervisorFromJson(String str) =>
    List<Supervisor>.from(json.decode(str).map((x) => Supervisor.fromJson(x)));

String supervisorToJson(List<Supervisor> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Supervisor {
  Supervisor({
    this.id,
    this.quien,
    this.claveacceso,
    this.claveSupervisor,
    this.nombre,
  });

  String? id;
  String? quien;
  String? claveacceso;
  String? claveSupervisor;
  String? nombre;

  factory Supervisor.fromJson(Map<String, dynamic> json) => Supervisor(
        id: json["ID"],
        quien: json["QUIEN"],
        claveacceso: json["CLAVEACCESO"],
        claveSupervisor: json["ClaveSupervisor"],
        nombre: json["NOMBRE"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "QUIEN": quien,
        "CLAVEACCESO": claveacceso,
        "ClaveSupervisor": claveSupervisor,
        "NOMBRE": nombre,
      };
}
