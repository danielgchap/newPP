// ignore_for_file: prefer_const_constructors

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer_pals/core/utils/size_config.dart';
import 'package:prayer_pals/core/widgets/avatar_widget.dart';
import 'package:prayer_pals/core/widgets/update_profile_pic.dart';
import 'package:prayer_pals/features/group/models/group.dart';
import 'package:prayer_pals/features/group/models/group_member.dart';
import 'package:prayer_pals/core/utils/constants.dart';
import 'package:prayer_pals/features/group/providers/group_provider.dart';
import 'admin_edit.dart';
import 'admin_members_page.dart';
import 'group_desription_nonedit.dart';

//////////////////////////////////////////////////////////////////////////
//
//     This controls what the user sees on the grouo description page when
//     is Admin = true. It allows them to see the edit pencil and the label
//     on the button changes depending on admin or member status. I am not 100%
//     happy with the functionality of the pencil and editing. I would like it
//     to be smoother and more intuative. I colored the word members if you
//     are admin becuase you tap on "members" to get to the admin members
//     section. Need to think about a better way of doing this.
//
//////////////////////////////////////////////////////////////////////////

class GroupDescriptionPage extends StatefulHookWidget {
  final GroupMember groupMember;
  final bool isGuest;

  const GroupDescriptionPage(
      {Key? key, required this.groupMember, required this.isGuest})
      : super(key: key);

  @override
  _GroupDescriptionPageState createState() => _GroupDescriptionPageState();
}

class _GroupDescriptionPageState extends State<GroupDescriptionPage> {
  bool isSwitchedApp = true; //will come from user data
  bool isSwitchedText = true; //will come from user data
  bool isSwitchedEmail = true; //will come from user data

  final int _memberCount = 50; //will come from group data
  final int _prayerCount = 25; //will come from group data

  bool isEdit = false;

  @override
  Widget build(BuildContext context) {
    String _image = 'assets/images/group_icon.jpeg'; // Change to Firestore TODO
    final group = ModalRoute.of(context)!.settings.arguments as Group;
    final _groupName = group.groupName;
    final _groupDescription = group.description;
    final groupProvider = useProvider(groupControllerProvider);

    isSwitchedApp = widget.groupMember.appNotify;
    isSwitchedText = widget.groupMember.textNotify;
    isSwitchedEmail = widget.groupMember.emailNotify;

    SizeConfig().init(context);
    return Scaffold(
      appBar: AppBar(
        title: Text(_groupName),
        centerTitle: true,
        leading: IconButton(
            icon: Visibility(
              visible: !isEdit,
              child:
                  Icon(Icons.arrow_back_ios_new_rounded, color: Colors.white),
              replacement: Icon(Icons.edit, color: Colors.white),
            ),
            onPressed: () {
              if (isEdit == false) {
                Navigator.of(context).pop();
              } else {
                showDialog(
                    context: context,
                    builder: (BuildContext context) =>
                        _editName(context, _groupName));
              }
            }),
        actions: [
          Consumer(builder: (ctx, ref, widget) {
            return IconButton(
                icon: Visibility(
                  visible: isEdit,
                  child: Icon(CupertinoIcons.floppy_disk, color: Colors.white),
                ),
                onPressed: () {
                  _saveDescription(ctx);
                  // need to save the changes that are made to the Description
                  // would like a better way to edit the page. maybe the pencil
                  // should be next to the member and prayer counts rather than
                  // on the top.
                });
          }),
          Visibility(
            visible: widget.groupMember.isAdmin,
            child: IconButton(
              icon: Visibility(
                visible: !isEdit,
                child: const Icon(Icons.edit, color: Colors.white),
                replacement: const Icon(Icons.clear, color: Colors.white),
              ),
              onPressed: () {
                isEdit == true ? isEdit = false : isEdit = true;
                setState(() {});
              },
            ),
          ),
        ],
      ),
      body: _layoutSection(
          _groupName, _groupDescription, group, _image, groupProvider),
    );
  }

