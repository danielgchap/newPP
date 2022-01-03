// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'prayer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_$_Prayer _$$_PrayerFromJson(Map<String, dynamic> json) => _$_Prayer(
      uid: json['uid'] as String,
      title: json['title'] as String,
      description: json['description'] as String,
      creatorUID: json['creatorUID'] as String,
      creatorDisplayName: json['creatorDisplayName'] as String,
      creatorImageURL: json['creatorImageURL'] as String?,
      dateCreated: json['dateCreated'] as String,
      isGlobal: json['isGlobal'] as bool,
      groups:
          (json['groups'] as List<dynamic>).map((e) => e as String).toList(),
    );

Map<String, dynamic> _$$_PrayerToJson(_$_Prayer instance) => <String, dynamic>{
      'uid': instance.uid,
      'title': instance.title,
      'description': instance.description,
      'creatorUID': instance.creatorUID,
      'creatorDisplayName': instance.creatorDisplayName,
      'creatorImageURL': instance.creatorImageURL,
      'dateCreated': instance.dateCreated,
      'isGlobal': instance.isGlobal,
      'groups': instance.groups,
    };
