import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer_pals/core/utils/providers.dart';
import 'package:prayer_pals/features/user/models/ppcuser.dart';
import 'package:prayer_pals/core/utils/constants.dart';

final authClientProvider = Provider<AuthClient>((ref) {
  return AuthClient(ref.read(firebaseAuthProvider));
});

class AuthClient {
  final FirebaseAuth _firebaseAuth;
  AuthClient(this._firebaseAuth);

  Stream<User?> get authStateChange => _firebaseAuth.authStateChanges();

  Future<String> signIn(
      {required String email, required String password}) async {
    try {
      await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return StringConstants.success;
    } on FirebaseAuthException catch (e) {
      return e.message!;
    }
  }

  Future<String> signUp(
      {required String username,
      required String email,
      required String password}) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        _saveUserToCloudDB(
          username: username,
          emailAddress: email,
        );
        FirebaseAuth.instance.currentUser!.updateDisplayName(username);
        return StringConstants.success;
      } else {
        return StringConstants.genericError;
      }
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }

  _saveUserToCloudDB({
    required String username,
    required String emailAddress,
  }) {
    PPCUser user = PPCUser(
        username: username,
        emailAddress: emailAddress,
        uid: _firebaseAuth.currentUser!.uid,
        dateJoined: DateTime.now().month.toString() +
            "/" +
            DateTime.now().day.toString() +
            "/" +
            DateTime.now().year.toString(),
        hoursPrayer: 0,
        daysPrayedWeek: 0,
        daysPrayedMonth: 0,
        daysPrayedYear: 0,
        daysPrayedLastYear: 0,
        removedAds: false,
        supportLevel: 0,
        answered: 0,
        prayers: 0);
    FirebaseFirestore.instance
        .collection('users')
        .doc(_firebaseAuth.currentUser!.uid)
        .set(
          user.toJson(),
        );
  }

  Future<String> edit(
      {required String username,
      required String email,
      required String password}) async {
    try {
      final userCredential = await _firebaseAuth.createUserWithEmailAndPassword(
        email: email,
        password: password,
      );
      if (userCredential.user != null) {
        _editUserToCloudDB(
          username: username,
          emailAddress: email,
        );
        FirebaseAuth.instance.currentUser!.updateDisplayName(username);
        return StringConstants.success;
      } else {
        return StringConstants.genericError;
      }
    } on FirebaseAuthException catch (e) {
      return e.message.toString();
    }
  }

  _editUserToCloudDB({
    required String username,
    required String emailAddress,
  }) {
    PPCUser user = PPCUser(
        username: username,
        emailAddress: emailAddress,
        uid: _firebaseAuth.currentUser!.uid,
        dateJoined: DateTime.now().month.toString() +
            "/" +
            DateTime.now().day.toString() +
            "/" +
            DateTime.now().year.toString(),
        hoursPrayer: 0,
        daysPrayedWeek: 0,
        daysPrayedMonth: 0,
        daysPrayedYear: 0,
        daysPrayedLastYear: 0,
        removedAds: false,
        supportLevel: 0,
        answered: 0,
        prayers: 0);
    FirebaseFirestore.instance
        .collection('users')
        .doc(_firebaseAuth.currentUser!.uid)
        .update(
          user.toJson(),
        );
  }

  Future<void> signOut() async {
    await _firebaseAuth.signOut();
  }

  Future<String> forgotPassword({required String emailAddress}) {
    try {
      FirebaseAuth.instance.sendPasswordResetEmail(email: emailAddress);
      return Future.value(StringConstants.success);
    } on FirebaseAuthException catch (e) {
      return Future.value(e.message.toString());
    }
  }
}
