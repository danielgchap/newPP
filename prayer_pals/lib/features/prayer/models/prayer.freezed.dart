// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'prayer.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Prayer _$PrayerFromJson(Map<String, dynamic> json) {
  return _Prayer.fromJson(json);
}

/// @nodoc
class _$PrayerTearOff {
  const _$PrayerTearOff();

  _Prayer call(
      {required String uid,
      required String title,
      required String description,
      required String creatorUID,
      required String creatorDisplayName,
      required String dateCreated,
      required bool isGlobal,
      required List<String> groups}) {
    return _Prayer(
      uid: uid,
      title: title,
      description: description,
      creatorUID: creatorUID,
      creatorDisplayName: creatorDisplayName,
      dateCreated: dateCreated,
      isGlobal: isGlobal,
      groups: groups,
    );
  }

  Prayer fromJson(Map<String, Object> json) {
    return Prayer.fromJson(json);
  }
}

/// @nodoc
const $Prayer = _$PrayerTearOff();

/// @nodoc
mixin _$Prayer {
  String get uid => throw _privateConstructorUsedError;
  String get title => throw _privateConstructorUsedError;
  String get description => throw _privateConstructorUsedError;
  String get creatorUID => throw _privateConstructorUsedError;
  String get creatorDisplayName => throw _privateConstructorUsedError;
  String get dateCreated => throw _privateConstructorUsedError;
  bool get isGlobal => throw _privateConstructorUsedError;
  List<String> get groups => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $PrayerCopyWith<Prayer> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $PrayerCopyWith<$Res> {
  factory $PrayerCopyWith(Prayer value, $Res Function(Prayer) then) =
      _$PrayerCopyWithImpl<$Res>;
  $Res call(
      {String uid,
      String title,
      String description,
      String creatorUID,
      String creatorDisplayName,
      String dateCreated,
      bool isGlobal,
      List<String> groups});
}

/// @nodoc
class _$PrayerCopyWithImpl<$Res> implements $PrayerCopyWith<$Res> {
  _$PrayerCopyWithImpl(this._value, this._then);

  final Prayer _value;
  // ignore: unused_field
  final $Res Function(Prayer) _then;

  @override
  $Res call({
    Object? uid = freezed,
    Object? title = freezed,
    Object? description = freezed,
    Object? creatorUID = freezed,
    Object? creatorDisplayName = freezed,
    Object? dateCreated = freezed,
    Object? isGlobal = freezed,
    Object? groups = freezed,
  }) {
    return _then(_value.copyWith(
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      creatorUID: creatorUID == freezed
          ? _value.creatorUID
          : creatorUID // ignore: cast_nullable_to_non_nullable
              as String,
      creatorDisplayName: creatorDisplayName == freezed
          ? _value.creatorDisplayName
          : creatorDisplayName // ignore: cast_nullable_to_non_nullable
              as String,
      dateCreated: dateCreated == freezed
          ? _value.dateCreated
          : dateCreated // ignore: cast_nullable_to_non_nullable
              as String,
      isGlobal: isGlobal == freezed
          ? _value.isGlobal
          : isGlobal // ignore: cast_nullable_to_non_nullable
              as bool,
      groups: groups == freezed
          ? _value.groups
          : groups // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
abstract class _$PrayerCopyWith<$Res> implements $PrayerCopyWith<$Res> {
  factory _$PrayerCopyWith(_Prayer value, $Res Function(_Prayer) then) =
      __$PrayerCopyWithImpl<$Res>;
  @override
  $Res call(
      {String uid,
      String title,
      String description,
      String creatorUID,
      String creatorDisplayName,
      String dateCreated,
      bool isGlobal,
      List<String> groups});
}

/// @nodoc
class __$PrayerCopyWithImpl<$Res> extends _$PrayerCopyWithImpl<$Res>
    implements _$PrayerCopyWith<$Res> {
  __$PrayerCopyWithImpl(_Prayer _value, $Res Function(_Prayer) _then)
      : super(_value, (v) => _then(v as _Prayer));

  @override
  _Prayer get _value => super._value as _Prayer;

  @override
  $Res call({
    Object? uid = freezed,
    Object? title = freezed,
    Object? description = freezed,
    Object? creatorUID = freezed,
    Object? creatorDisplayName = freezed,
    Object? dateCreated = freezed,
    Object? isGlobal = freezed,
    Object? groups = freezed,
  }) {
    return _then(_Prayer(
      uid: uid == freezed
          ? _value.uid
          : uid // ignore: cast_nullable_to_non_nullable
              as String,
      title: title == freezed
          ? _value.title
          : title // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String,
      creatorUID: creatorUID == freezed
          ? _value.creatorUID
          : creatorUID // ignore: cast_nullable_to_non_nullable
              as String,
      creatorDisplayName: creatorDisplayName == freezed
          ? _value.creatorDisplayName
          : creatorDisplayName // ignore: cast_nullable_to_non_nullable
              as String,
      dateCreated: dateCreated == freezed
          ? _value.dateCreated
          : dateCreated // ignore: cast_nullable_to_non_nullable
              as String,
      isGlobal: isGlobal == freezed
          ? _value.isGlobal
          : isGlobal // ignore: cast_nullable_to_non_nullable
              as bool,
      groups: groups == freezed
          ? _value.groups
          : groups // ignore: cast_nullable_to_non_nullable
              as List<String>,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Prayer with DiagnosticableTreeMixin implements _Prayer {
  _$_Prayer(
      {required this.uid,
      required this.title,
      required this.description,
      required this.creatorUID,
      required this.creatorDisplayName,
      required this.dateCreated,
      required this.isGlobal,
      required this.groups});

  factory _$_Prayer.fromJson(Map<String, dynamic> json) =>
      _$$_PrayerFromJson(json);

  @override
  final String uid;
  @override
  final String title;
  @override
  final String description;
  @override
  final String creatorUID;
  @override
  final String creatorDisplayName;
  @override
  final String dateCreated;
  @override
  final bool isGlobal;
  @override
  final List<String> groups;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Prayer(uid: $uid, title: $title, description: $description, creatorUID: $creatorUID, creatorDisplayName: $creatorDisplayName, dateCreated: $dateCreated, isGlobal: $isGlobal, groups: $groups)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Prayer'))
      ..add(DiagnosticsProperty('uid', uid))
      ..add(DiagnosticsProperty('title', title))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('creatorUID', creatorUID))
      ..add(DiagnosticsProperty('creatorDisplayName', creatorDisplayName))
      ..add(DiagnosticsProperty('dateCreated', dateCreated))
      ..add(DiagnosticsProperty('isGlobal', isGlobal))
      ..add(DiagnosticsProperty('groups', groups));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Prayer &&
            (identical(other.uid, uid) ||
                const DeepCollectionEquality().equals(other.uid, uid)) &&
            (identical(other.title, title) ||
                const DeepCollectionEquality().equals(other.title, title)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.creatorUID, creatorUID) ||
                const DeepCollectionEquality()
                    .equals(other.creatorUID, creatorUID)) &&
            (identical(other.creatorDisplayName, creatorDisplayName) ||
                const DeepCollectionEquality()
                    .equals(other.creatorDisplayName, creatorDisplayName)) &&
            (identical(other.dateCreated, dateCreated) ||
                const DeepCollectionEquality()
                    .equals(other.dateCreated, dateCreated)) &&
            (identical(other.isGlobal, isGlobal) ||
                const DeepCollectionEquality()
                    .equals(other.isGlobal, isGlobal)) &&
            (identical(other.groups, groups) ||
                const DeepCollectionEquality().equals(other.groups, groups)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(uid) ^
      const DeepCollectionEquality().hash(title) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(creatorUID) ^
      const DeepCollectionEquality().hash(creatorDisplayName) ^
      const DeepCollectionEquality().hash(dateCreated) ^
      const DeepCollectionEquality().hash(isGlobal) ^
      const DeepCollectionEquality().hash(groups);

  @JsonKey(ignore: true)
  @override
  _$PrayerCopyWith<_Prayer> get copyWith =>
      __$PrayerCopyWithImpl<_Prayer>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_PrayerToJson(this);
  }
}

abstract class _Prayer implements Prayer {
  factory _Prayer(
      {required String uid,
      required String title,
      required String description,
      required String creatorUID,
      required String creatorDisplayName,
      required String dateCreated,
      required bool isGlobal,
      required List<String> groups}) = _$_Prayer;

  factory _Prayer.fromJson(Map<String, dynamic> json) = _$_Prayer.fromJson;

  @override
  String get uid => throw _privateConstructorUsedError;
  @override
  String get title => throw _privateConstructorUsedError;
  @override
  String get description => throw _privateConstructorUsedError;
  @override
  String get creatorUID => throw _privateConstructorUsedError;
  @override
  String get creatorDisplayName => throw _privateConstructorUsedError;
  @override
  String get dateCreated => throw _privateConstructorUsedError;
  @override
  bool get isGlobal => throw _privateConstructorUsedError;
  @override
  List<String> get groups => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$PrayerCopyWith<_Prayer> get copyWith => throw _privateConstructorUsedError;
}
