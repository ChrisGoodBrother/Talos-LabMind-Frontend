import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:lab_mind_frontend/bloc/agent_scripts_bloc/agent_chat_bloc.dart';
import 'package:lab_mind_frontend/bloc/server_connection_bloc/server_bloc.dart';
import 'package:lab_mind_frontend/config/router.dart';
import 'package:lab_mind_frontend/dependencies/dependency_injections.dart';
import 'package:lab_mind_frontend/utils/styles/themes.dart';

void main() {
  initServicesDependencies();
  initBlocDependencies();

  ServerBloc _serverBloc = GetIt.instance<ServerBloc>();
  AgentChatBloc _agentScriptBloc = GetIt.instance<AgentChatBloc>();

  runApp(
    MultiBlocProvider(
      providers: [
        BlocProvider.value(value: _serverBloc),
        BlocProvider.value(value: _agentScriptBloc),
      ],
      
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  MyApp({super.key});

  final _router = AppRouter();

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      title: 'Flutter Demo',
      routerConfig: _router.config(),
      debugShowCheckedModeBanner: false,
      theme: appTheme,
    );
  }
}
