// ignore_for_file: must_be_immutable

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:prayer_pals/core/event_bus/group_subscribtion_event.dart';
import 'package:prayer_pals/core/event_bus/ppc_event_bus.dart';
import 'package:prayer_pals/features/home/view/home_page_container.dart';

class MessageRootHandler extends HookWidget {
  MessageRootHandler({Key? key}) : super(key: key);

  final PPCEventBus _eventBus = PPCEventBus();
  StreamSubscription? iosSubscription;

  @override
  Widget build(BuildContext context) {
    useEffect(() {
      {
        _configureFCM();
        _setupEventListeners();
      }
    }, []);
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      body: Material(
        child: HomePageContainer(),
      ),
    );
  }

  _configureFCM() async {
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    await messaging.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      criticalAlert: false,
      provisional: false,
      sound: true,
    );

    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      debugPrint('Got a message whilst in the foreground!');
      debugPrint('Message data: ${message.data}');

      if (message.notification != null) {
        debugPrint(
            'Message also contained a notification: ${message.notification}');
      }
    });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      debugPrint('A new onMessageOpenedApp event was published!');
      analyzeIncomingPNString(
          message.data['type'], message.data['id'], message.data);
    });
  }

  _setupEventListeners() {
    _eventBus.on<SubscribeToGroupPNEvent>().listen((event) {
      fcmSubscribeToTopic(event.groupId, (success) => {});
    });
    _eventBus.on<UNSubscribeToGroupPNEvent>().listen((event) {
      fcmUnsubscribeFromTopic(event.groupId, (success) => {});
    });
  }

  analyzeIncomingPNString(
      String input, String id, Map<String, dynamic> message) {
    debugPrint(
        '\n\nRECEIVED PN: $input FOR ID: $id\n\n WITH MESSAGE: $message');
    switch (input) {
      default:
    }
  }

  static fcmSubscribeToTopic(
      String groupId, Function(bool success) successCallback) {
    FirebaseMessaging.instance.subscribeToTopic('sub_to_group').then((value) {
      debugPrint('FCM - Successfully subscribed to topic: SUBTOGROUP-$groupId');
      successCallback(true);
    }).catchError((error) {
      debugPrint('FCM - Error subscribing to topic: $groupId:\n****$error');
      successCallback(false);
    });
  }

  static fcmUnsubscribeFromTopic(
      String groupId, Function(bool success) successCallback) {
    FirebaseMessaging.instance
        .subscribeToTopic('SUBTOGROUP-$groupId')
        .then((value) {
      debugPrint(
          'FCM - Successfully UNSUBscribed from topic: SUBTOGROUP-$groupId');
      successCallback(true);
    }).catchError((error) {
      debugPrint('FCM - Error unsubscribing from topic: $groupId:\n****$error');
      successCallback(false);
    });
  }
}
