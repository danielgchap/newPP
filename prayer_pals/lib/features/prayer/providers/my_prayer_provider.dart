import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer_pals/features/group/models/group.dart';
import 'package:prayer_pals/features/prayer/models/prayer.dart';
import 'package:prayer_pals/features/prayer/repositories/my_prayer_repository.dart';
import 'package:uuid/uuid.dart';

import '../../../core/utils/constants.dart';

final prayerControllerProvider =
    ChangeNotifierProvider((ref) => PrayerController(ref.read));

class PrayerController extends ChangeNotifier {
  final Reader _reader;

  PrayerController(this._reader) : super() {
    //  retrievePrayers();
  }

  Future<String> createPrayer(String? title, String? description,
      String creatorUID, List<String> groupsToAdd, bool isGlobal) async {
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
      Uuid uuid = const Uuid();
      String prayerId = uuid.v1();
      String? displayName = FirebaseAuth.instance.currentUser!.displayName;

      Prayer prayer = Prayer(
        uid: prayerId,
        title: title!,
        description: description!,
        creatorUID: creatorUID,
        creatorDisplayName: displayName!,
        dateCreated: DateFormat("MM-dd-yyyy").format(DateTime.now()).toString(),
        isGlobal: isGlobal,
        groups: groupsToAdd,
      );
      return await _reader(prayerRepositoryProvider).createPrayer(prayer);
    }
  }

  Future<List<Prayer>> retrievePrayers(PrayerType prayerType) async {
    return await _reader(prayerRepositoryProvider).retrievePrayers(prayerType);
  }

  Future<String> updatePrayer(
      PrayerType prayerType,
      String uid,
      String? title,
      String? description,
      String creatorUID,
      String displayName,
      String dateCreated,
      List<String> groupsToAdd,
      List<String> groupsToUpdateAdd,
      List<String> groupsToUpdateDelete,
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
      Prayer prayer = Prayer(
          uid: uid,
          title: title!,
          description: description!,
          creatorUID: creatorUID,
          creatorDisplayName: displayName,
          dateCreated: dateCreated,
          groups: groupsToAdd,
          isGlobal: isGlobal);
      return await _reader(prayerRepositoryProvider).updatePrayer(
        prayer,
        prayerType,
        groupsToUpdateDelete,
        groupsToUpdateAdd,
      );
    }
  }

  Future<String> deletePrayer(Prayer prayer) async {
    String result =
        await _reader(prayerRepositoryProvider).deletePrayer(prayer);
    if (result == StringConstants.success) notifyListeners();
    return result;
  }

  Future<List<Group>> fetchGroupsForCurrentUser() async {
    return await _reader(prayerRepositoryProvider).fetchGroupsForCurrentUser();
  }
}
