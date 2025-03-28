import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pulse/core/constants/constants.dart';
import 'package:pulse/core/helpers/extensions.dart';
import 'package:pulse/core/helpers/spacing.dart';
import 'package:pulse/core/theming/app_colors.dart';
import 'package:pulse/features/auth/presentation/ui/widgets/continue_with_google.dart';

import '../../../../core/di/dependency_injection.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/app_styles.dart';
import '../../../../core/widgets/app_elevated_button.dart';
import '../../../../generated/l10n.dart';
import '../../../theme/presentation/cubit/theme_cubit.dart';

class AuthStartupScreen extends StatelessWidget {
  const AuthStartupScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: appHorizontalPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              S.of(context).authStartupFirstText,
              style: TextStyles.font16Regular,
            ),
            Text(
              S.of(context).appName,
              style: TextStyles.font40Bold.copyWith(
                color: AppColors.lightThemeBlack,
              ),
            ),
            Text(
              S.of(context).authStartupSecondText,
              style: TextStyles.font14Regular,
            ),
            verticalSpace(40),
            Text(
              S.of(context).authStartupThirdText,
              style: TextStyles.font16Regular,
            ),
            verticalSpace(10),
            const ContinueWithGoogle(),
            verticalSpace(10),
            AppElevatedButton(
              buttonText: S.of(context).authStartupSecondButtonText,
              onPressed: () {
                context.navigateToNamed(
                  Routes.loginScreen,
                );
              },
              buttonPrefixWidget: Icon(
                FontAwesomeIcons.envelope,
                color: getIt<ThemeCubit>().state.isDarkMode
                    ? AppColors.lightThemeBlack
                    : AppColors.lightThemePurple,
                size: 28,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
