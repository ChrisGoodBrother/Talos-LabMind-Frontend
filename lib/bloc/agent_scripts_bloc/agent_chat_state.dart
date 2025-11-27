import 'package:equatable/equatable.dart';
import 'package:lab_mind_frontend/models/chat_message.dart';

abstract class AgentChatState extends Equatable {}

class AgentChatEmptyChatState extends AgentChatState {
  @override
  List<Object?> get props => [];
}

class AgentChatLoadingState extends AgentChatState {
  @override
  List<Object?> get props => [];
}

class AgentChatNewMessageState extends AgentChatState {
  final ChatMessage chatMessage;

  AgentChatNewMessageState(this.chatMessage);

  @override
  List<Object?> get props => [chatMessage];
}

class AgentChatLoadedState extends AgentChatState {
  @override
  List<Object?> get props => [];
}
