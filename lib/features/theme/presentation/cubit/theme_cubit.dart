import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulse/core/cache/cache_helper.dart';
import 'package:pulse/core/theming/app_themes.dart';

part 'theme_state.dart';

class ThemeCubit extends Cubit<ThemeState> {
  ThemeCubit() : super(ThemeStateInit()) {
    final bool isDarkMode = CacheHelper.getBoolData(key: "isDarkMode") ?? false;
    final bool hasThemeChosen =
        CacheHelper.getBoolData(key: "hasThemeChosen") ?? false;
    emit(ThemeChangedState(
      themeData:
          isDarkMode ? AppThemes.appDarkTheme() : AppThemes.appLightTheme(),
      isDarkMode: isDarkMode,
      hasThemeChosen: hasThemeChosen,
    ));
  }

  void setTheme(bool isDark) async {
    await CacheHelper.setBoolData(key: "isDarkMode", value: isDark);
    await CacheHelper.setBoolData(key: "hasThemeChosen", value: true);
    if (state.isDarkMode == isDark) return;
    emit(
      ThemeChangedState(
        themeData:
            isDark ? AppThemes.appDarkTheme() : AppThemes.appLightTheme(),
        isDarkMode: isDark,
        hasThemeChosen: true,
      ),
    );
  }
}
