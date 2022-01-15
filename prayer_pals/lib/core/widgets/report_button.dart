import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:prayer_pals/core/utils/constants.dart';
import 'package:prayer_pals/core/widgets/rounded_button.dart';

class ReportButton extends HookWidget {
  const ReportButton({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: PPCRoundedButton(
          title: StringConstants.report,
          buttonRatio: .9,
          buttonWidthRatio: .9,
          callback: () {
            showDialogForReport(context);
          },
          bgColor: Colors.lightBlueAccent.shade100,
          textColor: Colors.white,
        ),
      ),
    );
  }

  showDialogForReport(BuildContext context) {
    return showDialog<void>(
      context: context,
      barrierDismissible: false, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text(StringConstants.prayerPals),
          content: SingleChildScrollView(
            child: ListBody(
              children: const <Widget>[
                Text(
                  StringConstants.reporthingThisPrayer,
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
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
