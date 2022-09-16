import 'package:template/task.dart';
import 'package:flutter/cupertino.dart';

class TaskProvider extends ChangeNotifier {
  final List<Tasks> _name = [];
  String _filterBy = 'all';
  List<Tasks> get getName {
    return _name;
  }

  String get filterBy => _filterBy;

  void setFilterBy(String filterBy) {
    _filterBy = filterBy;
    notifyListeners();
  }

  void updateAll(bool check) {
    for (var a in _name) {
      a.checked = check;
    }
    notifyListeners();
  }

  void addTask(String name, bool checked) {
    Tasks todo = Tasks(name, checked);

    _name.add(todo);

    notifyListeners();
  }

  void removeTask(Tasks todo) {
    _name.remove(todo);
  }

  bool checkAllMarked() {
    bool value = false;
    if (_name.every((element) => element.checked == false)) {
      value = false;
    }
    if (_name.every((element) => element.checked == true)) {
      value = true;
    }
    return value;
  }
}
