import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:flutter/foundation.dart';

part 'group_member.freezed.dart';
part 'group_member.g.dart';

@freezed
class GroupMember with _$GroupMember {
  factory GroupMember({
    required String groupMemberUID,
    required String groupMemberName,
    required String groupName,
    required String groupUID,
    required bool isAdmin,
    required bool isOwner,
    required bool isCreated,
    required bool isInvited,
    required String emailAddress,
    required String phoneNumber,
    required bool appNotify,
    required bool textNotify,
    required bool emailNotify,
    required bool isPending,
  }) = _GroupMember;
  factory GroupMember.fromJson(Map<String, dynamic> json) =>
      _$GroupMemberFromJson(json);

  factory GroupMember.fromDocument(DocumentSnapshot<Map<String, dynamic>> doc) {
    final data = doc.data()!;
    return GroupMember.fromJson(data).copyWith(groupMemberUID: doc.id);
  }
}
