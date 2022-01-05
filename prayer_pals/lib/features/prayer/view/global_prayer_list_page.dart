import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prayer_pals/core/utils/size_config.dart';
import 'package:prayer_pals/core/utils/constants.dart';
import 'global_prayer_list.dart';

class GlobalPrayersPage extends StatefulWidget {
  const GlobalPrayersPage({
    Key? key,
  }) : super(key: key);

  @override
  _GlobalPrayersPageState createState() => _GlobalPrayersPageState();
}

class _GlobalPrayersPageState extends State<GlobalPrayersPage> {
  bool _showAnswered = true;
  String _previousType = "";
  String _listType = "";

  @override
  Widget build(BuildContext context) {
    String _title;
    _listType == _previousType ? _listType = "global" : debugPrint(_listType);
    if (_listType == "answered") {
      _title = StringConstants.answeredPrayer;
    } else {
      _title = "Prayer Pals";
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
              visible: _showAnswered,
              replacement: IconButton(
                icon: Icon(
                  CupertinoIcons.chat_bubble_2,
                  color: Colors.white,
                  size: SizeConfig.safeBlockHorizontal! * 8,
                ),
                onPressed: () {
                  if (_showAnswered == false) {
                    _showAnswered = true;
                    _listType = "global";
                    setState(() {});
                  } else {
                    _showAnswered = false;
                    _listType = _previousType;
                  }
                  setState(() {});
                },
              ),
              child: IconButton(
                icon: Icon(
                  Icons.comment_outlined,
                  color: Colors.white,
                  size: SizeConfig.safeBlockHorizontal! * 8,
                ),
                onPressed: () {
                  if (_showAnswered == true) {
                    _showAnswered = false;
                    _previousType = _listType;
                    _listType = "answered";
                    setState(() {});
                  } else {
                    _showAnswered = true;
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
                children: const [GlobalPrayerList(PrayerType.global)],
              ),
            ),
          ],
        ));
  }
}
