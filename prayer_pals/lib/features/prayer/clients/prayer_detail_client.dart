import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer_pals/core/utils/constants.dart';
import 'package:prayer_pals/features/prayer/models/prayer.dart';

final prayerDetailClientProvider =
    Provider<PrayerDetailClient>((ref) => PrayerDetailClient());

class PrayerDetailClient {
  Future<Prayer> fetchPrayer(String uid, bool isGlobal) async {
    DocumentReference<Map<String, dynamic>> docRef;
    if (!isGlobal) {
      docRef = FirebaseFirestore.instance
          .collection(StringConstants.usersCollection)
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .collection(StringConstants.myPrayersCollection)
          .doc(uid);
    } else {
      docRef = FirebaseFirestore.instance
          .collection(StringConstants.globalPrayersCollection)
          .doc(uid);
    }
    final response = await docRef.get();
    return Prayer.fromJson(response.data()!);
  }
}
