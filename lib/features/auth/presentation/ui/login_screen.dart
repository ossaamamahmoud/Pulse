import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pulse/core/helpers/extensions.dart';
import 'package:pulse/core/helpers/spacing.dart';
import 'package:pulse/core/theming/app_styles.dart';
import 'package:pulse/core/widgets/app_elevated_button.dart';
import 'package:pulse/core/widgets/app_indicator.dart';
import 'package:pulse/core/widgets/app_text_field.dart';
import 'package:pulse/core/widgets/show_custom_toast.dart';
import 'package:pulse/features/auth/presentation/ui/widgets/continue_with_google.dart';
import 'package:pulse/features/auth/presentation/ui/widgets/have_account_or_not.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../generated/l10n.dart';
import '../../../theme/presentation/cubit/theme_cubit.dart';
import '../cubit/auth/auth_cubit.dart';
import '../cubit/auth/auth_state.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final authCubit = context.read<AuthCubit>();

    return Scaffold(
      appBar: AppBar(
        forceMaterialTransparency: true,
      ),
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: appHorizontalPadding),
        child: SingleChildScrollView(
          keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                S.of(context).authStartupLoginButtonText,
                style: TextStyles.font40Bold.copyWith(
                  color: getIt<ThemeCubit>().state.isDarkMode
                      ? AppColors.lightThemeLighterGrey
                      : AppColors.lightThemePurple,
                ),
              ),
              verticalSpace(5),
              Text(
                S.of(context).loginFirstText,
                style: TextStyles.font14Regular,
              ),
              verticalSpace(40),
              AppTextField(
                tffHeaderText: S.of(context).registerTffEmail,
                tffHintText: S.of(context).registerTffEmailHint,
                tffPrefixIcon: FontAwesomeIcons.at,
                controller: _emailController,
                keyboardType: TextInputType.emailAddress,
              ),
              verticalSpace(20),
              AppTextField(
                tffHeaderText: S.of(context).registerTffPassword,
                tffHintText: S.of(context).registerTffPasswordHint,
                tffPrefixIcon: FontAwesomeIcons.lock,
                keyboardType: TextInputType.visiblePassword,
                isPassword: true,
                controller: _passwordController,
              ),
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  if (state is AuthSignInSuccessState) {
                    // Schedule navigation and SnackBar after the current frame.
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      context.navigateAndRemoveUntil(Routes.chatsScreen);
                      showToast(
                        message: S.of(context).loginSuccess,
                        color: AppColors.toastSuccessColor,
                      );
                    });
                  } else if (state is AuthSignInErrorState) {
                    WidgetsBinding.instance.addPostFrameCallback((_) {
                      showToast(
                        message: state.message,
                        color: AppColors.toastErrorColor,
                      );
                    });
                  }
                },
                builder: (context, state) {
                  return Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    spacing: 20.h,
                    children: [
                      TextButton(
                        style: ButtonStyle(
                          padding: WidgetStateProperty.all(EdgeInsets.zero),
                        ),
                        onPressed: () => context
                            .navigateToNamed(Routes.forgetPasswordScreen),
                        child: Text(
                          S.of(context).loginForgetPassword,
                          style: TextStyles.font17SemiBold.copyWith(
                            color: getIt<ThemeCubit>().state.isDarkMode
                                ? AppColors.lightThemeBlack
                                : AppColors.lightThemePurple,
                          ),
                        ),
                      ),
                      state is AuthSignInLoadingState
                          ? const Center(
                              child: AppIndicator(),
                            )
                          : AppElevatedButton(
                              buttonText:
                                  S.of(context).authStartupLoginButtonText,
                              onPressed: () {
                                if (!_isValidInput()) return;
                                authCubit.signInWithEmailAndPassword(
                                  emailAddress: _emailController.text.trim(),
                                  password: _passwordController.text.trim(),
                                );
                              },
                              borderWidth: 0,
                              color: getIt<ThemeCubit>().state.isDarkMode
                                  ? AppColors.lightThemeBlack
                                  : AppColors.lightThemePurple,
                              textColor: AppColors.lightThemeScaffoldBg,
                            ),
                      const Divider(
                        thickness: 1.8,
                        color: AppColors.lightThemeBlack,
                      ),
                      const ContinueWithGoogle(),
                      HaveAccountOrNot(
                        firstText: S.of(context).loginNotHaveAccount,
                        buttonText: S.of(context).registerFirstText,
                        onPressed: () {
                          context.navigateToNamed(
                            Routes.registerScreen,
                            arguments:
                                authCubit, // pass the same AuthCubit instance
                          );
                        },
                      )
                    ],
                  );
                },
              )
            ],
          ),
        ),
      ),
    );
  }

  bool _isValidInput() {
    if (_emailController.text.trim().isEmpty ||
        _passwordController.text.trim().isEmpty) {
      showToast(
        message: S.of(context).fillAllFieldsError,
        color: AppColors.toastErrorColor,
      );
      return false;
    }
    return true;
  }
}
