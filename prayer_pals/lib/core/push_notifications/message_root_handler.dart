import 'dart:async';

import 'package:flutter/material.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:prayer_pals/core/event_bus/group_subscribtion_event.dart';
import 'package:prayer_pals/core/event_bus/ppc_event_bus.dart';
import 'package:prayer_pals/features/home/view/home_page_container.dart';

class MessageRootHandler extends StatefulWidget {
  const MessageRootHandler({Key? key}) : super(key: key);
  @override
  MessageRootHandlerState createState() => MessageRootHandlerState();
}

class MessageRootHandlerState extends State<MessageRootHandler> {
  final PPCEventBus _eventBus = PPCEventBus();
  StreamSubscription? iosSubscription;

  @override
  void initState() {
    super.initState();
    setup();
  }

  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      resizeToAvoidBottomInset: false,
      body: Material(
        child: HomePageContainer(),
      ),
    );
  }

  setup() {
    _configureFCM();
    _setupEventListeners();
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
    FirebaseMessaging.instance
        .subscribeToTopic('SUBTOGROUP-$groupId')
        .then((value) {
      debugPrint('FCM - Successfully subscribed to group: $groupId');
      successCallback(true);
    }).catchError((error) {
      debugPrint('FCM - Error subscribing to topic: $groupId:\n****$error');
      successCallback(false);
    });
  }

  static fcmUnsubscribeFromTopic(
      String groupId, Function(bool success) successCallback) {
    FirebaseMessaging.instance
        .subscribeToTopic('UNSUBTOGROUP-$groupId')
        .then((value) {
      debugPrint('FCM - Successfully UNSUBscribed from topic: $groupId');
      successCallback(true);
    }).catchError((error) {
      debugPrint('FCM - Error unsubscribing from topic: $groupId:\n****$error');
      successCallback(false);
    });
  }

  @override
  void dispose() {
    if (iosSubscription != null) iosSubscription!.cancel();
    super.dispose();
  }
}