import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:tuner_app/domain/entities/theme_entity.dart';
import 'package:tuner_app/domain/entities/ui_state.dart';
import 'package:tuner_app/domain/params/no_params.dart';
import 'package:tuner_app/domain/usecase/theme/get_theme_usecase.dart';

part 'splash_screen_event.dart';
part 'splash_screen_state.dart';

class SplashScreenBloc extends Bloc<SplashScreenEvent, SplashScreenState> {

  final GetThemeUsecase getThemeUsecase;
  
  SplashScreenBloc(
    this.getThemeUsecase
  ) : super(SplashScreenState(state: UIState.idle(), savedTheme: ThemeType.light)) {
    on<SplashScreenEvent>((event, emit) {
      // TODO: implement event handler
    });

    on<OnLoadTheme>((event, emit) async {
      emit(state.copyWith(state: UIState.loading()));

      var result = await getThemeUsecase.call(NoParams());

      result.fold(
        (failure) => emit(state.copyWith(state: UIState.error(failure.message))), 
        (theme) => emit(state.copyWith(state: UIState.success(), savedTheme: theme.theme))
      );
    });
  }
}
