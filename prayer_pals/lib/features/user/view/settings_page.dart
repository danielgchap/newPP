// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer_pals/core/utils/credential_textfield.dart';
import 'package:prayer_pals/core/utils/size_config.dart';
import 'package:prayer_pals/core/widgets/user_info_bar.dart';
import 'package:prayer_pals/features/user/clients/auth_client.dart';
import 'package:prayer_pals/features/user/models/ppcuser.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:prayer_pals/core/utils/constants.dart';
import 'activity_page.dart';
import 'login_page.dart';

class SettingsPage extends ConsumerWidget {
  PPCUser? _ppcUser;

  SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    loadUser();
    //final _auth = watch(authStateProvider);
    bool isSwitched = true;
    final _auth = AuthClient(FirebaseAuth.instance);

    return Scaffold(
        appBar: AppBar(
          title: const Text(StringConstants.settings),
          centerTitle: true,
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const UserInfoBarWidget(isSettings: true),
            Expanded(
              child: SingleChildScrollView(
                child: Column(
                  children: [
                    _titleRow(StringConstants.settingsCaps),
                    Row(children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 0, 5),
                        child: InkWell(
                          child: const Text(
                            StringConstants.changePassword,
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (BuildContext context) =>
                                    _changePassword(context));
                          },
                        ),
                      ),
                    ]),

                    _clickableRow(StringConstants.setReminder, _setReminder),

                    Row(children: [
                      Padding(
                        padding: const EdgeInsets.fromLTRB(20, 10, 0, 5),
                        child: InkWell(
                          child: const Text(
                            StringConstants.viewActivity,
                            style: TextStyle(color: Colors.black, fontSize: 16),
                          ),
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        Activity(ppcUser: _ppcUser!)));
                            //settings: RouteSettings(arguments: ppcUser)));
                          },
                        ),
                      )
                    ]),
                    Row(children: [
                      const Padding(
                        padding: EdgeInsets.fromLTRB(20, 0, 0, 0),
                        child: Text(
                          StringConstants.notifications,
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 16,
                          ),
                        ),
                      ),
                      SizedBox(
                        width: SizeConfig.safeBlockHorizontal! * 55,
                      ),
                      Switch(
                        value: isSwitched,
                        onChanged: (value) {
                          //setState(() {
                          isSwitched = value;
                          _toggleNotifications();
                          //});
                        },
                        activeTrackColor: Colors.grey,
                        activeColor: Colors.lightBlueAccent,
                      ),
                    ]),
                    const SizedBox(height: 20),
                    _titleRow(StringConstants.supportCaps),
                    _clickableRow(StringConstants.aboutUs, _aboutUs),
                    _clickableRow(StringConstants.usersGuide, _usersGuide),
                    _clickableRow(
                        StringConstants.privacyPolicy, _privacyPolicy),
                    _clickableRow(StringConstants.terms, _termsOfService),
                    _clickableRow(
                        StringConstants.reportProblem, _reportAProblem),
                    _clickableRow(StringConstants.sendFeedback, _sendFeedback),
                    _clickableRow(StringConstants.removeAds, _removeAds),
                    //_clickableRow(StringConstants.logOutCaps, _logOut(_auth)),
                    Row(children: [
                      Padding(
                          padding: const EdgeInsets.fromLTRB(20, 10, 0, 15),
                          child: InkWell(
                            child: const Text(
                              StringConstants.logOutCaps,
                              style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.w600,
                                fontSize: 16,
                              ),
                            ),
                            onTap: () async {
                              await _auth.signOut();
                              Navigator.pushReplacementNamed(
                                  context, '/LoginPage');
                              LoginPage();
                            },
                          )),
                    ]),
                  ],
                ),
              ),
            ),
          ],
        ));
  }

  void loadUser() async {
    await FirebaseFirestore.instance
        .collection(StringConstants.usersCollection)
        .where(FieldPath.documentId,
            isEqualTo: FirebaseAuth.instance.currentUser!.uid)
        .get()
        .then((event) {
      if (event.docs.isNotEmpty) {
        Map<String, dynamic> _user = event.docs.single.data();
        _ppcUser = PPCUser(
          username: _user["username"],
          emailAddress: _user["emailAddress"],
          uid: _user["uid"],
          dateJoined: _user["dateJoined"],
          daysPrayedWeek: _user["daysPrayedWeek"],
          hoursPrayer: _user["hoursPrayer"],
          daysPrayedMonth: _user["daysPrayedMonth"],
          daysPrayedYear: _user["daysPrayedYear"],
          daysPrayedLastYear: _user["daysPrayedLastYear"],
          removedAds: _user["removedAds"],
          supportLevel: _user["supportLevel"],
          answered: _user["answered"] ?? 0,
          prayers: _user["prayers"] ?? 0,
        );
      }
    });
  }
}

