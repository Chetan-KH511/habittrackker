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
       showColorTip: false,
      colorsets: {
        1: Colors.purple.shade300,
        2: Colors.purple.shade400,
        3: Colors.purple.shade500,
        4: Colors.purple.shade600,
        5: Colors.purple.shade700,
      },
    );
  }
}
