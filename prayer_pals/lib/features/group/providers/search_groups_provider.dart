import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer_pals/features/group/repositories/group_repository.dart';

final searchGroupControllerProvider =
    ChangeNotifierProvider((ref) => SearchGroupController(ref.read));

class SearchGroupController with ChangeNotifier {
  final Reader reader;
  SearchGroupController(this.reader);

  Stream<QuerySnapshot> searchGroups(String searchParams) {
    return reader(groupRepositoryProvider).searchGroups(searchParams);
  }

  notify() {
    notifyListeners();
  }
}
