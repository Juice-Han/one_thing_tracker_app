import 'package:flutter/material.dart';
import 'package:calendar_view/calendar_view.dart';

class Calendar extends StatelessWidget {
  Calendar({super.key, this.oneThingDate});
  var oneThingDate;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(15.0),
        child: MonthView(),
      ),
    );
  }
}
