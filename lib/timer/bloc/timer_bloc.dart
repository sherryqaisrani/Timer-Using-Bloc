import 'dart:async';

import 'package:bloc/bloc.dart';

import 'package:timer_with_bloc/timer/bloc/timer_event.dart';
import 'package:timer_with_bloc/timer/bloc/timer_state.dart';
import 'package:timer_with_bloc/timer/ticker.dart';

class TimerBloc extends Bloc<TimerEvent, TimerState> {
  final Ticker _ticker;
  static const int _duration = 60;
  StreamSubscription<int>? _tickerSubscription;

  TimerBloc({required Ticker ticker})
      : _ticker = ticker,
        super(TimerInitial(_duration)) {
    on<TimerStarted>(_onStarted);
    on<TimerPaused>(_onPaused);
     on<TimerResumed>(_onResumed);
     on<TimerReset>(_onReset);
    on<TimerTicked>(onTicked);
  }

    @override
  Future<void> close() {
    _tickerSubscription?.cancel();
    return super.close();
  }

void _onStarted(TimerStarted event, Emitter<TimerState> emit) {
    emit(TimerRunInProgress(event.duration));
    _tickerSubscription?.cancel();
    _tickerSubscription = _ticker
        .tick(ticks: event.duration)
        .listen((duration) => add(TimerTicked(duration: duration)));
  }

  void onTicked(TimerTicked event, Emitter<TimerState> emit) {
    emit(event.duration > 0
        ? TimerRunInProgress(event.duration)
        : TimerRunComplete());
  }

  void _onPaused(TimerPaused event, Emitter<TimerState> emit) {
    if (state is TimerRunInProgress) {
      _tickerSubscription!.pause();
      emit(TimerRunPause(state.duration));
    }
  }

   void _onResumed(TimerResumed resume, Emitter<TimerState> emit) {
    if (state is TimerRunPause) {
      _tickerSubscription?.resume();
      emit(TimerRunInProgress(state.duration));
    }
  }
   void _onReset(TimerReset event, Emitter<TimerState> emit) {
    _tickerSubscription?.cancel();
    emit( TimerInitial(_duration));
  }
}
