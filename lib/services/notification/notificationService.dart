// ignore_for_file: require_trailing_commas
// Copyright 2019 The Chromium Authors. All rights reserved.
// Use of this source code is governed by a BSD-style license that can be
// found in the LICENSE file.

import 'dart:async';
import 'dart:convert';
import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:flutter_local_notifications/flutter_local_notifications.dart';

import 'message.dart';
import 'message_list.dart';
import 'permissions.dart';
import 'token_monitor.dart';

/// Define a top-level named handler which background/terminated messages will
/// call.
///
/// To verify things are working, check out the native platform logs.

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  // Set the background messaging handler early on, as a named top-level function

  runApp(MessagingExampleApp());
}

/// Entry point for the example application.
class MessagingExampleApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Messaging Example App',
      theme: ThemeData.dark(),
      routes: {
        '/': (context) => Application(),
        '/message': (context) => MessageView(),
      },
    );
  }
}

// Crude counter to make messages unique
int _messageCount = 0;

/// The API endpoint here accepts a raw FCM payload for demonstration purposes.
String constructFCMPayload(String token) {
  _messageCount++;
  return jsonEncode({
    'token': token,
    'data': {
      'via': 'FlutterFire Cloud Messaging!!!',
      'count': _messageCount.toString(),
    },
    'notification': {
      'title': 'Hello FlutterFire!',
      'body': 'This notification (#$_messageCount) was created via FCM!',
    },
  });
}

/// Renders the example application.
class Application extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _Application();
}


class _Application extends State<Application> {
  String _token;

  // var flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();
  @override
  void initState() {
    super.initState();

    FirebaseMessagingInit(context);

  }

  Future<void> sendPushMessage() async {
    if (_token == null) {
      print('Unable to send FCM message, no token exists.');
      return;
    }

    try {
      await http.post(
        Uri.parse('https://api.rnfirebase.io/messaging/send'),
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: constructFCMPayload(_token),
      );
      print('FCM request for device sent!');
    } catch (e) {
      print(e);
    }
  }

  Future<void> onActionSelected(String value) async {
    switch (value) {
      case 'subscribe':
        {
          print(
              'FlutterFire Messaging Example: Subscribing to topic "fcm_test".');
          await FirebaseMessaging.instance.subscribeToTopic('fcm_test');
          print(
              'FlutterFire Messaging Example: Subscribing to topic "fcm_test" successful.');
        }
        break;
      case 'unsubscribe':
        {
          print(
              'FlutterFire Messaging Example: Unsubscribing from topic "fcm_test".');
          await FirebaseMessaging.instance.unsubscribeFromTopic('fcm_test');
          print(
              'FlutterFire Messaging Example: Unsubscribing from topic "fcm_test" successful.');
        }
        break;
      case 'get_apns_token':
        {
          if (defaultTargetPlatform == TargetPlatform.iOS ||
              defaultTargetPlatform == TargetPlatform.macOS) {
            print('FlutterFire Messaging Example: Getting APNs token...');
            String token = await FirebaseMessaging.instance.getAPNSToken();
            print('FlutterFire Messaging Example: Got APNs token: $token');
          } else {
            print(
                'FlutterFire Messaging Example: Getting an APNs token is only supported on iOS and macOS platforms.');
          }
        }
        break;
      default:
        break;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cloud Messaging'),
        actions: <Widget>[
          PopupMenuButton(
            onSelected: onActionSelected,
            itemBuilder: (BuildContext context) {
              return [
                const PopupMenuItem(
                  value: 'subscribe',
                  child: Text('Subscribe to topic'),
                ),
                const PopupMenuItem(
                  value: 'unsubscribe',
                  child: Text('Unsubscribe to topic'),
                ),
                const PopupMenuItem(
                  value: 'get_apns_token',
                  child: Text('Get APNs token (Apple only)'),
                ),
              ];
            },
          ),
        ],
      ),
      floatingActionButton: Builder(
        builder: (context) => FloatingActionButton(
          onPressed: sendPushMessage,
          backgroundColor: Colors.white,
          child: const Icon(Icons.send),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(children: [
          MetaCard(
              'FCM Token',
              FutureBuilder(
                  future: FirebaseMessaging.instance.getToken(),
                  builder: (context, snapshot) {
                    print(snapshot.data);

                    return Text(snapshot.hasData ? snapshot.data : 'loading',
                        style: const TextStyle(fontSize: 12));
                  })),
          MetaCard('Message Stream', MessageList()),
        ]),
      ),
    );
  }
}

