import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:prayer_pals/core/utils/constants.dart';
import 'package:prayer_pals/core/widgets/rounded_button.dart';
import 'package:prayer_pals/features/group/view/create_group.dart';

class ConnectionsButton extends HookWidget {
  const ConnectionsButton({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          PPCRoundedButton(
            title: StringConstants.joinGroup,
            buttonRatio: .6,
            buttonWidthRatio: .5,
            callback: () {
              Navigator.pushNamed(context, '/GroupSearchPage');
            },
            bgColor: Colors.lightBlueAccent.shade100,
            textColor: Colors.white,
          ),
          PPCRoundedButton(
            title: StringConstants.startGroup,
            buttonRatio: .6,
            buttonWidthRatio: .5,
            callback: () {
              bool isCreating = true;
              showDialog(
                  context: context,
                  builder: (BuildContext context) =>
                      CreateGroupWidget(context, isCreating: isCreating));
            },
            bgColor: Colors.lightBlueAccent.shade100,
            textColor: Colors.white,
          ),
        ],
      ),
    );
  }
}
