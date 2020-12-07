import 'dart:isolate';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:medicfy/src/pages/home_page.dart';
import 'package:medicfy/src/pages/login_page.dart';
import 'package:medicfy/src/pages/tab_pag.dart';
import 'package:android_alarm_manager/android_alarm_manager.dart';

import 'package:medicfy/src/routes/routes.dart';
import 'package:flutter_localizations/flutter_localizations.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await AndroidAlarmManager.initialize();
  //final int helloAlarmID = 0;
  runApp(MyApp());

  await AndroidAlarmManager.periodic(
      const Duration(seconds: 2), 0, deployNotificacion);
}

void printHello() {
  final DateTime now = DateTime.now();
  final int isolateId = Isolate.current.hashCode;
  print("[$now] Hello, world! isolate=${isolateId} function='$printHello'");
}

Future singleNotificacion(FlutterLocalNotificationsPlugin plugin,
    DateTime dateTime, String message, String subtext, int hashcode,
    {String sound}) async {
  printHello();
  var androidChanel = AndroidNotificationDetails(
      'channel-id', 'channel-name', 'channel-description',
      importance: Importance.max, priority: Priority.max);
  var iosChanel = IOSNotificationDetails();
  var plataformChannel =
      NotificationDetails(android: androidChanel, iOS: iosChanel);
  plugin.schedule(hashcode, message, subtext, dateTime, plataformChannel,
      payload: hashcode.toString());
}

Future deployNotificacion() async {
  FlutterLocalNotificationsPlugin localNotificationsPlugin =
      FlutterLocalNotificationsPlugin();
  var initializeAndroid = AndroidInitializationSettings('launch_background');
  var initializeIOS = IOSInitializationSettings();
  var initSettings =
      InitializationSettings(android: initializeAndroid, iOS: initializeIOS);
  await localNotificationsPlugin.initialize(initSettings);
  singleNotificacion(localNotificationsPlugin, DateTime.now().toUtc(),
      'Tome el Medicamento', 'Horario de medicamento', 123111);
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MedicFy',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', 'US'), // English, no country code
        const Locale('es', 'ES'), // Hebrew, no country code
      ],
      home: Scaffold(
        body: HomePage(),
      ),
      routes: getApplicationRoutes(),
    );

    /*MaterialApp(
      title: 'Material App',
      debugShowCheckedModeBanner: false,
      localizationsDelegates: [
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales: [
        const Locale('en', 'US'), // English, no country code
        const Locale('es', 'ES'), // Hebrew, no country code
      ],
      initialRoute: '/',
      routes: getApplicationRoutes(),
    );*/
  }
}
