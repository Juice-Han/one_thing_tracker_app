import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:one_thing_tracker_app/main.dart';
import 'package:provider/provider.dart';

import '../notification.dart';

class Setting extends StatefulWidget {
  Setting({super.key, this.changeOneThing});

  var changeOneThing;

  @override
  State<Setting> createState() => _SettingState();
}

class _SettingState extends State<Setting> {
  final textController1 = TextEditingController();
  final textController2 = TextEditingController();
  var saveIndex = 0;

  @override
  void initState() {
    super.initState();
    textController1.addListener(() {
      if (textController1.text.isNotEmpty) {
        setState(() {
          saveIndex = 1;
        });
      } else {
        setState(() {
          saveIndex = 0;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
            child: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height * 9 / 10,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                Text(
                  '당신의 OneThing은 무엇인가요? (필수)',
                  style: TextStyle(fontSize: 20),
                ),
                TextField(
                  maxLength: 20,
                  controller: textController1,
                ),
                Text(
                  '매일 정해진 시간에 알림을 전송할까요? (선택)',
                  style: TextStyle(fontSize: 17),
                ),
                TimePick(),
                SizedBox(
                  height: 6,
                ),
                [
                  ElevatedButton(
                    onPressed: null,
                    child: Text('원띵을 정해주세요'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pop(context);
                      widget.changeOneThing(textController1.text);
                      context.read<store1>().saveOneThing(textController1.text);
                    },
                    child: Text('저장'),
                  ),
                ][saveIndex]
              ],
            ),
          ),
        )),
      ),
    );
  }
}

class TimePick extends StatefulWidget {
  const TimePick({super.key});

  @override
  State<TimePick> createState() => _TimePickState();
}

class _TimePickState extends State<TimePick> {
  var index = 0;
  var selectedTime;
  @override
  Widget build(BuildContext context) {
    return [
      ElevatedButton(
          onPressed: () {
            selectedTime =
                showTimePicker(context: context, initialTime: TimeOfDay.now());
            selectedTime.then((timeOfDay) {
              if (timeOfDay == null) {
                selectedTime = null;
                showDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                        title: Text('주의!'),
                        content: Text(
                          '시간이 선택되지 않았습니다',
                        )));
              } else {
                context.read<store1>().changeNotificationTime(timeOfDay);
                FlutterLocalNotificationsPlugin
                    flutterLocalNotificationsPlugin =
                    FlutterLocalNotificationsPlugin();
                flutterLocalNotificationsPlugin
                    .resolvePlatformSpecificImplementation<
                        AndroidFlutterLocalNotificationsPlugin>()
                    ?.requestPermission();
                showNotification(context.read<store1>().notificationTime);
                setState(() {
                  index = 1;
                });
              }
            });
          },
          child: Text('시간을 정해주세요')),
      ElevatedButton(
        onPressed: null,
        child: Text('시간 설정 완료'),
      ),
    ][index];
  }
}
