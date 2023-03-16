import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:one_thing_tracker_app/pages/OneThingAfter.dart';
import 'package:provider/provider.dart';
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:shared_preferences/shared_preferences.dart';

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
  runApp(ChangeNotifierProvider(
    create: (c) => store1(),
    child: MaterialApp(
      home: MyApp(),
    ),
  ));
}

class store1 extends ChangeNotifier {
  var oneThing = '';
  var isChanged = 0;

  changeOneThing(s) async {
    var prefs = await SharedPreferences.getInstance();
    prefs.setString('oneThing', s);
    prefs.setInt('isChanged', 1);
    oneThing = s;
    isChanged = 1;
    notifyListeners();
  }

  getOneThing() async {
    var prefs = await SharedPreferences.getInstance();
    var savedOneThing = prefs.getString('oneThing');
    var checkOneThing = prefs.getInt('isChanged');
    if (savedOneThing != null) {
      oneThing = savedOneThing;
    }
    if (checkOneThing != null) {
      isChanged = checkOneThing;
    }
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var page = 0;

  navigationTapped(i) {
    setState(() {
      page = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: context.read<store1>().getOneThing(),
      builder: (context, snapshot) {
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
              OneThingBefore(),
              OneThingAfter()
            ][context.watch<store1>().isChanged],
            Progress()
          ][page],
          bottomNavigationBar: BottomNavigationBar(
            currentIndex: page,
            onTap: (i) {
              navigationTapped(i);
            },
            items: [
              BottomNavigationBarItem(
                  icon: Icon(Icons.home), label: 'OneThing'),
              BottomNavigationBarItem(
                  icon: Icon(Icons.calendar_month), label: 'Calendar')
            ],
          ),
        );
      },
    );
  }
}
