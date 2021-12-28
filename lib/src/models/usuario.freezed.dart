// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'usuario.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Usuario _$UsuarioFromJson(Map<String, dynamic> json) {
  return _Usuario.fromJson(json);
}

/// @nodoc
class _$UsuarioTearOff {
  const _$UsuarioTearOff();

  _Usuario call({String? id, String? nombre}) {
    return _Usuario(
      id: id,
      nombre: nombre,
    );
  }

  Usuario fromJson(Map<String, Object?> json) {
    return Usuario.fromJson(json);
  }
}

/// @nodoc
const $Usuario = _$UsuarioTearOff();

/// @nodoc
mixin _$Usuario {
  String? get id => throw _privateConstructorUsedError;
  String? get nombre => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $UsuarioCopyWith<Usuario> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $UsuarioCopyWith<$Res> {
  factory $UsuarioCopyWith(Usuario value, $Res Function(Usuario) then) =
      _$UsuarioCopyWithImpl<$Res>;
  $Res call({String? id, String? nombre});
}

/// @nodoc
class _$UsuarioCopyWithImpl<$Res> implements $UsuarioCopyWith<$Res> {
  _$UsuarioCopyWithImpl(this._value, this._then);

  final Usuario _value;
  // ignore: unused_field
  final $Res Function(Usuario) _then;

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
abstract class _$UsuarioCopyWith<$Res> implements $UsuarioCopyWith<$Res> {
  factory _$UsuarioCopyWith(_Usuario value, $Res Function(_Usuario) then) =
      __$UsuarioCopyWithImpl<$Res>;
  @override
  $Res call({String? id, String? nombre});
}

/// @nodoc
class __$UsuarioCopyWithImpl<$Res> extends _$UsuarioCopyWithImpl<$Res>
    implements _$UsuarioCopyWith<$Res> {
  __$UsuarioCopyWithImpl(_Usuario _value, $Res Function(_Usuario) _then)
      : super(_value, (v) => _then(v as _Usuario));

  @override
  _Usuario get _value => super._value as _Usuario;

  @override
  $Res call({
    Object? id = freezed,
    Object? nombre = freezed,
  }) {
    return _then(_Usuario(
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
class _$_Usuario extends _Usuario {
  _$_Usuario({this.id, this.nombre}) : super._();

  factory _$_Usuario.fromJson(Map<String, dynamic> json) =>
      _$$_UsuarioFromJson(json);

  @override
  final String? id;
  @override
  final String? nombre;

  @override
  String toString() {
    return 'Usuario(id: $id, nombre: $nombre)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Usuario &&
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
  _$UsuarioCopyWith<_Usuario> get copyWith =>
      __$UsuarioCopyWithImpl<_Usuario>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_UsuarioToJson(this);
  }
}

abstract class _Usuario extends Usuario {
  factory _Usuario({String? id, String? nombre}) = _$_Usuario;
  _Usuario._() : super._();

  factory _Usuario.fromJson(Map<String, dynamic> json) = _$_Usuario.fromJson;

  @override
  String? get id;
  @override
  String? get nombre;
  @override
  @JsonKey(ignore: true)
  _$UsuarioCopyWith<_Usuario> get copyWith =>
      throw _privateConstructorUsedError;
}
