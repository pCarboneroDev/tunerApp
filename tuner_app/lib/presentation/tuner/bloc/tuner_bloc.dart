import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';

part 'tuner_event.dart';
part 'tuner_state.dart';

class TunerBloc extends Bloc<TunerEvent, TunerState> {

  static const recordChannel = MethodChannel('com.example.recordAudio');


  TunerBloc() : super(TunerState(isRecording: false, hzFound: 0.0)) {
    on<TunerEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<OnToggleRecordingEvent>((event, emit) async {
      emit(state.copyWith(isRecording: !state.isRecording));

      var freq = state.hzFound;

      if (state.isRecording){
        freq = await recordChannel.invokeMethod('startAudioRecord', [state.isRecording]);
      }
      else{
        await recordChannel.invokeMethod('stopAudioRecord');
      }


    });
  }
}
