import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'group.freezed.dart';
part 'group.g.dart';

@freezed
class Group with _$Group {
  factory Group({
    required String groupUID,
    required String groupName,
    String? description,
    String? creatorUID,
    bool? isPrivate,
    String? tags,
  }) = _Group;
  factory Group.fromJson(Map<String, dynamic> json) => _$GroupFromJson(json);

  //factory Group.fromDocument(DocumentSnapshot<Map<String, dynamic>> doc) {
  //  final data = doc.data()!;
  //  return Group.fromJson(data).copyWith(uid: doc.id);
  //}
}
