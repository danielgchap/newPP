import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:prayer_pals/core/utils/size_config.dart';
import 'package:prayer_pals/core/widgets/avatar_widget.dart';
import 'package:prayer_pals/core/widgets/ppc_logo_widget.dart';
import 'package:prayer_pals/features/prayer/models/prayer.dart';
import 'package:share_plus/share_plus.dart';
import 'package:prayer_pals/core/utils/constants.dart';
import 'create_prayer_page.dart';
import 'prayer_detail_page.dart';

class PrayerListItem extends StatelessWidget {
  final Prayer prayer;
  final VoidCallback? callback;

  const PrayerListItem({
    Key? key,
    required this.prayer,
    this.callback,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _image = 'assets/images/user_icon.jpeg'; // Change to Firestore TODO
    String? _uid = FirebaseAuth.instance.currentUser!.uid;
    bool _isOwner;
    _uid == prayer.creatorUID ? _isOwner = true : _isOwner = false;
    return InkWell(
        child: Card(
          clipBehavior: Clip.antiAlias,
          margin: EdgeInsets.only(
            top: SizeConfig.blockSizeVertical! * 1.5,
            left: SizeConfig.blockSizeHorizontal! * 2,
            right: SizeConfig.blockSizeHorizontal! * 2,
          ),
          child: Container(
            padding: const EdgeInsets.all(8.0),
            child: Column(
              children: [
                _headerRow(_image),
                _detailRow(),
                SizedBox(
                  height: SizeConfig.safeBlockVertical! * 1,
                ),
                _bottomRow(_isOwner, context)
              ],
            ),
          ),
        ),
        onTap: () {
          if (_isOwner == true) {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => CreatePrayerPage(prayer: prayer),
                ));
          } else {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const PrayerDetailPage(),
                    settings: RouteSettings(arguments: prayer)));
          }
        });
  }

  Widget _headerRow(_image) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              children: [
                PPCAvatar(radSize: 20, image: _image),
                SizedBox(
                  width: SizeConfig.safeBlockHorizontal! * 2,
                ),
                Container(
                  width: SizeConfig.safeBlockHorizontal! * 45,
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
                          height: SizeConfig.safeBlockVertical! * 0.2,
                          fontSize: SizeConfig.safeBlockVertical! * 2.2,
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(0, 0, 8, 8),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Text(
                    prayer.dateCreated,
                    style: TextStyle(
                      fontSize: SizeConfig.safeBlockVertical! * 2.2,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
        const Divider(),
      ],
    );
  }

  Widget _detailRow() {
    return Container(
      padding: EdgeInsets.all(0),
      width: SizeConfig.screenWidth,
      child: Text(prayer.description,
          textAlign: TextAlign.left,
          maxLines: 2,
          overflow: TextOverflow.ellipsis),
    );
  }

  Widget _bottomRow(_isOwner, context) {
    String _groupName;
    if (prayer.isGlobal == true) {
      _groupName = StringConstants.prayerPals;
    } else {
      if (_isOwner == true) {
        _groupName = StringConstants.myPrayer;
      } else {
        _groupName = prayer.groups[0];
        //Name of the first group from Firebase TODO
      }
    }
    return Row(
      //mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      //crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Container(
          padding: EdgeInsets.only(bottom: 5),
          width: SizeConfig.safeBlockHorizontal! * 52,
          child: Row(
            children: [
              Visibility(
                child: PPCLogoWidget(size: 2.5),
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
              visible: _isOwner,
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
                _onShare(context);
              }, //Share - should use phones sharing system just like sharing photo TODO
            ),
            IconButton(
              icon: Icon(
                CupertinoIcons.alarm,
                color: Colors.lightBlue,
                size: SizeConfig.safeBlockHorizontal! * 5,
              ),
              onPressed: () {
                //Set a prayer reminder notification TODO
              },
            ),
          ],
        ),
      ],
    );
  }

  void _onShare(BuildContext context) async {
    final box = context.findRenderObject() as RenderBox?;
//https://pub.dev/packages/share_plus/example
// TODO fix this later
    await Share.share(prayer.title,
        subject: prayer.description,
        sharePositionOrigin: box!.localToGlobal(Offset.zero) & box.size);
  }
}
