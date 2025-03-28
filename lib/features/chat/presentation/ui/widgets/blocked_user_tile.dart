import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pulse/core/theming/app_styles.dart';
import 'package:pulse/features/chat/data/user_model.dart';

import '../../../../../core/di/dependency_injection.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../generated/l10n.dart';
import '../../../../theme/presentation/cubit/theme_cubit.dart';

class BlockedUserTile extends StatelessWidget {
  const BlockedUserTile({
    super.key,
    required this.user,
    required this.onTap,
  });

  final UserModel user;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      color: getIt<ThemeCubit>().state.isDarkMode
          ? AppColors.lightThemeLighterGrey.withOpacity(0.4)
          : AppColors.lightThemeLighterGrey,
      margin: EdgeInsets.symmetric(horizontal: 16.w, vertical: 8.h),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.r),
      ),
      child: ListTile(
        contentPadding: EdgeInsets.all(8.r),
        leading: CircleAvatar(
          radius: 30,
          backgroundColor: getIt<ThemeCubit>().state.isDarkMode
              ? AppColors.lightThemeLighterGrey
              : AppColors.darkThemeWhite,
          child: Text(
            user.name.isNotEmpty
                ? user.name.substring(0, 1).toUpperCase()
                : '-',
            style: TextStyles.font40Bold.copyWith(
              color: AppColors.lightThemePurple,
            ),
          ),
        ),
        title: Text(
          user.name,
          style: TextStyles.font20SemiBold.copyWith(
            color: AppColors.lightThemeBlack,
          ),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          user.email,
          style: TextStyles.font14Regular
              .copyWith(color: AppColors.lightThemeBlack),
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        trailing: TextButton(
          style: ButtonStyle(
            backgroundColor: WidgetStateProperty.all(
              getIt<ThemeCubit>().state.isDarkMode
                  ? AppColors.darkThemeScaffoldBg
                  : AppColors.lightThemeScaffoldBg,
            ),
          ),
          onPressed: onTap,
          child: Text(
            S.of(context).unblock,
            style: TextStyles.font20SemiBold.copyWith(
              color: getIt<ThemeCubit>().state.isDarkMode
                  ? AppColors.lightThemeLighterGrey
                  : AppColors.lightThemePurple,
            ),
          ),
        ),
      ),
    );
  }
}
