import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MyHabittile extends StatelessWidget {
  final String text;
  final bool iscompleted;
  final void Function(bool?)? onchanged;
  final void Function(BuildContext)? editHabit;
  final void Function(BuildContext)? deleteHabit;

  const MyHabittile(
      {super.key,
      required this.iscompleted,
      required this.text,
      required this.onchanged,
      required this.editHabit,
      required this.deleteHabit});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 5, horizontal: 25),
      child: Slidable(
        endActionPane: ActionPane(motion: const StretchMotion(), children: [
          //edit
          SlidableAction(
            onPressed: editHabit,
            backgroundColor: Colors.green,
            icon: Icons.settings,
            borderRadius: BorderRadius.circular(8),
          ),
          //Delete
          SlidableAction(
            onPressed: deleteHabit,
            backgroundColor: Color.fromARGB(255, 190, 4, 4),
            icon: Icons.delete,
            borderRadius: BorderRadius.circular(8),
          )
        ]),
        child: GestureDetector(
          onTap: () {
            if (onchanged != null) {
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
            child: ListTile(
              title: Text(text),
              leading: Checkbox(
                activeColor: Colors.purple,
                onChanged: onchanged,
                value: iscompleted,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
