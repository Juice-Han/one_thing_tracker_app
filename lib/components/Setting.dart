import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';
import 'package:one_thing_tracker_app/main.dart';
import 'package:provider/provider.dart';

class Setting extends StatelessWidget {
  Setting({super.key, this.changeOneThing});

  final textController1 = TextEditingController();
  final textController2 = TextEditingController();

  var changeOneThing;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Setting'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Text(
              '당신의 OneThing은 무엇인가요?',
              style: TextStyle(fontSize: 20),
            ),
            TextField(
              controller: textController1,
            ),
            Text(
              '매일 저녁 6시마다 알림을 전송할까요?',
              style: TextStyle(fontSize: 18),
            ),
            ElevatedButton(
                onPressed: () {
                  AwesomeNotifications()
                      .isNotificationAllowed()
                      .then((isAllowed) {
                    if (!isAllowed) {
                      AwesomeNotifications()
                          .requestPermissionToSendNotifications();
                    }
                  });
                },
                child: Text('네')),
            SizedBox(
              height: 6,
            ),
            ElevatedButton(
                onPressed: () {
                  context.read<store1>().changeOneThing(textController1.text);
                  Navigator.pop(context);
                  AwesomeNotifications().createNotification(
                      content: NotificationContent(
                          id: 10,
                          channelKey: 'basic_channel',
                          title: '오늘의 OneThing을 실천했나요?',
                          body: '앱에서 확인버튼을 눌러주세요!',
                          wakeUpScreen: true,
                          autoDismissible: false),
                      schedule: NotificationCalendar(
                          hour: 18, repeats: true, preciseAlarm: true));
                },
                child: Text('저장'))
          ],
        )),
      ),
    );
  }
}
