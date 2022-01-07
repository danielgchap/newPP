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
      {String? creatorUID,
      String? description,
      required String groupUID,
      required String groupName,
      String? imageURL,
      bool? isPrivate,
      int? memberCount,
      int? prayerCount,
      List<dynamic>? searchParamsList,
      bool? subscribed,
      String? tags}) {
    return _Group(
      creatorUID: creatorUID,
      description: description,
      groupUID: groupUID,
      groupName: groupName,
      imageURL: imageURL,
      isPrivate: isPrivate,
      memberCount: memberCount,
      prayerCount: prayerCount,
      searchParamsList: searchParamsList,
      subscribed: subscribed,
      tags: tags,
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
  String? get creatorUID => throw _privateConstructorUsedError;
  String? get description => throw _privateConstructorUsedError;
  String get groupUID => throw _privateConstructorUsedError;
  String get groupName => throw _privateConstructorUsedError;
  String? get imageURL => throw _privateConstructorUsedError;
  bool? get isPrivate => throw _privateConstructorUsedError;
  int? get memberCount => throw _privateConstructorUsedError;
  int? get prayerCount => throw _privateConstructorUsedError;
  List<dynamic>? get searchParamsList => throw _privateConstructorUsedError;
  bool? get subscribed => throw _privateConstructorUsedError;
  String? get tags => throw _privateConstructorUsedError;

  Map<String, dynamic> toJson() => throw _privateConstructorUsedError;
  @JsonKey(ignore: true)
  $GroupCopyWith<Group> get copyWith => throw _privateConstructorUsedError;
}

/// @nodoc
abstract class $GroupCopyWith<$Res> {
  factory $GroupCopyWith(Group value, $Res Function(Group) then) =
      _$GroupCopyWithImpl<$Res>;
  $Res call(
      {String? creatorUID,
      String? description,
      String groupUID,
      String groupName,
      String? imageURL,
      bool? isPrivate,
      int? memberCount,
      int? prayerCount,
      List<dynamic>? searchParamsList,
      bool? subscribed,
      String? tags});
}

/// @nodoc
class _$GroupCopyWithImpl<$Res> implements $GroupCopyWith<$Res> {
  _$GroupCopyWithImpl(this._value, this._then);

  final Group _value;
  // ignore: unused_field
  final $Res Function(Group) _then;

  @override
  $Res call({
    Object? creatorUID = freezed,
    Object? description = freezed,
    Object? groupUID = freezed,
    Object? groupName = freezed,
    Object? imageURL = freezed,
    Object? isPrivate = freezed,
    Object? memberCount = freezed,
    Object? prayerCount = freezed,
    Object? searchParamsList = freezed,
    Object? subscribed = freezed,
    Object? tags = freezed,
  }) {
    return _then(_value.copyWith(
      creatorUID: creatorUID == freezed
          ? _value.creatorUID
          : creatorUID // ignore: cast_nullable_to_non_nullable
              as String?,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      groupUID: groupUID == freezed
          ? _value.groupUID
          : groupUID // ignore: cast_nullable_to_non_nullable
              as String,
      groupName: groupName == freezed
          ? _value.groupName
          : groupName // ignore: cast_nullable_to_non_nullable
              as String,
      imageURL: imageURL == freezed
          ? _value.imageURL
          : imageURL // ignore: cast_nullable_to_non_nullable
              as String?,
      isPrivate: isPrivate == freezed
          ? _value.isPrivate
          : isPrivate // ignore: cast_nullable_to_non_nullable
              as bool?,
      memberCount: memberCount == freezed
          ? _value.memberCount
          : memberCount // ignore: cast_nullable_to_non_nullable
              as int?,
      prayerCount: prayerCount == freezed
          ? _value.prayerCount
          : prayerCount // ignore: cast_nullable_to_non_nullable
              as int?,
      searchParamsList: searchParamsList == freezed
          ? _value.searchParamsList
          : searchParamsList // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
      subscribed: subscribed == freezed
          ? _value.subscribed
          : subscribed // ignore: cast_nullable_to_non_nullable
              as bool?,
      tags: tags == freezed
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
abstract class _$GroupCopyWith<$Res> implements $GroupCopyWith<$Res> {
  factory _$GroupCopyWith(_Group value, $Res Function(_Group) then) =
      __$GroupCopyWithImpl<$Res>;
  @override
  $Res call(
      {String? creatorUID,
      String? description,
      String groupUID,
      String groupName,
      String? imageURL,
      bool? isPrivate,
      int? memberCount,
      int? prayerCount,
      List<dynamic>? searchParamsList,
      bool? subscribed,
      String? tags});
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
    Object? creatorUID = freezed,
    Object? description = freezed,
    Object? groupUID = freezed,
    Object? groupName = freezed,
    Object? imageURL = freezed,
    Object? isPrivate = freezed,
    Object? memberCount = freezed,
    Object? prayerCount = freezed,
    Object? searchParamsList = freezed,
    Object? subscribed = freezed,
    Object? tags = freezed,
  }) {
    return _then(_Group(
      creatorUID: creatorUID == freezed
          ? _value.creatorUID
          : creatorUID // ignore: cast_nullable_to_non_nullable
              as String?,
      description: description == freezed
          ? _value.description
          : description // ignore: cast_nullable_to_non_nullable
              as String?,
      groupUID: groupUID == freezed
          ? _value.groupUID
          : groupUID // ignore: cast_nullable_to_non_nullable
              as String,
      groupName: groupName == freezed
          ? _value.groupName
          : groupName // ignore: cast_nullable_to_non_nullable
              as String,
      imageURL: imageURL == freezed
          ? _value.imageURL
          : imageURL // ignore: cast_nullable_to_non_nullable
              as String?,
      isPrivate: isPrivate == freezed
          ? _value.isPrivate
          : isPrivate // ignore: cast_nullable_to_non_nullable
              as bool?,
      memberCount: memberCount == freezed
          ? _value.memberCount
          : memberCount // ignore: cast_nullable_to_non_nullable
              as int?,
      prayerCount: prayerCount == freezed
          ? _value.prayerCount
          : prayerCount // ignore: cast_nullable_to_non_nullable
              as int?,
      searchParamsList: searchParamsList == freezed
          ? _value.searchParamsList
          : searchParamsList // ignore: cast_nullable_to_non_nullable
              as List<dynamic>?,
      subscribed: subscribed == freezed
          ? _value.subscribed
          : subscribed // ignore: cast_nullable_to_non_nullable
              as bool?,
      tags: tags == freezed
          ? _value.tags
          : tags // ignore: cast_nullable_to_non_nullable
              as String?,
    ));
  }
}

/// @nodoc
@JsonSerializable()
class _$_Group with DiagnosticableTreeMixin implements _Group {
  _$_Group(
      {this.creatorUID,
      this.description,
      required this.groupUID,
      required this.groupName,
      this.imageURL,
      this.isPrivate,
      this.memberCount,
      this.prayerCount,
      this.searchParamsList,
      this.subscribed,
      this.tags});

  factory _$_Group.fromJson(Map<String, dynamic> json) =>
      _$$_GroupFromJson(json);

  @override
  final String? creatorUID;
  @override
  final String? description;
  @override
  final String groupUID;
  @override
  final String groupName;
  @override
  final String? imageURL;
  @override
  final bool? isPrivate;
  @override
  final int? memberCount;
  @override
  final int? prayerCount;
  @override
  final List<dynamic>? searchParamsList;
  @override
  final bool? subscribed;
  @override
  final String? tags;

  @override
  String toString({DiagnosticLevel minLevel = DiagnosticLevel.info}) {
    return 'Group(creatorUID: $creatorUID, description: $description, groupUID: $groupUID, groupName: $groupName, imageURL: $imageURL, isPrivate: $isPrivate, memberCount: $memberCount, prayerCount: $prayerCount, searchParamsList: $searchParamsList, subscribed: $subscribed, tags: $tags)';
  }

  @override
  void debugFillProperties(DiagnosticPropertiesBuilder properties) {
    super.debugFillProperties(properties);
    properties
      ..add(DiagnosticsProperty('type', 'Group'))
      ..add(DiagnosticsProperty('creatorUID', creatorUID))
      ..add(DiagnosticsProperty('description', description))
      ..add(DiagnosticsProperty('groupUID', groupUID))
      ..add(DiagnosticsProperty('groupName', groupName))
      ..add(DiagnosticsProperty('imageURL', imageURL))
      ..add(DiagnosticsProperty('isPrivate', isPrivate))
      ..add(DiagnosticsProperty('memberCount', memberCount))
      ..add(DiagnosticsProperty('prayerCount', prayerCount))
      ..add(DiagnosticsProperty('searchParamsList', searchParamsList))
      ..add(DiagnosticsProperty('subscribed', subscribed))
      ..add(DiagnosticsProperty('tags', tags));
  }

  @override
  bool operator ==(dynamic other) {
    return identical(this, other) ||
        (other is _Group &&
            (identical(other.creatorUID, creatorUID) ||
                const DeepCollectionEquality()
                    .equals(other.creatorUID, creatorUID)) &&
            (identical(other.description, description) ||
                const DeepCollectionEquality()
                    .equals(other.description, description)) &&
            (identical(other.groupUID, groupUID) ||
                const DeepCollectionEquality()
                    .equals(other.groupUID, groupUID)) &&
            (identical(other.groupName, groupName) ||
                const DeepCollectionEquality()
                    .equals(other.groupName, groupName)) &&
            (identical(other.imageURL, imageURL) ||
                const DeepCollectionEquality()
                    .equals(other.imageURL, imageURL)) &&
            (identical(other.isPrivate, isPrivate) ||
                const DeepCollectionEquality()
                    .equals(other.isPrivate, isPrivate)) &&
            (identical(other.memberCount, memberCount) ||
                const DeepCollectionEquality()
                    .equals(other.memberCount, memberCount)) &&
            (identical(other.prayerCount, prayerCount) ||
                const DeepCollectionEquality()
                    .equals(other.prayerCount, prayerCount)) &&
            (identical(other.searchParamsList, searchParamsList) ||
                const DeepCollectionEquality()
                    .equals(other.searchParamsList, searchParamsList)) &&
            (identical(other.subscribed, subscribed) ||
                const DeepCollectionEquality()
                    .equals(other.subscribed, subscribed)) &&
            (identical(other.tags, tags) ||
                const DeepCollectionEquality().equals(other.tags, tags)));
  }

  @override
  int get hashCode =>
      runtimeType.hashCode ^
      const DeepCollectionEquality().hash(creatorUID) ^
      const DeepCollectionEquality().hash(description) ^
      const DeepCollectionEquality().hash(groupUID) ^
      const DeepCollectionEquality().hash(groupName) ^
      const DeepCollectionEquality().hash(imageURL) ^
      const DeepCollectionEquality().hash(isPrivate) ^
      const DeepCollectionEquality().hash(memberCount) ^
      const DeepCollectionEquality().hash(prayerCount) ^
      const DeepCollectionEquality().hash(searchParamsList) ^
      const DeepCollectionEquality().hash(subscribed) ^
      const DeepCollectionEquality().hash(tags);

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
      {String? creatorUID,
      String? description,
      required String groupUID,
      required String groupName,
      String? imageURL,
      bool? isPrivate,
      int? memberCount,
      int? prayerCount,
      List<dynamic>? searchParamsList,
      bool? subscribed,
      String? tags}) = _$_Group;

  factory _Group.fromJson(Map<String, dynamic> json) = _$_Group.fromJson;

  @override
  String? get creatorUID => throw _privateConstructorUsedError;
  @override
  String? get description => throw _privateConstructorUsedError;
  @override
  String get groupUID => throw _privateConstructorUsedError;
  @override
  String get groupName => throw _privateConstructorUsedError;
  @override
  String? get imageURL => throw _privateConstructorUsedError;
  @override
  bool? get isPrivate => throw _privateConstructorUsedError;
  @override
  int? get memberCount => throw _privateConstructorUsedError;
  @override
  int? get prayerCount => throw _privateConstructorUsedError;
  @override
  List<dynamic>? get searchParamsList => throw _privateConstructorUsedError;
  @override
  bool? get subscribed => throw _privateConstructorUsedError;
  @override
  String? get tags => throw _privateConstructorUsedError;
  @override
  @JsonKey(ignore: true)
  _$GroupCopyWith<_Group> get copyWith => throw _privateConstructorUsedError;
}
