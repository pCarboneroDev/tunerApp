part of 'settings_bloc.dart';


class SettingsState extends Equatable {
  final UIState state;
  final ThemeEntity themeEntity;

  const SettingsState({
    required this.state, 
    required this.themeEntity
  });

  SettingsState copyWith({
    UIState? state,
    ThemeEntity? themeEntity
  }) => SettingsState(
    state: state ?? this.state, 
    themeEntity: themeEntity ?? this.themeEntity
  );

  @override
  List<Object?> get props => [state, themeEntity];

}


