import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'dart:convert';

class MyState extends ChangeNotifier {
  final List<TaskItemState> _list = [];
  List<TaskItemState> get list => _list;

  String _filterBy = 'Alla';
  String get filterBy => _filterBy;
  String url = 'https://todoapp-api.apps.k8s.gu.se/todos';
  String key = '?key=a0b119ca-ed1f-45fb-aaf3-0028b4cbd019';

  MyState() {
    _fetchTasks();
  }

//load tasks from $url $key
  void _fetchTasks() async {
    http.Response reply = await http.get(Uri.parse('$url$key'));
    if (reply.statusCode == 200) {
      List<dynamic> data = jsonDecode(reply.body);
      updateFetch(data);
      notifyListeners();
    }
  }

  void updateFetch(List<dynamic> data) {
    _list.clear();
    for (var task in data) {
      _list.add(TaskItemState.fromJson(task));
    }
  }

  void addtask(TaskItemState taskitem) async {
    http.Response reply = await http.post(Uri.parse('$url$key'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(taskitem.toJson()));

    if (reply.statusCode == 200) {
      _list.add(taskitem);
      notifyListeners();
      updateFetch(jsonDecode(reply.body));
    }
  }

  void removetask(TaskItemState taskitem) async {
    http.Response reply = await http.delete(
        Uri.parse('$url/${taskitem.id}$key'),
        headers: {'Content-Type': 'application/json'});

    if (reply.statusCode == 200) {
      _list.remove(taskitem);
      notifyListeners();
      updateFetch(jsonDecode(reply.body));
    }
  }

  void updatetask(TaskItemState taskitem) async {
    taskitem.taskDone(taskitem);
    http.Response reply = await http.put(Uri.parse('$url/${taskitem.id}$key'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode(taskitem.toJson()));

    if (reply.statusCode == 200) {
      notifyListeners();
      updateFetch(jsonDecode(reply.body));
    }
  }

  void filter(String filterBy) {
    _filterBy = filterBy;
    notifyListeners();
  }
}

class TaskItemState {
  String id;
  String title;
  bool done;

  TaskItemState({
    required this.id,
    required this.title,
    this.done = false,
  });

  factory TaskItemState.fromJson(Map<String, dynamic> json) {
    return TaskItemState(
      title: json['title'],
      done: json['done'],
      id: json['id'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'done': done,
      'id': id,
    };
  }

  void taskDone(taskitem) {
    done = !done;
  }
}
