import 'dart:convert';

List<Maquina> maquinasFromJson(String str) =>
    List<Maquina>.from(json.decode(str).map((x) => Maquina.fromJson(x)));

String maquinaToJson(List<Maquina> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class Maquina {
  Maquina({
    this.id,
    this.maquina,
    this.tipo,
  });

  String? id;
  String? maquina;
  String? tipo;

  factory Maquina.fromJson(Map<String, dynamic> json) => Maquina(
        id: json["ID"],
        maquina: json["MAQUINA"],
        tipo: json["TIPO"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "MAQUINA": maquina,
        "TIPO": tipo,
      };
}
