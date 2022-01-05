import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:prayer_pals/core/utils/constants.dart';
import 'package:prayer_pals/core/widgets/rounded_button.dart';

class AddRemovePrayerButton extends HookWidget {
  final bool isListed;

  const AddRemovePrayerButton({required this.isListed, Key? key})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Visibility(
          visible: isListed,
          child: PPCRoundedButton(
            title: StringConstants.remove,
            buttonRatio: .9,
            buttonWidthRatio: .9,
            callback: () {
//remove from personal list
            },
            bgColor: Colors.lightBlueAccent.shade100,
            textColor: Colors.white,
          ),
          replacement: PPCRoundedButton(
            title: StringConstants.add,
            buttonRatio: .9,
            buttonWidthRatio: .9,
            callback: () {
//add to personal list
            },
            bgColor: Colors.lightBlueAccent.shade100,
            textColor: Colors.white,
          ),
        ),
      ),
    );
  }
}
