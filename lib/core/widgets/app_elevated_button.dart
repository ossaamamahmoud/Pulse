import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pulse/core/theming/app_styles.dart';

import '../constants/constants.dart';
import '../helpers/spacing.dart';

class AppElevatedButton extends StatelessWidget {
  const AppElevatedButton({
    super.key,
    this.buttonPrefixWidget,
    required this.buttonText,
    required this.onPressed,
    this.buttonTextStyle,
    this.color,
    this.textColor,
    this.borderWidth,
  });
  final Widget? buttonPrefixWidget;
  final String buttonText;
  final TextStyle? buttonTextStyle;
  final VoidCallback onPressed;
  final Color? color;
  final Color? textColor;
  final double? borderWidth;
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      style: ElevatedButton.styleFrom(
        backgroundColor: color,
        minimumSize: appElevatedButtonSize,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(
            12.r,
          ),
        ),
        side: BorderSide(
          width: borderWidth ?? 1.5,
        ),
      ),
      onPressed: onPressed,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          if (buttonPrefixWidget != null) ...[
            buttonPrefixWidget!,
            horizontalSpace(10),
          ],
          Text(buttonText,
              style: buttonTextStyle ??
                  TextStyles.font16semiBold.copyWith(
                    color: textColor,
                  )),
        ],
      ),
    );
  }
}
