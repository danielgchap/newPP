import 'dart:io';
import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer_pals/features/group/models/group.dart';
import 'package:prayer_pals/features/group/repositories/group_repository.dart';

//////////////////////////////////////////////////////////////////////////
//
//     Used for creating groups in the groups collection
//
//////////////////////////////////////////////////////////////////////////

final groupControllerProvider =
    ChangeNotifierProvider((ref) => GroupController(ref.read, false));

class GroupController extends ChangeNotifier {
  final Reader _reader;
  bool isEdit;

  GroupController(this._reader, this.isEdit) : super();

  Future<String> deleteGroup(Group group) async {
    return await _reader(groupRepositoryProvider).deleteGroup(group);
  }

  Future<String> updateGroupImage(
      BuildContext context, File imageFile, Group group) async {
    return await _reader(groupRepositoryProvider)
        .updateGroupImage(context, imageFile, group);
  }

  Future<Group> fetchGroup(String uid) async {
    final group = _reader(groupRepositoryProvider).fetchGroup(uid);
    notify();
    return group;
  }

  Stream<QuerySnapshot> fetchMyGroups() {
    return _reader(groupRepositoryProvider).fetchMyGroups();
  }

  saveDescriptionForGroup(String groupDescription, String groupUID) async {
    await _reader(groupRepositoryProvider)
        .saveDescriptionForGroup(groupDescription, groupUID);
    setIsEdit(false);
  }

  setIsEdit(bool edit) {
    isEdit = edit;
    notify();
  }

  notify() {
    Timer.run(() {
      notifyListeners();
    });
  }
}
