import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/di/dependency_injection.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../core/theming/app_styles.dart';
import '../../../../theme/presentation/cubit/theme_cubit.dart';

class HaveAccountOrNot extends StatelessWidget {
  const HaveAccountOrNot(
      {super.key,
      required this.firstText,
      required this.buttonText,
      required this.onPressed});
  final String firstText;
  final String buttonText;
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          firstText,
          style: TextStyles.font14Regular,
        ),
        TextButton(
          style: ButtonStyle(
            alignment: Alignment.centerLeft,
            padding: WidgetStateProperty.all(
              EdgeInsets.all(8.r),
            ),
          ),
          onPressed: onPressed,
          child: Text(
            buttonText,
            style: TextStyles.font14Bold.copyWith(
              color: getIt<ThemeCubit>().state.isDarkMode
                  ? AppColors.lightThemeBlack
                  : AppColors.lightThemePurple,
            ),
          ),
        ),
      ],
    );
  }
}
