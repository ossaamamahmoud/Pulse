import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pulse/core/constants/constants.dart';
import 'package:pulse/core/di/dependency_injection.dart';
import 'package:pulse/core/helpers/extensions.dart';
import 'package:pulse/core/theming/app_colors.dart';
import 'package:pulse/core/widgets/get_current_lang.dart';
import 'package:pulse/core/widgets/show_custom_toast.dart';
import 'package:pulse/features/chat/data/user_model.dart';
import 'package:pulse/features/chat/presentation/cubit/chat/chat_cubit.dart';

import '../../../../../core/widgets/app_text_field.dart';
import '../../../../../generated/l10n.dart';

class ChatInputField extends StatelessWidget {
  final TextEditingController messageController;
  final FocusNode focusNode;
  final VoidCallback onSendMessage;
  final UserModel user;

  const ChatInputField({
    super.key,
    required this.messageController,
    required this.focusNode,
    required this.onSendMessage,
    required this.user,
  });

  @override
  Widget build(BuildContext context) {
    final bool isArabic = GetCurrentLang.isArabic();

    final List<Widget> rowChildren = isArabic
        ? [
            IconButton(
              onPressed: onSendMessage,
              icon: Icon(FontAwesomeIcons.paperPlane, size: appIconSize),
            ),
            Expanded(
              child: AppTextField(
                keyboardType: TextInputType.multiline,
                controller: messageController,
                tffHintText: S.of(context).typeMessageHint,
                focusNode: focusNode,
                isMsgField: true,
              ),
            ),
            IconButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isDismissible: false,
                  useSafeArea: true,
                  builder: _buildBottomSheet,
                );
              },
              icon: Icon(FontAwesomeIcons.ellipsisVertical, size: appIconSize),
            ),
          ]
        : [
            IconButton(
              onPressed: () {
                showModalBottomSheet(
                  context: context,
                  isDismissible: false,
                  useSafeArea: true,
                  builder: _buildBottomSheet,
                );
              },
              icon: Icon(FontAwesomeIcons.ellipsisVertical, size: appIconSize),
            ),
            Expanded(
              child: AppTextField(
                keyboardType: TextInputType.multiline,
                controller: messageController,
                tffHintText: S.of(context).typeMessageHint,
                focusNode: focusNode,
                isMsgField: true,
              ),
            ),
            IconButton(
              onPressed: onSendMessage,
              icon: Icon(FontAwesomeIcons.paperPlane, size: appIconSize),
            ),
          ];

    return Padding(
      padding: EdgeInsets.all(16.r),
      child: Row(
        children: rowChildren,
      ),
    );
  }

  Widget _buildBottomSheet(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        // Block user option.
        BlocProvider.value(
          value: getIt<ChatCubit>(),
          child: BlocListener<ChatCubit, ChatState>(
            listener: (context, state) {
              if (state is ChatUserBlockedSuccessfulState) {
                context.pop();
                context.pop();
                showToast(
                  message: "${user.name.split(" ")[0]} blocked successfully",
                  color: AppColors.toastSuccessColor,
                );
              } else if (state is ChatUserBlockedErrorState) {
                showToast(
                  message: state.error,
                  color: AppColors.toastErrorColor,
                );
              }
            },
            child: ListTile(
              leading: const Icon(FontAwesomeIcons.ban),
              title: Text('Block ${user.name.split(" ")[0]}'),
              onTap: () {
                getIt<ChatCubit>().blockUser(userId: user.uid);
              },
            ),
          ),
        ),
        // Cancel option.
        ListTile(
          leading: const Icon(FontAwesomeIcons.circleXmark),
          title: const Text('Cancel'),
          onTap: () => context.pop(),
        ),
      ],
    );
  }
}
