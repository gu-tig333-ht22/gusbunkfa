import 'package:flutter/material.dart';

class MyState extends ChangeNotifier {
  final List<TaskItemState> _list = [];

  List<TaskItemState> get list => _list;

  String _filterBy = 'Alla';
  String get filterBy => _filterBy;

  void removetask(TaskItemState taskitem) {
    _list.remove(taskitem);
    notifyListeners();
  }

  void addtask(TaskItemState taskitem) {
    _list.add(taskitem);
    notifyListeners();
  }

  void filter(String filterBy) {
    _filterBy = filterBy;
    notifyListeners();
  }
}

class TaskItemState {
  final String title;
  bool value;

  TaskItemState({
    required this.title,
    this.value = false,
  });
}
