abstract class Task {
  const Task();
}

abstract class TimeTask extends Task {
  final int currentMinutes;
  final int currentSeconds;

  const TimeTask(this.currentMinutes, this.currentSeconds);
}

class BeginTask extends TimeTask {
  const BeginTask(int currentMinutes, int currentSeconds)
      : super(currentMinutes, currentSeconds);
}

class EndTask extends TimeTask {
  const EndTask(int currentMinutes, int currentSeconds)
      : super(currentMinutes, currentSeconds);
}

class FinishedTask extends Task {
  const FinishedTask();
}

//-----------------------------------------

