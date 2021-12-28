import 'package:freezed_annotation/freezed_annotation.dart';

part 'maquina.freezed.dart';
part 'maquina.g.dart';

@freezed
class Maquina with _$Maquina {
  Maquina._();

  factory Maquina({
    String? id,
    String? nombre,
  }) = _Maquina;

  factory Maquina.fromJson(Map<String, dynamic> json) =>
      _$MaquinaFromJson(json);
}
