import 'package:flutter/material.dart';

class ReplyCard extends StatelessWidget {
  final String message;
  final String time;

  const ReplyCard({super.key, required this.message, required this.time});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(6),
        color: Colors.grey[400],
      ),
      child: Column(
        children: [
          Text(message),
          Align(
            alignment: Alignment.bottomRight,
            child: Text(
              time,
              style: TextStyle(fontSize: 10),
            ),
          ),
        ],
      ),
    );
  }
}
