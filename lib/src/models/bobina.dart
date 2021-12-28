import 'package:freezed_annotation/freezed_annotation.dart';

part 'bobina.freezed.dart';
part 'bobina.g.dart';

@freezed
class Bobina with _$Bobina {
  Bobina._();

  factory Bobina({
    String? id,
    String? nombre,
  }) = _Bobina;

  factory Bobina.fromJson(Map<String, dynamic> json) => _$BobinaFromJson(json);
}
