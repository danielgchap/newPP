// ignore_for_file: must_be_immutable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer_pals/core/providers/reminder_provider.dart';
import 'package:prayer_pals/core/services/settings_service.dart';
import 'package:prayer_pals/core/utils/size_config.dart';
import 'package:prayer_pals/core/widgets/settings/change_password_dialog.dart';
import 'package:prayer_pals/core/widgets/settings/clickable_row.dart';
import 'package:prayer_pals/core/widgets/settings/reminder_row.dart';
import 'package:prayer_pals/core/widgets/settings/settings_title_row.dart';
import 'package:prayer_pals/core/widgets/user_info_bar.dart';
import 'package:prayer_pals/features/user/clients/auth_client.dart';
import 'package:prayer_pals/features/user/models/ppcuser.dart';
import 'package:prayer_pals/core/utils/constants.dart';
import 'package:prayer_pals/features/user/view/group_notifications_list.dart';
import 'activity_page.dart';
import 'login_page.dart';

class SettingsPage extends ConsumerWidget {
  PPCUser? _ppcUser;

  SettingsPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, ScopedReader watch) {
    loadUser();
    final settingsProvider = watch(reminderControllerProvider);
    bool isSwitched = true;
    final _auth = AuthClient(FirebaseAuth.instance);

    return Scaffold(
        appBar: AppBar(
          title: const Text(StringConstants.settings),
          centerTitle: true,
        ),
        body: Column(
          mainAxisSize: MainAxisSize.max,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            const UserInfoBarWidget(isSettings: true),
            SingleChildScrollView(
              child: Column(
                children: [
                  const SettingsTitleRow(title: StringConstants.settingsCaps),
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
                                ChangePasswordDialog(),
                          );
                        },
                      ),
                    ),
                  ]),
                  ReminderRow(
                      clickableText: settingsProvider.timeString != null &&
                              settingsProvider.timeString!.isNotEmpty &&
                              settingsProvider.timeString != "null"
                          ? '${StringConstants.cancelReminder} \n(Daily @ ${settingsProvider.timeString})'
                          : StringConstants.setReminder,
                      settingsProvider: settingsProvider),
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
                        SettingsService.toggleNotifications();
                        //});
                      },
                      activeTrackColor: Colors.grey,
                      activeColor: Colors.lightBlueAccent,
                    ),
                  ]),
                  // const GroupNotificationsList(),
                  const SizedBox(height: 20),
                  const SettingsTitleRow(title: StringConstants.supportCaps),
                  const ClickableRow(
                      clickableText: StringConstants.aboutUs,
                      clickPath: SettingsService.aboutUs),
                  const ClickableRow(
                      clickableText: StringConstants.usersGuide,
                      clickPath: SettingsService.usersGuide),
                  const ClickableRow(
                      clickableText: StringConstants.privacyPolicy,
                      clickPath: SettingsService.privacyPolicy),
                  const ClickableRow(
                      clickableText: StringConstants.terms,
                      clickPath: SettingsService.termsOfService),
                  const ClickableRow(
                      clickableText: StringConstants.reportProblem,
                      clickPath: SettingsService.reportAProblem),
                  const ClickableRow(
                      clickableText: StringConstants.sendFeedback,
                      clickPath: SettingsService.sendFeedback),
                  const ClickableRow(
                      clickableText: StringConstants.removeAds,
                      clickPath: SettingsService.removeAds),
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
          subscribedGroups: _user['subscribedGroups'],
        );
      }
    });
  }
}
