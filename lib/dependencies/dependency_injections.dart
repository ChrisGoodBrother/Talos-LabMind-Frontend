
import 'package:get_it/get_it.dart';
import 'package:lab_mind_frontend/bloc/agent_scripts_bloc/agent_chat_bloc.dart';
import 'package:lab_mind_frontend/bloc/server_connection_bloc/server_bloc.dart';
import 'package:lab_mind_frontend/data/services/server_services.dart';

final getIt = GetIt.instance;

void initServicesDependencies() {
  getIt.registerLazySingleton<ServerServices>(() => ServerServices());
}

void initBlocDependencies() {
  getIt.registerLazySingleton<ServerBloc>(() => ServerBloc(getIt<ServerServices>()));
  getIt.registerLazySingleton<AgentChatBloc>(() => AgentChatBloc(getIt<ServerServices>()));
}