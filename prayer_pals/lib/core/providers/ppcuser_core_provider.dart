import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer_pals/features/user/models/ppcuser.dart';

final ppcUserCoreProvider =
    ChangeNotifierProvider.autoDispose<PPCUserCore>((ref) => PPCUserCore(ref.read));

class PPCUserCore extends ChangeNotifier {
  Reader reader;
  PPCUserCore(this.reader);
  PPCUser? currentUserModel;
  setupPPUserListener() async {
    if (FirebaseAuth.instance.currentUser != null) {
      final docRef = FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid);
      docRef.snapshots().listen(
        (event) {
          if (event.data() != null) {
            currentUserModel = PPCUser.fromJson(event.data()!);
            Timer.run(() {
              notifyListeners();
            });
          }
        },
      );
    }
  }

  Future<PPCUser> currentUserNetworkFetch() async {
    final docRef = await FirebaseFirestore.instance
        .collection('users')
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    return PPCUser.fromJson(docRef.data()!);
  }

  PPCUser? getCurrentUserModel() {
    if (currentUserModel == null) {
      setupPPUserListener();
    }
    return currentUserModel;
  }
}
