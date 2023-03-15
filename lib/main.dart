import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'pages/Progress.dart';
import 'components/History.dart';
import 'pages/OneThing.dart';

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (c) => store1(),
      child: MaterialApp(
      home: MyApp(),
      ),
    ));
}

class store1 extends ChangeNotifier{
  var oneThing= '당신의 One Thing을 설정하세요';
  changeOneThing(s){
    oneThing = s;
    notifyListeners();
  }
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  var page = 0;

  navigationTapped(i) {
    setState(() {
      page = i;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('One Thing Tracker'),
        actions: [
          IconButton(
            onPressed: () {
              Navigator.push(
                  context, CupertinoPageRoute(builder: (c) => History()));
            },
            icon: Icon(Icons.menu),
          )
        ],
      ),
      body: [OneThing(), Progress()][page],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: page,
        onTap: (i){
          navigationTapped(i);
        },
        items: [
          BottomNavigationBarItem(icon: Icon(Icons.home), label: 'OneThing'),
          BottomNavigationBarItem(
              icon: Icon(Icons.calendar_month), label: 'Progress')
        ],
      ),
    );
  }
}
