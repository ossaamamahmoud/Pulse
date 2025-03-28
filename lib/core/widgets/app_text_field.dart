import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pulse/core/di/dependency_injection.dart';
import 'package:pulse/features/theme/presentation/cubit/theme_cubit.dart';

import '../constants/constants.dart';
import '../theming/app_colors.dart';
import '../theming/app_styles.dart';

class AppTextField extends StatefulWidget {
  const AppTextField({
    super.key,
    this.tffHeaderText,
    required this.tffHintText,
    this.tffPrefixIcon,
    required this.controller,
    this.isPassword = false,
    required this.keyboardType,
    this.focusNode,
    this.isMsgField = false,
  });

  final String? tffHeaderText;
  final String tffHintText;
  final IconData? tffPrefixIcon;
  final TextEditingController controller;
  final bool isPassword;
  final TextInputType keyboardType;
  final FocusNode? focusNode;
  final bool isMsgField;

  @override
  State<AppTextField> createState() => _AppTextFieldState();
}

class _AppTextFieldState extends State<AppTextField> {
  late bool _obscureText;

  @override
  void initState() {
    super.initState();
    _obscureText = widget.isPassword;
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        if (widget.tffHeaderText != null) ...[
          Text(
            widget.tffHeaderText!,
            style: TextStyles.font14Regular,
          ),
          SizedBox(height: 5.h),
        ],
        // Wrap TextField in a ConstrainedBox to limit its maximum height.
        ConstrainedBox(
          constraints: BoxConstraints(
            maxHeight: 0.5.sw, // Maximum height is half of the screen width.
          ),
          child: TextField(
            controller: widget.controller,
            focusNode: widget.focusNode,
            obscureText: widget.isPassword ? _obscureText : false,
            keyboardType: widget.keyboardType,
            textInputAction: widget.isMsgField
                ? TextInputAction.newline
                : TextInputAction.next,
            minLines: 1,
            maxLines: widget.isMsgField ? 4 : 1,
            cursorColor: AppColors.lightThemePurple,
            style: TextStyles.font17SemiBold.copyWith(
              color: getIt<ThemeCubit>().state.isDarkMode
                  ? AppColors.lightThemeBlack
                  : AppColors.lightThemeBlack,
            ),
            decoration: InputDecoration(
              hintText: widget.tffHintText,
              hintStyle: TextStyles.font16Regular.copyWith(
                color: getIt<ThemeCubit>().state.isDarkMode
                    ? AppColors.lightThemeBlack
                    : AppColors.lightThemeGrey,
              ),
              suffixIcon: widget.isPassword
                  ? IconButton(
                      icon: Icon(
                        _obscureText
                            ? FontAwesomeIcons.eye
                            : FontAwesomeIcons.eyeSlash,
                        size: appIconSize,
                        color: getIt<ThemeCubit>().state.isDarkMode
                            ? AppColors.lightThemeBlack
                            : AppColors.lightThemePurple,
                      ),
                      onPressed: () {
                        setState(() {
                          _obscureText = !_obscureText;
                        });
                      },
                    )
                  : null,
              prefixIcon: widget.tffPrefixIcon == null
                  ? null
                  : Icon(
                      widget.tffPrefixIcon,
                      size: appIconSize,
                      color: getIt<ThemeCubit>().state.isDarkMode
                          ? AppColors.lightThemeBlack
                          : AppColors.lightThemePurple,
                    ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: BorderSide(
                  color: getIt<ThemeCubit>().state.isDarkMode
                      ? AppColors.lightThemeScaffoldBg
                      : AppColors.lightThemePurple,
                  width: 2,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: BorderSide(
                  color: getIt<ThemeCubit>().state.isDarkMode
                      ? AppColors.lightThemeScaffoldBg
                      : AppColors.lightThemePurple,
                  width: 2,
                ),
              ),
              errorBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(16.r),
                borderSide: const BorderSide(
                  color: AppColors.toastErrorColor,
                  width: 2,
                ),
              ),
              filled: true,
              fillColor: getIt<ThemeCubit>().state.isDarkMode
                  ? AppColors.lightThemeLighterGrey
                  : AppColors.lightThemeScaffoldBg,
            ),
          ),
        ),
      ],
    );
  }
}
