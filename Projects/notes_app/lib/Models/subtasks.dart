class SubTasks {
  final String subTaskName;

  final String subTaskId;

  final bool subCompleted;

  final List<DateTime> subReminders;

  SubTasks(
      {this.subTaskName, this.subTaskId, this.subCompleted, this.subReminders});
}
