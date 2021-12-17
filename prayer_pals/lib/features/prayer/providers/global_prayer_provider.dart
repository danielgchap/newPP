import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer_pals/core/utils/constants.dart';
import 'package:prayer_pals/features/prayer/models/prayer.dart';
import 'package:prayer_pals/features/prayer/repositories/global_prayer_repository.dart';

final globalPrayerControllerProvider =
    Provider((ref) => GlobalPrayerController(ref.read));

class GlobalPrayerController {
  final Reader _reader;

  GlobalPrayerController(this._reader) : super() {
    //retrievePrayers(prayerType);
  }

  Future<List<Prayer>> retrievePrayers(PrayerType prayerType) async {
    return await _reader(globalPrayerRepositoryProvider)
        .retrievePrayers(prayerType);
  }
}
