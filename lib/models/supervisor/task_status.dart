class TaskStatus {
  final int minutes;
  final int seconds;

  TaskStatus(this.minutes, this.seconds);
}

class NotStartTask extends TaskStatus {
  NotStartTask(int minutes, int seconds) : super(minutes, seconds);
}

class AssignedTask extends TaskStatus {
  AssignedTask(int minutes, int seconds) : super(minutes, seconds);
}
