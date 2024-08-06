import 'package:flutter/material.dart';

class MyHabittile extends StatelessWidget {
  final String text;
  final bool iscompleted;
  final void Function(bool?)? onchanged;

  const MyHabittile(
      {super.key,
      required this.iscompleted,
      required this.text,
      required this.onchanged});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if(onchanged != null){
          ///toggle completeion status
          onchanged!(!iscompleted);
        }
      },
      child: Container(
        decoration: BoxDecoration(
          color: iscompleted
              ? Colors.purple
              : Theme.of(context).colorScheme.secondary,
          borderRadius: BorderRadius.circular(8),
        ),
        padding: const EdgeInsets.all(12),
        margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
        child: ListTile(
          title: Text(text),
          leading: Checkbox(
            activeColor: Colors.purple,
            onChanged: onchanged,
            value: iscompleted,
          ),
        ),
      ),
    );
  }
}
