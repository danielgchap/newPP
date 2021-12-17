import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer_pals/core/utils/constants.dart';
import 'package:prayer_pals/features/group/models/group.dart';
import 'package:prayer_pals/features/prayer/clients/my_prayer_client.dart';
import 'package:prayer_pals/features/prayer/models/prayer.dart';

final prayerRepositoryProvider = Provider.autoDispose<PrayerRepository>(
    (ref) => PrayerRepositoryImpl(ref.read));

abstract class PrayerRepository {
  Future<String> createPrayer(Prayer prayer);
  Future<List<Prayer>> retrievePrayers(PrayerType prayerType);
  Future<String> updatePrayer(
    Prayer prayer,
    PrayerType prayerType,
    List<String> groupsToRemoveFrom,
    List<String> groupsToAddTo,
  );
  Future<String> deletePrayer(Prayer prayer);
  Future<List<Group>> fetchGroupsForCurrentUser();
}

class PrayerRepositoryImpl implements PrayerRepository {
  final Reader _reader;

  const PrayerRepositoryImpl(this._reader);

  @override
  Future<String> createPrayer(Prayer prayer) async {
    return await _reader(prayerClientProvider).createPrayer(prayer);
  }

  @override
  Future<List<Prayer>> retrievePrayers(PrayerType prayerType) async {
    return await _reader(prayerClientProvider).retrievePrayer(prayerType);
  }

  @override
  Future<String> updatePrayer(
    Prayer prayer,
    PrayerType prayerType,
    List<String> groupsToRemoveFrom,
    List<String> groupsToAddTo,
  ) async {
    return await _reader(prayerClientProvider).updatePrayer(
      prayer,
      prayerType,
      groupsToRemoveFrom,
      groupsToAddTo,
    );
  }

  @override
  Future<String> deletePrayer(Prayer prayer) async {
    return await _reader(prayerClientProvider).deletePrayer(prayer);
  }

  Future<List<Group>> fetchGroupsForCurrentUser() async {
    return await _reader(prayerClientProvider).fetchGroupsForCurrentUser();
  }
}
