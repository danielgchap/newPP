// ignore_for_file: prefer_const_constructors, must_be_immutable
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer_pals/core/event_bus/group_subscribtion_event.dart';
import 'package:prayer_pals/core/event_bus/ppc_event_bus.dart';
import 'package:prayer_pals/core/utils/size_config.dart';
import 'package:prayer_pals/core/widgets/avatar_widget.dart';
import 'package:prayer_pals/core/widgets/edit_group_name_dialog.dart';
import 'package:prayer_pals/core/widgets/ppc_alert_dialog.dart';
import 'package:prayer_pals/core/widgets/rounded_button.dart';
import 'package:prayer_pals/core/widgets/update_profile_pic.dart';
import 'package:prayer_pals/features/group/models/group.dart';
import 'package:prayer_pals/core/utils/constants.dart';
import 'package:prayer_pals/features/group/providers/group_provider.dart';
import 'package:prayer_pals/features/group/providers/search_groups_provider.dart';
import 'package:prayer_pals/features/group/view/admin_edit.dart';
import 'package:prayer_pals/features/group/view/group_desription_nonedit.dart';
import 'admin_members_page.dart';

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

class GroupDescriptionPage extends HookConsumerWidget {
  final String groupUID;
  bool isSwitchedApp = true; //will come from user data
  bool isSwitchedText = true; //will come from user data
  bool isSwitchedEmail = true; //will come from user data
  Group? group;
  GroupController? groupProvider;

  GroupDescriptionPage({Key? key, required this.groupUID}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final groupProvider = ref.watch(groupControllerProvider);

//TODO:
    // isSwitchedApp = groupMember.appNotify;
    // isSwitchedText = groupMember.textNotify;
    // isSwitchedEmail = groupMember.emailNotify;

    return FutureBuilder(
      future: groupProvider.fetchGroup(groupUID),
      builder: (BuildContext context, snapshot) {
        if (snapshot.hasData) {
          group = snapshot.data as Group;
          final userIsAdmin =
              group!.creatorUID == FirebaseAuth.instance.currentUser!.uid;
          return Scaffold(
            appBar: AppBar(
              title: Text(group!.groupName),
              centerTitle: true,
              leading: IconButton(
                icon: Visibility(
                  visible: !groupProvider.isEdit,
                  child: Icon(Icons.arrow_back_ios_new_rounded,
                      color: Colors.white),
                  replacement: Icon(Icons.edit, color: Colors.white),
                ),
                onPressed: () {
                  if (groupProvider.isEdit == false) {
                    Navigator.of(context).pop();
                  } else {
                    showDialog(
                      context: context,
                      builder: (BuildContext context) =>
                          EditGroupNameDialog(groupName: group!.groupName),
                    );
                  }
                },
              ),
              actions: [
                Consumer(builder: (ctx, ref, widget) {
                  return IconButton(
                      icon: Visibility(
                        visible: groupProvider.isEdit,
                        child: Icon(CupertinoIcons.floppy_disk,
                            color: Colors.white),
                      ),
                      onPressed: () {
                        //TODO:
                        // _saveDescription(ctx);
                        // need to save the changes that are made to the Description
                        // would like a better way to edit the page. maybe the pencil
                        // should be next to the member and prayer counts rather than
                        // on the top.
                      });
                }),
                Visibility(
                  visible: userIsAdmin,
                  child: IconButton(
                    icon: Visibility(
                      visible: !groupProvider.isEdit,
                      child: const Icon(Icons.edit, color: Colors.white),
                      replacement: const Icon(Icons.clear, color: Colors.white),
                    ),
                    onPressed: () {
                      groupProvider.isEdit == true
                          ? groupProvider.setIsEdit(false)
                          : groupProvider.setIsEdit(true);
                    },
                  ),
                ),
              ],
            ),
            body: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Container(
                  padding: const EdgeInsets.fromLTRB(0, 15, 0, 15),
                  child: Row(children: [
                    Padding(
                      padding: const EdgeInsets.fromLTRB(40, 0, 0, 0),
                      child: Visibility(
                        visible: userIsAdmin,
                        child: InkWell(
                          child: PPCAvatar(
                            radSize: 25,
                            image: StringConstants.groupIcon,
                            networkImage: group!.groupImageURL,
                          ),
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (BuildContext context) => UpdatePicture(
                                context: context,
                                callback: (imageFile) async {
                                  await groupProvider.updateGroupImage(
                                      context, imageFile, group!);
                                  group =
                                      await groupProvider.fetchGroup(groupUID);
                                },
                              ),
                            );
                          },
                        ),
                        replacement: PPCAvatar(
                          radSize: 25,
                          image: StringConstants.groupIcon,
                          networkImage: group!.groupImageURL,
                        ),
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
                              visible: userIsAdmin,
                              child: InkWell(
                                  child: Text(StringConstants.members,
                                      style: TextStyle(
                                        color: userIsAdmin == true
                                            ? Colors.lightBlue
                                            : Colors.black,
                                        fontSize:
                                            SizeConfig.safeBlockVertical! * 2,
                                        height:
                                            SizeConfig.safeBlockVertical! * .2,
                                      )),
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const AdminMembersPage(),
                                            settings: RouteSettings(
                                                arguments: group)));
                                  }),
                              replacement: Text(StringConstants.members,
                                  style: TextStyle(
                                    color: userIsAdmin == true
                                        ? Colors.lightBlue
                                        : Colors.black,
                                    fontSize: SizeConfig.safeBlockVertical! * 2,
                                    height: SizeConfig.safeBlockVertical! * .2,
                                  )),
                            ),
                          ),
                          SizedBox(width: SizeConfig.safeBlockHorizontal! * 4),
                          Container(
                            width: SizeConfig.safeBlockHorizontal! * 20,
                            alignment: Alignment.centerLeft,
                            child: Text(group!.memberCount.toString(),
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
                            child: Text(group!.prayerCount.toString(),
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
                Spacer(),
                Padding(
                  padding: EdgeInsets.only(bottom: 20.0),
                  child: PPCRoundedButton(
                    title: StringConstants.joinGroup,
                    buttonRatio: .8,
                    buttonWidthRatio: .8,
                    callback: () {
                      _joinGroup(context, ref, group!);
                    },
                    bgColor: Colors.lightBlueAccent.shade100,
                    textColor: Colors.white,
                  ),
                ),

                //TODO:
                // Visibility(
                //   visible: groupProvider.isEdit,
                //   child: AdminEdit(
                //     groupName: group!.groupName,
                //     groupDescription: group!.description,
                //   ),
                //   replacement: GroupDescriptionNonEdit(
                //       groupName: group!.groupName,
                //       groupDescription: group!.description,
                //       groupMember: groupMember,
                //       isGuest: isGuest),
                // ),
              ],
            ),
          );
        } else {
          return Scaffold(
            body: const Center(
              child: Text(StringConstants.loading),
            ),
          );
        }
      },
    );
  }

  _joinGroup(BuildContext ctx, WidgetRef ref, Group group) async {
    String srvMsg =
        await ref.read(searchGroupControllerProvider).joinGroup(group);
    if (srvMsg == StringConstants.success) {
      PPCEventBus eventBus = PPCEventBus();
      eventBus.fire(SubscribeToGroupPNEvent(groupId: group.groupUID));
      Navigator.of(ctx).pop();
    } else {
      showPPCDialog(ctx, StringConstants.almostThere, srvMsg, null);
    }
  }
}
