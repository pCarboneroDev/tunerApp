part of 'splash_screen_bloc.dart';

class SplashScreenState extends Equatable {
  final UIState state; 
  final ThemeType savedTheme;

  const SplashScreenState({
    required this.state,
    required this.savedTheme
  });

  SplashScreenState copyWith({
    UIState? state,
    ThemeType? savedTheme
  }) => SplashScreenState(
    state: state ?? this.state,
    savedTheme: savedTheme ?? this.savedTheme
  );
  
  @override
  List<Object> get props => [state, savedTheme];
}