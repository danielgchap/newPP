import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer_pals/features/user/models/ppcuser.dart';

final ppcUserCoreProvider =
    Provider.autoDispose((ref) => PPCUserCore(ref.read));

class PPCUserCore {
  Reader reader;
  PPCUserCore(this.reader);

  static PPCUser? _currentUserModel;
//listener hooked to the collection. If my user changes, update my local model
  setupPPUserListener() async {
    if (FirebaseAuth.instance.currentUser != null) {
      final docRef = FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid);
      docRef.snapshots().listen(
        (event) {
          if (event.data() != null) {
            _currentUserModel = PPCUser.fromJson(event.data()!);
          }
        },
      );
    }
    if (_currentUserModel == null) {
      final docRef = await FirebaseFirestore.instance
          .collection('users')
          .doc(FirebaseAuth.instance.currentUser!.uid)
          .get();
      if (docRef.data() != null)
        _currentUserModel = PPCUser.fromJson(docRef.data()!);
    }
  }

  static PPCUser getCurrentUserModel() {
    return _currentUserModel!;
  }
}
