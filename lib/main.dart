import 'package:firebase_remote_config/firebase_remote_config.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:lunch_app/firebase_options.dart';
import 'package:lunch_app/login/app_state.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:lunch_app/login/notification.dart';

final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  notification myNotification = notification();
  await myNotification.initilizeNotification();
  await myNotification.showNotification(1, 'ℍ𝕖𝕝𝕝𝕠 𝕘𝕦𝕪𝕤 😊.😝',
      '˜”*°•.˜”*°• Update your lunch •°*”˜.•°*”˜..😋🍛');

  if (!kIsWeb)
    await Firebase.initializeApp();
  else
    await Firebase.initializeApp(
        options: DefaultFirebaseOptions.currentPlatform);
  final remoteConfig = FirebaseRemoteConfig.instance;
  await remoteConfig.setConfigSettings(
    RemoteConfigSettings(
      fetchTimeout: const Duration(minutes: 1),
      minimumFetchInterval: const Duration(minutes: 1),
    ),
  );
  await remoteConfig.fetchAndActivate();
  runApp(const LunchApp());
}
