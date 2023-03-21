import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class Save extends StatelessWidget {
  Save({super.key, this.oneThing, this.oneThingDate});

  var oneThingDate;
  var oneThing;

  @override
  Widget build(BuildContext context) {
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
              '나의 One Thing: ',
              style: TextStyle(fontSize: 20),
            ),
            SizedBox(height: 25,),
            Text(
              oneThing,
              style: TextStyle(fontSize: 30, fontWeight: FontWeight.w700),
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
              '총 원띵 수행일',
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
                ElevatedButton(onPressed: () {}, child: Text('저장'))
              ],
            ),
          ],
        ),
      ),
    );
  }
}
