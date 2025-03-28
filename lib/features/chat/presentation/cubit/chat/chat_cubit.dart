import 'dart:developer';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:pulse/core/di/dependency_injection.dart';
import 'package:pulse/features/auth/presentation/cubit/auth/auth_cubit.dart';
import 'package:pulse/features/chat/data/message_model.dart';
import 'package:pulse/features/chat/data/report_model.dart';
import 'package:pulse/features/chat/data/user_model.dart';
import 'package:uuid/uuid.dart';

part 'chat_state.dart';

class ChatCubit extends Cubit<ChatState> {
  ChatCubit() : super(ChatInitialState());

  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  static final Set<String> _reportedMessageIds = {};

  User? get currentUser => getIt<AuthCubit>().getCurrentUser();

  Future<void> fetchAllUsersStream() async {
    try {
      emit(ChatsUsersLoadingState());
      final currentUserId = currentUser!.uid;
      final snapshot = await _firestore
          .collection('Users')
          .where('uid', isNotEqualTo: currentUserId)
          .get();
      final users = snapshot.docs
          .map(
            (doc) => UserModel.fromMap(
              doc.data(),
            ),
          )
          .toList();
      emit(ChatsUsersLoadedState(users: users));
    } catch (e) {
      emit(ChatsUsersErrorState(error: e.toString()));
    }
  }

  Future<void> fetchAllUsersExceptBlocked() async {
    try {
      emit(ChatsUsersExceptBlockedLoadingState());
      final currentUserId = currentUser!.uid;
      final allUsers = await _firestore.collection("Users").get();
      final blockedUsers = await _firestore
          .collection('Users')
          .doc(currentUserId)
          .collection("BlockedUsers")
          .get();
      final users = allUsers.docs
          .where((user) => !blockedUsers.docs
              .any((blockedUser) => blockedUser.id == user.id))
          .map(
            (doc) => UserModel.fromMap(
              doc.data(),
            ),
          )
          .toList();
      emit(ChatsUsersExceptBlockedLoadedState(users: users));
    } catch (e) {
      emit(ChatsUsersExceptBlockedErrorState(error: e.toString()));
    }
  }

  void sendMessage({
    required String message,
    required String receiverId,
  }) {
    final user = currentUser;
    if (user == null) {
      log("Error: No current user.");
      return;
    }
    final senderId = user.uid;
    final senderEmail = user.email;
    final timestamp = Timestamp.now();
    final messageId = const Uuid().v4();

    final newMessage = MessageModel(
      senderId: senderId,
      senderEmail: senderEmail ?? '',
      receiverId: receiverId,
      message: message,
      timestamp: timestamp,
      messageId: messageId,
    );

    // Generate chat room ID using both sender and receiver IDs.
    List<String> ids = [senderId, receiverId];
    ids.sort();
    String chatRoomId = ids.join('_');

    _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .add(newMessage.toMap());
  }

  void fetchMessages({required String senderId, required String receiverId}) {
    // Emit loading only if we are starting from initial state.
    if (state is ChatInitialState) {
      emit(ChatRoomMessagesLoadingState());
    }

    List<String> ids = [senderId, receiverId];
    ids.sort();
    String chatRoomId = ids.join('_');

    _firestore
        .collection('chat_rooms')
        .doc(chatRoomId)
        .collection('messages')
        .orderBy('timestamp', descending: false)
        .snapshots()
        .listen(
      (snapshot) {
        final messages = snapshot.docs
            .map((doc) => MessageModel.fromMap(doc.data()))
            .toList();
        // Filter out messages that have been reported.
        final filteredMessages = messages
            .where((msg) => !_reportedMessageIds.contains(msg.messageId))
            .toList();
        emit(ChatRoomMessagesUpdatedState(filteredMessages));
      },
      onError: (error) {
        emit(ChatRoomMessagesErrorState(error.toString()));
      },
    );
  }

  // Keep this commented function as-is.
  // Stream<QuerySnapshot> fetchMessagesStream({
  //   required String senderId,
  //   required String receiverId,
  // }) {
  //   List<String> ids = [senderId, receiverId];
  //   ids.sort();
  //   String chatRoomId = ids.join('_');
  //   return _firestore
  //       .collection('chat_rooms')
  //       .doc(chatRoomId)
  //       .collection('messages')
  //       .orderBy('timestamp', descending: false)
  //       .snapshots();
  // }

  Future<void> reportUserMessage({
    required String messageId,
    required String reportedUserId,
  }) async {
    try {
      emit(ChatUserReportedLoadingState());
      final currentUserId = currentUser!.uid;
      final newReport = Report(
        messageId: messageId,
        reporterById: currentUserId,
        reportedUserId: reportedUserId,
        timestamp: Timestamp.now(),
      );
      await _firestore.collection('Reports').add(newReport.toMap());
      // Add the reported message ID to the static set.
      _reportedMessageIds.add(messageId);
      emit(ChatUserReportedSuccessfulState(report: newReport));
      // The next snapshot update in fetchMessages will filter out the reported message.
    } catch (e) {
      emit(ChatUserReportedErrorState(error: e.toString()));
    }
  }

  Future<void> blockUser({required String userId}) async {
    try {
      final currentUserId = currentUser!.uid;
      emit(ChatUserBlockedLoadingState());
      await _firestore
          .collection('Users')
          .doc(currentUserId)
          .collection("BlockedUsers")
          .doc(userId)
          .set({});
      emit(ChatUserBlockedSuccessfulState());
    } catch (e) {
      emit(ChatUserBlockedErrorState(error: e.toString()));
    }
  }

  Future<void> unblockUser({required String userId}) async {
    try {
      final currentUserId = currentUser!.uid;
      emit(ChatUserUnblockedLoadingState());
      await _firestore
          .collection('Users')
          .doc(currentUserId)
          .collection("BlockedUsers")
          .doc(userId)
          .delete();
      final unBlockedUser =
          await _firestore.collection('Users').doc(userId).get();
      emit(ChatUserUnblockedSuccessfulState(
          user: UserModel.fromMap(unBlockedUser.data()!)));
    } catch (e) {
      emit(ChatUserUnblockedErrorState(error: e.toString()));
    }
  }

  Future<void> getBlockedUsers() async {
    try {
      emit(ChatBlockedUsersLoadingState());
      final currentUserId = currentUser!.uid;
      // First, fetch the blocked user IDs from the subcollection.
      final blockedSnapshot = await _firestore
          .collection('Users')
          .doc(currentUserId)
          .collection("BlockedUsers")
          .get();
      final blockedUserIds = blockedSnapshot.docs.map((doc) => doc.id).toList();

      // For each blocked user ID, fetch the full user data from the Users collection.
      final futures = blockedUserIds
          .map((id) => _firestore.collection('Users').doc(id).get())
          .toList();
      final userSnapshots = await Future.wait(futures);
      final blockedUsers = userSnapshots.map((doc) {
        final data = doc.data() ?? {};
        // Ensure the user id is included.
        data['uid'] = doc.id;
        return UserModel.fromMap(data);
      }).toList();
      emit(ChatBlockedUsersLoadedState(blockedUsers: blockedUsers));
    } catch (e) {
      emit(ChatBlockedUsersErrorState(error: e.toString()));
    }
  }
}
