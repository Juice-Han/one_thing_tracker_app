import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/material.dart';
import 'package:one_thing_tracker_app/main.dart';
import 'package:provider/provider.dart';

import '../components/Setting.dart';

class OneThing extends StatefulWidget {
  const OneThing({super.key});

  @override
  State<OneThing> createState() => _OneThingState();
}

class _OneThingState extends State<OneThing> {

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              onPressed: () {Navigator.push(context, MaterialPageRoute(builder: (c)=> Setting()));},
              child: Icon(Icons.add),
            ),
            Text(context.watch<store1>().oneThing, style: TextStyle(fontSize: 20),),
          ],
        ),
      );
  }
}