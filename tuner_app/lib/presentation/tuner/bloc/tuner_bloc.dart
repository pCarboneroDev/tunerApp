import 'dart:async';
import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:tuner_app/domain/entities/music_note.dart';
import 'package:tuner_app/domain/entities/tuning.dart';
import 'package:tuner_app/domain/entities/ui_state.dart';

part 'tuner_event.dart';
part 'tuner_state.dart';

class TunerBloc extends Bloc<TunerEvent, TunerState> {

  static const recordChannel = MethodChannel('com.example.recordAudio');

  static const _eventChannel = EventChannel('com.example.recordAudioStream');

  StreamSubscription<double>? _subscription;

  /// Stream de frecuencias detectadas
  static Stream<double> get frequencyStream {
    return _eventChannel.receiveBroadcastStream().map((event) {
      if (event is double) return event;
      if (event is int) return event.toDouble();
      return 0.0;
    });
  }


  TunerBloc() : super(

    TunerState(
      uiState: UIState.idle(),
      isRecording: false, 
      hzFound: 0.0, 
      selectedTuning: Tuning(
        tuningName: "Standard", 
        tuningNotes: []
      ),
      tuningList: []
    )

  ) {

    on<TunerEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<OnToggleRecordingEvent>((event, emit) async {
      emit(state.copyWith(isRecording: !state.isRecording));

      if (state.isRecording){
        recordChannel.invokeMethod('startAudioRecord');

        _subscription = frequencyStream.listen((freq){
          add(OnFrequencyReceivedEvent(freq));
        });

      }
      else{
        await recordChannel.invokeMethod('stopAudioRecord');
        _subscription!.cancel();
        _subscription = null;
      }
    });

    on<OnFrequencyReceivedEvent>((event, emit) {
      emit(state.copyWith(hzFound: event.frequency));
    });

    on<LoadTuningsEvent>((event, emit) {

      emit(state.copyWith(uiState: UIState.loading()));

      final MusicNote e = MusicNote(4, 2);
      final MusicNote A = MusicNote(9, 2);
      final MusicNote D = MusicNote(2, 3);
      final MusicNote G = MusicNote(7, 3);
      final MusicNote B = MusicNote(11, 3);
      final MusicNote E = MusicNote(4, 4);


      final Tuning standardTuning = Tuning(tuningName: 'Standard Tuning', tuningNotes: [e,A,D,G,B,E]);
      final Tuning p1 = Tuning(tuningName: 'Prueba 1', tuningNotes: [e,A,D,G,B,E]);
      final Tuning p3 = Tuning(tuningName: 'Prueba 2', tuningNotes: [e,A,D,G,B,E]);
      final Tuning p2 = Tuning(tuningName: 'Prueba 3', tuningNotes: [e,A,D,G,B,E]);
      final Tuning p4 = Tuning(tuningName: 'Prueba 4', tuningNotes: [e,A,D,G,B,E]);


      final List<Tuning> tuningList = [standardTuning, p1, p4, p3, p2];

      emit(state.copyWith(uiState: UIState.success(), selectedTuning: standardTuning, tuningList: tuningList));
    });

  }
}
