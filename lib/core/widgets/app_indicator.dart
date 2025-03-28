import 'package:flutter/material.dart';

import '../../features/theme/presentation/cubit/theme_cubit.dart';
import '../di/dependency_injection.dart';
import '../theming/app_colors.dart';

class AppIndicator extends StatelessWidget {
  const AppIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return CircularProgressIndicator(
      color: getIt<ThemeCubit>().state.isDarkMode
          ? AppColors.lightThemeBlack
          : AppColors.lightThemePurple,
    );
  }
}
