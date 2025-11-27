import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lab_mind_frontend/bloc/agent_scripts_bloc/agent_chat_bloc.dart';
import 'package:lab_mind_frontend/bloc/agent_scripts_bloc/agent_chat_state.dart';
import 'package:lab_mind_frontend/models/chat_message.dart';
import 'package:lab_mind_frontend/widgets/chat_bubble.dart';

class ChatBox extends HookWidget {
  ChatBox({super.key});

  final messages = useState<List<ChatMessage>>([]);

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();

    return Expanded(
      child: BlocConsumer<AgentChatBloc, AgentChatState>(
        listener: (context, state) {
          if (state is AgentChatNewMessageState) {
            messages.value.add(state.chatMessage);
          }

          if (state is AgentChatEmptyChatState) {
            messages.value.clear();
          }
        },
        builder: (context, state) {
          if (state is AgentChatEmptyChatState) {
            return ListView.separated(
              shrinkWrap: true,
              controller: scrollController,
              itemCount: messages.value.length,
              separatorBuilder: (context, index) {
                return SizedBox();
              },
              itemBuilder: (context, index) {
                return Text("Select Script");
              },
            );
          }
          if (state is AgentChatNewMessageState || state is AgentChatLoadedState) {
            return ListView.separated(
              shrinkWrap: true,
              controller: scrollController,
              itemCount: messages.value.length,
              separatorBuilder: (context, index) {
                return SizedBox();
              },
              itemBuilder: (context, index) {
                return ChatBubble(chatMessage: messages.value[index]);
              },
            );
          }

          return Container();
        },
      ),
    );
  }
}
