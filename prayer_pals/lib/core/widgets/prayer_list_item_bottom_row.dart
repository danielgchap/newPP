import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer_pals/core/providers/reminder_provider.dart';
import 'package:prayer_pals/core/utils/constants.dart';
import 'package:prayer_pals/core/utils/size_config.dart';
import 'package:prayer_pals/core/widgets/ppc_logo_widget.dart';
import 'package:prayer_pals/features/prayer/models/prayer.dart';
import 'package:share_plus/share_plus.dart';

class PrayerListItemBottomRow extends HookWidget {
  final Prayer prayer;
  final bool isOwner;
  final VoidCallback? callback;

  const PrayerListItemBottomRow(this.callback,
      {Key? key, required this.prayer, required this.isOwner})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final reminderProvider = useProvider(reminderControllerProvider);
    String _groupName;
    if (prayer.isGlobal == true) {
      _groupName = StringConstants.prayerPals;
    } else {
      if (isOwner == true) {
        _groupName = StringConstants.myPrayer;
      } else {
        _groupName = prayer.groups[0];
      }
    }
    return FutureBuilder(
      future: reminderProvider.getReminderForPrayer(prayer),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData && snapshot.data.toString().isNotEmpty) {
          return Row(
            children: [
              Expanded(
                child: Row(
                  children: [
                    Visibility(
                      child: const PPCLogoWidget(size: 2.5),
                      visible: prayer.isGlobal,
                    ),
                    Text(
                      _groupName,
                      style: TextStyle(
                        fontSize: SizeConfig.safeBlockVertical! * 2.3,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Visibility(
                    visible: isOwner,
                    maintainState: true,
                    maintainAnimation: true,
                    maintainSize: true,
                    child: IconButton(
                      icon: Icon(
                        CupertinoIcons.delete,
                        color: Colors.lightBlue,
                        size: SizeConfig.safeBlockHorizontal! * 5,
                      ),
                      onPressed: () async {
                        //move to bottom and add a pop up "are you sure"
                        //TODO: are you sure dialog
                        if (callback != null) callback!();
                      }, //Delete prayer, or remove it from your list if it is group/global TODO
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.ios_share,
                      color: Colors.lightBlue,
                      size: SizeConfig.safeBlockVertical! * 3,
                    ),
                    onPressed: () {
                      _onShare(context, prayer);
                    }, //Share - should use phones sharing system just like sharing photo TODO
                  ),
                  TextButton(
                    onPressed: () {
                      showDeleteReminderDialog(context, reminderProvider);
                    },
                    child: Text(
                      '${snapshot.data.toString()}\n${StringConstants.daily}',
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: Colors.redAccent),
                    ),
                  ),
                ],
              ),
            ],
          );
        } else {
          return Row(
            children: [
              Container(
                padding: const EdgeInsets.only(bottom: 5),
                width: SizeConfig.safeBlockHorizontal! * 52,
                child: Row(
                  children: [
                    Visibility(
                      child: const PPCLogoWidget(size: 2.5),
                      visible: prayer.isGlobal,
                    ),
                    Text(
                      _groupName,
                      style: TextStyle(
                        fontSize: SizeConfig.safeBlockVertical! * 2.3,
                      ),
                    ),
                  ],
                ),
              ),
              Row(
                children: [
                  Visibility(
                    visible: isOwner,
                    maintainState: true,
                    maintainAnimation: true,
                    maintainSize: true,
                    child: IconButton(
                      icon: Icon(
                        CupertinoIcons.delete,
                        color: Colors.lightBlue,
                        size: SizeConfig.safeBlockHorizontal! * 5,
                      ),
                      onPressed: () async {
                        //move to bottom and add a pop up "are you sure"
                        //TODO: are you sure dialog
                        if (callback != null) callback!();
                      }, //Delete prayer, or remove it from your list if it is group/global TODO
                    ),
                  ),
                  IconButton(
                    icon: Icon(
                      Icons.ios_share,
                      color: Colors.lightBlue,
                      size: SizeConfig.safeBlockVertical! * 3,
                    ),
                    onPressed: () {
                      _onShare(context, prayer);
                    }, //Share - should use phones sharing system just like sharing photo TODO
                  ),
                  IconButton(
                    icon: Icon(
                      CupertinoIcons.alarm,
                      color: Colors.lightBlue,
                      size: SizeConfig.safeBlockHorizontal! * 5,
                    ),
                    onPressed: () {
                      reminderProvider.setReminderForPrayer(context, prayer);
                    },
                  ),
                ],
              ),
            ],
          );
        }
      },
    );
  }

  void _onShare(BuildContext context, Prayer prayer) async {
    final box = context.findRenderObject() as RenderBox?;
    await Share.share("${prayer.title}\n${prayer.description}",
        subject: prayer.description,
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  }

  showDeleteReminderDialog(
      BuildContext context, ReminderController reminderProvider) {
    Widget okButton = TextButton(
      child: const Text(StringConstants.okCaps),
      onPressed: () async {
        Navigator.of(context).pop();
        await reminderProvider.deleteReminderForPrayer(prayer);
      },
    );

    Widget cancel = TextButton(
      child: const Text(StringConstants.cancel),
      onPressed: () {},
    );

    AlertDialog alert = AlertDialog(
      title: const Text(StringConstants.prayerPals),
      content:
          const Text(StringConstants.areYouSureYouWishToCancelThisReminder),
      actions: [
        okButton,
        cancel,
      ],
    );

    // show the dialog
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return alert;
      },
    );
  }
}
