import 'dart:io';

import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer_pals/features/group/models/group.dart';
import 'package:prayer_pals/features/group/repositories/group_repository.dart';
import 'package:prayer_pals/core/utils/constants.dart';

//////////////////////////////////////////////////////////////////////////
//
//     Used for creating groups in the groups collection
//
//////////////////////////////////////////////////////////////////////////

final groupControllerProvider =
    ChangeNotifierProvider((ref) => GroupController(ref.read));

class GroupController extends ChangeNotifier {
  final Reader _reader;

  GroupController(this._reader) : super();

  Future<String> retrieveGroup(
    String groupUID,
    String? groupName,
    String? description,
    String creatorUID,
    bool isPrivate,
    String tags,
  ) async {
    String message = '';

    if (groupName == null || groupName.isEmpty) {
      message = StringConstants.creategroupErrorNoName;
    }

    if (message.isNotEmpty) {
      return message;
    } else {
      Group group = Group(
          groupUID: groupUID,
          groupName: groupName!,
          description: description!,
          creatorUID: creatorUID,
          isPrivate: isPrivate,
          tags: tags);
      return await _reader(groupRepositoryProvider).retrieveGroup(group);
    }
  }

  Future<String> updateGroup(
      String groupUID,
      String? groupName,
      String? description,
      String creatorUID,
      bool isPrivate,
      String tags) async {
    String message = '';

    if (groupName == null || groupName.isEmpty) {
      message = StringConstants.creategroupErrorNoName;
    }

    if (message.isNotEmpty) {
      return message;
    } else {
      Group group = Group(
          groupUID: groupUID,
          groupName: groupName!,
          description: description!,
          creatorUID: creatorUID,
          isPrivate: isPrivate,
          tags: tags);
      return await _reader(groupRepositoryProvider).updateGroup(group);
    }
  }

  Future<String> deleteGroup(Group group) async {
    return await _reader(groupRepositoryProvider).deleteGroup(group);
  }

  Future<String> updateGroupImage(
      BuildContext context, File imageFile, Group group) async {
    return await _reader(groupRepositoryProvider)
        .updateGroupImage(context, imageFile, group);
  }

  Future<Group> fetchGroup(String uid) async {
    return _reader(groupRepositoryProvider).fetchGroup(uid);
  }
}
