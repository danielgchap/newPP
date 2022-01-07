import 'package:flutter/material.dart';
import 'package:prayer_pals/core/utils/constants.dart';
import 'package:url_launcher/url_launcher.dart';

class SettingsService {
  static toggleNotifications() {}

  static aboutUs() async => await canLaunch(StringConstants.ppcHome)
      ? await launch(StringConstants.ppcHome)
      : throw StringConstants.couldNotLaunch + StringConstants.ppcHome;

  static usersGuide() async => await canLaunch(StringConstants.ppcGuide)
      ? await launch(StringConstants.ppcGuide)
      : throw StringConstants.couldNotLaunch + StringConstants.ppcGuide;

  static privacyPolicy() async => await canLaunch(StringConstants.ppcPolicy)
      ? await launch(StringConstants.ppcPolicy)
      : throw StringConstants.couldNotLaunch + StringConstants.ppcPolicy;

  static termsOfService() async => await canLaunch(StringConstants.ppcTerms)
      ? await launch(StringConstants.ppcTerms)
      : throw StringConstants.couldNotLaunch + StringConstants.ppcTerms;

  static reportAProblem() async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: StringConstants.ppcSupport,
    );
    String url = params.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      debugPrint(StringConstants.couldNotLaunch + url);
    }
  }

  static sendFeedback() async {
    final Uri params = Uri(
      scheme: 'mailto',
      path: StringConstants.ppcInfo,
    );
    String url = params.toString();
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      debugPrint(StringConstants.couldNotLaunch + url);
    }
  }

  static removeAds() {}
}
