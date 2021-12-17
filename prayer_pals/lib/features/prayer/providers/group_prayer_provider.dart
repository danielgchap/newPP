import 'package:intl/intl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer_pals/features/group/models/group.dart';
import 'package:prayer_pals/features/group/models/group_member.dart';
import 'package:prayer_pals/features/prayer/models/prayer.dart';
import 'package:prayer_pals/features/prayer/repositories/group_prayer_repository.dart';
import 'package:prayer_pals/core/utils/constants.dart';

final groupPrayerControllerProvider =
    Provider((ref) => GroupPrayerController(ref.read));

class GroupPrayerController {
  final Reader _reader;

  GroupPrayerController(this._reader) : super() {
    //retrievePrayers();
  }

  Future<String> createPrayer(
      GroupMember groupMember,
      String uid,
      String? title,
      String? description,
      String creatorUID,
      List<String> groupsToAdd,
      bool isGlobal) async {
    String message = '';

    if (title == null || title.isEmpty) {
      message = StringConstants.createPrayerErrorNoTitle;
    }

    if (description == null || description.isEmpty) {
      message = message + '\n${StringConstants.createPrayerErrorNoDescription}';
    }
    if (message.isNotEmpty) {
      return message;
    } else {
      //TODO: return success string

      Prayer prayer = Prayer(
        uid: uid,
        title: title!,
        description: description!,
        creatorUID: creatorUID,
        creatorDisplayName: groupMember.groupMemberName,
        dateCreated: DateFormat("MM-dd-yyyy").format(DateTime.now()).toString(),
        isGlobal: isGlobal,
        groups: groupsToAdd,
      );
      return await _reader(groupPrayerRepositoryProvider)
          .createPrayer(prayer, groupMember);
    }
  }

  Future<List<Prayer>> retrievePrayers(
    String groupId,
    PrayerType prayerType,
  ) async {
    return await _reader(groupPrayerRepositoryProvider).retrievePrayers(
      groupId,
      prayerType,
    );
  }

  Future<String> updatePrayer(
      Group group,
      String uid,
      String? title,
      String? description,
      String creatorUID,
      String displayName,
      String dateCreated,
      List<String> groupsToAdd,
      bool isGlobal) async {
    String message = '';

    if (title == null || title.isEmpty) {
      message = StringConstants.createPrayerErrorNoTitle;
    }

    if (description == null || description.isEmpty) {
      message = message + '\n${StringConstants.createPrayerErrorNoDescription}';
    }
    if (message.isNotEmpty) {
      return message;
    } else {
      //TODO: return success string
      Prayer prayer = Prayer(
        uid: uid,
        title: title!,
        description: description!,
        creatorUID: creatorUID,
        creatorDisplayName: displayName,
        dateCreated: dateCreated,
        isGlobal: isGlobal,
        groups: groupsToAdd,
      );
      return await _reader(groupPrayerRepositoryProvider)
          .updatePrayer(prayer, group);
    }
  }

  Future<String> deletePrayer(Prayer prayer, Group group) async {
    return await _reader(groupPrayerRepositoryProvider)
        .deletePrayer(prayer, group);
  }
}
