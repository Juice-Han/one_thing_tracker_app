import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:one_thing_tracker_app/main.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../components/Setting.dart';

class OneThingAfter extends StatefulWidget {
  const OneThingAfter({super.key});

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
          ElevatedButton(
            onPressed: () {},
            child: Container(
              height: 150,
              width: 200,
              child: Center(
                  child: Text(
                '실행 완료!',
                style: TextStyle(fontSize: 30),
              )),
            ),
          ),
          FutureBuilder(
            future: context.read<store1>().getOneThing(),
            builder: (context, snapshot) {
              return Text(
                context.watch<store1>().oneThing,
                style: TextStyle(fontSize: 20),
              );
            },
          ),
        ],
      ),
    );
  }
}
