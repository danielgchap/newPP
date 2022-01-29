import 'package:flutter/material.dart';
import 'package:prayer_pals/core/utils/constants.dart';

Future<void> showPPCDeleteDialog(
    BuildContext context, bool isGlobal, VoidCallback callback) async {
  return showDialog<void>(
    context: context,
    barrierDismissible: true,
    builder: (BuildContext context) {
      return AlertDialog(
        title: const Text(StringConstants.prayerPals),
        content: SingleChildScrollView(
          child: ListBody(
            children: <Widget>[
              Text(
                isGlobal
                    ? StringConstants
                        .areYouSureYouWishToRemoveThisGlobalPrayerFromYourPrayerList
                    : StringConstants.areYouSureYouWishToDeleteYourPrayer,
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
        actions: <Widget>[
          TextButton(
            child: const Text(StringConstants.cancel),
            onPressed: () {
              Navigator.of(context).pop();
            },
          ),
          TextButton(
            child: const Text(StringConstants.okCaps),
            onPressed: () {
              callback();
              Navigator.of(context).pop();
            },
          ),
        ],
      );
    },
  );
}
