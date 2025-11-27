import 'package:equatable/equatable.dart';

abstract class ServerState extends Equatable {}

class ServerConnectedState extends ServerState {
  
  final List<String> scripts;

  ServerConnectedState(this.scripts);
  
  @override
  List<Object?> get props => [scripts];
}

class ServerDisconnectedState extends ServerState {
  @override
  List<Object?> get props => [];
}
