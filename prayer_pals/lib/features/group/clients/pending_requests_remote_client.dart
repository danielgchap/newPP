import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer_pals/core/utils/constants.dart';

final pendingRequestsClientProvider =
    Provider<PendingRequestsClient>((ref) => PendingRequestsClient());

class PendingRequestsClient {
  Stream<QuerySnapshot<Map<String, dynamic>>> fetchMyPendingRequests() {
    return FirebaseFirestore.instance
        .collection(StringConstants.usersCollection)
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .collection(StringConstants.pendingRequestsCollection)
        .snapshots();
  }
}
