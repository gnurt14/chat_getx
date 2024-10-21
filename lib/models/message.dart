import 'package:cloud_firestore/cloud_firestore.dart';

class MessageModel {
  final String senderId;
  final String receiverId;
  final String message;
  final DateTime timeSent;
  final String messageId;
  final bool isSeen;

  MessageModel({
    required this.senderId,
    required this.receiverId,
    required this.message,
    required this.timeSent,
    required this.messageId,
    this.isSeen = false,
  });

  Map<String, dynamic> toMap() {
    return {
      'senderId': senderId,
      'receiverId': receiverId,
      'message': message,
      'timeSent': timeSent,
      'messageId': messageId,
      'isSeen': isSeen,
    };
  }

  factory MessageModel.fromMap(Map<String, dynamic> map) {
    return MessageModel(
      senderId: map['senderId'] ?? '',
      receiverId: map['receiverId'] ?? '',
      message: map['message'] ?? '',
      timeSent: (map['timeSent'] as Timestamp).toDate(),
      messageId: map['messageId'] ?? '',
      isSeen: map['isSeen'] ?? false,
    );
  }
}
