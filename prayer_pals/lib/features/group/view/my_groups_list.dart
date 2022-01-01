import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:prayer_pals/core/utils/size_config.dart';
import 'package:prayer_pals/core/widgets/avatar_widget.dart';
import 'package:prayer_pals/features/group/models/group.dart';
import 'package:prayer_pals/features/group/models/group_member.dart';
import 'package:prayer_pals/features/prayer/view/group_prayer_list_page.dart';
import 'package:prayer_pals/core/utils/constants.dart';
import 'group_description_page.dart';

//////////////////////////////////////////////////////////////////////////
//
//     Makes a list of all the groups user is in - this is a duplicate
//     collection from groups and is not efficient or good to have
//     duplicate data, but it is controlled through clients file so data
//     integrity is maintained.
//
//////////////////////////////////////////////////////////////////////////

class MyGroups extends StatelessWidget {
  const MyGroups({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    String _image = 'assets/images/group_icon.jpeg';

    final Stream<QuerySnapshot> myGroups = FirebaseFirestore.instance
        .collection(StringConstants.usersCollection)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(StringConstants.userGroupsCollection)
        .snapshots();

    return StreamBuilder<QuerySnapshot>(
        stream: myGroups,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {}
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: Text("Loading ..."),
            );
          } else {
            final data = snapshot.requireData;
            return Expanded(
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
                      Color _titleColor;
                      groupMember.isAdmin == true
                          ? _titleColor = Colors.lightBlue
                          : _titleColor = Colors.black;
                      return Visibility(
                          visible: !groupMember.isPending,
                          child: Card(
                              margin: const EdgeInsets.all(1),
                              child: ListTile(
                                leading: PPCAvatar(radSize: 15, image: _image),
                                trailing: IconButton(
                                  icon:
                                      const Icon(CupertinoIcons.chat_bubble_2),
                                  onPressed: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => GroupPrayersPage(
                                          groupId: groupMember.groupUID,
                                          groupName: groupMember.groupName,
                                        ),
                                      ),
                                    );
                                  },
                                ),
                                title: Text(
                                  groupMember.groupName,
                                  style: TextStyle(
                                    color: _titleColor,
                                  ),
                                ),
                                onTap: () async {
                                  await FirebaseFirestore.instance
                                      .collection(
                                          StringConstants.groupsCollection)
                                      .where(FieldPath.documentId,
                                          isEqualTo: groupMember.groupUID)
                                      .get()
                                      .then((event) {
                                    if (event.docs.isNotEmpty) {
                                      Map<String, dynamic> _group =
                                          event.docs.single.data();
                                      Group group = Group(
                                          groupUID: _group["groupUID"],
                                          groupName: _group["groupName"],
                                          description: _group["description"],
                                          creatorUID: _group["creatorUID"],
                                          isPrivate: _group["isPrivate"],
                                          tags: _group["tags"]);
                                      const bool isGuest = false;
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  GroupDescriptionPage(
                                                    groupMember: groupMember,
                                                    isGuest: isGuest,
                                                  ),
                                              settings: RouteSettings(
                                                  arguments: group)));
                                    }
                                  });
                                },
                              )));
                    }));
          }
        });
  }
}