/// UI Widget for displaying metadata.
class MetaCard extends StatelessWidget {
  final String _title;
  final Widget _children;

  // ignore: public_member_api_docs
  MetaCard(this._title, this._children);

  @override
  Widget build(BuildContext context) {
    return Container(
        width: double.infinity,
        margin: const EdgeInsets.only(left: 8, right: 8, top: 8),
        child: Card(
            child: Padding(
                padding: const EdgeInsets.all(16),
                child: Column(children: [
                  Container(
                      margin: const EdgeInsets.only(bottom: 16),
                      child:
                          Text(_title, style: const TextStyle(fontSize: 18))),
                  _children,
                ]))));
  }
}
FirebaseMessagingInit(context) {
  var flutterLocalNotificationsPlugin = FlutterLocalNotificationsPlugin();

  FirebaseMessaging.instance.getInitialMessage().then((RemoteMessage message) {
    if (message != null) {
      Navigator.pushNamed(context, '/message',
          arguments: MessageArguments(message, true));
    }
  });

  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    RemoteNotification notification = message.notification;
    AndroidNotification android = message.notification.android;
    if (notification != null && android != null && !kIsWeb) {
      flutterLocalNotificationsPlugin.show(
          notification.hashCode,
          notification.title,
          notification.body,
          NotificationDetails(
            android: AndroidNotificationDetails(
              'id',
              'name',
// TODO add a proper drawable resource to android, for now using
//      one that already exists in example app.
              icon: 'launch_background',
            ),
          ));
    }
  });

  FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
    print('A new onMessageOpenedApp event was published!');
    Navigator.pushNamed(context, '/message',
        arguments: MessageArguments(message, true));
  });
}


SaveDeviceToken(uid) async {
  final  _db = FirebaseFirestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  // Get the current user

  // FirebaseUser user = await _auth.currentUser();

  // Get the token for this device
  String fcmToken = await _fcm.getToken();

  // Save it to Firestore
  if (fcmToken != null) {
    var tokens = _db
        .collection('users')
        .doc(uid)
        .collection('tokens')
        .doc(fcmToken);

    await tokens.set({
      'token': fcmToken,
      'createdAt': FieldValue.serverTimestamp(), // optional
      'platform': Platform.operatingSystem // optional
    });
  }
}
DeleteDeviceToken(uid) async {
  final  _db = FirebaseFirestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  // Get the current user

  // FirebaseUser user = await _auth.currentUser();

  // Get the token for this device
  String fcmToken = await _fcm.getToken();

  // Save it to Firestore
  if (fcmToken != null) {
    var tokens = _db
        .collection('users')
        .doc(uid)
        .collection('tokens')
        .doc(fcmToken);

    await tokens.delete();
  }
}


SaveDeviceTokenForCelebrity(uid) async {
  final  _db = FirebaseFirestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

print("celebrity sign in running");

  String fcmToken = await _fcm.getToken();

  // Save it to Firestore
  if (fcmToken != null) {

    var tokens = _db
        .collection('celebrities')
        .doc(uid)
        .collection('tokens')
        .doc(fcmToken);

    await tokens.set({
      'token': fcmToken,
      'createdAt': FieldValue.serverTimestamp(), // optional
      'platform': Platform.operatingSystem // optional
    });
  }
}
DeleteDeviceTokenForCelebrity(uid) async {
  final  _db = FirebaseFirestore.instance;
  final FirebaseMessaging _fcm = FirebaseMessaging.instance;

  // Get the current user

  // FirebaseUser user = await _auth.currentUser();

  // Get the token for this device
  String fcmToken = await _fcm.getToken();

  // Save it to Firestore
  if (fcmToken != null) {
    var tokens = _db
        .collection('celebrities')
        .doc(uid)
        .collection('tokens')
        .doc(fcmToken);

    await tokens.delete();
  }
}