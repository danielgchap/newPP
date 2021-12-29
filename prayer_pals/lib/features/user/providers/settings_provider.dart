import 'package:flutter/material.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer_pals/core/services/notification_service.dart';
import 'package:shared_preferences/shared_preferences.dart';

final settingsControllerProvider =
    ChangeNotifierProvider((ref) => SettingsController(ref.read));

class SettingsController extends ChangeNotifier {
  final Reader _reader;
  String? timeString = '';

  SettingsController(this._reader) : super() {
    getTimeString();
  }

  getTimeString() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    timeString = prefs.getString('timeString');
    notifyListeners();
  }

  void setReminder(BuildContext context) async {
    NotificationService _notificationService = NotificationService();
    final timeString =
        await _notificationService.scheduleNotifications(context);
    if (timeString.isNotEmpty) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      await prefs.setString('timeString', timeString);
      getTimeString();
    }
  }

  void cancelReminder(BuildContext context) async {
    NotificationService _notificationService = NotificationService();
    await _notificationService.cancelAllNotifications();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('timeString', 'null');
    getTimeString();
  }
}
