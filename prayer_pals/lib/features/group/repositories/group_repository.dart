import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer_pals/features/group/clients/group_client.dart';
import 'package:prayer_pals/features/group/models/group.dart';

//////////////////////////////////////////////////////////////////////////
//
//       used for creating groups in the group collection
//
//////////////////////////////////////////////////////////////////////////

final groupRepositoryProvider = Provider.autoDispose<GroupRepository>(
    (ref) => GroupRepositoryImpl(ref.read));

abstract class GroupRepository {
  Future<String> createGroup(Group group);
  Future<String> retrieveGroup(Group group);
  Future<String> updateGroup(Group group);
  Future<String> deleteGroup(Group group);
}

class GroupRepositoryImpl implements GroupRepository {
  final Reader _reader;

  const GroupRepositoryImpl(this._reader);

  @override
  Future<String> createGroup(Group group) async {
    return await _reader(groupClientProvider).createGroup(group);
  }

  @override
  Future<String> retrieveGroup(Group group) async {
    return await _reader(groupClientProvider).retrieveGroup(group);
  }

  @override
  Future<String> updateGroup(Group group) async {
    return await _reader(groupClientProvider).updateGroup(group);
  }

  @override
  Future<String> deleteGroup(Group group) async {
    return await _reader(groupClientProvider).deleteGroup(group);
  }
}
