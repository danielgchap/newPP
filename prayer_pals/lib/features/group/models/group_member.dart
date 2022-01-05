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
    String? groupImageURL,
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

  factory GroupMember.fromQuerySnapshot(
      QuerySnapshot<Object?> data, int index) {
    GroupMember groupMember = GroupMember(
      groupMemberUID: data.docs[index]['groupMemberUID'],
      groupMemberName: data.docs[index]['groupMemberName'],
      groupName: data.docs[index]['groupName'],
      groupUID: data.docs[index]['groupUID'],
      isAdmin: data.docs[index]['isAdmin'],
      isOwner: data.docs[index]['isOwner'],
      isCreated: data.docs[index]['isCreated'],
      isInvited: data.docs[index]['isInvited'],
      emailAddress: data.docs[index]['emailAddress'],
      phoneNumber: data.docs[index]['phoneNumber'],
      appNotify: data.docs[index]['appNotify'],
      textNotify: data.docs[index]['textNotify'],
      emailNotify: data.docs[index]['emailNotify'],
      isPending: data.docs[index]['isPending'],
      groupImageURL: data.docs[index]['imageURL'],
    );
    return groupMember;
  }
}
