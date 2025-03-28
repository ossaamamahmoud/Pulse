import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pulse/core/constants/app_strings.dart';
import 'package:pulse/core/constants/constants.dart';
import 'package:pulse/core/widgets/app_elevated_button.dart';
import 'package:pulse/features/theme/presentation/cubit/theme_cubit.dart';

import '../../../../core/routing/routes.dart';
import '../../../../core/theming/app_styles.dart';

class ThemeStartupScreen extends StatelessWidget {
  const ThemeStartupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(AppStrings.appName),
        automaticallyImplyLeading: false,
      ),
      body: Center(
        child: Padding(
          padding: EdgeInsets.all(appHorizontalPadding),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            spacing: 50.h,
            children: [
              Text(
                AppStrings.chooseThemeMode,
                style: TextStyles.font24Bold,
              ),
              AppElevatedButton(
                buttonPrefixWidget: appLightModeIcon,
                buttonText: AppStrings.themeLightMode,
                onPressed: () {
                  context.read<ThemeCubit>().setTheme(false);
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    Routes.authStartupScreen,
                    (route) => false, // Remove all previous routes
                  );
                },
              ),
              AppElevatedButton(
                buttonPrefixWidget: appDarkModeIcon,
                buttonText: AppStrings.themeDarkMode,
                onPressed: () {
                  context.read<ThemeCubit>().setTheme(true);
                  Navigator.pushNamedAndRemoveUntil(
                    context,
                    Routes.authStartupScreen,
                    (route) => false,
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
