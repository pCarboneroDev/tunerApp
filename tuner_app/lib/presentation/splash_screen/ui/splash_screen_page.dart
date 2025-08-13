import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuner_app/domain/entities/ui_state.dart';
import 'package:tuner_app/presentation/splash_screen/bloc/splash_screen_bloc.dart';

class SplashScreenPage extends StatefulWidget {
  @override
  State<SplashScreenPage> createState() => _SplashScreenPageState();
}

class _SplashScreenPageState extends State<SplashScreenPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocListener<SplashScreenBloc, SplashScreenState>(
        listenWhen: (previous, current) =>
            previous.state.status != current.state.status,
        listener: (context, state) {
          if (state.state.status == UIStatus.success) {
            Navigator.pushReplacementNamed(context, 'main');
          }
        },
        child: Center(
          child: BlocBuilder<SplashScreenBloc, SplashScreenState>(
            builder: (context, state) {
              final status = <UIStatus, Widget>{
                UIStatus.idle: const Center(child: Text("IDLE")),
                UIStatus.error: const Center(child: Text("ERROR")),
                UIStatus.loading: const Center(child: CircularProgressIndicator.adaptive()),
                UIStatus.success: const Center(child: Text("")),
              };
              return status[state.state.status] ?? Container();
            },
          ),
        ),
      ),
    );
  }
}

