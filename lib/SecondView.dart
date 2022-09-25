import 'package:flutter/material.dart';
import 'model.dart';

class SecondView extends StatefulWidget {
  final TaskItemState taskitem;

  const SecondView(this.taskitem);

  @override
  State<StatefulWidget> createState() {
    return SecondViewState(taskitem);
  }
}

class SecondViewState extends State<SecondView> {
  late String title;

  late TextEditingController textEditingController;

  SecondViewState(TaskItemState taskitem) {
    title = taskitem.title;

    textEditingController = TextEditingController();

    textEditingController.addListener(() {
      setState(() {
        title = textEditingController.text;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    var scaffold = Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.grey,
          leading: IconButton(
            color: Colors.white,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.keyboard_arrow_left_rounded, size: 30),
          ),
          title: Center(
            child: Container(
                alignment: Alignment.center,
                margin: const EdgeInsets.only(right: 30),
                child: const Text(
                  'Att göra-lista',
                  style: TextStyle(color: Colors.white),
                )),
          ),
        ),
        body: _createtask());
    return MaterialApp(
      title: 'TDL-2022',
      theme: ThemeData.dark(),
      home: scaffold,
      debugShowCheckedModeBanner: false,
    );
  }

  _createtask() {
    return Column(children: [
      Container(
        margin: const EdgeInsets.only(left: 25, right: 25, top: 30),
        child: TextField(
          controller: textEditingController,
          decoration: const InputDecoration(
            border: OutlineInputBorder(
              borderSide: BorderSide(color: Colors.white),
            ),
            hintText: 'Vad vill du göra?',
          ),
        ),
      ),
      Container(height: 30),
      ElevatedButton(
          child: const Text("+ Lägg till"),
          onPressed: () {
            Navigator.pop(context, TaskItemState(title: title));
          }),
    ]);
  }
}
