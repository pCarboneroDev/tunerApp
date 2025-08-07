import 'package:get_it/get_it.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tuner_app/data/repository_impl/theme_repository_impl.dart';
import 'package:tuner_app/data/shared_preferences/preferences_datasource.dart';
import 'package:tuner_app/domain/repositories/theme_repository.dart';
import 'package:tuner_app/domain/usecase/theme/get_theme_usecase.dart';
import 'package:tuner_app/domain/usecase/theme/save_theme_usecase.dart';
import 'package:tuner_app/presentation/settings/bloc/settings_bloc.dart';

final getIt = GetIt.instance;

Future<void> init() async {
  getIt.registerSingleton(await SharedPreferences.getInstance());

  getIt.registerSingleton(PreferencesDatasource(preferences: getIt()));

  getIt.registerSingleton<ThemeRepository>(ThemeRepositoryImpl(datasource: getIt()));

  getIt.registerSingleton(GetThemeUsecase(repo: getIt()));
  getIt.registerSingleton(SaveThemeUsecase(repo: getIt()));

  getIt.registerSingleton(SettingsBloc(getIt(), getIt()));
}