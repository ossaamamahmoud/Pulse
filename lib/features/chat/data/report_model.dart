import 'package:cloud_firestore/cloud_firestore.dart';

class Report {
  final String messageId;
  final String reporterById;
  final String reportedUserId;
  final Timestamp timestamp;

  Report(
      {required this.messageId,
      required this.reporterById,
      required this.reportedUserId,
      required this.timestamp});

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      'messageId': messageId,
      'reporterById': reporterById,
      'reportedUserId': reportedUserId,
      'timestamp': timestamp,
    };
  }

  factory Report.fromMap(Map<String, dynamic> map) {
    return Report(
      messageId: map['messageId'] as String,
      reporterById: map['reporterById'] as String,
      reportedUserId: map['reportedUserId'] as String,
      timestamp: map['timestamp'] as Timestamp,
    );
  }
}
