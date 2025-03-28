part of 'theme_cubit.dart';

@immutable
sealed class ThemeState extends Equatable {
  final ThemeData themeData;
  final bool isDarkMode;
  final bool hasThemeChosen;

  const ThemeState({
    required this.themeData,
    required this.isDarkMode,
    required this.hasThemeChosen,
  });

  @override
  List<Object> get props => [themeData, isDarkMode, hasThemeChosen];
}

class ThemeStateInit extends ThemeState {
  ThemeStateInit()
      : super(
          themeData: AppThemes.appLightTheme(),
          isDarkMode: false,
          hasThemeChosen: false,
        );
}

class ThemeChangedState extends ThemeState {
  const ThemeChangedState({
    required super.themeData,
    required super.isDarkMode,
    required super.hasThemeChosen,
  });
}
