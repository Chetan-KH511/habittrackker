import 'package:flutter/material.dart';
import 'package:habittrackker/database/habit_database.dart';
import 'package:habittrackker/datamodel/habit.dart';
import 'package:habittrackker/screens/functions/drawer.dart';
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
            },child: const Text('Cancel'),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Theme.of(context).colorScheme.tertiary,
      appBar: AppBar(),
      drawer: const Mydrawer(),
      floatingActionButton: FloatingActionButton(
        onPressed: createNewhabit,
        elevation: 10,
        backgroundColor: Theme.of(context).colorScheme.tertiary,
        child: const Icon(Icons.add),
      ),
      body: _buildHabitlist(),
    );
  }


  Widget _buildHabitlist () {
    //habit db
    final habitDatabase = context.watch<HabitDatabase>();

    //current habits
    List<Habit> currentHabits = habitDatabase.currentHabits;

    //return list of habits UI
    return ListView.builder(
      itemCount: currentHabits.length,
      itemBuilder: (context, index) {
        final habit = currentHabits[index];

        bool isCompletedToday = isHabitCompletedToday(habit.completedDays);
        
        return ListTile(title: Text(habit.name),);
       
    },);
  }
}
