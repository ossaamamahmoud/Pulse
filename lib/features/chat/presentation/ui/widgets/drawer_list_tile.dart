import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/di/dependency_injection.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../core/theming/app_styles.dart';
import '../../../../../core/widgets/get_current_lang.dart';
import '../../../../theme/presentation/cubit/theme_cubit.dart';

class MyListTile extends StatelessWidget {
  const MyListTile(
      {super.key,
      required this.onTap,
      required this.leadingIcon,
      required this.title});
  final VoidCallback onTap;
  final IconData leadingIcon;
  final String title;
  @override
  Widget build(BuildContext context) {
    return ListTile(
      visualDensity: VisualDensity.comfortable,
      onTap: onTap,
      tileColor: getIt<ThemeCubit>().state.isDarkMode
          ? AppColors.darkThemeWhite
          : AppColors.lightThemeLighterGrey,
      leading: Icon(
        leadingIcon,
        size: appIconSize,
        color: AppColors.darkThemeScaffoldBg,
      ),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      title: Padding(
        padding: EdgeInsets.only(left: 8.0.w),
        child: Text(
          title,
          style: TextStyles.font24Bold.copyWith(
            color: AppColors.lightThemeBlack,
          ),
        ),
      ),
      trailing: Icon(
        GetCurrentLang.isArabic()
            ? FontAwesomeIcons.arrowLeft
            : FontAwesomeIcons.arrowRight,
        size: appIconSize,
        color: AppColors.darkThemeScaffoldBg,
      ),
    );
  }
}
