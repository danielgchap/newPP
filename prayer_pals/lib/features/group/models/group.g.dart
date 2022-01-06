// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'group.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Group _$$_GroupFromJson(Map<String, dynamic> json) => _$_Group(
      creatorUID: json['creatorUID'] as String?,
      description: json['description'] as String?,
      groupUID: json['groupUID'] as String,
      groupName: json['groupName'] as String,
      imageURL: json['imageURL'] as String?,
      isPrivate: json['isPrivate'] as bool?,
      memberCount: json['memberCount'] as int,
      prayerCount: json['prayerCount'] as int,
      searchParamsList: (json['searchParamsList'] as List<dynamic>?)
          ?.map((e) => e as String)
          .toList(),
      tags: json['tags'] as String?,
    );

Map<String, dynamic> _$$_GroupToJson(_$_Group instance) => <String, dynamic>{
      'creatorUID': instance.creatorUID,
      'description': instance.description,
      'groupUID': instance.groupUID,
      'groupName': instance.groupName,
      'imageURL': instance.imageURL,
      'isPrivate': instance.isPrivate,
      'memberCount': instance.memberCount,
      'prayerCount': instance.prayerCount,
      'searchParamsList': instance.searchParamsList,
      'tags': instance.tags,
    };
