// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Group _$$_GroupFromJson(Map<String, dynamic> json) => _$_Group(
      groupUID: json['groupUID'] as String,
      groupName: json['groupName'] as String,
      description: json['description'] as String?,
      creatorUID: json['creatorUID'] as String?,
      isPrivate: json['isPrivate'] as bool?,
      tags: json['tags'] as String?,
      imageURL: json['imageURL'] as String?,
      searchParamsList: (json['searchParamsList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
    );

Map<String, dynamic> _$$_GroupToJson(_$_Group instance) => <String, dynamic>{
      'groupUID': instance.groupUID,
      'groupName': instance.groupName,
      'description': instance.description,
      'creatorUID': instance.creatorUID,
      'isPrivate': instance.isPrivate,
      'tags': instance.tags,
      'imageURL': instance.imageURL,
      'searchParamsList': instance.searchParamsList,
    };
