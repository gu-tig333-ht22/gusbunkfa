import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'TaskList.dart';
import 'SecondView.dart';
import 'model.dart';

void main() {
  var state = MyState();

  runApp(
    ChangeNotifierProvider(create: (context) => state, child: const TaskApp()),
  );
}

class TaskApp extends StatelessWidget {
  const TaskApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'TDL-2022',
      theme: ThemeData.dark(),
      home: const MyHomeView(title: 'Att göra-lista'),
      debugShowCheckedModeBanner: false,
    );
  }
}

class MyHomeView extends StatefulWidget {
  const MyHomeView({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomeView> createState() => _MyHomeViewState();
}

class _MyHomeViewState extends State<MyHomeView> {
  @override
  Widget build(BuildContext context) => Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          title: const Text("Att göra-lista"),
          centerTitle: true,
          actions: [
            PopupMenuButton(
                onSelected: (String value) {
                  Provider.of<MyState>(context, listen: false).filter(value);
                },
                itemBuilder: (context) => [
                      const PopupMenuItem(
                          value: 'Alla', child: Text('Visa alla')),
                      const PopupMenuItem(
                          value: 'Klar', child: Text('Visa klara')),
                      const PopupMenuItem(
                          value: 'Inte', child: Text('Visa inte klara'))
                    ]),
          ],
        ),
        body: Consumer<MyState>(
            builder: (context, state, child) =>
                TaskList(filterList: _filterList(state.list, state.filterBy))),
        floatingActionButton: FloatingActionButton(
          backgroundColor: Colors.grey,
          child: const Icon(
            Icons.add,
          ),
          onPressed: () async {
            var newtask = await Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => SecondView(TaskItemState(
                          title: '',
                        ))));
            if (newtask != null) {
              Provider.of<MyState>(context, listen: false).addtask(newtask);
            }
          },
        ),
      );

  List<TaskItemState> _filterList(List<TaskItemState> list, String filterBy) {
    List<TaskItemState> filteredList = [];
    filteredList.clear();

    if (filterBy == "Klar") {
      list.forEach((TaskItemState element) {
        if (element.value == true) {
          filteredList.add(element);
        }
      });
      return filteredList;
    }

    if (filterBy == "Inte") {
      for (var element in list) {
        if (element.value == false) {
          filteredList.add(element);
        }
      }
      return filteredList;
    }
    return list;
  }
}
