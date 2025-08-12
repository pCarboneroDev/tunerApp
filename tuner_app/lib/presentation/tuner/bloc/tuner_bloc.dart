import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';

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


  TunerBloc() : super(TunerState(isRecording: false, hzFound: 0.0)) {

    on<TunerEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<OnToggleRecordingEvent>((event, emit) async {
      emit(state.copyWith(isRecording: !state.isRecording));

      if (state.isRecording){
        recordChannel.invokeMethod('startAudioRecord');

        _subscription = frequencyStream.listen((freq){
          print('$freq');
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

  }
}
