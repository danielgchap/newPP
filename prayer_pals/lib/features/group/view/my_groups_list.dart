import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer_pals/core/widgets/avatar_widget.dart';
import 'package:prayer_pals/features/group/models/group.dart';
import 'package:prayer_pals/features/group/models/group_member.dart';
import 'package:prayer_pals/features/group/providers/group_provider.dart';
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

class MyGroups extends HookWidget {
  const MyGroups({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final groupProvider = useProvider(groupControllerProvider);
    return StreamBuilder<QuerySnapshot>(
      stream: groupProvider.fetchMyGroups(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {}
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(
            child: Text(StringConstants.loading),
          );
        } else {
          final data = snapshot.requireData;
          return Expanded(
            child: ListView.builder(
              itemCount: data.size,
              itemBuilder: (context, index) {
                GroupMember groupMember =
                    GroupMember.fromQuerySnapshot(data, index);
                Color _titleColor;
                groupMember.isAdmin == true
                    ? _titleColor = Colors.lightBlue
                    : _titleColor = Colors.black;
                return Visibility(
                  visible: !groupMember.isPending,
                  child: Card(
                    margin: const EdgeInsets.all(1),
                    child: ListTile(
                      leading: PPCAvatar(
                        radSize: 15,
                        image: StringConstants.groupIcon,
                        networkImage: groupMember.groupImageURL,
                      ),
                      trailing: IconButton(
                        icon: const Icon(CupertinoIcons.chat_bubble_2),
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
                            .collection(StringConstants.groupsCollection)
                            .where(FieldPath.documentId,
                                isEqualTo: groupMember.groupUID)
                            .get()
                            .then(
                          (event) {
                            if (event.docs.isNotEmpty) {
                              Map<String, dynamic> _group =
                                  event.docs.single.data();
                              Group group = Group(
                                groupUID: _group["groupUID"],
                                groupName: _group["groupName"],
                                description: _group["description"],
                                creatorUID: _group["creatorUID"],
                                isPrivate: _group["isPrivate"],
                                tags: _group["tags"],
                                prayerCount: _group['prayerCount'],
                                memberCount: _group['memberCount'],
                              );
                              const bool isGuest = false;
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => GroupDescriptionPage(
                                    groupMember: groupMember,
                                    isGuest: isGuest,
                                  ),
                                  settings: RouteSettings(arguments: group),
                                ),
                              );
                            }
                          },
                        );
                      },
                    ),
                  ),
                );
              },
            ),
          );
        }
      },
    );
  }
}
