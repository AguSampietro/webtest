import 'package:freezed_annotation/freezed_annotation.dart';

part 'usuario.freezed.dart';
part 'usuario.g.dart';

@freezed
class Usuario with _$Usuario {
  Usuario._();

  factory Usuario({
    String? id,
    String? nombre,
  }) = _Usuario;

  factory Usuario.fromJson(Map<String, dynamic> json) =>
      _$UsuarioFromJson(json);
}
