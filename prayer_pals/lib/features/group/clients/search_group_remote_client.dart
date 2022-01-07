import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';

final searchGroupClientProvider =
    Provider<SearchGroupClient>((ref) => SearchGroupClient());

class SearchGroupClient {
  Stream<QuerySnapshot<Map<String, dynamic>>> searchGroups(
      String searchParams) {
    return FirebaseFirestore.instance
        .collection('groups')
        .where("searchParamsList", arrayContains: searchParams)
        .where("creatorUID",
            isNotEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .snapshots();
  }
}
