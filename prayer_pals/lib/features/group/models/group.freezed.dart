// coverage:ignore-file
// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target

part of 'group.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

T _$identity<T>(T value) => value;

final _privateConstructorUsedError = UnsupportedError(
    'It seems like you constructed your class using `MyClass._()`. This constructor is only meant to be used by freezed and you are not supposed to need it nor use it.\nPlease check the documentation here for more informations: https://github.com/rrousselGit/freezed#custom-getters-and-methods');

Group _$GroupFromJson(Map<String, dynamic> json) {
  return _Group.fromJson(json);
}

/// @nodoc
class _$GroupTearOff {
  const _$GroupTearOff();

  _Group call(
      {required String groupUID,
      required String groupName,
      String? description,
      String? creatorUID,
      bool? isPrivate,
      String? tags,
      List<String>? searchParamsList}) {
    return _Group(
      groupUID: groupUID,
      groupName: groupName,
      description: description,
      creatorUID: creatorUID,
      isPrivate: isPrivate,
      tags: tags,
      searchParamsList: searchParamsList,
    );
  }

  Group fromJson(Map<String, Object> json) {
    return Group.fromJson(json);
  }
}

/// @nodoc
const $Group = _$GroupTearOff();

/// @nodoc
mixin _$Group {
  String get groupUID => throw _privateConstructorUsedError;
  String get groupName => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String? get creatorUID => throw _privateConstructorUsedError;
  bool? get isPrivate => throw _privateConstructorUsedError;
  String? get tags => throw _privateConstructorUsedError;
  List<String>? get searchParamsList => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GroupCopyWith<Group> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupCopyWith<$Res> {
  factory $GroupCopyWith(Group value, $Res Function(Group) then) =
      _$GroupCopyWithImpl<$Res>;
  $Res call(
      {String groupUID,
      String groupName,
      String? description,
      String? creatorUID,
      bool? isPrivate,
      String? tags,
      List<String>? searchParamsList});
}

/// @nodoc
class _$GroupCopyWithImpl<$Res> implements $GroupCopyWith<$Res> {
  _$GroupCopyWithImpl(this._value, this._then);

  final Group _value;
  // ignore: unused_field
  final $Res Function(Group) _then;

  @override
  $Res call({
    Object? groupUID = freezed,
    Object? groupName = freezed,
    Object? description = freezed,
    Object? creatorUID = freezed,
    Object? isPrivate = freezed,
    Object? tags = freezed,
    Object? searchParamsList = freezed,
  }) {
    return _then(_value.copyWith(
      groupUID: groupUID == freezed
          ? _value.groupUID
          : groupUID // ignore: cast_nullable_to_non_nullable
              as String,
      groupName: groupName == freezed
          ? _value.groupName
          : groupName // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      creatorUID: creatorUID == freezed
          ? _value.creatorUID
          : creatorUID // ignore: cast_nullable_to_non_nullable
              as String?,
      isPrivate: isPrivate == freezed
          ? _value.isPrivate
          : isPrivate // ignore: cast_nullable_to_non_nullable
              as bool?,
      tags: tags == freezed
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as String?,
      searchParamsList: searchParamsList == freezed
          ? _value.searchParamsList
          : searchParamsList // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
abstract class _$GroupCopyWith<$Res> implements $GroupCopyWith<$Res> {
  factory _$GroupCopyWith(_Group value, $Res Function(_Group) then) =
      __$GroupCopyWithImpl<$Res>;
  @override
  $Res call(
      {String groupUID,
      String groupName,
      String? description,
      String? creatorUID,
      bool? isPrivate,
      String? tags,
      List<String>? searchParamsList});
}

/// @nodoc
class __$GroupCopyWithImpl<$Res> extends _$GroupCopyWithImpl<$Res>
    implements _$GroupCopyWith<$Res> {
  __$GroupCopyWithImpl(_Group _value, $Res Function(_Group) _then)
      : super(_value, (v) => _then(v as _Group));

  @override
  _Group get _value => super._value as _Group;

  @override
  $Res call({
    Object? groupUID = freezed,
    Object? groupName = freezed,
    Object? description = freezed,
    Object? creatorUID = freezed,
    Object? isPrivate = freezed,
    Object? tags = freezed,
    Object? searchParamsList = freezed,
  }) {
    return _then(_Group(
      groupUID: groupUID == freezed
          ? _value.groupUID
          : groupUID // ignore: cast_nullable_to_non_nullable
              as String,
      groupName: groupName == freezed
          ? _value.groupName
          : groupName // ignore: cast_nullable_to_non_nullable
              as String,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      creatorUID: creatorUID == freezed
          ? _value.creatorUID
          : creatorUID // ignore: cast_nullable_to_non_nullable
              as String?,
      isPrivate: isPrivate == freezed
          ? _value.isPrivate
          : isPrivate // ignore: cast_nullable_to_non_nullable
              as bool?,
      tags: tags == freezed
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as String?,
      searchParamsList: searchParamsList == freezed
          ? _value.searchParamsList
          : searchParamsList // ignore: cast_nullable_to_non_nullable
              as List<String>?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Group with DiagnosticableTreeMixin implements _Group {
  _$_Group(
      {required this.groupUID,
      required this.groupName,
      this.description,
      this.creatorUID,
      this.isPrivate,
      this.tags,
      this.searchParamsList});

  factory _$_Group.fromJson(Map<String, dynamic> json) =>
      _$$_GroupFromJson(json);

  @override
  final String groupUID;
  @override
  final String groupName;
  @override
  final String? description;
  @override
  final String? creatorUID;
  @override
  final bool? isPrivate;
  @override
  final String? tags;
  @override
  final List<String>? searchParamsList;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Group(groupUID: $groupUID, groupName: $groupName, description: $description, creatorUID: $creatorUID, isPrivate: $isPrivate, tags: $tags, searchParamsList: $searchParamsList)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Group'))
      ..add(DiagnosticsProperty('groupUID', groupUID))
      ..add(DiagnosticsProperty('groupName', groupName))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('creatorUID', creatorUID))
      ..add(DiagnosticsProperty('isPrivate', isPrivate))
      ..add(DiagnosticsProperty('tags', tags))
      ..add(DiagnosticsProperty('searchParamsList', searchParamsList));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Group &&
            (identical(other.groupUID, groupUID) ||
                const DeepCollectionEquality()
                    .equals(other.groupUID, groupUID)) &&
            (identical(other.groupName, groupName) ||
                const DeepCollectionEquality()
                    .equals(other.groupName, groupName)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.creatorUID, creatorUID) ||
                const DeepCollectionEquality()
                    .equals(other.creatorUID, creatorUID)) &&
            (identical(other.isPrivate, isPrivate) ||
                const DeepCollectionEquality()
                    .equals(other.isPrivate, isPrivate)) &&
            (identical(other.tags, tags) ||
                const DeepCollectionEquality().equals(other.tags, tags)) &&
            (identical(other.searchParamsList, searchParamsList) ||
                const DeepCollectionEquality()
                    .equals(other.searchParamsList, searchParamsList)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(groupUID) ^
      const DeepCollectionEquality().hash(groupName) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(creatorUID) ^
      const DeepCollectionEquality().hash(isPrivate) ^
      const DeepCollectionEquality().hash(tags) ^
      const DeepCollectionEquality().hash(searchParamsList);

  @JsonKey(ignore: true)
  @override
  _$GroupCopyWith<_Group> get copyWith =>
      __$GroupCopyWithImpl<_Group>(this, _$identity);

  @override
  Map<String, dynamic> toJson() {
    return _$$_GroupToJson(this);
  }
}

abstract class _Group implements Group {
  factory _Group(
      {required String groupUID,
      required String groupName,
      String? description,
      String? creatorUID,
      bool? isPrivate,
      String? tags,
      List<String>? searchParamsList}) = _$_Group;

  factory _Group.fromJson(Map<String, dynamic> json) = _$_Group.fromJson;

  @override
  String get groupUID => throw _privateConstructorUsedError;
  @override
  String get groupName => throw _privateConstructorUsedError;
  @override
  String? get description => throw _privateConstructorUsedError;
  @override
  String? get creatorUID => throw _privateConstructorUsedError;
  @override
  bool? get isPrivate => throw _privateConstructorUsedError;
  @override
  String? get tags => throw _privateConstructorUsedError;
  @override
  List<String>? get searchParamsList => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$GroupCopyWith<_Group> get copyWith => throw _privateConstructorUsedError;
}
