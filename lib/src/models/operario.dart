import 'package:freezed_annotation/freezed_annotation.dart';

part 'operario.freezed.dart';
part 'operario.g.dart';

@freezed
class Operario with _$Operario {
  Operario._();

  factory Operario({
    String? id,
    String? nombre,
    String? clave,
  }) = _Operario;

  factory Operario.fromJson(Map<String, dynamic> json) =>
      _$OperarioFromJson(json);
}
