import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prayer_pals/core/utils/size_config.dart';
import 'package:prayer_pals/core/utils/constants.dart';
import 'my_prayer_list.dart';

class MyPrayersPage extends StatefulWidget {
  const MyPrayersPage({
    Key? key,
  }) : super(key: key);

  @override
  _MyPrayersPageState createState() => _MyPrayersPageState();
}

class _MyPrayersPageState extends State<MyPrayersPage> {
  PrayerType _prayerType = PrayerType.myPrayers;

  @override
  Widget build(BuildContext context) {
    String _title;
    if (_prayerType == PrayerType.answered) {
      _title = StringConstants.answeredPrayer;
    } else {
      _title = StringConstants.myPrayers;
    }
    SizeConfig().init(context);
    bool isPrayNow = false;
    return Scaffold(
      backgroundColor: Colors.lightBlue[50],
      appBar: AppBar(
        title: Text(
          _title,
        ),
        centerTitle: true,
        actions: [
          Visibility(
            visible: _prayerType == PrayerType.answered,
            replacement: IconButton(
              icon: Icon(
                Icons.comment_outlined,
                color: Colors.white,
                size: SizeConfig.safeBlockHorizontal! * 8,
              ),
              onPressed: () {
                if (_prayerType == PrayerType.answered) {
                  _prayerType = PrayerType.myPrayers;
                } else {
                  _prayerType = PrayerType.answered;
                }
                setState(() {});
              },
            ),
            child: IconButton(
              icon: Icon(
                CupertinoIcons.chat_bubble_2,
                color: Colors.white,
                size: SizeConfig.safeBlockHorizontal! * 8,
              ),
              onPressed: () {
                if (_prayerType == PrayerType.answered) {
                  _prayerType = PrayerType.myPrayers;
                } else {
                  _prayerType = PrayerType.answered;
                }
                setState(() {});
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
                PrayerList(isPrayNow: isPrayNow, prayerType: _prayerType)
              ],
            ),
          ),
        ],
      ),
    );
  }
}
