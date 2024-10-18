class ChatModel {
  final String name;
  final String receiverUid;
  final String timeSent;
  final String lastMessage;

  ChatModel({
    required this.name,
    required this.receiverUid,
    required this.timeSent,
    required this.lastMessage,
  });

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'receiverName': receiverUid,
      'timeSent': timeSent,
      'lastMessage': lastMessage,
    };
  }

  factory ChatModel.fromMap(Map<String, dynamic> map) {
    return ChatModel(
      name: map['name'] ?? '',
      receiverUid: map['receiverUid'] ?? '',
      timeSent: map['timeSent'] ?? '',
      lastMessage: map['lastMessage'] ?? '',
    );
  }
}
