abstract class Task {
  const Task();
  String getText();
}

abstract class TimeTask extends Task {
  final int currentMinutes;
  final int currentSeconds;

  const TimeTask(this.currentMinutes, this.currentSeconds);
}

abstract class ActiveTask extends TimeTask {
  const ActiveTask(int currentMinutes, int currentSeconds)
      : super(currentMinutes, currentSeconds);
}

abstract class PendingTask extends TimeTask {
  const PendingTask(int currentMinutes, int currentSeconds)
      : super(currentMinutes, currentSeconds);
}

class FinishedTask extends Task {
  const FinishedTask();

  @override
  String getText() {
    return '';
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
    return 'Change Assessment';
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
