import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tuner_app/presentation/tuner/bloc/tuner_bloc.dart';

class TunerPage extends StatefulWidget {
  
  @override
  State<TunerPage> createState() => _TunerPageState();
}

class _TunerPageState extends State<TunerPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    Text('Standard Tuning', style: TextStyle(fontWeight: FontWeight.bold),), 
                    Icon(Icons.arrow_drop_down_sharp)
                  ]
                ),
                Text('E2 A2 D3 G3 B3 E4', style: TextStyle(fontSize: 15))
              ],
            ),
            Spacer(),
            Icon(Icons.add)
          ],
        ),

      ),
      body: BlocBuilder<TunerBloc, TunerState>(
        builder: (context, state) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,

              children: [
                Text(state.hzFound.toString()),

                Switch.adaptive(
                  value: state.isRecording, 
                  onChanged: (value) async {
                    final permissionStatus = await Permission.microphone.status; // el error aquí
                    if (permissionStatus == PermissionStatus.granted) {
                      BlocProvider.of<TunerBloc>(context).add(OnToggleRecordingEvent());
                    }
                    else{
                      Permission.microphone.request();
                    }        
                  },
                ),
              ],
            ),
          );
        },
      )
    );
  }
}