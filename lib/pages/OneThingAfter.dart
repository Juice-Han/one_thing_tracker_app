import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:one_thing_tracker_app/main.dart';
import 'package:provider/provider.dart';

class OneThingAfter extends StatefulWidget {
  OneThingAfter({super.key, this.oneThing, this.completeIndex, this.changeCompleteIndexTo1, this.addOneThingDate });
  var completeIndex;
  var oneThing;
  var changeCompleteIndexTo1;
  var addOneThingDate;
  @override
  State<OneThingAfter> createState() => _OneThingAfterState();
}

class _OneThingAfterState extends State<OneThingAfter> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          [
            ElevatedButton(
              onPressed: (){
                var now = DateTime.now().toString();
                widget.changeCompleteIndexTo1();
                context.read<store1>().saveCompleteIndex(1);
                final event = CalendarEventData(title: 'One',date: DateTime.now());
                CalendarControllerProvider.of(context).controller.add(event);
                context.read<store1>().saveDate(now);
                widget.addOneThingDate(now);
                },
              child: Container(
                height: 150,
                width: 200,
                child: Center(
                    child: Text(
                  '실행 완료',
                  style: TextStyle(fontSize: 30),
                )),
              ),
            ),
            ElevatedButton(
              onPressed: null,
              child: Container(
                height: 150,
                width: 200,
                child: Center(
                  child: Text(
                    '오늘의\nOneThing을\n실행했습니다!',
                    style: TextStyle(fontSize: 30),
                  ),
                ),
              ),
            )
          ][widget.completeIndex],
          Text(widget.oneThing, style: TextStyle(fontSize: 30),),
        ],
      ),
    );
  }
}
