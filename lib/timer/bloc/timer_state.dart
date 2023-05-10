import 'package:equatable/equatable.dart';

abstract class TimerState extends Equatable {
  final int duration;
  TimerState(this.duration);

  @override
  List<Object> get props => [duration];
}

class TimerInitial extends TimerState {
  TimerInitial(super.duration);

  @override
  String toString() => 'TimerInitial { duration: $duration }';
}

class TimerRunPause extends TimerState {
  TimerRunPause(super.duration);

  @override
  String toString() => 'Timer Run Puase {duration: $duration}';
}

class TimerRunInProgress extends TimerState {
  TimerRunInProgress(super.duration);

  @override
  String toString() => 'Timer Run In Progress {duration: $duration}';
}

class TimerRunComplete extends TimerState {
  TimerRunComplete() : super(0);
}
