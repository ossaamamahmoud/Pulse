import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../../../../../core/widgets/app_elevated_button.dart';
import '../../../../../generated/l10n.dart';

class GoogleButton extends StatelessWidget {
  const GoogleButton({super.key, required this.onPressed});
  final VoidCallback onPressed;
  @override
  Widget build(BuildContext context) {
    return AppElevatedButton(
      buttonText: S.of(context).authStartupFirstButtonText,
      onPressed: onPressed,
      buttonPrefixWidget: Image.asset(
        "assets/images/google_logo.png",
        height: 30.h,
      ),
    );
  }
}
