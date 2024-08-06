import 'package:flutter/material.dart';
import 'package:habittrackker/database/habit_database.dart';
import 'package:habittrackker/screens/homepage.dart';
import 'package:habittrackker/screens/theme/theme_provider.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //initialize database
  await HabitDatabase.initialize();
  await HabitDatabase().saveFirstLaunchDate();

  runApp(
    MultiProvider(
      providers: [
        //habit provider
        ChangeNotifierProvider(create: (context) => HabitDatabase()),

        //theme provider
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(),
        )
      ],child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Homepage(),
      title: 'Habbit tracker',
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
