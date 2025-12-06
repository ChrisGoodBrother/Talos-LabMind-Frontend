import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lab_mind_frontend/models/chat_message.dart';
import 'package:lab_mind_frontend/utils/styles/colors.dart';

class ChatBubble extends HookWidget {
  final ChatMessage chatMessage;

  ChatBubble({super.key, required this.chatMessage});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(left: 14, right: 14, top: 10, bottom: 10),
      child: Align(
        alignment: switch (chatMessage.messageType) {
          "agent" => Alignment.topLeft,
          "human" => Alignment.topRight,
          _ => Alignment.topCenter,
        },
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            color: switch (chatMessage.messageType) {
              "agent" => MyColors.firstAgentMessageColor,
              "human" => MyColors.secondAgentMessageColor,
              "system" => MyColors.systemMessageColor,
              _ => Colors.red,
            },
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
