import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer_pals/core/utils/size_config.dart';
import 'package:prayer_pals/core/utils/constants.dart';
import 'package:prayer_pals/features/prayer/providers/global_prayer_provider.dart';
import 'global_prayer_list.dart';

class GlobalPrayersPage extends HookWidget {
  const GlobalPrayersPage({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final globalPrayerListController =
        useProvider(globalPrayerControllerProvider);
    String _title;
    globalPrayerListController.listType ==
            globalPrayerListController.previousType
        ? globalPrayerListController.setListType(StringConstants.global)
        : debugPrint(globalPrayerListController.listType);
    if (globalPrayerListController.listType ==
        StringConstants.lowercaseAnswered) {
      _title = StringConstants.answeredPrayer;
    } else {
      _title = StringConstants.prayerPals;
    }
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      appBar: AppBar(
        title: Text(
          _title,
        ),
        centerTitle: true,
        actions: [
          Visibility(
            visible: globalPrayerListController.showAnswered,
            replacement: IconButton(
              icon: Icon(
                CupertinoIcons.chat_bubble_2,
                color: Colors.white,
                size: SizeConfig.safeBlockHorizontal! * 8,
              ),
              onPressed: () {
                if (globalPrayerListController.showAnswered == false) {
                  globalPrayerListController.setShowAnswered(true);
                  globalPrayerListController
                      .setListType(StringConstants.global);
                } else {
                  globalPrayerListController.setShowAnswered(false);
                  globalPrayerListController
                      .setListType(globalPrayerListController.previousType);
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
                if (globalPrayerListController.showAnswered == true) {
                  globalPrayerListController.setShowAnswered(false);
                  globalPrayerListController
                      .setPreviousType(globalPrayerListController.listType);
                  globalPrayerListController
                      .setListType(StringConstants.lowercaseAnswered);
                } else {
                  globalPrayerListController.setShowAnswered(true);
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
              children: const [GlobalPrayerList(PrayerType.global)],
            ),
          ),
        ],
      ),
    );
  }
}
