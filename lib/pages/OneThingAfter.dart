import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:one_thing_tracker_app/main.dart';
import 'package:provider/provider.dart';

class OneThingAfter extends StatefulWidget {
  OneThingAfter(
      {super.key,
      this.oneThing,
      this.completeIndex,
      this.changeCompleteIndexTo1,
      this.addOneThingDate,
      this.addCalendarEvent});
  var completeIndex;
  var oneThing;
  var changeCompleteIndexTo1;
  var addOneThingDate;
  var addCalendarEvent;

  @override
  State<OneThingAfter> createState() => _OneThingAfterState();
}

class _OneThingAfterState extends State<OneThingAfter> {

  var tSize;
  
  @override
  void initState() {
    super.initState();
    if(widget.oneThing.length > 15){
      setState(() {
        tSize = 17.0;
      });
    }else if(widget.oneThing.length > 10){
      setState(() {
        tSize = 22.0;
      });
    }else{
      setState(() {
        tSize = 30.0;
      });
    }
  }
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          [
            ElevatedButton(
              onPressed: () {
                var now = DateTime.now().toString();
                widget.changeCompleteIndexTo1();
                context.read<store1>().saveCompleteIndex(1);
                final event =
                    CalendarEventData(title: 'One', date: DateTime.now());
                CalendarControllerProvider.of(context).controller.add(event);
                widget.addCalendarEvent(event);
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
          Column(
            children: [
              Text('One Thing: ', style: TextStyle(fontSize: 25),),
              SizedBox(height: 30,),
              Padding(
                padding: const EdgeInsets.all(15.0),
                child: Text(
                  widget.oneThing,
                  style: TextStyle(fontSize: tSize, fontWeight: FontWeight.w700,),
                  textAlign: TextAlign.center,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
