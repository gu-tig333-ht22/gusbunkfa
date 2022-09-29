// ignore: file_names
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:template/model.dart';

class TaskList extends StatefulWidget {
  final List<TaskItemState> filterList;

  const TaskList({super.key, required this.filterList});

  @override
  State<TaskList> createState() => _CreateListState();
}

class _CreateListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    return ListView(
        children: widget.filterList
            .map((taskitem) => _createtaskitem(context, taskitem))
            .toList());
  }

  Widget _createtaskitem(context, TaskItemState taskitem) {
    var checkboxListTile = CheckboxListTile(
      contentPadding: const EdgeInsets.all(10.0),
      controlAffinity: ListTileControlAffinity.leading,
      value: taskitem.done,
      title: Text(taskitem.title,
          style: TextStyle(
              decoration: taskitem.done
                  ? TextDecoration.lineThrough
                  : TextDecoration.none)),
      secondary: IconButton(
          icon: const Icon(Icons.delete),
          onPressed: () {
            Provider.of<MyState>(context, listen: false).removetask(taskitem);
          }),
      onChanged: (bool? value) {
        Provider.of<MyState>(context, listen: false).updatetask(taskitem);
      },
    );
    return checkboxListTile;
  }
}
