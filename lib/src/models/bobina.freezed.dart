// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'bobina.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Bobina _$BobinaFromJson(Map<String, dynamic> json) {
  return _Bobina.fromJson(json);
}

/// @nodoc
class _$BobinaTearOff {
  const _$BobinaTearOff();

  _Bobina call({String? id, String? nombre}) {
    return _Bobina(
      id: id,
      nombre: nombre,
    );
  }

  Bobina fromJson(Map<String, Object?> json) {
    return Bobina.fromJson(json);
  }
}

/// @nodoc
const $Bobina = _$BobinaTearOff();

/// @nodoc
mixin _$Bobina {
  String? get id => throw _privateConstructorUsedError;
  String? get nombre => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $BobinaCopyWith<Bobina> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $BobinaCopyWith<$Res> {
  factory $BobinaCopyWith(Bobina value, $Res Function(Bobina) then) =
      _$BobinaCopyWithImpl<$Res>;
  $Res call({String? id, String? nombre});
}

/// @nodoc
class _$BobinaCopyWithImpl<$Res> implements $BobinaCopyWith<$Res> {
  _$BobinaCopyWithImpl(this._value, this._then);

  final Bobina _value;
  // ignore: unused_field
  final $Res Function(Bobina) _then;

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
abstract class _$BobinaCopyWith<$Res> implements $BobinaCopyWith<$Res> {
  factory _$BobinaCopyWith(_Bobina value, $Res Function(_Bobina) then) =
      __$BobinaCopyWithImpl<$Res>;
  @override
  $Res call({String? id, String? nombre});
}

/// @nodoc
class __$BobinaCopyWithImpl<$Res> extends _$BobinaCopyWithImpl<$Res>
    implements _$BobinaCopyWith<$Res> {
  __$BobinaCopyWithImpl(_Bobina _value, $Res Function(_Bobina) _then)
      : super(_value, (v) => _then(v as _Bobina));

  @override
  _Bobina get _value => super._value as _Bobina;

  @override
  $Res call({
    Object? id = freezed,
    Object? nombre = freezed,
  }) {
    return _then(_Bobina(
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
class _$_Bobina extends _Bobina {
  _$_Bobina({this.id, this.nombre}) : super._();

  factory _$_Bobina.fromJson(Map<String, dynamic> json) =>
      _$$_BobinaFromJson(json);

  @override
  final String? id;
  @override
  final String? nombre;

  @override
  String toString() {
    return 'Bobina(id: $id, nombre: $nombre)';
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other.runtimeType == runtimeType &&
            other is _Bobina &&
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
  _$BobinaCopyWith<_Bobina> get copyWith =>
      __$BobinaCopyWithImpl<_Bobina>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_BobinaToJson(this);
  }
}

abstract class _Bobina extends Bobina {
  factory _Bobina({String? id, String? nombre}) = _$_Bobina;
  _Bobina._() : super._();

  factory _Bobina.fromJson(Map<String, dynamic> json) = _$_Bobina.fromJson;

  @override
  String? get id;
  @override
  String? get nombre;
  @override
  @JsonKey(ignore: true)
  _$BobinaCopyWith<_Bobina> get copyWith => throw _privateConstructorUsedError;
}
