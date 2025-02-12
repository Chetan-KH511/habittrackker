import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:habittrackker/screens/theme/theme_provider.dart';
import 'package:provider/provider.dart';

class Mydrawer extends StatelessWidget {
  const Mydrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
        backgroundColor: Theme.of(context).colorScheme.surface,
        child: Center(
          child: CupertinoSwitch(
            trackColor: Colors.black,
            thumbColor: Colors.white,
            value: Provider.of<ThemeProvider>(context).isDark,
            onChanged: (value) =>
                Provider.of<ThemeProvider>(context, listen: false).switchTheme(),
          ),
        ),
      );
  }
}