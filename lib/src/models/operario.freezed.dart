// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'operario.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Operario _$OperarioFromJson(Map<String, dynamic> json) {
  return _Operario.fromJson(json);
}

/// @nodoc
class _$OperarioTearOff {
  const _$OperarioTearOff();

  _Operario call({String? id, String? nombre, String? clave}) {
    return _Operario(
      id: id,
      nombre: nombre,
      clave: clave,
    );
  }

  Operario fromJson(Map<String, Object?> json) {
    return Operario.fromJson(json);
  }
}

/// @nodoc
const $Operario = _$OperarioTearOff();

/// @nodoc
mixin _$Operario {
  String? get id => throw _privateConstructorUsedError;
  String? get nombre => throw _privateConstructorUsedError;
  String? get clave => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $OperarioCopyWith<Operario> get copyWith =>
      throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $OperarioCopyWith<$Res> {
  factory $OperarioCopyWith(Operario value, $Res Function(Operario) then) =
      _$OperarioCopyWithImpl<$Res>;
  $Res call({String? id, String? nombre, String? clave});
}

/// @nodoc
class _$OperarioCopyWithImpl<$Res> implements $OperarioCopyWith<$Res> {
  _$OperarioCopyWithImpl(this._value, this._then);

  final Operario _value;
  // ignore: unused_field
  final $Res Function(Operario) _then;

  @override
  $Res call({
    Object? id = freezed,
    Object? nombre = freezed,
    Object? clave = freezed,
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
      clave: clave == freezed
          ? _value.clave
          : clave // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$OperarioCopyWith<$Res> implements $OperarioCopyWith<$Res> {
  factory _$OperarioCopyWith(_Operario value, $Res Function(_Operario) then) =
      __$OperarioCopyWithImpl<$Res>;
  @override
  $Res call({String? id, String? nombre, String? clave});
}

/// @nodoc
class __$OperarioCopyWithImpl<$Res> extends _$OperarioCopyWithImpl<$Res>
    implements _$OperarioCopyWith<$Res> {
  __$OperarioCopyWithImpl(_Operario _value, $Res Function(_Operario) _then)
      : super(_value, (v) => _then(v as _Operario));

  @override
  _Operario get _value => super._value as _Operario;

  @override
  $Res call({
    Object? id = freezed,
    Object? nombre = freezed,
    Object? clave = freezed,
  }) {
    return _then(_Operario(
      id: id == freezed
          ? _value.id
          : id // ignore: cast_nullable_to_non_nullable
              as String?,
      nombre: nombre == freezed
          ? _value.nombre
          : nombre // ignore: cast_nullable_to_non_nullable
              as String?,
      clave: clave == freezed
          ? _value.clave
          : clave // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Operario extends _Operario {
  _$_Operario({this.id, this.nombre, this.clave}) : super._();

  factory _$_Operario.fromJson(Map<String, dynamic> json) =>
      _$$_OperarioFromJson(json);

  @override
  final String? id;
  @override
  final String? nombre;
  @override
  final String? clave;

  @override
  String toString() {
    return 'Operario(id: $id, nombre: $nombre, clave: $clave)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Operario &&
            const DeepCollectionEquality().equals(other.id, id) &&
            const DeepCollectionEquality().equals(other.nombre, nombre) &&
            const DeepCollectionEquality().equals(other.clave, clave));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(id),
      const DeepCollectionEquality().hash(nombre),
      const DeepCollectionEquality().hash(clave));

  @JsonKey(ignore: true)
  @override
  _$OperarioCopyWith<_Operario> get copyWith =>
      __$OperarioCopyWithImpl<_Operario>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_OperarioToJson(this);
  }
}

abstract class _Operario extends Operario {
  factory _Operario({String? id, String? nombre, String? clave}) = _$_Operario;
  _Operario._() : super._();

  factory _Operario.fromJson(Map<String, dynamic> json) = _$_Operario.fromJson;

  @override
  String? get id;
  @override
  String? get nombre;
  @override
  String? get clave;
  @override
  @JsonKey(ignore: true)
  _$OperarioCopyWith<_Operario> get copyWith =>
      throw _privateConstructorUsedError;
}
