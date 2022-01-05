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
          callback: () {},
          bgColor: Colors.lightBlueAccent.shade100,
          textColor: Colors.white,
        ),
      ),
    );
  }
}
