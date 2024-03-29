import 'package:easy_localization/easy_localization.dart';

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

abstract class LateTask extends ActiveTask {
  const LateTask(int currentMinutes, int currentSeconds)
      : super(currentMinutes, currentSeconds);
  @override
  String getText() {
    return 'StartTask'.tr();
  }

  @override
  String getImagePath() {
    return 'assets/images/icons/late.svg';
  }
}

// Supervisor -----------------------------------------

class ActiveSupervisorTask extends ActiveTask {
  const ActiveSupervisorTask(int currentMinutes, int currentSeconds)
      : super(currentMinutes, currentSeconds);

  @override
  String getText() {
    return 'StartTask'.tr();
  }
}

class PendingSupervisorTask extends PendingTask {
  const PendingSupervisorTask(int currentMinutes, int currentSeconds)
      : super(currentMinutes, currentSeconds);

  @override
  String getText() {
    return 'EndTask'.tr();
  }
}

class LateSupervisorTask extends LateTask implements ActiveSupervisorTask {
  const LateSupervisorTask(int currentMinutes, int currentSeconds)
      : super(currentMinutes, currentSeconds);
}

// Employee -------------------------------------

class ActiveEmployeeTask extends ActiveTask {
  const ActiveEmployeeTask(int currentMinutes, int currentSeconds)
      : super(currentMinutes, currentSeconds);

  @override
  String getText() {
    return 'StartTask'.tr();
  }
}

class PendingEmployeeTask extends PendingTask {
  const PendingEmployeeTask(int currentMinutes, int currentSeconds)
      : super(currentMinutes, currentSeconds);

  @override
  String getText() {
    return 'EndTask'.tr();
  }
}

class LateEmployeeTask extends LateTask implements ActiveEmployeeTask {
  const LateEmployeeTask(int currentMinutes, int currentSeconds)
      : super(currentMinutes, currentSeconds);
}
