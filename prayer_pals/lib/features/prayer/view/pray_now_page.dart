import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:prayer_pals/core/utils/size_config.dart';
import 'package:prayer_pals/core/utils/constants.dart';
import 'my_prayer_list.dart';

//TODO figure out how to get a value from firestore, add it to the variable,
// then save it back to firestore !!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!!

class PrayNowPage extends StatelessWidget {
  const PrayNowPage({
    Key? key,
  }) : super(key: key);

  Future<int> get currentHoursPrayer async {
    var data = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    int currentHours = data['hoursPrayer'];
    return currentHours;
  }

  @override
  Widget build(BuildContext context) {
    DateTime startTime = DateTime.now();
    bool isPrayNow = true;
    SizeConfig().init(context);
    return Scaffold(
        backgroundColor: Colors.lightBlue[50],
        appBar: AppBar(
          title: const Text(
            StringConstants.prayNow,
          ),
          leading: IconButton(
              icon: const Icon(Icons.arrow_back_ios_new_rounded,
                  color: Colors.white),
              onPressed: () {
                _updateTime(startTime);
                Navigator.of(context).pop();
              }),
          centerTitle: true,
        ),
        body:
            PrayerList(isPrayNow: isPrayNow, prayerType: PrayerType.myPrayers));
  }

  _updateTime(startTime) async {
    var difference = DateTime.now().difference(startTime);
    num currentHours = 9; // this is a plcaeholder until I can get real data
    var newHoursPrayer = difference.inSeconds + currentHours;
    await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .update({'hoursPrayer': newHoursPrayer});
  }
}
