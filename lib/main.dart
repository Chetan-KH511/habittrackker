import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:habittrackker/database/habit_database.dart';
import 'package:habittrackker/firebase_options.dart';
import 'package:habittrackker/screens/homepage.dart';
import 'package:habittrackker/screens/theme/theme_provider.dart';
import 'package:habittrackker/signup/signup.dart';
import 'package:provider/provider.dart';
 

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  //initializze with firebase
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform
  );
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
      home: Signup(),
      title: 'Habbit tracker',
      theme: Provider.of<ThemeProvider>(context).themeData,
    );
  }
}
