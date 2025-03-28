import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String senderId;
  final String messageId;
  final String senderEmail;
  final String receiverId;
  final String message;
  final Timestamp timestamp;

  MessageModel(
      {required this.senderId,
      required this.senderEmail,
      required this.receiverId,
      required this.message,
      required this.timestamp,
      required this.messageId});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'senderId': senderId,
      'senderEmail': senderEmail,
      'receiverId': receiverId,
      'message': message,
      'timestamp': timestamp,
      'messageId': messageId
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      senderId: map['senderId'] as String,
      senderEmail: map['senderEmail'] as String,
      receiverId: map['receiverId'] as String,
      message: map['message'] as String,
      timestamp: map['timestamp'] as Timestamp,
      messageId: map['messageId'] as String,
    );
  }
}
