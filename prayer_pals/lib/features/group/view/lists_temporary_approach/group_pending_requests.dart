import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:prayer_pals/core/utils/size_config.dart';
import 'package:prayer_pals/core/widgets/avatar_widget.dart';
import 'package:prayer_pals/features/group/models/group.dart';
import 'package:prayer_pals/features/group/models/group_member.dart';
import 'package:prayer_pals/core/utils/constants.dart';

//////////////////////////////////////////////////////////////////////////
//
//     Builds a list of pending requests for group admin in members section
//     Might be able to find a way to list this differently using client
//
//////////////////////////////////////////////////////////////////////////

class GroupPendingRequests extends StatefulWidget {
  final Group group;

  const GroupPendingRequests({Key? key, required this.group}) : super(key: key);

  @override
  State<GroupPendingRequests> createState() => _GroupPendingRequestsState();
}

class _GroupPendingRequestsState extends State<GroupPendingRequests> {
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
                height: SizeConfig.screenHeight! * .17,
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
                      return Card(
                          margin: const EdgeInsets.all(1),
                          child: Visibility(
                            visible: groupMember.isPending,
                            child: ListTile(
                              leading: PPCAvatar(
                                  radSize: 15,
                                  image: StringConstants.groupIcon),
                              trailing: SizedBox(
                                width: 96,
                                child: Row(children: [
                                  IconButton(
                                    icon: const Icon(Icons.check),
                                    color: Colors.green,
                                    onPressed: () {
                                      // _updateGroups(
                                      //     context, groupMember, widget.group);
                                    },
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.close),
                                    color: Colors.red,
                                    onPressed: () async {
                                      try {
                                        await FirebaseFirestore.instance
                                            .collection(
                                                StringConstants.usersCollection)
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
                                ]),
                              ),
                              title: Text(data.docs[index]['groupMemberName']),
                            ),
                          ));
                    }));
          }
        });
  }

  // _updateGroups(BuildContext ctx, groupMember, group) async {
  //   final srvMsg =
  //       await ctx.read(groupMemberControllerProvider).createGroupMember(
  //             groupMember.groupMemberUID,
  //             groupMember.groupMemberName!,
  //             groupMember.groupName,
  //             groupMember.groupUID,
  //             false,
  //             false,
  //             false,
  //             false,
  //             groupMember.emailAddress!,
  //             groupMember.phoneNumber,
  //             true,
  //             false,
  //             false,
  //             false,
  //             "",
  //           );
  //   if (srvMsg == StringConstants.success) {
  //   } else {
  //     showPPCDialog(ctx, StringConstants.almostThere, srvMsg, null);
  //   }
  // }
}
