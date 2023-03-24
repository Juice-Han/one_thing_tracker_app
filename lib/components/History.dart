import 'package:flutter/material.dart';

class History extends StatefulWidget {
  History({super.key, this.historyData});

  var historyData;

  @override
  State<History> createState() => _HistoryState();
}

class _HistoryState extends State<History> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('History'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(15.0),
        child: ListView.builder(
          itemBuilder: (c, i) => Column(
            children: [
              Container(
                height: 30,
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(color: Colors.black),
                        left: BorderSide(color: Colors.black),
                        right: BorderSide(color: Colors.black))),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: EdgeInsets.only(left: 10),
                      child: Row(children: [
                        Text(
                          'OneThing:  ',
                        ),
                        Text('${widget.historyData[i]['oneThing']}', style: TextStyle(fontWeight: FontWeight.w700),)
                      ]),
                    )
                  ],
                ),
              ),
              Container(
                  height: 30,
                  decoration: BoxDecoration(
                      border: Border(
                          top: BorderSide(color: Colors.grey),
                          left: BorderSide(color: Colors.black),
                          right: BorderSide(color: Colors.black))),
                  child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                            '${widget.historyData[i]['start']}  ~  ${widget.historyData[i]['end']}')
                      ])),
              Container(
                height: 30,
                decoration: BoxDecoration(
                    border: Border(
                        top: BorderSide(color: Colors.grey),
                        left: BorderSide(color: Colors.black),
                        right: BorderSide(color: Colors.black),
                        bottom: BorderSide(color: Colors.black))),
                child: Row(mainAxisAlignment: MainAxisAlignment.end, children: [
                  Padding(
                    padding: EdgeInsets.only(right: 10),
                    child: Text('총 실행횟수: ${widget.historyData[i]['times']}회'),
                  ),
                ]),
              ),
              SizedBox(
                height: 30,
              ),
            ],
          ),
          itemCount: widget.historyData.length,
        ),
      ),
    );
  }
}
