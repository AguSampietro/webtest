import 'dart:convert';

List<Producto> productosFromJson(String str) =>
    List<Producto>.from(json.decode(str).map((x) => Producto.fromJson(x)));

String productosToJson(List<Producto> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

String productoToJson(Producto data) => json.encode(data.toJson());

Map<String, dynamic> productoMapToJson(Producto data) => data.toJson();

class Producto {
  Producto({
    this.id,
    this.codproducto,
    this.nombre,
    this.clase,
    this.rubro,
    this.grupo,
    this.cantXBulto,
  });

  String? id;
  String? codproducto;
  String? nombre;
  String? clase;
  String? rubro;
  String? grupo;
  dynamic cantXBulto;

  factory Producto.fromJson(Map<String, dynamic> json) => Producto(
        id: json["ID"],
        codproducto: json["CODPRODUCTO"],
        nombre: json["NOMBRE"],
        clase: json["CLASE"],
        rubro: json["RUBRO"],
        grupo: json["GRUPO"],
        cantXBulto: json["CantXBulto"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "CODPRODUCTO": codproducto,
        "NOMBRE": nombre,
        "CLASE": clase,
        "RUBRO": rubro,
        "GRUPO": grupo,
        "CantXBulto": cantXBulto,
      };
}
