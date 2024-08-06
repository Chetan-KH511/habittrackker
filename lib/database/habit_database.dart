import 'package:flutter/material.dart';
import 'package:habittrackker/datamodel/app_setting.dart';
import 'package:habittrackker/datamodel/habit.dart';
import 'package:isar/isar.dart';
import 'package:path_provider/path_provider.dart';

class HabitDatabase extends ChangeNotifier {
  static late Isar isar;

  /* 

  SETUP 

  */

  //Initialize the database
  static Future<void> initialize() async {
    final dir = await getApplicationDocumentsDirectory();
    isar =
        await Isar.open([HabitSchema, AppsettingSchema], directory: dir.path);
  }

  //save first date
  Future<void> saveFirstLaunchDate() async {
    final existingsetting = await isar.appsettings.where().findFirst();
    if (existingsetting == null) {
      final settings = Appsetting()..firstTimeLaunch = DateTime.now();
      await isar.writeTxn(
        () => isar.appsettings.put(settings),
      );
    }
  }

  //get first date
  Future<DateTime?> getFirstlaunchdate() async {
    final settings = await isar.appsettings.where().findFirst();
    return settings?.firstTimeLaunch;
  }

  /*

  Crud operations

  */

  //List of habits
  final List<Habit> currentHabits = [];
  //Create
  Future<void> addHabit(String name) async {
    //create a new habit
    final newHabit = Habit()..name = name;

    //save it to the database
    await isar.writeTxn(() => isar.habits.put(newHabit));

    //reread fro db
    readHabits();
  }

  //Read
  Future<void> readHabits() async {
    //fetch from db
    List<Habit> fetchedHabits = await isar.habits.where().findAll();

    //give to current habits
    currentHabits.clear();
    currentHabits.addAll(fetchedHabits);

    //update ui
    notifyListeners();
  }

  //Update
  //1.check habit on and off
  Future<void> updateHabitCompletion(int id, bool iscompleted) async {
    final habit = await isar.habits.get(id);

    if (habit != null) {
      await isar.writeTxn(() async {
        if (iscompleted && !habit.completedDays.contains(DateTime.now())) {
          //today
          final today = DateTime.now();

          habit.completedDays.add(
            DateTime(today.year, today.month, today.day),
          );
        } else {
          //remove the current date if marked as not completed
          habit.completedDays.removeWhere((date) =>
              date.year == DateTime.now().year &&
              date.month == DateTime.now().month &&
              date.day == DateTime.now().day);
        }
        //save the updated back to database
        await isar.habits.put(habit);
      });
    }

    //2.UPDATE habit name
    Future<void> updateHabitname(int id, String newName) async {
      final habit = await isar.habits.get(id);

      if (habit != null) {
        //update name
        await isar.writeTxn(() async {
          habit.name = newName;
          //save it back to the database
          await isar.habits.put(habit);
        });
      }
      //re read from db
      readHabits();
    }

    //Delete
    Future<void> deleteHabit(int id)async{
      //perform the delete
      await isar.writeTxn(() async{
        await isar.habits.delete(id);
      });

      ///re read
      readHabits();
    }
  }
}
