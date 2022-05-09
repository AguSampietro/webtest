import 'dart:convert';

List<Bobina> bobinasFromJson(String str) =>
    List<Bobina>.from(json.decode(str).map((x) => Bobina.fromJson(x)));

String bobinasToJson(List<Bobina> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

String bobinaToJson(Bobina data) => json.encode(data.toJson());

Map<String, dynamic> bobinaMapToJson(Bobina data) => data.toJson();

class Bobina {
  Bobina({
    this.id,
    this.codproducto,
    this.nombre,
    this.clase,
    this.rubro,
    this.grupo,
    this.cantXBulto,
    this.nroSerie,
    this.checked,
  });

  String? id;
  String? codproducto;
  String? nombre;
  String? clase;
  String? rubro;
  String? grupo;
  dynamic cantXBulto;
  String? nroSerie;
  bool? checked = false;

  factory Bobina.init() => Bobina(
        id: '',
        nombre: '',
        nroSerie: '',
        checked: false,
        codproducto: '',
      );

  factory Bobina.fromJson(Map<String, dynamic> json) => Bobina(
        id: json["ID"] ?? '0',
        codproducto: json["CODPRODUCTO"] ?? '',
        nombre: json["NOMBRE"],
        clase: json["CLASE"],
        rubro: json["RUBRO"],
        grupo: json["GRUPO"],
        cantXBulto: json["CantXBulto"],
        nroSerie: json["NROSERIE"] ?? '',
        checked: (json["CHECKED"] == null)
            ? false
            : (json["CHECKED"].toString().toLowerCase() == "true")
                ? true
                : false,
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "CODPRODUCTO": codproducto,
        "NOMBRE": nombre,
        "CLASE": clase,
        "RUBRO": rubro,
        "GRUPO": grupo,
        "CantXBulto": cantXBulto,
        "NROSERIE": nroSerie,
        "CHECKED": checked,
      };
}
