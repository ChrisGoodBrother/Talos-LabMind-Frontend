
import 'package:get_it/get_it.dart';
import 'package:lab_mind_frontend/bloc/server_bloc.dart';
import 'package:lab_mind_frontend/data/services/server_services.dart';

final getIt = GetIt.instance;

void initServicesDependencies() {
  getIt.registerLazySingleton<ServerServices>(() => ServerServices());
}

void initBlocDependencies() {
  getIt.registerLazySingleton<ServerBloc>(() => ServerBloc(getIt<ServerServices>()));
}