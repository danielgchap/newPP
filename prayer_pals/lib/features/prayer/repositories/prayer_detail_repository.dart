import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer_pals/features/prayer/clients/prayer_detail_client.dart';
import 'package:prayer_pals/features/prayer/models/prayer.dart';

final prayerDetailRepositoryProvider =
    Provider.autoDispose<PrayerDetailRepository>(
        (ref) => PrayerDetailRepositoryImpl(ref.read));

abstract class PrayerDetailRepository {
  Future<Prayer> fetchPrayer(String id, bool isGlobal);
}

class PrayerDetailRepositoryImpl implements PrayerDetailRepository {
  final Reader read;
  PrayerDetailRepositoryImpl(this.read);

  @override
  Future<Prayer> fetchPrayer(String id, bool isGlobal) async {
    return await read(prayerDetailClientProvider).fetchPrayer(id, isGlobal);
  }
}