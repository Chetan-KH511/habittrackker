import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habittrackker/screens/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class Homepage extends StatefulWidget {
  const Homepage({super.key});

  @override
  State<Homepage> createState() => _HomepageState();
}

class _HomepageState extends State<Homepage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      drawer: Drawer(
        backgroundColor: Theme.of(context).colorScheme.surface,
        child: Center(
          child: CupertinoSwitch(
            value: Provider.of<ThemeProvider>(context).isDark,
            onChanged: (value) =>
                Provider.of<ThemeProvider>(context, listen: false).switchTheme(),
          ),
        ),
      ),
    );
  }
}
