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
  final bool _backButton = true;
  Group? group;

  GroupPrayersPage({
    Key? key,
    required this.groupId,
    required this.groupName,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    PrayerType _prayerType = PrayerType.group;
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      appBar: AppBar(
        title: Text(
          groupName,
        ),
        leading: Visibility(
          visible: _backButton,
          child: IconButton(
            icon: const Icon(Icons.arrow_back_ios_new_rounded,
                color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
        ),
        centerTitle: true,
        actions: [
          Visibility(
            visible: _prayerType == PrayerType.answered,
            replacement: IconButton(
              icon: Icon(
                CupertinoIcons.chat_bubble_2,
                color: Colors.white,
                size: SizeConfig.safeBlockHorizontal! * 8,
              ),
              onPressed: () {
                if (_prayerType == PrayerType.answered) {
                  _prayerType = PrayerType.group;
                } else {
                  _prayerType = PrayerType.answered;
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
                if (_prayerType == PrayerType.answered) {
                  _prayerType = PrayerType.group;
                } else {
                  _prayerType = PrayerType.answered;
                }
              },
            ),
          ),
        ],
      ),
      body: Column(
        children: [
          Expanded(
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
      ),
    );
  }
}
