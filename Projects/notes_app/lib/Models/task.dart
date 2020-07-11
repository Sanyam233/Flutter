
//model for tasks
import 'package:flutter/material.dart';

class Tasks {
  String title;
  String taskId;
  bool completed;
  bool important;
  TimeOfDay dealLine;
  String notes;
  DateTime retrivalId;
  String username;
  

  Tasks(
      {
      this.title,
      this.taskId,
      this.completed,
      this.important,
      this.dealLine,
      this.notes,
      this.retrivalId,
      @required this.username});
}

