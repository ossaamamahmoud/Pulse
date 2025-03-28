import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulse/core/helpers/extensions.dart';
import 'package:pulse/features/auth/presentation/cubit/auth/auth_cubit.dart';

import '../../../../../core/routing/routes.dart';
import '../../../../../core/theming/app_colors.dart';
import '../../../../../core/widgets/app_indicator.dart';
import '../../../../../core/widgets/show_custom_toast.dart';
import '../../../../../generated/l10n.dart';
import '../../cubit/auth/auth_state.dart';
import 'google_button.dart';

class ContinueWithGoogle extends StatelessWidget {
  const ContinueWithGoogle({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AuthCubit, AuthState>(
      listener: (context, state) {
        if (state is AuthGoogleSignInSuccessState) {
          context.navigateToNamed(
            Routes.chatsScreen,
            arguments: state.userCredential,
          );
          showToast(
              message: S.of(context).loginSuccess,
              color: AppColors.toastSuccessColor);
        } else if (state is AuthGoogleSignInErrorState) {
          showToast(message: state.message, color: AppColors.toastErrorColor);
        }
      },
      builder: (context, state) {
        if (state is AuthGoogleSignInLoadingState) {
          return const Center(child: AppIndicator());
        }
        return GoogleButton(
          onPressed: () => context.read<AuthCubit>().signInWithGoogle(),
        );
      },
    );
  }
}
