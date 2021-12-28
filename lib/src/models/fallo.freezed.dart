// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'fallo.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Fallo _$FalloFromJson(Map<String, dynamic> json) {
  return _Fallo.fromJson(json);
}

/// @nodoc
class _$FalloTearOff {
  const _$FalloTearOff();

  _Fallo call({String? codigo, String? nombre}) {
    return _Fallo(
      codigo: codigo,
      nombre: nombre,
    );
  }

  Fallo fromJson(Map<String, Object?> json) {
    return Fallo.fromJson(json);
  }
}

/// @nodoc
const $Fallo = _$FalloTearOff();

/// @nodoc
mixin _$Fallo {
  String? get codigo => throw _privateConstructorUsedError;
  String? get nombre => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $FalloCopyWith<Fallo> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $FalloCopyWith<$Res> {
  factory $FalloCopyWith(Fallo value, $Res Function(Fallo) then) =
      _$FalloCopyWithImpl<$Res>;
  $Res call({String? codigo, String? nombre});
}

/// @nodoc
class _$FalloCopyWithImpl<$Res> implements $FalloCopyWith<$Res> {
  _$FalloCopyWithImpl(this._value, this._then);

  final Fallo _value;
  // ignore: unused_field
  final $Res Function(Fallo) _then;

  @override
  $Res call({
    Object? codigo = freezed,
    Object? nombre = freezed,
  }) {
    return _then(_value.copyWith(
      codigo: codigo == freezed
          ? _value.codigo
          : codigo // ignore: cast_nullable_to_non_nullable
              as String?,
      nombre: nombre == freezed
          ? _value.nombre
          : nombre // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$FalloCopyWith<$Res> implements $FalloCopyWith<$Res> {
  factory _$FalloCopyWith(_Fallo value, $Res Function(_Fallo) then) =
      __$FalloCopyWithImpl<$Res>;
  @override
  $Res call({String? codigo, String? nombre});
}

/// @nodoc
class __$FalloCopyWithImpl<$Res> extends _$FalloCopyWithImpl<$Res>
    implements _$FalloCopyWith<$Res> {
  __$FalloCopyWithImpl(_Fallo _value, $Res Function(_Fallo) _then)
      : super(_value, (v) => _then(v as _Fallo));

  @override
  _Fallo get _value => super._value as _Fallo;

  @override
  $Res call({
    Object? codigo = freezed,
    Object? nombre = freezed,
  }) {
    return _then(_Fallo(
      codigo: codigo == freezed
          ? _value.codigo
          : codigo // ignore: cast_nullable_to_non_nullable
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
class _$_Fallo extends _Fallo {
  _$_Fallo({this.codigo, this.nombre}) : super._();

  factory _$_Fallo.fromJson(Map<String, dynamic> json) =>
      _$$_FalloFromJson(json);

  @override
  final String? codigo;
  @override
  final String? nombre;

  @override
  String toString() {
    return 'Fallo(codigo: $codigo, nombre: $nombre)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Fallo &&
            const DeepCollectionEquality().equals(other.codigo, codigo) &&
            const DeepCollectionEquality().equals(other.nombre, nombre));
  }

  @override
  int get hashCode => Object.hash(
      runtimeType,
      const DeepCollectionEquality().hash(codigo),
      const DeepCollectionEquality().hash(nombre));

  @JsonKey(ignore: true)
  @override
  _$FalloCopyWith<_Fallo> get copyWith =>
      __$FalloCopyWithImpl<_Fallo>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_FalloToJson(this);
  }
}

abstract class _Fallo extends Fallo {
  factory _Fallo({String? codigo, String? nombre}) = _$_Fallo;
  _Fallo._() : super._();

  factory _Fallo.fromJson(Map<String, dynamic> json) = _$_Fallo.fromJson;

  @override
  String? get codigo;
  @override
  String? get nombre;
  @override
  @JsonKey(ignore: true)
  _$FalloCopyWith<_Fallo> get copyWith => throw _privateConstructorUsedError;
}
