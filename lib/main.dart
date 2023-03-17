import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:one_thing_tracker_app/pages/OneThingAfter.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';
import 'package:provider/provider.dart';

import 'pages/Progress.dart';
import 'components/History.dart';
import 'pages/OneThingBefore.dart';

void main() {
  //awesome notifications 초기 세팅
  AwesomeNotifications().initialize(
      // set the icon to null if you want to use the default app icon
      null,
      [
        NotificationChannel(
          channelGroupKey: 'basic_channel_group',
          channelKey: 'basic_channel',
          channelName: 'Basic notifications',
          channelDescription: 'Notification channel for basic tests',
        )
      ],
      debug: true);
  runApp(
    ChangeNotifierProvider(
      create: (c) => store1(),
      child: MaterialApp(
        home: MyApp(),
      ),
    ),
  );
}

class store1 extends ChangeNotifier {
  saveOneThing(s) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setString('oneThing', s);
    await prefs.setInt('isChanged', 1);
  }

  saveCompleteIndex(i) async {
    var prefs = await SharedPreferences.getInstance();
    await prefs.setInt('completeIndex', i);
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var page = 0;
  var oneThing = '';
  var isChanged = 0;
  var completeIndex = 0;

  getData() async {
    var prefs = await SharedPreferences.getInstance();
    var getOneThing = prefs.getString('oneThing');
    var getIsChanged = prefs.getInt('isChanged');
    var getCompleteIndex = prefs.getInt('completeIndex');
    setState(() {
      if (getOneThing != null) {
        oneThing = getOneThing;
      }
      if (getIsChanged != null) {
        isChanged = getIsChanged;
      }
      if (getCompleteIndex != null) {
        completeIndex = getCompleteIndex;
      }
    });
  }

  navigationTapped(i) {
    setState(() {
      page = i;
    });
  }

  changeOneThing(s) {
    setState(() {
      oneThing = s;
      isChanged = 1;
    });
  }

  changeCompleteIndexTo1() {
    setState(() {
      completeIndex = 1;
    });
  }

  @override
  void initState() {
    super.initState();
    getData();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('One Thing Tracker'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context, CupertinoPageRoute(builder: (c) => History()));
            },
            icon: Icon(Icons.menu),
          )
        ],
      ),
      body: [
        [
          OneThingBefore(changeOneThing: changeOneThing),
          OneThingAfter(
              oneThing: oneThing,
              completeIndex: completeIndex,
              changeCompleteIndexTo1: changeCompleteIndexTo1)
        ][isChanged],
        Progress()
      ][page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: page,
        onTap: (i) {
          navigationTapped(i);
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'OneThing'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month), label: 'Calendar')
        ],
      ),
    );
  }
}
