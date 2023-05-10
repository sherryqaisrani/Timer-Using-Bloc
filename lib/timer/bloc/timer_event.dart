
abstract class TimerEvent {
  const TimerEvent();
}

class TimerStarted extends TimerEvent {
  final int duration;
  TimerStarted(this.duration);
}

class TimerPaused extends TimerEvent {
  const TimerPaused();
}

class TimerResumed extends TimerEvent {
  const TimerResumed();
}

class TimerReset extends TimerEvent {
  const TimerReset();
}

class TimerTicked extends TimerEvent {
  const TimerTicked({required this.duration});
  final int duration;
}
