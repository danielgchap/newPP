import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer_pals/core/utils/constants.dart';
import 'package:prayer_pals/features/group/models/group.dart';

//////////////////////////////////////////////////////////////////////////
//
//       Used for creating groups in the group collection
//       Not sure how to implment retrieve, update , or delete
//
//////////////////////////////////////////////////////////////////////////

final groupClientProvider = Provider<GroupClient>((ref) => GroupClient());

class GroupClient {
  Future<String> createGroup(Group group) async {
    try {
      await FirebaseFirestore.instance
          .collection(StringConstants.groupsCollection)
          .doc(group.groupUID)
          .set(group.toJson());

      return StringConstants.success;
    } on FirebaseException catch (e) {
      return Future.value(e.message.toString());
    }
  }

  Future<String> retrieveGroup(Group group) async {
    try {
      final snap = FirebaseFirestore.instance
          .collection(StringConstants.usersCollection)
          .doc(group.creatorUID)
          .collection(StringConstants.groupsCollection)
          .snapshots();
      return snap
          .every((element) => true)
          .toString(); // snap.docs.map((doc) => Group.fromDocument(doc)).toList();
      // not working - try to get this working instead of the list thing  TODO

    } on FirebaseException catch (e) {
      throw Future.value(e.message.toString());
    }
  }

  Future<String> updateGroup(Group group) async {
    try {
      await FirebaseFirestore.instance
          .collection(StringConstants.groupsCollection)
          .doc(group.groupUID)
          .update(group.toJson());

      return StringConstants.success;
    } on FirebaseException catch (e) {
      return Future.value(e.message.toString());
    }
  }

  Future<String> deleteGroup(Group group) async {
    try {
      await FirebaseFirestore.instance
          .collection(StringConstants.groupsCollection)
          .doc(group.groupUID)
          .delete();
      return StringConstants.success;
    } on FirebaseException catch (e) {
      return Future.value(e.message);
    }
  }
}
