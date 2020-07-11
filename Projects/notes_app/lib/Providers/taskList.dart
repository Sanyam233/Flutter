//class to modify task lists
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:notes_app/Models/http_error_generator.dart';

import '../Models/task.dart';

class TaskList extends ChangeNotifier {
  final String token;
  final oldTasklist;
  final String userId;
  final String userName;
  String newUserName;

  TaskList(
      {@required this.token, this.oldTasklist, this.userId, this.userName});

  //private task list that cannot be manipulated from the outside
  List<Tasks> _filteredTaskList = [];
  List userLocation = [];
  DateTime __dateTime = DateTime(
      int.parse(DateFormat.y().format(DateTime.now())),
      int.parse(
        DateFormat.M().format(DateTime.now()),
      ),
      int.parse(DateFormat.d().format(DateTime.now())));

  List<Tasks> _taskList = [];

  Future<void> fetchData() async {
    final url =
        'https://todoapp-5fac0.firebaseio.com/tasks.json?auth=$token&orderBy="userId"&equalTo="$userId"';

    final response = await http.get(url);

    List<Tasks> taskList = [];

    final formatJsonProduct =
        json.decode(response.body) as Map<String, dynamic>;

    formatJsonProduct.forEach((key, task) {
      taskList.add(
        Tasks(
            retrivalId: DateTime.parse(task["retrivalId"]),
            title: task["title"],
            notes: task["notes"],
            important: task["important"],
            taskId: key,
            completed: task["completed"],
            dealLine: task["deadline"],
            username: task["username"]),
      );
    });

    _taskList = taskList;

    filterTaskListMethod(DateTime(
        int.parse(DateFormat.y().format(DateTime.now())),
        int.parse(DateFormat.M().format(DateTime.now())),
        int.parse(DateFormat.d().format(DateTime.now()))));

    notifyListeners();
  }

  Future<void> addTask(Tasks task, DateTime dateTime) async {
    final url = 'https://todoapp-5fac0.firebaseio.com/tasks.json?auth=$token';
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            "retrivalId": task.retrivalId.toIso8601String(),
            "title": task.title,
            "notes": task.notes,
            "important": task.important,
            "completed": task.completed,
            "dealLine": null,
            "userId": userId,
            "username": userName
          },
        ),
      );
      final newTask = Tasks(
          retrivalId: task.retrivalId,
          title: task.title,
          notes: task.notes,
          important: task.important,
          taskId: json.decode(response.body)["name"],
          completed: task.completed,
          dealLine: task.dealLine,
          username: task.username);

      _taskList.add(newTask);
    } catch (error) {
      throw error;
    }

    if (dateTime != __dateTime) {
      if (_filteredTaskList.isNotEmpty) {
        _filteredTaskList = [];
      }

      _taskList.forEach(
        (item) {
          if (item.retrivalId.compareTo(dateTime) == 0) {
            _filteredTaskList.add(item);
          }
        },
      );
    } else {
      filterTaskListMethod(__dateTime);
    }
  }

  void filterTaskListMethod(DateTime dateTime) {
    if (_filteredTaskList.isNotEmpty) {
      _filteredTaskList = [];
    }

    _taskList.forEach(
      (item) {
        if (item.retrivalId.compareTo(dateTime) == 0) {
          _filteredTaskList.add(item);
        }
      },
    );
    notifyListeners();
  }

  void initalTaskListMethod(DateTime dateTime) {
    _taskList.forEach(
      (item) {
        if (item.retrivalId.compareTo(dateTime) == 0) {
          _filteredTaskList.add(item);
        }
      },
    );
  }

  void refreshTaskListMethod() {
    if (_filteredTaskList.isNotEmpty) {
      _filteredTaskList = [];

      notifyListeners();
    }
  }

  Future<void> deleteTask(String id, DateTime dateTime) async {
    final url =
        'https://todoapp-5fac0.firebaseio.com/tasks/$id.json?auth=$token';

    final response = await http.delete(url);

    int taskIndex = _taskList.indexWhere((task) => task.taskId == id);

    var copyTask = _taskList[taskIndex];

    _taskList.removeAt(taskIndex);

    filterTaskListMethod(dateTime);

    if (response.statusCode >= 400) {
      _taskList.insert(taskIndex, copyTask);
      throw (HttpErrorGenerator(errorMessage: "Task couldn't be deleted"));
    } else {
      copyTask = null;
    }
  }

  void markComplete(String id, DateTime dateTime) {
    int taskIndex = _taskList.indexWhere((task) => task.taskId == id);

    _taskList[taskIndex].completed = !_taskList[taskIndex].completed;

    if (_taskList[taskIndex].completed) {
      deleteTask(id, dateTime);
    }
  }

  void updateDeadline(String id, DateTime dateTime, TimeOfDay deadline) {
    int taskIndex = _taskList.indexWhere((task) => task.taskId == id);

    if (taskIndex >= 0) {
      _taskList[taskIndex].dealLine = deadline;
    } else {
      print("...");
    }

    notifyListeners();
  }

  //getter for task list
  List<Tasks> get taskList => [..._taskList];
  List<Tasks> get filterTaskList => [..._filteredTaskList];
}
