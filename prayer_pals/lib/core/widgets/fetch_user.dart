import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:prayer_pals/features/user/models/ppcuser.dart';

class FetchUser extends StatefulWidget {
  FetchUser({Key? key}) : super(key: key);
  @override
  _FetchUserState createState() => _FetchUserState();
}

class _FetchUserState extends State<FetchUser> {
  Future<PPCUser> fetchUser() async {
    var data = await FirebaseFirestore.instance
        .collection("users")
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .get();
    PPCUser ppcUser = PPCUser(
        username: data['username'],
        emailAddress: data['emailAddress'],
        uid: data['uid'],
        dateJoined: data['memberSince'],
        daysPrayedWeek: data['daysPrayedWeek'],
        hoursPrayer: data['hoursPrayer'],
        daysPrayedMonth: data['daysPrayedMonth'],
        daysPrayedYear: data['daysPrayedYear'],
        daysPrayedLastYear: data['daysPrayedLastYear'],
        removedAds: data['removedAds'],
        supportLevel: data['supportLevel'],
        answered: data['answered'],
        prayers: data['prayers']);
    return ppcUser;
  }

  @override
  Widget build(BuildContext context) {
    throw UnimplementedError();
  }
}
