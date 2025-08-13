import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:tuner_app/domain/entities/ui_state.dart';
import 'package:tuner_app/presentation/tuner/bloc/tuner_bloc.dart';

class TunerPage extends StatefulWidget {
  @override
  State<TunerPage> createState() => _TunerPageState();
}

class _TunerPageState extends State<TunerPage> {


  @override
  void initState() {
    super.initState();
    final provider = BlocProvider.of<TunerBloc>(context);
    provider.add(LoadTuningsEvent());
  }


  @override
  Widget build(BuildContext context) {
    return BlocBuilder<TunerBloc, TunerState>(
      builder: (context, state) {

        final status = <UIStatus, Widget>{
          UIStatus.idle: Center(child: Text("IDLE")),
          UIStatus.error: Center(child: Text("ERROR")),
          UIStatus.loading: Center(child: CircularProgressIndicator.adaptive()),

          UIStatus.success: Scaffold(
            appBar: AppBar(
              toolbarHeight: 100,
              title: TunerHeader(state: state,),
            ),
            body: RecordSwitch(state: state)
          )
        };

        return status[state.uiState.status] ?? Container();  
      },
    );
  }
}

class TunerHeader extends StatelessWidget {
  final TunerState state;
  const TunerHeader({
    super.key,
    required this.state
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Expanded(
          child: DropdownMenu(
            initialSelection: state.selectedTuning,
          
            helperText: state.selectedTuning.getNotes(),
          
            textStyle: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
          
            inputDecorationTheme: InputDecorationTheme(
              helperStyle: TextStyle(fontSize: 15),
              outlineBorder: BorderSide(width: 0)
            ),
            
            dropdownMenuEntries: state.tuningList.map((tuning) => DropdownMenuEntry(value: tuning, label: tuning.tuningName)).toList(),
          ),
        ),
 
        Icon(Icons.add),
      ],
    );
  }
}

class RecordSwitch extends StatelessWidget {
  final TunerState state;

  const RecordSwitch({
    super.key,
    required this.state
  });

  @override
  Widget build(BuildContext context) {
    return Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
    
            children: [
              Text('${state.hzFound}'),
    
              Switch.adaptive(
                value: state.isRecording,
                onChanged: (value) async {
                  final permissionStatus =
                      await Permission.microphone.status; // el error aquí
                  if (permissionStatus == PermissionStatus.granted) {
                    BlocProvider.of<TunerBloc>(
                      context,
                    ).add(OnToggleRecordingEvent());
                  } else {
                    Permission.microphone.request();
                  }
                },
              ),
            ],
          ),
        );
  }
}







/*

Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                children: [
                  Text(
                    state.selectedTuning.tuningName,
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Icon(Icons.arrow_drop_down_sharp),
                ],
              ),
              Text(state.selectedTuning.getNotes(), style: TextStyle(fontSize: 15)),
            ],
          ),

 */
