part of 'chat_cubit.dart';

sealed class ChatState {}

class ChatInitialState extends ChatState {}

class ChatsUsersLoadingState extends ChatState {}

class ChatsUsersLoadedState extends ChatState {
  final List<UserModel> users;

  ChatsUsersLoadedState({required this.users});
}

class ChatsUsersErrorState extends ChatState {
  final String error;

  ChatsUsersErrorState({required this.error});
}

class ChatsUsersExceptBlockedLoadingState extends ChatState {}

class ChatsUsersExceptBlockedLoadedState extends ChatState {
  final List<UserModel> users;

  ChatsUsersExceptBlockedLoadedState({required this.users});
}

class ChatsUsersExceptBlockedErrorState extends ChatState {
  final String error;

  ChatsUsersExceptBlockedErrorState({required this.error});
}

class ChatRoomMessagesLoadingState extends ChatState {}

class ChatRoomMessagesUpdatedState extends ChatState {
  final List<MessageModel> messages;

  ChatRoomMessagesUpdatedState(this.messages);
}

class ChatRoomMessagesErrorState extends ChatState {
  final String error;

  ChatRoomMessagesErrorState(this.error);
}

class ChatUserReportedLoadingState extends ChatState {}

class ChatUserReportedSuccessfulState extends ChatState {
  final Report report;

  ChatUserReportedSuccessfulState({required this.report});
}

class ChatUserReportedErrorState extends ChatState {
  final String error;

  ChatUserReportedErrorState({required this.error});
}

class ChatUserBlockedLoadingState extends ChatState {}

class ChatUserBlockedSuccessfulState extends ChatState {}

class ChatUserBlockedErrorState extends ChatState {
  final String error;

  ChatUserBlockedErrorState({required this.error});
}

class ChatUserUnblockedLoadingState extends ChatState {}

class ChatUserUnblockedSuccessfulState extends ChatState {
  final UserModel user;

  ChatUserUnblockedSuccessfulState({required this.user});
}

class ChatUserUnblockedErrorState extends ChatState {
  final String error;

  ChatUserUnblockedErrorState({required this.error});
}

class ChatBlockedUsersLoadingState extends ChatState {}

class ChatBlockedUsersLoadedState extends ChatState {
  final List<UserModel>? blockedUsers;

  ChatBlockedUsersLoadedState({required this.blockedUsers});
}

class ChatBlockedUsersErrorState extends ChatState {
  final String error;

  ChatBlockedUsersErrorState({required this.error});
}
