import 'package:flutter/material.dart';

void main() => runApp(const App());

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TIG169 TODO',
      theme: ThemeData.dark(),
      home: TodoList(),
    );
  }
}

class TodoList extends StatefulWidget {
  const TodoList({super.key});

  @override
  _TodoListState createState() => _TodoListState();
}

class object {
  object({required this.title, required this.outcome});
  String title;
  bool outcome;
}

//ska göras interaktiv
class _TodoListState extends State<TodoList> {
  List<object> items = <object>[
    object(title: 'Matlåda', outcome: false),
    object(title: 'Gym', outcome: false),
    object(title: 'Uni', outcome: false),
    object(title: 'Brygghuset på onsdag', outcome: true),
    object(title: 'meditera', outcome: false),
  ];
  final List<String> _todoList = <String>[];
  final TextEditingController _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('TIG169 TODO')),
      body: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, i) {
          return Card(
            child: ListTile(
              leading: items[i].outcome.toString() == 'true'
                  ? const Icon(Icons.check_box_sharp) //iconbutton()
                  : const Icon(Icons.check_box_outline_blank_outlined),
              onTap: () {},
              title: Text(
                items[i].title,
                style: TextStyle(
                  decoration: items[i].outcome.toString() == 'true'
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
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => SecondView()));
        },
        child: const Icon(Icons.add),
      ),
    );
  }

//ska göras interaktiv
  void _addTodoobject(String title) {
    setState(() {
      _todoList.add(title);
    });
    _textFieldController.clear();
  }

  Widget _buildTodoobject(String title) {
    return ListTile(title: Text(title));
  }
}

class SecondView extends StatelessWidget {
  const SecondView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('TIG169 TODO'),
      ),
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Container(height: 20),
            _todotext(),
            Container(height: 20),
            _symbol(),
          ],
        ),
      ),
    );
  }

  Widget _todotext() {
    return Container(
      margin: const EdgeInsets.only(left: 25, right: 25, top: 30),
      child: const TextField(
        decoration: InputDecoration(
          border: OutlineInputBorder(),
          hintText: 'Vad tänker du göra?',
        ),
      ),
    );
  }

  Widget _symbol() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Icon(Icons.add),
        Column(
          children: const [
            Text('komplettera listan', style: TextStyle(fontSize: 16)),
          ],
        ),
      ],
    );
  }
}
