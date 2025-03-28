import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:pulse/core/di/dependency_injection.dart';
import 'package:pulse/core/theming/app_colors.dart';
import 'package:pulse/core/theming/app_styles.dart';
import 'package:pulse/core/widgets/show_custom_toast.dart';
import 'package:pulse/features/theme/presentation/cubit/theme_cubit.dart';

import '../../../../../generated/l10n.dart';
import '../../cubit/chat/chat_cubit.dart';

class ChatBubble extends StatefulWidget {
  final String msg;
  final bool isMe;
  final String reportedUserId;
  final String messageId;
  // For reporting purposes.
  final String senderId;
  final String receiverId;

  const ChatBubble({
    super.key,
    required this.msg,
    required this.isMe,
    required this.reportedUserId,
    required this.messageId,
    required this.senderId,
    required this.receiverId,
  });

  @override
  _ChatBubbleState createState() => _ChatBubbleState();
}

class _ChatBubbleState extends State<ChatBubble> {
  bool _visible = true;
  bool _isReporting = false;

  Future<void> _reportMessage() async {
    setState(() {
      _visible = false; // Trigger removal animation.
      _isReporting = true;
    });
    await Future.delayed(const Duration(milliseconds: 200));
    await getIt<ChatCubit>().reportUserMessage(
      messageId: widget.messageId,
      reportedUserId: widget.reportedUserId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedSwitcher(
      duration: const Duration(milliseconds: 300),
      transitionBuilder: (child, animation) {
        return SizeTransition(
          sizeFactor: animation,
          child: child,
        );
      },
      child: _visible
          ? GestureDetector(
              key: ValueKey(widget.messageId),
              onLongPress: () {
                if (!widget.isMe && !_isReporting) {
                  showAdaptiveDialog(
                    context: context,
                    builder: (context) => AlertDialog(
                      title: Text(S.of(context).reportMessage),
                      content: Text(S.of(context).reportMessageConfirmation),
                      actions: [
                        TextButton(
                          onPressed: () => Navigator.pop(context),
                          child: Text(S.of(context).cancel),
                        ),
                        TextButton(
                          onPressed: () {
                            Navigator.pop(context);
                            showToast(
                              message: S.of(context).messageReported,
                              color: AppColors.toastSuccessColor,
                            );
                            _reportMessage();
                          },
                          child: Text(S.of(context).report),
                        ),
                      ],
                    ),
                  );
                }
              },
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 12.w, vertical: 4.h),
                child: Align(
                  alignment: widget.isMe
                      ? Alignment.centerRight
                      : Alignment.centerLeft,
                  child: Container(
                    padding:
                        EdgeInsets.symmetric(horizontal: 12.w, vertical: 8.h),
                    decoration: BoxDecoration(
                      color: widget.isMe
                          ? getIt<ThemeCubit>().state.isDarkMode
                              ? AppColors.lightThemeBlack
                              : AppColors.lightThemePurple
                          : AppColors.lightThemeLighterGrey,
                      borderRadius: BorderRadius.only(
                        topLeft: const Radius.circular(12),
                        topRight: const Radius.circular(12),
                        bottomLeft: widget.isMe
                            ? const Radius.circular(12)
                            : Radius.zero,
                        bottomRight: widget.isMe
                            ? Radius.zero
                            : const Radius.circular(12),
                      ),
                    ),
                    constraints: BoxConstraints(maxWidth: 0.75.sw),
                    child: Text(
                      widget.msg,
                      style: TextStyles.font17SemiBold.copyWith(
                        color: widget.isMe
                            ? AppColors.darkThemeWhite
                            : AppColors.lightThemeBlack,
                      ),
                    ),
                  ),
                ),
              ),
            )
          : const SizedBox.shrink(),
    );
  }
}
