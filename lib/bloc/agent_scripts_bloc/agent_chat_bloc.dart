import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab_mind_frontend/bloc/agent_scripts_bloc/agent_chat_event.dart';
import 'package:lab_mind_frontend/bloc/agent_scripts_bloc/agent_chat_state.dart';
import 'package:lab_mind_frontend/data/services/server_services.dart';
import 'package:lab_mind_frontend/models/chat_message.dart';
import 'package:lab_mind_frontend/utils/helper_functions.dart/chat_message_functions.dart';

class AgentChatBloc extends Bloc<AgentChatEvent, AgentChatState> {
  final ServerServices serverServices;
  final processedMessages = <String>{};

  AgentChatBloc(this.serverServices) : super(AgentChatEmptyChatState()) {
    on<AgentChatGetMessagesEvent>(
      (event, emit) async {
        emit(AgentChatLoadingState());

        String buffer = "";
        processedMessages.clear();

        final subscription = serverServices.stream.listen(
          (text) {
            buffer += text;
            parseAndDisplayMessages(buffer, processedMessages, emit);
          },
        );

        try {
          await serverServices.runScript(event.script);

          parseAndDisplayMessages(buffer, processedMessages, emit);
          emit(AgentChatNewMessageState(ChatMessage(message: "Execution Completed", messageType: "system")));
        } catch (e) {
          if (e.toString() == "Empty Script") {
            emit(AgentChatNewMessageState(ChatMessage(message: "Please Select a Script", messageType: "system")));
          } else if (!e.toString().contains('network') && !e.toString().contains('aborted')) {
            emit(AgentChatNewMessageState(ChatMessage(message: "Error: $e", messageType: "system_error")));
          } else {
            // Connection closed normally after script finished
            parseAndDisplayMessages(buffer, processedMessages, emit);
            emit(AgentChatNewMessageState(ChatMessage(message: "Execution Completed", messageType: "system")));
          }
        }

        emit(AgentChatLoadedState());
        subscription.cancel();
      },
    );

    on<AgentChatForceStopScriptEvent>(
      (event, emit) async {
        try {
          await serverServices.stopScript();

          emit(AgentChatNewMessageState(ChatMessage(message: "Agent Conversation Stopped", messageType: "system")));
        } catch (e) {
          if (!e.toString().contains('network') && !e.toString().contains('aborted')) {
            emit(AgentChatNewMessageState(ChatMessage(message: "Error: $e", messageType: "system_error")));
          }
        }

        emit(AgentChatLoadedState());
      },
    );
  }
}
