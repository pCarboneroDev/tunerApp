part of 'tuner_bloc.dart';

class TunerState extends Equatable {
  final UIState uiState;
  final bool isRecording;
  final double hzFound;

  final Tuning selectedTuning;
  final List<Tuning> tuningList;

  const TunerState({
    required this.uiState,
    required this.isRecording,
    required this.hzFound,
    required this.selectedTuning,
    required this.tuningList
  });

  TunerState copyWith({
    UIState? uiState,
    bool? isRecording,
    double? hzFound,
    Tuning? selectedTuning,
    List<Tuning>? tuningList
  }) => TunerState(
    uiState: uiState ?? this.uiState,
    isRecording: isRecording ?? this.isRecording,
    hzFound: hzFound ?? this.hzFound,
    selectedTuning: selectedTuning ?? this.selectedTuning,
    tuningList: tuningList ?? this.tuningList
  );

  @override
  List<Object> get props => [uiState, isRecording, hzFound, selectedTuning, tuningList];
}

