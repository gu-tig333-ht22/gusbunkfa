import 'package:flutter/material.dart';

class TodoItem {
  String label;
  bool isDone;

  TodoItem({required this.label, required this.isDone});
}

class MyState extends ChangeNotifier {
  List<TodoItem> _list = [];
  String _filterBy = 'all';

  List<TodoItem> get list => _list;
  String get filterBy => _filterBy;

  void addItem(TodoItem item) {
    _list.add(item);
    notifyListeners();
  }

  void removeItem(TodoItem item) {
    _list.remove(item);
    notifyListeners();
  }

  void setIsDone(TodoItem item) {
    item.isDone = !item.isDone;
    notifyListeners();
  }

  void setFilterBy(String filterBy) {
    this._filterBy = filterBy;
    notifyListeners();
  }
}
