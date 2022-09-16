import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'TDL_provider.dart';

void main() => runApp(const TaskApp());

class Task {
  Task({required this.name, required this.checked});
  final String name;
  bool checked;
}

class TaskList extends StatefulWidget {
  const TaskList({Key? key}) : super(key: key);

  get checked => null;

  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  final TextEditingController _textFieldController = TextEditingController();
  final List<Task> _Tasks = <Task>[];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Task manager: TIG333'),
        backgroundColor: const Color.fromARGB(255, 0, 0, 0),
        actions: <Widget>[
          PopupMenuButton<String>(
            onSelected: (value) {
              setState(() {
                Provider.of<TaskProvider>(context, listen: false)
                    .setFilterBy(value);
              });
            },
            itemBuilder: (context) => [
              const PopupMenuItem(child: Text('Show all'), value: 'all'),
              const PopupMenuItem(child: Text('Dont show all'), value: 'not'),
              const PopupMenuItem(child: Text('Show all'), value: 'Done')
            ],
          )
        ],
      ),
      body: ListView(
        padding: const EdgeInsets.symmetric(vertical: 6.0),
        children: _Tasks.map((Task todo) {
          return TodoItem(
            todo: todo,
            onTodoChanged: _handleTodoChange,
          );
        }).toList(),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () => _displayDialog(),
          tooltip: 'Add task',
          backgroundColor: const Color.fromARGB(255, 0, 0, 0),
          child: const Icon(Icons.add)),
    );
  }

  void _handleTodoChange(Task todo) {
    setState(() {
      todo.checked = !todo.checked;
    });
  }

  void _addTodoItem(String name) {
    setState(() {
      _Tasks.add(Task(name: name, checked: false));
    });
    _textFieldController.clear();
  }

  Future<void> _displayDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Add task'),
          content: TextField(
            controller: _textFieldController,
            decoration:
                const InputDecoration(hintText: 'What would you like to do?'),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('discontinue'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: const Text('Add'),
              onPressed: () {
                Navigator.of(context).pop();
                _addTodoItem(_textFieldController.text);
              },
            )
          ],
        );
      },
    );
  }
}

Widget deleteButton(BuildContext context, todo, String name) {
  return IconButton(
    icon: const Icon(Icons.delete_outline),
    tooltip: "Delete",
    onPressed: () => showDialog<String>(
      context: context,
      builder: (BuildContext context) => AlertDialog(
        title: const Text('Warning'),
        content: Text("Do you want to delete '$name'?"),
        actions: <Widget>[
          TextButton(
            onPressed: () => Navigator.pop(context, 'Cancel'),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              Provider.of<TaskProvider>(context, listen: false)
                  .removeTask(todo);
              Navigator.pop(context);
            },
            child: const Text('OK'),
          ),
        ],
      ),
    ),
  );
}

class TodoItem extends StatelessWidget {
  TodoItem({
    required this.todo,
    required this.onTodoChanged,
  }) : super(key: ObjectKey(todo));

  final Task todo;
  final onTodoChanged;

  TextStyle? _getTextStyle(bool checked) {
    if (!checked) return null;

    return const TextStyle(
      color: Color.fromARGB(115, 0, 0, 0),
      decoration: TextDecoration.lineThrough,
    );
  }

  @override
  Widget build(BuildContext context) {
    return StatefulBuilder(
        builder: (BuildContext context, StateSetter setState) {
      return Card(
          child: CheckboxListTile(
        title: Text(todo.name, style: _getTextStyle(todo.checked)),
        value: todo.checked,
        secondary: deleteButton(context, todo, todo.name),
        onChanged: (newValue) {
          onTodoChanged(todo);
        },
        controlAffinity: ListTileControlAffinity.leading,
      ));
    });
  }
}

class TaskApp extends StatelessWidget {
  const TaskApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      title: 'TIG333:',
      home: TaskList(),
    );
  }
}
