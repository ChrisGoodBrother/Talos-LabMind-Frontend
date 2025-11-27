import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:lab_mind_frontend/bloc/server_bloc.dart';
import 'package:lab_mind_frontend/config/router.dart';
import 'package:lab_mind_frontend/dependencies/dependency_injections.dart';
import 'package:lab_mind_frontend/utils/styles/themes.dart';

void main() {
  initServicesDependencies();
  initBlocDependencies();

  runApp(
    BlocProvider(
      create: (context) => GetIt.instance<ServerBloc>(),
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    final _router = AppRouter();

    return MaterialApp.router(
      title: 'Flutter Demo',
      routerConfig: _router.config(),
      debugShowCheckedModeBanner: false,
      theme: appTheme,
    );
  }
}
