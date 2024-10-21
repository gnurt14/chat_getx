import 'package:flutter/material.dart';

class ChatBox extends StatelessWidget {
  final String userName;
  final String lastMessage;
  final String timeSent;

  const ChatBox({
    super.key,
    required this.userName,
    required this.lastMessage,
    required this.timeSent,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width * 0.8,
      height: 60,
      decoration: BoxDecoration(
        color: Colors.grey[200],
        borderRadius: BorderRadius.circular(8),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Row(
          children: [
            const CircleAvatar(
              radius: 16,
            ),
            const SizedBox(
              width: 15,
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  userName,
                  style: const TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 14,
                  ),
                ),
                Row(
                  children: [
                    Text(
                      lastMessage,
                      style: const TextStyle(
                        fontSize: 14,
                      ),
                    ),
                    Text(
                      timeSent,
                      style: const TextStyle(fontSize: 11),
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
