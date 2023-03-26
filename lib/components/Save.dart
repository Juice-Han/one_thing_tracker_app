import 'dart:convert';

import 'package:calendar_view/calendar_view.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:one_thing_tracker_app/main.dart';
import 'package:provider/provider.dart';

class Save extends StatelessWidget {
  Save({super.key, this.oneThing, this.oneThingDate,this.historyData, this.addHistory, this.resetData, this.removeCalendarEvent});

  var removeCalendarEvent;
  var historyData;
  var oneThingDate;
  var oneThing;
  var addHistory;
  var resetData;
  var tSize;

  @override
  Widget build(BuildContext context) {
    if(oneThing.length > 15){
      tSize = 18.0;
    }else if(oneThing.length > 10){
      tSize = 23.0;
    }else{
      tSize = 30.0;
    }
    return Scaffold(
      appBar: AppBar(),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            SizedBox(
              height: 50,
            ),
            Text(
              'One Thing: ',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 25,),
            Text(
              oneThing,
              style: TextStyle(fontSize: tSize, fontWeight: FontWeight.w700),
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '첫 수행일: ',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  DateFormat('yyyy년 MM월 dd일')
                      .format(DateTime.parse(oneThingDate[0])),
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            SizedBox(
              height: 25,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  '마지막 수행일: ',
                  style: TextStyle(fontSize: 20),
                ),
                Text(
                  DateFormat('yyyy년 MM월 dd일').format(
                      DateTime.parse(oneThingDate[oneThingDate.length - 1])),
                  style: TextStyle(fontSize: 20),
                ),
              ],
            ),
            SizedBox(
              height: 75,
            ),
            Text(
              '총 원띵 수행횟수',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(
              height: 25,
            ),
            Text(
              '${oneThingDate.length}회',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            SizedBox(
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Text(
                  '지금까지의 원띵은 저장되고 \n 새로운 원띵이 시작됩니다. 저장할까요?',
                  style: TextStyle(fontSize: 15),
                ),
                ElevatedButton(onPressed: (){
                  var savingData = {
                    'oneThing' : oneThing,
                    'start': DateFormat('yyyy년 MM월 dd일').format(DateTime.parse(oneThingDate[0])),
                    'end' : DateFormat('yyyy년 MM월 dd일').format(DateTime.parse(oneThingDate[oneThingDate.length - 1])),
                    'times': oneThingDate.length,
                  };
                  addHistory(savingData);
                  context.read<store1>().saveHistory(jsonEncode(historyData));
                  removeCalendarEvent();
                  resetData();
                  Navigator.pop(context);
                }, child: Text('저장'))
              ],
            ),
          ],
        ),
      ),
    );
  }
}

