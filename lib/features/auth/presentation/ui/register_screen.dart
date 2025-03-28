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
import 'package:pulse/features/auth/presentation/ui/widgets/have_account_or_not.dart';

import '../../../../core/constants/constants.dart';
import '../../../../core/di/dependency_injection.dart';
import '../../../../core/routing/routes.dart';
import '../../../../core/theming/app_colors.dart';
import '../../../../generated/l10n.dart';
import '../../../theme/presentation/cubit/theme_cubit.dart';
import '../cubit/auth/auth_cubit.dart';
import '../cubit/auth/auth_state.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();
  final TextEditingController _nameController = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
                S.of(context).registerFirstText,
                style: TextStyles.font40Bold.copyWith(
                  color: getIt<ThemeCubit>().state.isDarkMode
                      ? AppColors.lightThemeLighterGrey
                      : AppColors.lightThemePurple,
                ),
              ),
              verticalSpace(5),
              Text.rich(
                TextSpan(
                  text: S.of(context).registerCreateText,
                  style: TextStyles.font16Regular,
                  children: [
                    TextSpan(
                      text: S.of(context).registerAccountText,
                      style: TextStyles.font16semiBold.copyWith(
                        color: getIt<ThemeCubit>().state.isDarkMode
                            ? AppColors.toastWarningColor
                            : AppColors.lightThemePurple,
                      ),
                    ),
                    TextSpan(
                      text: S.of(context).registerCreateSecondText,
                      style: TextStyles.font16Regular,
                    ),
                    TextSpan(
                      text: S.of(context).appName,
                      style: TextStyles.font16semiBold.copyWith(
                        color: getIt<ThemeCubit>().state.isDarkMode
                            ? AppColors.toastWarningColor
                            : AppColors.lightThemePurple,
                      ),
                    ),
                  ],
                ),
              ),
              verticalSpace(40),
              Column(
                spacing: 30.h,
                children: [
                  AppTextField(
                    tffHeaderText: S.of(context).registerTffName,
                    tffHintText: S.of(context).registerTffNameHint,
                    tffPrefixIcon: FontAwesomeIcons.user,
                    controller: _nameController,
                    keyboardType: TextInputType.name,
                  ),
                  AppTextField(
                    tffHeaderText: S.of(context).registerTffEmail,
                    tffHintText: S.of(context).registerTffEmailHint,
                    tffPrefixIcon: FontAwesomeIcons.at,
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  AppTextField(
                    tffHeaderText: S.of(context).registerTffPassword,
                    tffHintText: S.of(context).registerTffPasswordHint,
                    tffPrefixIcon: FontAwesomeIcons.lock,
                    controller: _passwordController,
                    isPassword: true,
                    keyboardType: TextInputType.visiblePassword,
                  ),
                  AppTextField(
                    tffHeaderText: S.of(context).registerTffConfirmPassword,
                    tffHintText: S.of(context).registerTffPasswordHint,
                    tffPrefixIcon: FontAwesomeIcons.lock,
                    controller: _confirmPasswordController,
                    isPassword: true,
                    keyboardType: TextInputType.visiblePassword,
                  ),
                ],
              ),
              verticalSpace(40),
              BlocConsumer<AuthCubit, AuthState>(
                listener: (context, state) {
                  _handlingSignUpStates(state, context);
                },
                builder: (context, state) {
                  if (state is AuthSignUpLoadingState) {
                    return const Center(child: AppIndicator());
                  }
                  return AppElevatedButton(
                    buttonText: S.of(context).registerFirstText,
                    onPressed: () {
                      _handleSignUp(context);
                    },
                    borderWidth: 0,
                    color: getIt<ThemeCubit>().state.isDarkMode
                        ? AppColors.lightThemeBlack
                        : AppColors.lightThemePurple,
                    textColor: AppColors.lightThemeScaffoldBg,
                  );
                },
              ),
              verticalSpace(20),
              HaveAccountOrNot(
                firstText: S.of(context).authStartupHaveAnAccount,
                buttonText: S.of(context).authStartupLoginButtonText,
                onPressed: () => context.pop(),
              )
            ],
          ),
        ),
      ),
    );
  }

  void _handleSignUp(BuildContext context) {
    if (_nameController.text.isNotEmpty &&
        _emailController.text.isNotEmpty &&
        _passwordController.text.isNotEmpty &&
        _confirmPasswordController.text.isNotEmpty) {
      if (_passwordController.text == _confirmPasswordController.text) {
        context.read<AuthCubit>().signUpWithEmailAndPassword(
              emailAddress: _emailController.text,
              password: _passwordController.text,
              name: _nameController.text,
            );
      } else {
        showToast(
          message: S.of(context).passwordMismatch,
          color: AppColors.toastWarningColor,
        );
      }
    } else {
      showToast(
        message: S.of(context).fillAllFieldsError,
        color: AppColors.toastWarningColor,
      );
    }
  }

  void _handlingSignUpStates(AuthState state, BuildContext context) {
    if (state is AuthSignUpSuccessState) {
      // Schedule navigation and toast after the current frame.
      WidgetsBinding.instance.addPostFrameCallback((_) {
        context.navigateAndRemoveUntil(Routes.loginScreen);
        showToast(
          message: S.of(context).accountCreatedSuccess,
          color: AppColors.toastSuccessColor,
        );
      });
    } else if (state is AuthSignUpErrorState) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        showToast(
          message: state.message,
          color: AppColors.toastErrorColor,
        );
      });
    }
  }
}
