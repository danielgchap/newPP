import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prayer_pals/core/utils/constants.dart';
import 'package:prayer_pals/core/utils/size_config.dart';
import 'package:prayer_pals/core/widgets/avatar_widget.dart';
import 'package:prayer_pals/core/widgets/ppc_alert_dialog.dart';
import 'package:prayer_pals/features/group/models/group.dart';
import 'package:prayer_pals/features/group/models/group_member.dart';
import 'package:prayer_pals/features/group/providers/group_member_provider.dart';
import '../create_group_member.dart';

//////////////////////////////////////////////////////////////////////////
//
//     Builds a list of group members for group admin in members section
//     Might be able to find a way to list this differently using client
//
//////////////////////////////////////////////////////////////////////////

class GroupMembers extends StatefulWidget {
  final Group group;

  const GroupMembers({Key? key, required this.group}) : super(key: key);

  @override
  State<GroupMembers> createState() => _GroupMembersState();
}

class _GroupMembersState extends State<GroupMembers> {
  @override
  Widget build(BuildContext context) {
    final Stream<QuerySnapshot> pendingMembers = FirebaseFirestore.instance
        .collection(StringConstants.groupsCollection)
        .doc(widget.group.groupUID)
        .collection(StringConstants.groupMemberCollection)
        .snapshots();

    return StreamBuilder<QuerySnapshot>(
        stream: pendingMembers,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {}
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Text("Loading ..."),
            );
          } else {
            final data = snapshot.requireData;
            return Container(
                height: SizeConfig.screenHeight! * .4,
                padding: const EdgeInsets.fromLTRB(10, 0, 10, 0),
                child: ListView.builder(
                    itemCount: data.size,
                    itemBuilder: (context, index) {
                      GroupMember groupMember = GroupMember(
                        groupMemberUID: data.docs[index]['groupMemberUID'],
                        groupMemberName: data.docs[index]['groupMemberName'],
                        groupName: data.docs[index]['groupName'],
                        groupUID: data.docs[index]['groupUID'],
                        isAdmin: data.docs[index]['isAdmin'],
                        isOwner: data.docs[index]['isOwner'],
                        isCreated: data.docs[index]['isCreated'],
                        isInvited: data.docs[index]['isInvited'],
                        emailAddress: data.docs[index]['emailAddress'],
                        phoneNumber: data.docs[index]['phoneNumber'],
                        appNotify: data.docs[index]['appNotify'],
                        textNotify: data.docs[index]['textNotify'],
                        emailNotify: data.docs[index]['emailNotify'],
                        isPending: data.docs[index]['isPending'],
                      );
                      MaterialColor _color;
                      groupMember.isAdmin == true
                          ? _color = Colors.lightBlue
                          : _color = Colors.grey;
                      return Card(
                          margin: const EdgeInsets.all(1),
                          child: Visibility(
                              visible: !groupMember.isPending,
                              child: ListTile(
                                trailing: SizedBox(
                                  width: 48,
                                  child: Row(children: [
                                    Visibility(
                                      visible: !groupMember.isAdmin,
                                      child: IconButton(
                                        icon: const Icon(CupertinoIcons.delete),
                                        color: Colors.red,
                                        onPressed: () async {
                                          //TODO put some popups in to prevent accidents
                                          // Maybe remove trash can from bar and have options pop up if
                                          // user name tile is pressed
                                          try {
                                            await FirebaseFirestore.instance
                                                .collection(StringConstants
                                                    .usersCollection)
                                                .doc(groupMember.groupMemberUID)
                                                .collection(StringConstants
                                                    .userGroupsCollection)
                                                .doc(groupMember.groupUID)
                                                .delete();
                                            await FirebaseFirestore.instance
                                                .collection(StringConstants
                                                    .groupsCollection)
                                                .doc(groupMember.groupUID)
                                                .collection(StringConstants
                                                    .groupMemberCollection)
                                                .doc(groupMember.groupMemberUID)
                                                .delete();
                                            return setState(() {});
                                          } catch (e) {
                                            debugPrint(e.toString());
                                            return;
                                          }
                                        },
                                      ),
                                    ),
                                  ]),
                                ),
                                title: Row(children: [
                                  Visibility(
                                    visible: !groupMember.isCreated,
                                    replacement: IconButton(
                                      icon: const Icon(Icons.edit),
                                      onPressed: () {
                                        showDialog(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                CreateGroupMemberWidget(
                                                    group: widget.group));
                                        // Need to bring over text to edit, not start over
                                        //Currently, this will create a new person with a new uid
                                        //todo FIX
                                      },
                                    ),
                                    child: IconButton(
                                      icon: const Icon(Icons.badge_outlined),
                                      color: _color,
                                      onPressed: () {
                                        if (groupMember.isOwner == true) {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  _preventZeroAdmin(
                                                      context, groupMember));
                                        } else {
                                          showDialog(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  _assignAdmin(
                                                      context, groupMember));
                                        }
                                      },
                                    ),
                                  ),
                                  const SizedBox(width: 10),
                                  PPCAvatar(
                                    radSize: 15,
                                    image: StringConstants.groupIcon,
                                  ),
                                  const SizedBox(width: 10),
                                  Text(
                                    data.docs[index]['groupMemberName'],
                                    overflow: TextOverflow.ellipsis,
                                  )
                                ]),
                              )));
                    }));
          }
        });
  }

  _preventZeroAdmin(context, groupMember) {
    return AlertDialog(
      title: const Text(StringConstants.ownerMessage),
      actions: <Widget>[
        ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          child: const Text(StringConstants.okCaps),
        ),
      ],
    );
  }
}

_assignAdmin(context, groupMember) {
  String _title;
  bool? _isAdmin;
  groupMember.isAdmin == true
      ? _title = StringConstants.removeAdmin
      : _title = StringConstants.assignAdmin;
  return AlertDialog(
    title: Text(_title),
    actions: <Widget>[
      ElevatedButton(
        onPressed: () {
          groupMember.isAdmin == true ? _isAdmin = false : _isAdmin = true;
          _updateMember(context, groupMember, _isAdmin);
        },
        child: Text(_title),
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

_updateMember(BuildContext ctx, groupMember, _isAdmin) async {
  final srvMsg = await ctx
      .read(groupMemberControllerProvider)
      .createGroupMember(
          groupMember.groupMemberUID,
          groupMember.groupMemberName,
          groupMember.groupName,
          groupMember.groupUID,
          _isAdmin,
          groupMember.isOwner,
          groupMember.isCreated,
          groupMember.isInvited,
          groupMember.emailAddress,
          groupMember.phoneNumber,
          groupMember.appNotify,
          groupMember.textNotify,
          groupMember.emailNotify,
          groupMember.isPending);
  if (srvMsg == StringConstants.success) {
    Navigator.of(ctx).pop();
  } else {
    showPPCDialog(ctx, StringConstants.almostThere, srvMsg, null);
  }
}
