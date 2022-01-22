import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer_pals/features/prayer/models/prayer.dart';
import 'package:prayer_pals/features/prayer/repositories/prayer_detail_repository.dart';

final prayerDetailProvider =
    Provider<PrayerDetailController>((ref) => PrayerDetailController(ref.read));

class PrayerDetailController {
  final Reader _reader;

  PrayerDetailController(this._reader) : super();

  Future<Prayer> fetchPrayer(String uid, bool isGlobal) async {
    return await _reader(prayerDetailRepositoryProvider)
        .fetchPrayer(uid, isGlobal);
  }

  Future<bool> reportPrayer(Prayer prayer) async {
    return await _reader(prayerDetailRepositoryProvider).reportPrayer(prayer);
  }
}
