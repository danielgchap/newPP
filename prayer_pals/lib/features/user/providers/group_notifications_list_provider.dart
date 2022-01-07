import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer_pals/features/group/models/group.dart';
import 'package:prayer_pals/features/user/clients/group_notifications_remote_client.dart';

final prayerNowProvider =
    Provider((ref) => GroupNotificationsController(ref.read));

final groupNotificationsProvider =
    Provider((ref) => GroupNotificationsController(ref.read));

class GroupNotificationsController {
  final Reader read;
  GroupNotificationsController(this.read);

  Future<List<Group>> getGroupsSubscribedTo() async {
    return await read(groupNotificationsClientProvider).getGroupsSubscribedTo();
  }

  Future<void> unsubscribeFromGroup(Group group) async {
    return await read(groupNotificationsClientProvider)
        .removeGroupFromSubscribedArray(group);
  }

  Future<void> subscribeToGroup(Group group) async {
    return await read(groupNotificationsClientProvider)
        .addGroupToSubscribedArray(group);
  }
}
