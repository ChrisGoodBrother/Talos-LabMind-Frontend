import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lab_mind_frontend/models/chat_message.dart';

class ChatBubble extends HookWidget {
  final ChatMessage chatMessage;

  ChatBubble({super.key, required this.chatMessage});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
      child: Align(
        alignment: (chatMessage.messageType == "coder" ? Alignment.topLeft : Alignment.topRight),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: (chatMessage.messageType == "coder" ? Colors.grey.shade200 : Colors.blue[200]),
          ),
          padding: EdgeInsets.all(16),
          child: Text(
            chatMessage.message,
            style: TextStyle(fontSize: 15),
          ),
        ),
      ),
    );
  }
}
