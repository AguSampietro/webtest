class FechaHora {
  FechaHora({this.fecha, this.hora, this.fechaAlta});

  String? fecha;
  String? hora;
  DateTime? fechaAlta;

  factory FechaHora.init() => FechaHora(fecha: '', hora: '', fechaAlta: null);

  factory FechaHora.fromJson(Map<String, dynamic> json) => FechaHora(
        fecha: json["fecha"],
        hora: json["hora"],
      );

  Map<String, dynamic> toJson() => {"fecha": fecha, "hora": hora};

  String toString() => '$fecha $hora';
}
