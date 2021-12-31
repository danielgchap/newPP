import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:prayer_pals/core/event_bus/group_subscribtion_event.dart';
import 'package:prayer_pals/core/event_bus/ppc_event_bus.dart';
import 'package:prayer_pals/core/utils/providers.dart';
import 'package:prayer_pals/core/utils/size_config.dart';
import 'package:prayer_pals/core/widgets/avatar_widget.dart';
import 'package:prayer_pals/core/widgets/ppc_alert_dialog.dart';
import 'package:prayer_pals/core/widgets/rounded_button.dart';
import 'package:prayer_pals/features/group/models/group.dart';
import 'package:prayer_pals/features/group/models/group_member.dart';
import 'package:prayer_pals/features/group/providers/group_member_provider.dart';
import 'package:prayer_pals/core/utils/constants.dart';
import 'group_description_page.dart';

//////////////////////////////////////////////////////////////////////////
//
//     Returns the list of the search results on the search page. Still needs
//      to have sorting setup. when user joins the group, they will be added
//     to groups -> members collection with isPending = true and will have the
//     group name added to their isPending list. When the user clicks on the
//     group tile, they will see the group description page as guest, which
//     filters out some of the views.
//
//////////////////////////////////////////////////////////////////////////

// TODO - verify user is not in group - should not show up, but if it does and user
// hits join group button, they are removed from the group and placed in pending

class PPCSearchGroupsWidget extends StatefulWidget {
  final String result;

  const PPCSearchGroupsWidget({
    Key? key,
    required this.result,
  }) : super(key: key);

  @override
  _PPCSearchGroupsWidgetState createState() => _PPCSearchGroupsWidgetState();
}

class _PPCSearchGroupsWidgetState extends State<PPCSearchGroupsWidget> {
  //List<Group> _groupList = [];
  //List<Group> _filteredList = [];
  //Need to figure out how to show only groups based on keywords and not groups
  //the user is already in. should only show new groups.

  @override
  Widget build(BuildContext context) {
    String _image = 'assets/images/group_icon.jpeg'; // need firestore image

    final Stream<QuerySnapshot> pendingGroups = FirebaseFirestore.instance
        .collection(StringConstants.groupsCollection)
        .snapshots();
    return StreamBuilder<QuerySnapshot>(
        stream: pendingGroups,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {}
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Text("Loading ..."),
            );
          } else {
            final data = snapshot.requireData;
            return Container(
                height: SizeConfig.screenHeight! * .72,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ListView.builder(
                    itemCount: data.size,
                    itemBuilder: (context, index) {
                      Group group = Group(
                          groupUID: data.docs[index]['groupUID'],
                          groupName: data.docs[index]['groupName'],
                          description: data.docs[index]['description'],
                          creatorUID: data.docs[index]['creatorUID'],
                          isPrivate: data.docs[index]['isPrivate'],
                          tags: data.docs[index]['tags']);
                      return Card(
                          margin: const EdgeInsets.all(1),
                          child: ListTile(
                            leading: PPCAvatar(radSize: 15, image: _image),
                            trailing: Consumer(builder: (ctx, ref, widget) {
                              return PPCRoundedButton(
                                textColor: Colors.white,
                                bgColor: Colors.lightBlueAccent,
                                buttonRatio: .4,
                                buttonWidthRatio: .15,
                                title: StringConstants.join,
                                callback: () {
                                  _joinGroup(ctx, group);
                                },
                              );
                            }),
                            onTap: () {
                              GroupMember groupMember = GroupMember(
                                  groupMemberUID: 'groupMemberUID',
                                  groupMemberName: 'Guest',
                                  groupName: group.groupName,
                                  groupUID: group.groupUID,
                                  isAdmin: false,
                                  isOwner: false,
                                  isCreated: false,
                                  isInvited: false,
                                  emailAddress: 'emailAddress',
                                  phoneNumber: 'phoneNumber',
                                  appNotify: false,
                                  textNotify: false,
                                  emailNotify: false,
                                  isPending: false);
                              const bool _isGuest = true;
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          GroupDescriptionPage(
                                              groupMember: groupMember,
                                              isGuest: _isGuest),
                                      settings: RouteSettings(
                                        arguments: group,
                                      )));
                              setState(() {});
                            },
                            title: Text(group.groupName),
                          ));
                    }));
          }
        });
  }
}

_joinGroup(BuildContext ctx, Group group) async {
  final groupMemberUID = ctx.read(firebaseAuthProvider).currentUser!.uid;
  final groupMemberName =
      ctx.read(firebaseAuthProvider).currentUser!.displayName;
  final groupUID = group.groupUID;
  final emailAddress = ctx.read(firebaseAuthProvider).currentUser!.email;
  const phoneNumber = "";
  final srvMsg = await ctx
      .read(groupMemberControllerProvider)
      .createGroupMember(
          groupMemberUID,
          groupMemberName!,
          group.groupName,
          groupUID,
          false,
          false,
          false,
          false,
          emailAddress!,
          phoneNumber,
          true,
          false,
          false,
          true);
  if (srvMsg == StringConstants.success) {
    PPCEventBus eventBus = PPCEventBus();
    eventBus.fire(SubscribeToGroupPNEvent(groupId: groupUID));
    Navigator.of(ctx).pop();
  } else {
    showPPCDialog(ctx, StringConstants.almostThere, srvMsg, null);
  }
}
