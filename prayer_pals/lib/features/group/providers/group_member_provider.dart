import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer_pals/core/providers/ppcuser_core_provider.dart';
import 'package:prayer_pals/features/group/clients/group_client.dart';
import 'package:prayer_pals/features/group/models/group.dart';
import 'package:prayer_pals/features/group/models/group_member.dart';
import 'package:prayer_pals/features/group/repositories/group_member_repository.dart';
import 'package:prayer_pals/features/user/providers/group_notifications_list_provider.dart';

//////////////////////////////////////////////////////////////////////////
//
//     Used for creating members in the group-> members collection and
//     groups in the users -> groups collection
//
//////////////////////////////////////////////////////////////////////////

final groupMemberControllerProvider =
    Provider((ref) => GroupMemberController(ref.read));

class GroupMemberController {
  final Reader _reader;

  GroupMemberController(this._reader) : super() {
    // retrieveGroupMembers();
  }

  Future<String> createGroupMember(
      String groupMemberUID,
      String groupMemberName,
      String groupName,
      String groupUID,
      bool isAdmin,
      bool isOwner,
      bool isCreated,
      bool isInvited,
      String emailAddress,
      String phoneNumber,
      bool appNotify,
      bool textNotify,
      bool emailNotify,
      bool isPending,
      String groupImageURL) async {
    GroupMember groupMember = GroupMember(
      groupMemberUID: groupMemberUID,
      groupMemberName: groupMemberName,
      groupName: groupName,
      groupUID: groupUID,
      isAdmin: isAdmin,
      isOwner: isOwner,
      isCreated: isCreated,
      isInvited: isInvited,
      emailAddress: emailAddress,
      phoneNumber: phoneNumber,
      appNotify: appNotify,
      textNotify: textNotify,
      emailNotify: emailNotify,
      isPending: isPending,
      groupImageURL: groupImageURL,
    );
    final successString = await _reader(groupMemberRepositoryProvider)
        .createGroupMember(groupMember);
    if (isPending) {
      final group = await _reader(groupClientProvider).fetchGroup(groupUID);
      if (group.isPrivate != null && group.isPrivate!) {
        await _reader(groupMemberControllerProvider)
            .addGroupToMyPendingRequests(groupMember);
      } else {
        final group = await _reader(groupClientProvider).fetchGroup(groupUID);
        await _reader(groupMemberControllerProvider)
            .addGroupToMyGroups(group, groupMemberUID);
      }
    } else {
      final group = await _reader(groupClientProvider).fetchGroup(groupUID);
      await _reader(groupMemberControllerProvider)
          .addGroupToMyGroups(group, groupMemberUID);
    }
    _reader(groupNotificationsProvider).notify();
    return successString;
  }

  Future<String> updateGroupMember(
      String groupMemberUID,
      String groupMemberName,
      String groupName,
      String groupUID,
      bool isAdmin,
      bool isOwner,
      bool isCreated,
      bool isInvited,
      String emailAddress,
      String phoneNumber,
      bool appNotify,
      bool textNotify,
      bool emailNotify,
      bool isPending) async {
    GroupMember groupMember = GroupMember(
        groupMemberUID: groupMemberUID,
        groupMemberName: groupMemberName,
        groupName: groupName,
        groupUID: groupUID,
        isAdmin: isAdmin,
        isOwner: isOwner,
        isCreated: isCreated,
        isInvited: isInvited,
        emailAddress: emailAddress,
        phoneNumber: phoneNumber,
        appNotify: appNotify,
        textNotify: textNotify,
        emailNotify: emailNotify,
        isPending: isPending);
    return await _reader(groupMemberRepositoryProvider)
        .updateGroupMember(groupMember);
  }

  Future<void> addGroupToMyPendingRequests(GroupMember groupMember) async {
    final user = await _reader(ppcUserCoreProvider).currentUserNetworkFetch();
    return await _reader(groupMemberRepositoryProvider)
        .addGroupToMyPendingRequests(groupMember, user);
  }

  Future<void> addGroupToMyGroups(Group group, String userUID) async {
    return await _reader(groupClientProvider)
        .addGroupToMyGroups(group, userUID);
  }

  Future<String> deleteGroupMember(GroupMember groupMember) async {
    return await _reader(groupMemberRepositoryProvider)
        .deleteGroupMember(groupMember);
  }
}
