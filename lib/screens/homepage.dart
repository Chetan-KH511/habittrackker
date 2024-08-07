import 'package:flutter/material.dart';
import 'package:habittrackker/database/habit_database.dart';
import 'package:habittrackker/datamodel/habit.dart';
import 'package:habittrackker/screens/functions/calendar_show.dart';
import 'package:habittrackker/screens/functions/drawer.dart';
import 'package:habittrackker/screens/functions/habit_tile.dart';
import 'package:habittrackker/screens/functions/habit_util.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  void initState() {
    //read habits on startup
    Provider.of<HabitDatabase>(context, listen: false).readHabits();

    super.initState();
  }

  //text controller for value input
  final TextEditingController textController = TextEditingController();

  void createNewhabit() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: textController,
          decoration: const InputDecoration(
            hintText: "Enter the new habit",
          ),
        ),
        actions: [
          MaterialButton(
            onPressed: () {
              //get new habit name
              String newHabitname = textController.text;

              //save to db
              context.read<HabitDatabase>().addHabit(newHabitname);

              //pop box
              Navigator.pop(context);

              //clear controller
              textController.clear();
            },
            child: const Text("Save"),
          ),
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);

              textController.clear();
            },
            child: const Text('Cancel'),
          )
        ],
      ),
    );
  }

//edit habit on slidable
  void editHabit(Habit habit) {
    //set controllers text to current habit name
    textController.text = habit.name;

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        content: TextField(
          controller: textController,
        ),
        actions: [
          //save
          MaterialButton(
            onPressed: () {
              //get new habit name
              String newHabitname = textController.text;

              //save to db
              context
                  .read<HabitDatabase>()
                  .updateHabitname(habit.id, newHabitname);

              //pop box
              Navigator.pop(context);

              //clear controller
              textController.clear();
            },
            child: const Text("Save"),
          ),
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);

              textController.clear();
            },
            child: const Text('Cancel'),
          )

          //cancel
        ],
      ),
    );
  }

  //delete habit on slidable
  void deleteHabitonSlidable(Habit habit) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text("Do you want to delete this?"),
        actions: [
          MaterialButton(
            onPressed: () {
              //save to db
              context.read<HabitDatabase>().deleteHabit(habit.id);
              //pop box
              Navigator.pop(context);
            },
            child: const Text("Yes"),
          ),
          MaterialButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Cancel'),
          )
        ],
      ),
    );
  }

//check habit on&off
  void checkOnOff(bool? value, Habit habit) {
    //update habit completion status
    if (value != null) {
      context.read<HabitDatabase>().updateHabitCompletion(habit.id, value);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Theme.of(context).colorScheme.surface,
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          foregroundColor: Theme.of(context).colorScheme.inversePrimary,
        ),
        drawer: const Mydrawer(),
        floatingActionButton: FloatingActionButton(
          onPressed: createNewhabit,
          elevation: 10,
          backgroundColor: Theme.of(context).colorScheme.primary,
          child: const Icon(Icons.add),
        ),
        body: ListView(
          children: [_buildCalendarview(), _buildHabitlist()],
        ));
  }

  Widget _buildHabitlist() {
    //habit db
    final habitDatabase = context.watch<HabitDatabase>();

    //current habits
    List<Habit> currentHabits = habitDatabase.currentHabits;

    //return list of habits UI
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: currentHabits.length,
      itemBuilder: (context, index) {
        final habit = currentHabits[index];

        bool isCompletedToday = isHabitCompletedToday(habit.completedDays);

        return MyHabittile(
          iscompleted: isCompletedToday,
          text: habit.name,
          onchanged: (value) => checkOnOff(value, habit),
          editHabit: (context) => editHabit(habit),
          deleteHabit: (context) => deleteHabitonSlidable(habit),
        );
      },
    );
  }

  Widget _buildCalendarview() {
    //habit database
    final habitDatabase = context.watch<HabitDatabase>();
    //current habits
    List<Habit> currentHabits = habitDatabase.currentHabits;

    //return UI from calendaar view
    return FutureBuilder<DateTime?>(
      future: habitDatabase.getFirstlaunchdate(),
      builder: (context, snapshot) {
        if (snapshot.hasData) {
          return MyCalendar(
              startDate: snapshot.data!, data: prepareDataset(currentHabits));
        }else{
          return Container();
        }
      },
    );
  }
}
