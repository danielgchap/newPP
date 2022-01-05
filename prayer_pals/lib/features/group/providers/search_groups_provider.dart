import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer_pals/features/group/repositories/group_repository.dart';

final searchGroupControllerProvider =
    Provider((ref) => SearchGroupController(ref.read));

class SearchGroupController {
  final Reader reader;
  const SearchGroupController(this.reader);

  Stream<QuerySnapshot> searchGroups(String searchParams) {
    return reader(groupRepositoryProvider).searchGroups(searchParams);
  }
}
