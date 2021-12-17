import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer_pals/core/utils/size_config.dart';
import 'package:prayer_pals/features/group/models/group.dart';
import 'package:prayer_pals/core/utils/constants.dart';
import 'group_prayer_list.dart';

// ignore: must_be_immutable
class GroupPrayersPage extends ConsumerWidget {
  final String groupId;
  final String groupName;
  bool _backButton = true;
  Group? group;

  GroupPrayersPage({required this.groupId, required this.groupName});

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    PrayerType _prayerType = PrayerType.Group;
    return Scaffold(
        backgroundColor: Colors.lightBlue[50],
        appBar: AppBar(
          title: Text(
            groupName,
          ),
          leading: Visibility(
            visible: _backButton,
            child: IconButton(
              icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
              onPressed: () => Navigator.of(context).pop(),
            ),
          ),
          centerTitle: true,
          actions: [
            Visibility(
              visible: _prayerType == PrayerType.Answered,
              replacement: IconButton(
                icon: Icon(
                  CupertinoIcons.chat_bubble_2,
                  color: Colors.white,
                  size: SizeConfig.safeBlockHorizontal! * 8,
                ),
                onPressed: () {
                  if (_prayerType == PrayerType.Answered) {
                    _prayerType = PrayerType.Group;
                  } else {
                    _prayerType = PrayerType.Answered;
                  }
                },
              ),
              child: IconButton(
                icon: Icon(
                  Icons.comment_outlined,
                  color: Colors.white,
                  size: SizeConfig.safeBlockHorizontal! * 8,
                ),
                onPressed: () {
                  if (_prayerType == PrayerType.Answered) {
                    _prayerType = PrayerType.Group;
                  } else {
                    _prayerType = PrayerType.Answered;
                  }
                },
              ),
            ),
          ],
        ),
        body: Column(
          children: [
            Container(
              height: SizeConfig.screenHeight! * .81,
              child: Stack(
                children: [
                  GroupPrayerList(
                    groupId: groupId,
                    groupName: groupName,
                    prayerType: _prayerType,
                  )
                ],
              ),
            ),
          ],
        ));
  }
}
