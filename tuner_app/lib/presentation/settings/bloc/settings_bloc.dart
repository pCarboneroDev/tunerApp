import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';
import 'package:tuner_app/domain/entities/theme_entity.dart';
import 'package:tuner_app/domain/entities/ui_state.dart';
import 'package:tuner_app/domain/params/no_params.dart';
import 'package:tuner_app/domain/usecase/theme/get_theme_usecase.dart';
import 'package:tuner_app/domain/usecase/theme/save_theme_usecase.dart';

part 'settings_event.dart';
part 'settings_state.dart';

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {

  final GetThemeUsecase getThemeUsecase;
  final SaveThemeUsecase saveThemeUsecase;

  SettingsBloc(
    this.getThemeUsecase,
    this.saveThemeUsecase
  ) : super(SettingsState(state: UIState.idle(), themeEntity: ThemeEntity(theme: ThemeType.light))) {
    on<SettingsEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<GetThemeEvent>((event, emit) async {
      var result = await getThemeUsecase.call(NoParams());

      result.fold(
        (failure) => emit(state.copyWith(state: UIState.error(failure.message))), 
        (theme) => emit(state.copyWith(state: UIState.success(), themeEntity: theme))
      );
    });


    on<ToggleThemeEvent>((event, emit) async {
      var newTheme = state.themeEntity.theme == ThemeType.dark ? ThemeEntity(theme: ThemeType.light) : ThemeEntity(theme: ThemeType.dark);

      var result = saveThemeUsecase.call(newTheme);

      emit(state.copyWith(state: UIState.success(), themeEntity: newTheme));
    });

    on<LoadSettingdEvent>((event, emit) async {
      emit(state.copyWith(state: UIState.success()));
    });
  }
}
