import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer_pals/core/utils/search_array_maker.dart';
import 'package:prayer_pals/features/group/models/group.dart';
import 'package:prayer_pals/features/group/repositories/group_repository.dart';
import 'package:prayer_pals/core/utils/constants.dart';

//////////////////////////////////////////////////////////////////////////
//
//     Used for creating groups in the groups collection
//
//////////////////////////////////////////////////////////////////////////

final groupControllerProvider = Provider((ref) => GroupController(ref.read));

class GroupController {
  final Reader _reader;

  GroupController(this._reader) : super();

  Future<String> createGroup(
    String groupUID,
    String groupName,
    String? description,
    String creatorUID,
    bool isPrivate,
    String tags,
  ) async {
    String message = '';

    if (groupName.isEmpty) {
      message = StringConstants.creategroupErrorNoName;
    }

    final serachParamsList = SearchArrayMaker.setSearchParam(groupName);

    if (message.isNotEmpty) {
      return message;
    } else {
      Group group = Group(
          groupUID: groupUID,
          groupName: groupName,
          description: description!,
          creatorUID: creatorUID,
          isPrivate: isPrivate,
          searchParamsList: serachParamsList,
          tags: tags);
      return await _reader(groupRepositoryProvider).createGroup(group);
    }
  }

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
}
