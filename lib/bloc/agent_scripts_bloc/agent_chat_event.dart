import 'package:equatable/equatable.dart';

class AgentChatEvent extends Equatable {
  const AgentChatEvent();

  @override
  List<Object?> get props => [];
}

class AgentChatGetMessagesEvent extends AgentChatEvent {
  final List<String> scripts;

  const AgentChatGetMessagesEvent(this.scripts);

  @override
  List<Object?> get props => [scripts];
}

class AgentChatClearChatEvent extends AgentChatEvent {

  const AgentChatClearChatEvent();

  @override
  List<Object?> get props => [];
}

class AgentChatForceStopScriptEvent extends AgentChatEvent {
  const AgentChatForceStopScriptEvent();

  @override
  List<Object?> get props => [];
}