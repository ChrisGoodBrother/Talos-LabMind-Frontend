import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lab_mind_frontend/bloc/agent_scripts_bloc/agent_chat_bloc.dart';
import 'package:lab_mind_frontend/bloc/agent_scripts_bloc/agent_chat_state.dart';
import 'package:lab_mind_frontend/models/chat_message.dart';
import 'package:lab_mind_frontend/widgets/chat_bubble.dart';

class ChatBox extends HookWidget {
  const ChatBox({super.key});

  @override
  Widget build(BuildContext context) {
    final scrollController = ScrollController();
    final controller = useTextEditingController();
    final messages = useState<List<ChatMessage>>([]);

    return BlocListener<AgentChatBloc, AgentChatState>(
      listener: (context, state) {
        if (state is AgentChatNewMessageState) {
          messages.value = [...messages.value, state.chatMessage];
        }

        if (state is AgentChatEmptyChatState) {
          messages.value.clear();
        }
      },
      child: Padding(
        padding: const EdgeInsets.only(
          bottom: 5,
          right: 30,
          left: 30,
          top: 5,
        ),
        child: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.black.withValues(alpha: 0.3),
          ),
          child: Column(
            children: [
              ListView.separated(
                shrinkWrap: true,
                controller: scrollController,
                itemCount: messages.value.length,
                separatorBuilder: (context, index) {
                  return SizedBox();
                },
                itemBuilder: (context, index) {
                  return ChatBubble(
                    chatMessage: messages.value[index],
                  );
                },
              ),
              Spacer(),
              Row(
                children: [
                  Expanded(
                    child: TextField(
                      controller: controller,
                      decoration: InputDecoration(
                        hintText: "Talk with the agents...",
                        border: OutlineInputBorder(),
                      ),
                      minLines: 1,
                      maxLines: 5,
                      keyboardType: TextInputType.multiline,
                      textInputAction: TextInputAction.newline,
                    ),
                  ),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(Icons.send),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
