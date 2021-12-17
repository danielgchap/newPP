import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer_pals/features/group/models/group.dart';
import 'package:prayer_pals/features/group/models/group_member.dart';
import 'package:prayer_pals/features/prayer/clients/group_prayer_client.dart';
import 'package:prayer_pals/features/prayer/models/prayer.dart';

final groupPrayerRepositoryProvider =
    Provider.autoDispose<GroupPrayerRepository>(
        (ref) => GroupPrayerRepositoryImpl(ref.read));

abstract class GroupPrayerRepository {
  Future<String> createPrayer(Prayer prayer, GroupMember groupMember);
  Future<List<Prayer>> retrievePrayers(group, prayerType);
  Future<String> updatePrayer(Prayer prayer, Group group);
  Future<String> deletePrayer(Prayer prayer, Group group);
}

class GroupPrayerRepositoryImpl implements GroupPrayerRepository {
  final Reader _reader;

  const GroupPrayerRepositoryImpl(this._reader);

  @override
  Future<String> createPrayer(Prayer prayer, GroupMember groupMember) async {
    return await _reader(groupPrayerClientProvider)
        .createPrayer(prayer, groupMember);
  }

  @override
  Future<List<Prayer>> retrievePrayers(group, prayerType) async {
    return await _reader(groupPrayerClientProvider)
        .retrievePrayer(group, prayerType);
  }

  @override
  Future<String> updatePrayer(Prayer prayer, Group group) async {
    return await _reader(groupPrayerClientProvider).updatePrayer(prayer, group);
  }

  @override
  Future<String> deletePrayer(Prayer prayer, Group group) async {
    return await _reader(groupPrayerClientProvider).deletePrayer(prayer, group);
  }
}
