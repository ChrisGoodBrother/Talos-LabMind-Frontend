import 'package:equatable/equatable.dart';
import 'package:lab_mind_frontend/data/models/agent_model.dart';

class AgentChatEvent extends Equatable {
  const AgentChatEvent();

  @override
  List<Object?> get props => [];
}

class AgentChatGetMessagesEvent extends AgentChatEvent {
  final String firstMessage;
  final List<AgentModel> scripts;

  const AgentChatGetMessagesEvent(this.firstMessage, this.scripts);

  @override
  List<Object?> get props => [firstMessage, scripts];
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