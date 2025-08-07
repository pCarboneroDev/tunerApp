import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuner_app/domain/entities/ui_state.dart';
import 'package:tuner_app/presentation/settings/bloc/settings_bloc.dart';


class SettingsPage extends StatefulWidget {

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {

  @override
  void initState() {
    super.initState();
    final bloc = BlocProvider.of<SettingsBloc>(context);
    bloc.add(LoadSettingdEvent());
  }

  @override
  Widget build(BuildContext context) {
    final bloc = BlocProvider.of<SettingsBloc>(context);

    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {

        final status = <UIStatus, Widget>{
          UIStatus.idle: Center(child: Text("IDLE")),
          UIStatus.error: Center(child: Text("ERROR")),
          UIStatus.loading: Center(child: CircularProgressIndicator.adaptive()),
          UIStatus.success: Scaffold(
            appBar: AppBar(
              title: Text('Settings'),
            ),
            body: Center(
              child: FilledButton(
                onPressed: () {
                  print(state.themeEntity.theme);
                  bloc.add(ToggleThemeEvent());
                }, 
                child: Icon(Icons.light_mode)
              ),
            ),
          )
        };
        return status[state.state.status] ?? Container(); 
      },
    );
  }
}