import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:flutter/material.dart';
import 'package:prayer_pals/core/utils/constants.dart';
import 'package:prayer_pals/core/widgets/pray_now_widget.dart';
import 'package:prayer_pals/features/prayer/models/prayer.dart';
import 'package:prayer_pals/features/prayer/providers/my_prayer_provider.dart';
import 'prayer_list_item.dart';

// ignore: must_be_immutable
class PrayerList extends HookWidget {
  final bool isPrayNow;
  final PrayerType prayerType;
  List checkedIndexes = [];

  PrayerList({Key? key, required this.isPrayNow, required this.prayerType})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Prayer>>(
        future:
            context.read(prayerControllerProvider).retrievePrayers(prayerType),
        builder: (BuildContext context, AsyncSnapshot<List<Prayer>> snapshot) {
          if (snapshot.hasError) {}
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Text("Loading ..."),
            );
          } else {
            final data = snapshot.requireData;
            if (isPrayNow == true) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: ListView.builder(
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
                    }),
              );
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
      child: const Text(StringConstants.cancel),
      onPressed: () {
        Navigator.pop(context);
      },
    );
    Widget deleteButton = TextButton(
      child: const Text(
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
      title: const Text(StringConstants.areYouSure),
      content: const Text(StringConstants.doYouWishToDeleteThisPrayer),
      actions: [
        cancelButton,
        deleteButton,
      ],
    );
    showDialog(context: context, builder: (context) => alert);
  }
}
