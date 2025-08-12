part of 'tuner_bloc.dart';

abstract class TunerEvent {}

class OnToggleRecordingEvent implements TunerEvent {}

class OnFrequencyReceivedEvent extends TunerEvent {
  final double frequency;
  OnFrequencyReceivedEvent(this.frequency);
}
