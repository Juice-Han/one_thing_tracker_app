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
      body: Center(
          child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Text('당신의 OneThing은 무엇인가요?'),
          TextField(
            controller: textController1,
          ),
          Text('목표기간을 설정해주세요'),
          TextField(
            controller: textController2,
          ),
          
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Text('저녁 6시마다 알람을 보낼까요?'),
              ElevatedButton(onPressed: () {}, child: Text('네')),
            ],
          ),
          ElevatedButton(onPressed: () {
            context.read<store1>().changeOneThing(textController1.text);
            Navigator.pop(context);
          }, child: Text('저장'))
        ],
      )),
    );
  }
}
