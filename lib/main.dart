import 'package:flutter/material.dart';
import 'package:habittrackker/screens/homepage.dart';
import 'package:habittrackker/screens/theme/dark.dart';
import 'package:habittrackker/screens/theme/ligh.dart';
import 'package:habittrackker/screens/theme/theme_provider.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => ThemeProvider(),
    child: const MyApp(),
  ));
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
