import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer_pals/features/user/models/ppcuser.dart';

final ppcUserCoreProvider =
    ChangeNotifierProvider.autoDispose((ref) => PPCUserCore(ref.read));

class PPCUserCore extends ChangeNotifier {
  Reader reader;
  PPCUserCore(this.reader);
  String image = 'assets/images/user_icon.jpeg';

  static PPCUser? _currentUserModel;
  setupPPUserListener() async {
    if (FirebaseAuth.instance.currentUser != null) {
      final docRef = FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid);
      docRef.snapshots().listen(
        (event) {
          if (event.data() != null) {
            _currentUserModel = PPCUser.fromJson(event.data()!);
            notifyListeners();
          }
        },
      );
    }
  }

  PPCUser? getCurrentUserModel() {
    return _currentUserModel;
  }
}
