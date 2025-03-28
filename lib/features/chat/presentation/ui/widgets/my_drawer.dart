import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pulse/core/helpers/extensions.dart';
import 'package:pulse/features/chat/presentation/ui/widgets/drawer_list_tile.dart';

import '../../../../../core/constants/constants.dart';
import '../../../../../core/di/dependency_injection.dart';
import '../../../../../core/routing/routes.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../core/theming/app_styles.dart';
import '../../../../../core/widgets/show_custom_toast.dart';
import '../../../../../generated/l10n.dart';
import '../../../../auth/presentation/cubit/auth/auth_cubit.dart';
import '../../../../auth/presentation/cubit/auth/auth_state.dart';
import '../../../../theme/presentation/cubit/theme_cubit.dart';

class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      backgroundColor: getIt<ThemeCubit>().state.isDarkMode
          ? AppColors.darkThemeScaffoldBg
          : AppColors.lightThemeScaffoldBg,
      child: Padding(
        padding: EdgeInsets.symmetric(
          horizontal: appHorizontalPadding,
          vertical: drawerVerticalPadding,
        ),
        child: Column(
          spacing: 20.h,
          children: [
            Center(
              child: Text(
                S.of(context).appName,
                style: TextStyles.font40Bold.copyWith(
                  color: getIt<ThemeCubit>().state.isDarkMode
                      ? AppColors.darkThemeWhite
                      : AppColors.lightThemePurple,
                ),
              ),
            ),
            MyListTile(
              onTap: () => context.pop(),
              leadingIcon: FontAwesomeIcons.comments,
              title: S.of(context).drawerChats,
            ),
            MyListTile(
              onTap: () {
                context.pop();
                context.navigateToNamed(
                  Routes.settingsScreen,
                );
              },
              leadingIcon: FontAwesomeIcons.gears,
              title: S.of(context).drawerSettings,
            ),
            BlocListener<AuthCubit, AuthState>(
              listener: (context, state) {
                if (state is AuthSignOutSuccessState) {
                  context.navigateAndRemoveUntil(Routes.authStartupScreen);
                  showToast(
                      message: S.of(context).loggedOutSuccess,
                      color: AppColors.toastSuccessColor);
                }
                if (state is AuthSignOutErrorState) {
                  showToast(
                      message: state.message, color: AppColors.toastErrorColor);
                }
              },
              child: MyListTile(
                onTap: () {
                  context.read<AuthCubit>().signOut();
                },
                leadingIcon: FontAwesomeIcons.arrowRightFromBracket,
                title: S.of(context).drawerLogout,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
