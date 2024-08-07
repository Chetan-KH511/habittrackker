import 'package:habittrackker/datamodel/habit.dart';

bool isHabitCompletedToday(List<DateTime> completedDays) {
  final today = DateTime.now();
  return completedDays.any((element) =>
      element.year == today.year &&
      element.month == today.month &&
      element.day == today.day);
}


//prepare dataset
Map<DateTime, int> prepareDataset(List<Habit> habits){
  Map<DateTime,int> datasets = {};

  for(var habit in habits){
    for(var date in habit.completedDays){
      final normalizeDate = DateTime(date.year, date.month, date.day);

      //if already exists in dataset , increment its count
      if(datasets.containsKey(normalizeDate)){
        datasets[normalizeDate] = datasets[normalizeDate]! +1;
      }else{
        datasets[normalizeDate] =1;
      }
    }
  }
  return datasets;
}
