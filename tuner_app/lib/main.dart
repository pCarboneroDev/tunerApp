import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tuner_app/core/theme/app_theme.dart';
import 'package:tuner_app/di/get_it.dart';
import 'package:tuner_app/domain/entities/theme_entity.dart';
import 'package:tuner_app/presentation/settings/bloc/settings_bloc.dart';
import 'package:tuner_app/presentation/splash_screen/bloc/splash_screen_bloc.dart';
import 'package:tuner_app/presentation/splash_screen/ui/splash_screen_page.dart';
import 'package:tuner_app/presentation/tuner/bloc/tuner_bloc.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await init();

  runApp(MultiBlocProvider(
    providers: [
      BlocProvider(
        create: (context) => SplashScreenBloc()
      ),
      BlocProvider(
        create: (context) => getIt<SettingsBloc>()..add(GetThemeEvent()),
      ),
      BlocProvider(
        create: (context) => TunerBloc()
      )
    ],
    child: MyApp(),
  )); 
}

class MyApp extends StatelessWidget {

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<SettingsBloc, SettingsState>(
      builder: (context, state) {
        return FutureBuilder(
          future: AppTheme.getTheme(state.themeEntity.theme == ThemeType.dark),
          builder: (context, asyncSnapshot) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: 'Flutter Demo',
              theme: asyncSnapshot.data,
              home: SplashScreenPage(),
            );
          }
        );
      },
    );
  }
}

