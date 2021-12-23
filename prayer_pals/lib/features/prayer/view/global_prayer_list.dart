import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer_pals/core/utils/constants.dart';
import 'package:prayer_pals/features/prayer/models/prayer.dart';
import 'package:prayer_pals/features/prayer/providers/global_prayer_provider.dart';
import 'prayer_list_item.dart';

class GlobalPrayerList extends ConsumerWidget {
  final PrayerType prayerType;

  const GlobalPrayerList(this.prayerType, {Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final prayerList =
        watch(globalPrayerControllerProvider).retrievePrayers(prayerType);

    return FutureBuilder<List<Prayer>>(
        future: prayerList,
        builder: (BuildContext context, AsyncSnapshot<List<Prayer>> snapshot) {
          if (snapshot.hasError) {}
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Text("Loading ..."),
            );
          } else {
            final data = snapshot.requireData;

            return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return PrayerListItem(prayer: data[index]);
                });
          }
        });
  }
}