Widget _titleRow(String titleText) {
  return Row(children: [
    Padding(
      padding: const EdgeInsets.fromLTRB(10, 0, 0, 10),
      child: Text(
        titleText,
        style: const TextStyle(
          fontWeight: FontWeight.w600,
          fontSize: 18,
        ),
      ),
    )
  ]);
}

Widget _clickableRow(String clickableText, Function() clickPath) {
  return Row(children: [
    Padding(
      padding: const EdgeInsets.fromLTRB(20, 10, 0, 5),
      child: InkWell(
          child: Text(
            clickableText,
            style: const TextStyle(color: Colors.black, fontSize: 16),
          ),
          onTap: (clickPath)),
    ),
  ]);
}

Widget _changePassword(BuildContext context) {
  final TextEditingController _oldPasswordController = TextEditingController();
  final TextEditingController _newPasswordController = TextEditingController();
  final TextEditingController _verifyPasswordController =
      TextEditingController();

  return AlertDialog(
    title: const Text(
      StringConstants.changePassword,
    ),
    content: SizedBox(
      height: 220,
      child: Column(
        children: [
          const SizedBox(height: 20),
          CredentialTextfield(
            controller: _oldPasswordController,
            hintText: 'Old Password',
            obscure: true,
          ),
          const SizedBox(height: 20),
          CredentialTextfield(
            controller: _newPasswordController,
            hintText: 'New Password',
            obscure: true,
          ),
          const SizedBox(height: 20),
          CredentialTextfield(
            controller: _verifyPasswordController,
            hintText: 'Verify New Password',
            obscure: true,
          ),
        ],
      ),
    ),
    actions: <Widget>[
      ElevatedButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        child: const Text(StringConstants.cancel),
      ),
      ElevatedButton(
        onPressed: () async {
          //_newPasswordController.text == _verifyPasswordController.text ?
          // TODO figure out logic to verify old and new passwords before updating
          try {
            await FirebaseAuth.instance.currentUser!
                .updatePassword(_verifyPasswordController.text);
            return Navigator.of(context).pop();
          } catch (e) {
            debugPrint(e.toString());
            return;
          }
        },
        child: const Text(StringConstants.changePassword),
      ),
    ],
  );
}

void _setReminder() {}

void _toggleNotifications() {}

void _aboutUs() async => await canLaunch(StringConstants.ppcHome)
    ? await launch(StringConstants.ppcHome)
    : throw 'Could not launch ' + StringConstants.ppcHome;

void _usersGuide() async => await canLaunch(StringConstants.ppcGuide)
    ? await launch(StringConstants.ppcGuide)
    : throw 'Could not launch ' + StringConstants.ppcGuide;

void _privacyPolicy() async => await canLaunch(StringConstants.ppcPolicy)
    ? await launch(StringConstants.ppcPolicy)
    : throw 'Could not launch ' + StringConstants.ppcPolicy;

void _termsOfService() async => await canLaunch(StringConstants.ppcTerms)
    ? await launch(StringConstants.ppcTerms)
    : throw 'Could not launch ' + StringConstants.ppcTerms;

void _reportAProblem() async {
  final Uri params = Uri(
    scheme: 'mailto',
    path: StringConstants.ppcSupport,
  );
  String url = params.toString();
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    debugPrint('Could not launch $url');
  }
}

void _sendFeedback() async {
  final Uri params = Uri(
    scheme: 'mailto',
    path: StringConstants.ppcInfo,
  );
  String url = params.toString();
  if (await canLaunch(url)) {
    await launch(url);
  } else {
    debugPrint('Could not launch $url');
  }
}

void _removeAds() {}
