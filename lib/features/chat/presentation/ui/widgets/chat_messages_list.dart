import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulse/core/theming/app_styles.dart';
import 'package:pulse/core/widgets/app_indicator.dart';
import 'package:pulse/features/chat/presentation/cubit/chat/chat_cubit.dart';

import '../../../../../core/di/dependency_injection.dart';
import '../../../../../generated/l10n.dart';
import 'chat_bubble.dart';

class ChatMessagesList extends StatefulWidget {
  final ScrollController scrollController;
  final String senderId;
  final String receiverId;

  const ChatMessagesList({
    Key? key,
    required this.scrollController,
    required this.senderId,
    required this.receiverId,
  }) : super(key: key);

  @override
  State<ChatMessagesList> createState() => _ChatMessagesListState();
}

class _ChatMessagesListState extends State<ChatMessagesList> {
  @override
  void initState() {
    super.initState();
    // Fetch messages when this widget is first built.
    getIt<ChatCubit>().fetchMessages(
      senderId: widget.senderId,
      receiverId: widget.receiverId,
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ChatCubit, ChatState>(
      buildWhen: (previous, current) =>
          current is ChatRoomMessagesUpdatedState ||
          current is ChatRoomMessagesLoadingState ||
          current is ChatRoomMessagesErrorState,
      builder: (context, state) {
        if (state is ChatRoomMessagesLoadingState) {
          return const Center(child: AppIndicator());
        } else if (state is ChatRoomMessagesErrorState) {
          return Center(child: Text(state.error));
        } else if (state is ChatRoomMessagesUpdatedState) {
          final messages = state.messages;
          if (messages.isEmpty) {
            return Center(
              child: Text(
                S.of(context).noMessages,
                maxLines: 2,
                style: TextStyles.font16Regular,
              ),
            );
          }
          return ListView.builder(
            controller: widget.scrollController,
            itemCount: messages.length,
            itemBuilder: (context, index) {
              final messageModel = messages[index];
              final isMe = messageModel.senderId == widget.senderId;
              return ChatBubble(
                msg: messageModel.message,
                isMe: isMe,
                reportedUserId: messageModel.receiverId,
                messageId: messageModel.messageId,
                senderId: widget.senderId,
                receiverId: widget.receiverId,
              );
            },
          );
        }
        return Text(
          state.toString(),
        );
      },
    );
  }
}
