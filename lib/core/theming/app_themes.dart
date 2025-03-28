import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../constants/app_strings.dart';
import '../constants/constants.dart';
import 'app_colors.dart';
import 'app_styles.dart';

class AppThemes {
  AppThemes._();

  static ThemeData appDarkTheme() {
    final ThemeData base = ThemeData.dark();
    return base.copyWith(
      primaryColor: AppColors.darkThemeWhite,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColors.darkThemeScaffoldBg,
        centerTitle: true,
        elevation: 0,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppColors.darkThemeScaffoldBg,
          statusBarIconBrightness: Brightness.light,
        ),
        titleTextStyle: TextStyles.font24Bold.copyWith(
          color: AppColors.darkThemeWhite,
        ),
      ),
      scaffoldBackgroundColor: AppColors.darkThemeScaffoldBg,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(AppColors.darkThemeWhite),
          foregroundColor: WidgetStateProperty.all(
            AppColors.darkThemeScaffoldBg,
          ), // ✅ Controls text color
          side: WidgetStateProperty.all(
            const BorderSide(
              color: AppColors.darkThemeScaffoldBg,
            ),
          ),
          textStyle: WidgetStateProperty.all(
            TextStyles.font16semiBold,
          ),
          minimumSize: WidgetStateProperty.all(
            appElevatedButtonSize,
          ),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(
                12.r,
              ),
            ),
          ),
        ),
      ),
      iconTheme: IconThemeData(
        size: appIconSize,
        color: AppColors.darkThemeWhite,
      ),
      textTheme: base.textTheme.apply(
        bodyColor: AppColors.darkThemeWhite,
        displayColor: AppColors.darkThemeWhite,
        fontFamily: AppStrings.appFontFamily,
      ),
    );
  }

  static ThemeData appLightTheme() {
    final ThemeData base = ThemeData.light();
    return base.copyWith(
      primaryColor: AppColors.lightThemeBlack,
      appBarTheme: AppBarTheme(
        centerTitle: true,
        backgroundColor: AppColors.lightThemeScaffoldBg,
        systemOverlayStyle: const SystemUiOverlayStyle(
          statusBarColor: AppColors.lightThemeScaffoldBg,
          statusBarIconBrightness: Brightness.dark,
        ),
        elevation: 0,
        titleTextStyle: TextStyles.font24Bold.copyWith(
          color: AppColors.lightThemePurple,
        ),
      ),
      scaffoldBackgroundColor: AppColors.lightThemeScaffoldBg,
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(
            AppColors.lightThemeScaffoldBg,
          ),
          foregroundColor: WidgetStateProperty.all(
            AppColors.lightThemeBlack,
          ), // ✅ Controls text color
          textStyle: WidgetStateProperty.all(TextStyles.font16semiBold),
          minimumSize: WidgetStateProperty.all(appElevatedButtonSize),
          shape: WidgetStateProperty.all(
            RoundedRectangleBorder(borderRadius: BorderRadius.circular(12.r)),
          ),
        ),
      ),
      textTheme: base.textTheme.apply(
        bodyColor: AppColors.lightThemeBlack,
        displayColor: AppColors.lightThemeBlack,
        fontFamily: AppStrings.appFontFamily,
      ),
      iconTheme: IconThemeData(
        size: appIconSize,
        color: AppColors.lightThemePurple,
      ),
      indicatorColor: AppColors.lightThemePurple,
      textButtonTheme: TextButtonThemeData(
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(
            AppColors.lightThemeScaffoldBg,
          ),
          foregroundColor: WidgetStateProperty.all(
            AppColors.lightThemePurple,
          ), // ✅ Controls text color
          textStyle: WidgetStateProperty.all(TextStyles.font13SemiBold),
        ),
      ),
    );
  }
}
