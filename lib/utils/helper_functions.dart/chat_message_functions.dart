import 'dart:developer';
import 'dart:math' hide log;

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab_mind_frontend/bloc/agent_scripts_bloc/agent_chat_state.dart';
import 'package:lab_mind_frontend/models/chat_message.dart';

void parseAndDisplayMessages(String fullText, Set<String> processedMessages, Emitter<AgentChatState> emit) {
  final sections = fullText.split(RegExp(r'\n-{10,}\n'));

  sections.asMap().forEach((index, section) {
    final lines = section.trim().split('\n');
    if (lines.isEmpty) return;

    for (int i = 0; i < lines.length; i++) {
      final line = lines[i].trim();

      final agentMatch = RegExp(r'^(\w+)\s+\(to\s+\w+\):$').firstMatch(line);
      if (agentMatch != null) {
        final sender = agentMatch.group(1);
        final messageId = 'msg-$sender-$index-$i';

        if (processedMessages.contains(messageId)) {
          continue;
        }

        String content = '';
        bool captureStarted = false;

        for (int j = i + 1; j < lines.length; j++) {
          final contentLine = lines[j];

          if (contentLine.contains('USING AUTO REPLY')) continue;
          if (contentLine.startsWith('INFO:') && !contentLine.contains('INFO:__main__:')) continue;
          if (contentLine.startsWith('ERROR:') && !contentLine.contains('ERROR:__main__:')) continue;
          if (contentLine.startsWith('WARNING:') && !contentLine.contains('WARNING:__main__:')) continue;

          if (RegExp(r'^\w+\s+\(to\s+\w+\):$').firstMatch(contentLine) != null) {
            break;
          }

          if (contentLine.trim().isNotEmpty || captureStarted) {
            content += '$contentLine\n';
            if (contentLine.trim().isNotEmpty) captureStarted = true;
          }
        }

        content = content.trim();
        if (content.isNotEmpty) {
          if (content.length < 50) {
            log("Short message from $sender: $content");
          }
          if (sender != null) {
            emit(AgentChatNewMessageState(ChatMessage(message: content, messageType: sender)));
          } else {
            log("sender is null");
          }

          processedMessages.add(messageId);
        } else {
          log("Empty content for $sender at section $index");
        }
        break;
      }

      if (line.contains("TERMINATING RUN")) {
        final terminateId = "terminate-msg";
        if (!processedMessages.contains(terminateId)) {
          emit(
            AgentChatNewMessageState(
              ChatMessage(message: '🛑 Conversation terminated (max turns reached)', messageType: "system"),
            ),
          );
          processedMessages.add(terminateId);
        }
      }

      if (line.startsWith('INFO:__main__:')) {
        final logContent = line.replaceAll('INFO:__main__:', '').trim();

        final logId = 'log-${logContent.substring(0, min(30, logContent.length))}';
        if (!processedMessages.contains(logId) && logContent.isNotEmpty) {
          emit(AgentChatNewMessageState(ChatMessage(message: logContent, messageType: "system")));
          processedMessages.add(logId);
        }
      }
    }
  });
}
