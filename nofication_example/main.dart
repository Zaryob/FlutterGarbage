import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:timezone/data/latest.dart' as tz;
import 'package:timezone/timezone.dart' as tz;

Future<void> _configureLocalTimeZone() async {
  tz.initializeTimeZones();
  var turkey = tz.getLocation('Europe/Istanbul');
  tz.setLocalLocation(turkey);
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await _configureLocalTimeZone();

  runApp(new MaterialApp(
    title: "Water Notification",
    debugShowCheckedModeBanner: false,
    theme: ThemeData(
        appBarTheme: AppBarTheme(
      color: Colors.red,
    )),
    home: new MyApp(),
  ));
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  String _selectedParam;
  int val;
  String task;

  Future<void> scheduleNotification() async{
    var scheduledTime;
    if(_selectedParam == "Hours")
      scheduledTime = tz.TZDateTime.now(tz.local).add(Duration(hours:val));
    else if(_selectedParam == "Minutes")
      scheduledTime = tz.TZDateTime.now(tz.local).add(Duration(minutes:val));
    else
      scheduledTime = tz.TZDateTime.now(tz.local).add(Duration(seconds:val));

    var androidPlatformChannelSpecifics = AndroidNotificationDetails(
      'channel id',
      'channel name',
      'channel description',
      icon: 'flutter_devs',
      largeIcon: DrawableResourceAndroidBitmap('flutter_devs'),
    );
    var iOSPlatformChannelSpecifics = IOSNotificationDetails();
    var platformChannelSpecifics = NotificationDetails(
      android: androidPlatformChannelSpecifics,
      iOS: iOSPlatformChannelSpecifics,
      macOS: null,
    );
    await flutterLocalNotificationsPlugin.zonedSchedule(
      1,
      'flutter_dev',
      task,
      scheduledTime,
      platformChannelSpecifics,
      uiLocalNotificationDateInterpretation: null,
      androidAllowWhileIdle: false,
    );
  }
  Future<void> cancelNotification() async{
    await flutterLocalNotificationsPlugin.cancel(1);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: new AppBar(
        backgroundColor: Colors.red,
        title: new Text('Water Notification'),
      ),
      body:Center(
        child: Column(
          children: [
            Padding(
              padding: EdgeInsets.all(10),
              child: TextField(
                onChanged: (_val)
                {
                  task=_val;
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  DropdownButton(
                    hint: Text("Time"),
                    value: _selectedParam,
                    items: [
                      DropdownMenuItem(child: Text("Seconds"), value:"Seconds"),
                      DropdownMenuItem(child: Text("Minutes"), value:"Minutes"),
                      DropdownMenuItem(child: Text("Hours"), value:"Hours"),
                    ],
                    onChanged: (_val){
                      setState(() {
                        _selectedParam=_val;
                      });

                    },
                  ),
                  DropdownButton(
                    value: val,
                    hint: Text("Duration"),
                    items: [
                      DropdownMenuItem(child: Text("5"), value:5),
                      DropdownMenuItem(child: Text("10"), value:10),
                      DropdownMenuItem(child: Text("15"), value:15),
                      DropdownMenuItem(child: Text("15"), value:20),
                    ],
                    onChanged: (_val){
                      setState(() {
                        val=_val;
                      });

                    },
                  )
                ],
              ),
            ),
            RaisedButton(
              child: Text("schedule notification"),
              onPressed: scheduleNotification,
            ),
            RaisedButton(
              child: Text("cancel scheduled notification"),
              onPressed: cancelNotification,
            ),

          ],
        )
      ),
    );
  }
}
