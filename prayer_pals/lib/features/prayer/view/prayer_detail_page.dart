import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prayer_pals/core/utils/size_config.dart';
import 'package:prayer_pals/core/widgets/avatar_widget.dart';
import 'package:prayer_pals/core/widgets/rounded_button.dart';
import 'package:prayer_pals/features/prayer/models/prayer.dart';
import 'package:prayer_pals/core/utils/constants.dart';

//TODO fix scrolling

class PrayerDetailPage extends StatefulWidget {
  const PrayerDetailPage({Key? key}) : super(key: key);

  @override
  _PrayerDetailPageState createState() => _PrayerDetailPageState();
}

class _PrayerDetailPageState extends State<PrayerDetailPage> {
  @override
  Widget build(BuildContext context) {
    String _title;
    String _image = 'assets/images/user_icon.jpeg'; // Change to Firestore TODO
    final prayer = ModalRoute.of(context)!.settings.arguments as Prayer;
    prayer.isGlobal == true
        ? _title = StringConstants.prayerPals
        : _title = prayer.groups[0];
    bool isListed = false;
    var result = FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection("myPrayers")
        .where("uid", isEqualTo: prayer.uid)
        .get();

    // print("............................" + result.data().toString());

    result == null ? isListed = true : isListed = false;
    SizeConfig().init(context);

    return Scaffold(
        appBar: AppBar(
          leading: IconButton(
            icon: Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
            onPressed: () => Navigator.of(context).pop(),
          ),
          title: Text(
            _title,
          ),
          centerTitle: true,
        ),
        body: Column(children: [
          Container(
              height: SizeConfig.blockSizeVertical! * 68,
              child: SingleChildScrollView(
                  child: Padding(
                padding: EdgeInsets.all(
                  SizeConfig.safeBlockVertical! * 2,
                ),
                child: Column(
                  children: [
                    Row(
                      children: [
                        PPCAvatar(radSize: 30, image: _image),
                        SizedBox(
                          width: SizeConfig.safeBlockHorizontal! * 2,
                        ),
                        Container(
                          width: SizeConfig.screenWidth! * .7,
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                prayer.creatorDisplayName,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: SizeConfig.safeBlockVertical! * 2.5,
                                ),
                              ),
                              Text(
                                prayer.title,
                                overflow: TextOverflow.ellipsis,
                                style: TextStyle(
                                  fontSize: SizeConfig.safeBlockVertical! * 2.5,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical! * 2,
                    ),
                    Divider(
                      height: SizeConfig.safeBlockVertical! * 2,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: SizeConfig.safeBlockVertical! * 2,
                    ),
                    Container(
                      width: SizeConfig.screenWidth! * .9,
                      child: Text(
                        prayer.description,
                        textAlign: TextAlign.left,
                        style: TextStyle(
                            fontSize: SizeConfig.safeBlockVertical! * 2.5),
                      ),
                    ),
                  ],
                ),
              ))),
          _addRemoveButton(isListed),
          _reportButton(),
        ]));
  }

  Widget _addRemoveButton(isListed) {
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

  Widget _reportButton() {
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
