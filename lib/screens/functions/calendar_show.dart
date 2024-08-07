import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

class MyCalendar extends StatelessWidget {
  final DateTime startDate;
  final Map<DateTime, int> data;
  const MyCalendar({super.key, required this.startDate, required this.data});

  @override
  Widget build(BuildContext context) {
    return HeatMap(
      startDate: startDate,
      endDate: DateTime.now(),
      datasets: data,
      colorMode: ColorMode.color,
      defaultColor: Colors.grey,
      scrollable: true,
      size: 30,
       showText: true,

       showColorTip: true,
      colorsets: {
        1: Colors.green.shade300,
        2: Colors.green.shade400,
        3: Colors.green.shade500,
        4: Colors.green.shade600,
        5: Colors.green.shade700,
      },
    );
  }
}
