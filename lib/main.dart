import 'package:flutter/material.dart';

void main() => runApp(App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(title: 'TIG169 TODO', home: TodoList());
  }
}

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class hello1 {
  hello1({required this.title, required this.hej});
  String title;
  bool hej;
}

//ska göras interaktiv
class _TodoListState extends State<TodoList> {
  List<hello1> hello = <hello1>[
    hello1(title: 'Matlåda', hej: false),
    hello1(title: 'Gym', hej: false),
    hello1(title: 'Uni', hej: false),
    hello1(title: 'Brygghuset på onsdag', hej: true),
    hello1(title: 'meditera', hej: false),
  ];
  final List<String> _todoList = <String>[];
  final TextEditingController _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TIG169 TODO')),
      body: ListView.builder(
        itemCount: hello.length,
        itemBuilder: (context, i) {
          return Card(
            child: ListTile(
              leading: hello[i].hej.toString() == 'true'
                  ? const Icon(Icons.check_box_sharp)
                  : const Icon(Icons.check_box_outline_blank_outlined),
              onTap: () {},
              title: Text(
                hello[i].title,
                style: TextStyle(
                  decoration: hello[i].hej.toString() == 'true'
                      ? TextDecoration.lineThrough
                      : TextDecoration.none,
                ),
              ),
              trailing: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.close),
              ),
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {},
        child: const Icon(Icons.add),
      ),
    );
  }

//ska göras interaktiv
  void _addTodohello1(String title) {
    setState(() {
      _todoList.add(title);
    });
    _textFieldController.clear();
  }

  Widget _buildTodohello1(String title) {
    return ListTile(title: Text(title));
  }
}
