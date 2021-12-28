// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'maquina.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Maquina _$MaquinaFromJson(Map<String, dynamic> json) {
  return _Maquina.fromJson(json);
}

/// @nodoc
class _$MaquinaTearOff {
  const _$MaquinaTearOff();

  _Maquina call({String? id, String? nombre}) {
    return _Maquina(
      id: id,
      nombre: nombre,
    );
  }

  Maquina fromJson(Map<String, Object?> json) {
    return Maquina.fromJson(json);
  }
}

/// @nodoc
const $Maquina = _$MaquinaTearOff();

/// @nodoc
mixin _$Maquina {
  String? get id => throw _privateConstructorUsedError;
  String? get nombre => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $MaquinaCopyWith<Maquina> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $MaquinaCopyWith<$Res> {
  factory $MaquinaCopyWith(Maquina value, $Res Function(Maquina) then) =
      _$MaquinaCopyWithImpl<$Res>;
  $Res call({String? id, String? nombre});
}

/// @nodoc
class _$MaquinaCopyWithImpl<$Res> implements $MaquinaCopyWith<$Res> {
  _$MaquinaCopyWithImpl(this._value, this._then);

  final Maquina _value;
  // ignore: unused_field
  final $Res Function(Maquina) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? nombre = freezed,
  }) {
    return _then(_value.copyWith(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      nombre: nombre == freezed
          ? _value.nombre
          : nombre // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$MaquinaCopyWith<$Res> implements $MaquinaCopyWith<$Res> {
  factory _$MaquinaCopyWith(_Maquina value, $Res Function(_Maquina) then) =
      __$MaquinaCopyWithImpl<$Res>;
  @override
  $Res call({String? id, String? nombre});
}

/// @nodoc
class __$MaquinaCopyWithImpl<$Res> extends _$MaquinaCopyWithImpl<$Res>
    implements _$MaquinaCopyWith<$Res> {
  __$MaquinaCopyWithImpl(_Maquina _value, $Res Function(_Maquina) _then)
      : super(_value, (v) => _then(v as _Maquina));

  @override
  _Maquina get _value => super._value as _Maquina;

  @override
  $Res call({
    Object? id = freezed,
    Object? nombre = freezed,
  }) {
    return _then(_Maquina(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      nombre: nombre == freezed
          ? _value.nombre
          : nombre // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Maquina extends _Maquina {
  _$_Maquina({this.id, this.nombre}) : super._();

  factory _$_Maquina.fromJson(Map<String, dynamic> json) =>
      _$$_MaquinaFromJson(json);

  @override
  final String? id;
  @override
  final String? nombre;

  @override
  String toString() {
    return 'Maquina(id: $id, nombre: $nombre)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Maquina &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.nombre, nombre));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(nombre));

  @JsonKey(ignore: true)
  @override
  _$MaquinaCopyWith<_Maquina> get copyWith =>
      __$MaquinaCopyWithImpl<_Maquina>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_MaquinaToJson(this);
  }
}

abstract class _Maquina extends Maquina {
  factory _Maquina({String? id, String? nombre}) = _$_Maquina;
  _Maquina._() : super._();

  factory _Maquina.fromJson(Map<String, dynamic> json) = _$_Maquina.fromJson;

  @override
  String? get id;
  @override
  String? get nombre;
  @override
  @JsonKey(ignore: true)
  _$MaquinaCopyWith<_Maquina> get copyWith =>
      throw _privateConstructorUsedError;
}
