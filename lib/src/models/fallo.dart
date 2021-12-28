import 'package:freezed_annotation/freezed_annotation.dart';

part 'fallo.freezed.dart';
part 'fallo.g.dart';

@freezed
class Fallo with _$Fallo {
  Fallo._();

  factory Fallo({
    String? codigo,
    String? nombre,
  }) = _Fallo;

  factory Fallo.fromJson(Map<String, dynamic> json) => _$FalloFromJson(json);
}