  Widget _layoutSection(_groupName, _groupDescription, Group group, _image,
      GroupController groupProvider) {
    Color _color;
    widget.groupMember.isAdmin == true
        ? _color = Colors.lightBlue
        : _color = Colors.black;
    return SingleChildScrollView(
        child: Column(mainAxisAlignment: MainAxisAlignment.start, children: [
      Container(
        padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
        child: Row(children: [
          Padding(
            padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
            child: Visibility(
              visible: widget.groupMember.isAdmin,
              child: InkWell(
                child: PPCAvatar(radSize: 25, image: _image),
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (BuildContext context) => UpdatePicture(
                            context: context,
                            callback: (imageFile) {
                              groupProvider.updateGroupImage(
                                  context, imageFile, group.groupUID);
                            },
                          ));
                },
              ),
              replacement: PPCAvatar(radSize: 25, image: _image),
            ),
          ),
          SizedBox(
            width: SizeConfig.safeBlockHorizontal! * 15,
          ),
          Column(
            children: [
              Row(children: [
                Container(
                  width: SizeConfig.safeBlockHorizontal! * 20,
                  alignment: Alignment.centerRight,
                  child: Visibility(
                    visible: widget.groupMember.isAdmin,
                    child: InkWell(
                        child: Text(StringConstants.members,
                            style: TextStyle(
                              color: _color,
                              fontSize: SizeConfig.safeBlockVertical! * 2,
                              height: SizeConfig.safeBlockVertical! * .2,
                            )),
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const AdminMembersPage(),
                                  settings: RouteSettings(arguments: group)));
                        }),
                    replacement: Text(StringConstants.members,
                        style: TextStyle(
                          color: _color,
                          fontSize: SizeConfig.safeBlockVertical! * 2,
                          height: SizeConfig.safeBlockVertical! * .2,
                        )),
                  ),
                ),
                SizedBox(width: SizeConfig.safeBlockHorizontal! * 4),
                Container(
                  width: SizeConfig.safeBlockHorizontal! * 20,
                  alignment: Alignment.centerLeft,
                  child: Text(_memberCount.toString(),
                      style: TextStyle(
                        fontSize: SizeConfig.safeBlockVertical! * 2,
                        height: SizeConfig.safeBlockVertical! * .2,
                      )),
                ),
              ]),
              Row(children: [
                Container(
                  width: SizeConfig.safeBlockHorizontal! * 20,
                  alignment: Alignment.centerRight,
                  child: Text(StringConstants.prayers,
                      style: TextStyle(
                        fontSize: SizeConfig.safeBlockVertical! * 2,
                        height: SizeConfig.safeBlockVertical! * .2,
                      )),
                ),
                SizedBox(width: SizeConfig.safeBlockHorizontal! * 4),
                Container(
                  width: SizeConfig.safeBlockHorizontal! * 20,
                  alignment: Alignment.centerLeft,
                  child: Text(_prayerCount.toString(),
                      style: TextStyle(
                        fontSize: SizeConfig.safeBlockVertical! * 2,
                        height: SizeConfig.safeBlockVertical! * .2,
                      )),
                ),
              ]),
            ],
          ),
          SizedBox(width: SizeConfig.safeBlockHorizontal! * 15)
        ]),
      ),
      PPCstuff.divider,
      Visibility(
        visible: isEdit,
        child: AdminEdit(
          groupName: _groupName,
          groupDescription: _groupDescription,
        ),
        replacement: GroupDescriptionNonEdit(
            groupName: _groupName,
            groupDescription: _groupDescription,
            groupMember: widget.groupMember,
            isGuest: widget.isGuest),
      ),
    ]));
  }

  Widget _editName(BuildContext context, _groupName) {
    return AlertDialog(
      title: const Text(
        StringConstants.editGroupName,
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          TextField(
            style: const TextStyle(
              fontFamily: 'Helvetica',
            ),
            textInputAction: TextInputAction.done,
            cursorColor: Colors.blue,
            decoration: InputDecoration(
              hintText: _groupName,
              hintStyle: const TextStyle(
                color: Colors.grey,
              ),
            ),
          )
        ],
      ),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop(); // Need to update variable TODO
          },
          child: const Text(StringConstants.save),
        ),
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(StringConstants.cancel),
        ),
      ],
    );
  }

  _saveDescription(BuildContext ctx) async {
    // final userUID = ctx.read(firebaseAuthProvider).currentUser!.uid;
    // final srvMsg = await ctx.read(prayerControllerProvider).createPrayer(
    //     _titleController.text,
    //     _detailsController.text,
    //     userUID,
    //     [],
    //     _shareGlobal);
    //if (srvMsg == StringConstants.success) {
    //  ctx.read(homeControllerProvider).setIndex(1);
    //} else {
    //  showPPCDialog(context, StringConstants.almostThere, srvMsg, null);
    // }
  }
}
