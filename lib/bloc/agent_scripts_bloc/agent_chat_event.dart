import 'package:equatable/equatable.dart';

class AgentChatEvent extends Equatable {
  const AgentChatEvent();

  @override
  List<Object?> get props => [];
}

class AgentChatGetMessagesEvent extends AgentChatEvent {
  final String script;

  const AgentChatGetMessagesEvent(this.script);

  @override
  List<Object?> get props => [script];
}

class AgentChatClearChatEvent extends AgentChatEvent {

  const AgentChatClearChatEvent();

  @override
  List<Object?> get props => [];
}