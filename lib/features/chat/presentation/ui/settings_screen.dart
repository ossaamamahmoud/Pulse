import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pulse/core/helpers/extensions.dart';
import 'package:pulse/core/routing/routes.dart';
import 'package:pulse/core/theming/app_colors.dart';
import 'package:pulse/core/theming/app_styles.dart';
import 'package:pulse/core/widgets/app_elevated_button.dart';
import 'package:pulse/core/widgets/get_current_lang.dart';
import 'package:pulse/features/auth/presentation/cubit/auth/auth_cubit.dart';
import 'package:pulse/features/theme/presentation/cubit/theme_cubit.dart';

import '../../../../core/cubits/language_cubit/language_cubit.dart';
import '../../../../generated/l10n.dart';
import 'blocked_users_screen.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final themeCubit = context.watch<ThemeCubit>();
    final authCubit = context.read<AuthCubit>();
    final currentUser = authCubit.getCurrentUser();

    if (currentUser == null) {
      return Scaffold(
        appBar: AppBar(title: Text(S.of(context).settings)),
        body: Center(child: Text(S.of(context).noUserLoggedIn)),
      );
    }

    final initial = (currentUser.displayName?.isNotEmpty ?? false)
        ? currentUser.displayName![0].toUpperCase()
        : '?';

    return Scaffold(
      appBar: AppBar(
        title: Text(S.of(context).settings),
        leading: IconButton(
          icon: GetCurrentLang.isArabic()
              ? const Icon(FontAwesomeIcons.arrowRight)
              : const Icon(FontAwesomeIcons.arrowLeft),
          onPressed: () =>
              context.navigateToReplacementNamed(Routes.chatsScreen),
        ),
      ),
      body: ListView(
        padding: EdgeInsets.symmetric(horizontal: 16.w, vertical: 24.h),
        children: [
          // Avatar
          Center(
            child: CircleAvatar(
              radius: 65.h,
              backgroundColor: AppColors.lightThemeLighterGrey,
              child: Text(
                initial,
                style: TextStyles.font40Bold.copyWith(
                  color: AppColors.lightThemePurple,
                  fontSize: 70.sp,
                ),
              ),
            ),
          ),
          SizedBox(height: 24.h),
          // User Info
          Center(
            child: Column(
              children: [
                Text(
                  currentUser.displayName ?? 'N/A',
                  style: TextStyles.font20SemiBold,
                ),
                SizedBox(height: 8.h),
                Text(
                  currentUser.email ?? 'N/A',
                  style: TextStyles.font16Regular,
                ),
              ],
            ),
          ),
          SizedBox(height: 32.h),
          // Theme Mode Card
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Padding(
                padding: EdgeInsets.all(16.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).themeMode,
                      style: TextStyles.font17SemiBold,
                    ),
                    SizedBox(height: 12.h),
                    _ThemeDropdown(themeCubit: themeCubit),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 32.h),
          // Language Selection Card
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: Card(
              elevation: 2,
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12.r),
              ),
              child: Padding(
                padding: EdgeInsets.all(16.r),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      S.of(context).language,
                      style: TextStyles.font17SemiBold,
                    ),
                    SizedBox(height: 12.h),
                    const _LanguageDropdown(),
                  ],
                ),
              ),
            ),
          ),
          SizedBox(height: 32.h),
          // Blocked Users Button
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: AppElevatedButton(
              color: themeCubit.state.isDarkMode
                  ? AppColors.lightThemeBlack
                  : AppColors.lightThemePurple,
              borderWidth: 0,
              textColor: AppColors.lightThemeScaffoldBg,
              buttonPrefixWidget: const Icon(
                FontAwesomeIcons.userSlash,
                color: AppColors.lightThemeScaffoldBg,
              ),
              buttonText: S.of(context).blockedUsers,
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (_) => const BlockedUsersScreen(),
                  ),
                );
              },
            ),
          ),
          SizedBox(height: 32.h),
          // Log Out Button
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 8.w),
            child: AppElevatedButton(
              color: themeCubit.state.isDarkMode
                  ? AppColors.lightThemeBlack
                  : AppColors.lightThemePurple,
              borderWidth: 0,
              textColor: AppColors.lightThemeScaffoldBg,
              buttonPrefixWidget: const Icon(
                FontAwesomeIcons.rightFromBracket,
                color: AppColors.lightThemeScaffoldBg,
              ),
              buttonText: S.of(context).logOut,
              onPressed: () {
                authCubit.signOut();
                context.navigateToReplacementNamed(Routes.authStartupScreen);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class _LanguageDropdown extends StatelessWidget {
  const _LanguageDropdown({super.key});

  @override
  Widget build(BuildContext context) {
    final langCubit = context.watch<LangCubit>();
    final currentLang = langCubit.state;
    return DropdownButton<Language>(
      value: currentLang,
      items: [
        DropdownMenuItem(
          value: Language.en,
          child: Text(S.of(context).english),
        ),
        DropdownMenuItem(
          value: Language.ar,
          child: Text(S.of(context).arabic),
        ),
      ],
      onChanged: (Language? newLang) {
        if (newLang != null) {
          langCubit.switchLanguage(newLang);
        }
      },
      isExpanded: true,
      underline: Container(
        height: 1,
        color: AppColors.lightThemeGrey,
      ),
    );
  }
}

class _ThemeDropdown extends StatelessWidget {
  final ThemeCubit themeCubit;
  const _ThemeDropdown({required this.themeCubit});

  @override
  Widget build(BuildContext context) {
    final isDark = themeCubit.state.isDarkMode;
    return DropdownButton<bool>(
      value: isDark,
      items: [
        DropdownMenuItem(value: false, child: Text(S.of(context).lightMode)),
        DropdownMenuItem(value: true, child: Text(S.of(context).darkMode)),
      ],
      onChanged: (bool? value) {
        if (value != null) {
          themeCubit.setTheme(value);
        }
      },
      isExpanded: true,
      underline: Container(
        height: 1,
        color: AppColors.lightThemeGrey,
      ),
    );
  }
}
