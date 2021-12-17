import 'dart:ui';

import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:prayer_pals/core/utils/constants.dart';
import 'package:prayer_pals/core/widgets/pray_now_widget.dart';
import 'package:prayer_pals/features/prayer/models/prayer.dart';
import 'package:prayer_pals/features/prayer/providers/my_prayer_provider.dart';
import 'prayer_list_item.dart';

// ignore: must_be_immutable
class PrayerList extends ConsumerWidget {
  final bool isPrayNow;
  final PrayerType prayerType;
  List checkedIndexes = [];

  PrayerList({Key? key, required this.isPrayNow, required this.prayerType})
      : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    final prayerList =
        watch(prayerControllerProvider).retrievePrayers(prayerType);

    return FutureBuilder<List<Prayer>>(
        future: prayerList,
        builder: (BuildContext context, AsyncSnapshot<List<Prayer>> snapshot) {
          if (snapshot.hasError) {}
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: Text("Loading ..."),
            );
          } else {
            final data = snapshot.requireData;
            if (isPrayNow == true) {
              return ListView.builder(
                  itemCount: data.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: PrayNowRow(
                        title: data[index].title,
                        description: data[index].description,
                        isSelected: checkedIndexes.contains(index),
                        callback: () {
                          if (!checkedIndexes.contains(index)) {
                            checkedIndexes.add(index);
                          } else {
                            checkedIndexes.remove(index);
                          }
                        },
                      ),
                    );
                  });
            } else {
              return ListView.builder(
                itemCount: data.length,
                itemBuilder: (context, index) {
                  return PrayerListItem(
                    prayer: data[index],
                    callback: () {
                      _showDeleteConfirmationDialog(
                        context,
                        data[index],
                      );
                    },
                  );
                },
              );
            }
          }
        });
  }

  _showDeleteConfirmationDialog(BuildContext context, Prayer prayer) {
    Widget cancelButton = TextButton(
      child: Text(StringConstants.cancel),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget deleteButton = TextButton(
      child: Text(
        StringConstants.delete,
        style: TextStyle(
          color: Colors.red,
        ),
      ),
      onPressed: () async {
        await context.read(prayerControllerProvider).deletePrayer(prayer);
        Navigator.pop(context);
      },
    );
    AlertDialog alert = AlertDialog(
      title: Text(StringConstants.areYouSure),
      content: Text(StringConstants.doYouWishToDeleteThisPrayer),
      actions: [
        cancelButton,
        deleteButton,
      ],
    );
    showDialog(context: context, builder: (context) => alert);
  }
}
