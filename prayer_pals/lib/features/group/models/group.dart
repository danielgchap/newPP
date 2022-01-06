import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'group.freezed.dart';
part 'group.g.dart';

@freezed
class Group with _$Group {
  factory Group({
    String? creatorUID,
    String? description,
    required String groupUID,
    required String groupName,
    String? imageURL,
    bool? isPrivate,
    required int memberCount,
    required int prayerCount,
    List<String>? searchParamsList,
    String? tags,
  }) = _Group;
  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);

  factory Group.fromQuerySnapshot(QuerySnapshot<Object?> data, int index) {
    return Group(
      groupUID: data.docs[index]['groupUID'],
      groupName: data.docs[index]['groupName'],
      description: data.docs[index]['description'],
      creatorUID: data.docs[index]['creatorUID'],
      isPrivate: data.docs[index]['isPrivate'],
      tags: data.docs[index]['tags'],
      imageURL: data.docs[index]['imageURL'],
      memberCount: data.docs[index]['memberCount'],
      prayerCount: data.docs[index]['prayerCount'],
    );
  }
}
