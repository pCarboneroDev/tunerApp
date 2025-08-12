part of 'tuner_bloc.dart';

class TunerState extends Equatable {
  final bool isRecording;
  final double hzFound;

  const TunerState({
    required this.isRecording,
    required this.hzFound
  });

  TunerState copyWith({
    bool? isRecording,
    double? hzFound
  }) => TunerState(
    isRecording: isRecording ?? this.isRecording,
    hzFound: hzFound ?? this.hzFound
  );

  @override
  List<Object> get props => [isRecording, hzFound];
}

