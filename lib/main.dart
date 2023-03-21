import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:one_thing_tracker_app/notification.dart';
import 'package:one_thing_tracker_app/pages/OneThingAfter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:provider/provider.dart';

import 'pages/Calendar.dart';
import 'components/History.dart';
import 'pages/OneThingBefore.dart';
import 'components/Save.dart';

void main() {
  runApp(
    CalendarControllerProvider(
      controller: EventController(),
      child: ChangeNotifierProvider(
        create: (c) => store1(),
        child: MaterialApp(
          home: MyApp(),
        ),
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

  saveDate(d) async {
    var prefs = await SharedPreferences.getInstance();
    var dateList = prefs.getStringList('oneThingDate');
    if (dateList == null) {
      List<String> result = [d];
      prefs.setStringList('oneThingDate', result);
    } else {
      dateList.add(d);
      prefs.setStringList('oneThingDate', dateList);
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
  var oneThing = '';
  var isChanged = 0;
  var completeIndex = 0;
  var oneThingDate = [];
  var isGetCalendar = false;

  getData() async {
    final now = DateTime.now();
    var prefs = await SharedPreferences.getInstance();
    var getOneThing = prefs.getString('oneThing');
    var getIsChanged = prefs.getInt('isChanged');
    var getCompleteIndex = prefs.getInt('completeIndex');
    var getTomorrow = prefs.getString('tomorrow');
    var getOneThingDate = prefs.getStringList('oneThingDate');

    setState(() {
      if (getOneThing != null) {
        oneThing = getOneThing;
      }
      if (getIsChanged != null) {
        isChanged = getIsChanged;
      }
      if (getOneThingDate != null) {
        oneThingDate = getOneThingDate;
      }
    });

    if (getTomorrow != null) {
      if (now.isAfter(DateTime.parse(getTomorrow))) {
        setState(() {
          completeIndex = 0;
        });
        prefs.setInt('completeIndex', 0);
      } else {
        if (getCompleteIndex != null) {
          setState(() {
            completeIndex = getCompleteIndex;
          });
        }
      }
    }
    await prefs.setString(
        'tomorrow', DateTime(now.year, now.month, now.day + 1).toString());
  }

  showCalenderData() {
    //oneThingDate 가져와서 캘린더에 표시
    //입력된 인자가 0일때만 불러오기 = 한 번 불러오면 두 번째부터는 안 불러옴
    if (isGetCalendar == false) {
      if (oneThingDate != null) {
        for (var e in oneThingDate) {
          var event = CalendarEventData(title: 'One', date: DateTime.parse(e));
          CalendarControllerProvider.of(context).controller.add(event);
        }
      }
      setState(() {
        isGetCalendar = true;
      });
    }
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

  addOneThingDate(d){
    setState(() {
      oneThingDate.add(d);
    });
  }

  @override
  void initState() {
    super.initState();
    initNotification(context);
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
              if (oneThingDate.length != 0) {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: ((c) => Save(
                            oneThing: oneThing,
                            oneThingDate: oneThingDate,
                          )),
                    ));
              } else {
                showDialog(
                    context: context,
                    builder: ((context) => AlertDialog(
                          title: Text('주의!'),
                          content: Text('1회 수행 후 시도해주세요'),
                        )));
              }
            },
            icon: Icon(Icons.save),
          ),
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
            changeCompleteIndexTo1: changeCompleteIndexTo1,
            addOneThingDate: addOneThingDate,
          )
        ][isChanged],
        Progress()
      ][page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: page,
        onTap: (i) {
          navigationTapped(i);
          if (i == 1) {
            showCalenderData();
          }
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
