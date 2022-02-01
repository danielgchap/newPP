import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:google_mobile_ads/google_mobile_ads.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:prayer_pals/core/iap/iap_handler.dart';
import 'package:prayer_pals/core/services/notification_service.dart';
import 'prayer_pals_app.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  MobileAds.instance.initialize();
  await NotificationService().init(); //
  await Firebase.initializeApp();
  IAPHandler();
  runApp(
    const ProviderScope(
      child: MyApp(),
    ),
  );
}
