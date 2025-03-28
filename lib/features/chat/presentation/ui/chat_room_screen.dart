import 'package:flutter/material.dart';
import 'package:pulse/core/di/dependency_injection.dart';
import 'package:pulse/features/auth/presentation/cubit/auth/auth_cubit.dart';
import 'package:pulse/features/chat/data/user_model.dart';
import 'package:pulse/features/chat/presentation/ui/widgets/chat_input_field.dart';
import 'package:pulse/features/chat/presentation/ui/widgets/chat_messages_list.dart';

import '../cubit/chat/chat_cubit.dart';

class ChatRoomScreen extends StatefulWidget {
  final UserModel receiverUser;

  const ChatRoomScreen({super.key, required this.receiverUser});

  @override
  State<ChatRoomScreen> createState() => _ChatRoomScreenState();
}

class _ChatRoomScreenState extends State<ChatRoomScreen> {
  final TextEditingController _messageController = TextEditingController();
  final ScrollController _scrollController = ScrollController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();

    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        Future.delayed(const Duration(milliseconds: 400), scrollDown);
      }
    });

    Future.delayed(const Duration(milliseconds: 500), scrollDown);
  }

  void scrollDown() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        _scrollController.position.maxScrollExtent,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeOut,
      );
    }
  }

  @override
  void dispose() {
    _messageController.dispose();
    _scrollController.dispose();
    _focusNode.dispose();
    super.dispose();
  }

  void _sendMessage() {
    final message = _messageController.text.trim();
    if (message.isEmpty) return;

    getIt<ChatCubit>().sendMessage(
      message: message,
      receiverId: widget.receiverUser.uid,
    );

    _messageController.clear();
    Future.delayed(const Duration(milliseconds: 100), scrollDown);
  }

  @override
  Widget build(BuildContext context) {
    final senderId = getIt<AuthCubit>().getCurrentUser()!.uid;

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.receiverUser.name),
        forceMaterialTransparency: true,
      ),
      body: Column(
        children: [
          Expanded(
            child: ChatMessagesList(
              scrollController: _scrollController,
              senderId: senderId,
              receiverId: widget.receiverUser.uid,
            ),
          ),
          ChatInputField(
            messageController: _messageController,
            focusNode: _focusNode,
            onSendMessage: _sendMessage,
            user: widget.receiverUser,
          ),
        ],
      ),
    );
  }
}
