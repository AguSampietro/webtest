// To parse this JSON data, do
//
//     final registroLista = registroListaFromJson(jsonString);

import 'dart:convert';

List<RegistroLista> registroListaFromJson(String str) =>
    List<RegistroLista>.from(
        json.decode(str).map((x) => RegistroLista.fromJson(x)));

String registroListaToJson(List<RegistroLista> data) =>
    json.encode(List<dynamic>.from(data.map((x) => x.toJson())));

class RegistroLista {
  RegistroLista({
    this.id,
    this.codProducto,
    this.producto,
    this.operario,
    this.idMaquina,
    this.maquina,
    this.legajoOperario,
    this.contadorInicial,
    this.lote,
    this.contadorFinal,
    this.cantidadMoldes,
    this.cantidadCajas,
    this.fecha,
    this.hora,
    this.estado,
  });

  String? id;
  String? codProducto;
  String? producto;
  String? operario;
  String? idMaquina;
  String? maquina;
  String? legajoOperario;
  String? contadorInicial;
  String? lote;
  String? contadorFinal;
  String? cantidadMoldes;
  String? cantidadCajas;
  String? fecha;
  String? hora;
  String? estado;

  factory RegistroLista.fromJson(Map<String, dynamic> json) => RegistroLista(
        id: json["ID"],
        codProducto: json["COD_PRODUCTO"],
        producto: json["PRODUCTO"],
        operario: json["OPERARIO"],
        idMaquina: json["ID_MAQUINA"],
        maquina: json["MAQUINA"],
        legajoOperario: json["LEGAJO_OPERARIO"],
        contadorInicial: json["CONTADOR_INICIAL"],
        lote: json["LOTE"],
        contadorFinal: json["CONTADOR_FINAL"],
        cantidadMoldes: json["CANTIDAD_MOLDES"],
        cantidadCajas: json["CANTIDAD_CAJAS"],
        fecha: json["FECHA"],
        hora: json["HORA"],
        estado: json["ESTADO"],
      );

  Map<String, dynamic> toJson() => {
        "ID": id,
        "COD_PRODUCTO": codProducto,
        "PRODUCTO": producto,
        "OPERARIO": operario,
        "ID_MAQUINA": idMaquina,
        "MAQUINA": maquina,
        "LEGAJO_OPERARIO": legajoOperario,
        "CONTADOR_INICIAL": contadorInicial,
        "LOTE": lote,
        "CONTADOR_FINAL": contadorFinal,
        "CANTIDAD_MOLDES": cantidadMoldes,
        "CANTIDAD_CAJAS": cantidadCajas,
        "FECHA": fecha,
        "HORA": hora,
        "ESTADO": estado,
      };
}
