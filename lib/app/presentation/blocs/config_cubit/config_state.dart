part of 'config_cubit.dart';

class ConfigState extends Equatable {
  final ThemeState themeState;

  const ConfigState({
    this.themeState = ThemeState.lightTheme,
  });

  ConfigState copyWith({
    ThemeState? themeState,
  }) {
    return ConfigState(
      themeState: themeState ?? this.themeState,
    );
  }

  @override
  List<Object> get props => [themeState];
}
