part of 'settings_bloc.dart';

@immutable
abstract class SettingsEvent {}

class GetThemeEvent implements SettingsEvent{

}


class ToggleThemeEvent implements SettingsEvent{

}

class LoadSettingdEvent implements SettingsEvent{}
