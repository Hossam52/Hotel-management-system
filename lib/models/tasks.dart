abstract class Task {
  const Task();
  String getText();
  String getImagePath();
}

abstract class TimeTask extends Task {
  final int currentMinutes;
  final int currentSeconds;

  const TimeTask(this.currentMinutes, this.currentSeconds);
}

abstract class ActiveTask extends TimeTask {
  const ActiveTask(int currentMinutes, int currentSeconds)
      : super(currentMinutes, currentSeconds);
  @override
  String getImagePath() {
    return 'assets/images/icons/timer.svg';
  }
}

abstract class PendingTask extends TimeTask {
  const PendingTask(int currentMinutes, int currentSeconds)
      : super(currentMinutes, currentSeconds);
  @override
  String getImagePath() {
    return 'assets/images/icons/pending.svg';
  }
}

class FinishedTask extends Task {
  const FinishedTask();

  @override
  String getText() {
    return '';
  }

  @override
  String getImagePath() {
    return 'assets/images/icons/completed.svg';
  }
}

class LateTasks extends Task {
  const LateTasks();

  @override
  String getText() {
    return '';
  }

  @override
  String getImagePath() {
    return 'assets/images/icons/completed.svg';
  }
}

// Supervisor -----------------------------------------

class ActiveSupervisorTask extends ActiveTask {
  const ActiveSupervisorTask(int currentMinutes, int currentSeconds)
      : super(currentMinutes, currentSeconds);

  @override
  String getText() {
    return 'Start task';
  }
}

class PendingSupervisorTask extends PendingTask {
  const PendingSupervisorTask(int currentMinutes, int currentSeconds)
      : super(currentMinutes, currentSeconds);

  @override
  String getText() {
    return 'End task';
  }
}

// Employee -------------------------------------

class ActiveEmployeeTask extends ActiveTask {
  const ActiveEmployeeTask(int currentMinutes, int currentSeconds)
      : super(currentMinutes, currentSeconds);

  @override
  String getText() {
    return 'Start task';
  }
}

class PendingEmployeeTask extends PendingTask {
  const PendingEmployeeTask(int currentMinutes, int currentSeconds)
      : super(currentMinutes, currentSeconds);

  @override
  String getText() {
    return 'End Task';
  }
}
