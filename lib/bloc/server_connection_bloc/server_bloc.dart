import 'dart:developer';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:lab_mind_frontend/bloc/server_connection_bloc/server_event.dart';
import 'package:lab_mind_frontend/bloc/server_connection_bloc/server_state.dart';
import 'package:lab_mind_frontend/data/services/server_services.dart';

class ServerBloc extends Bloc<ServerEvent, ServerState> {
  final ServerServices serverServices;

  ServerBloc(this.serverServices) : super(ServerDisconnectedState()) {
    on<CheckServerConnectionEvent>(
      (event, emit) async {
        emit(ServerConnectingState());
        bool isConnected;
        try {
          isConnected = await serverServices.checkServerConnection();
          if(isConnected) {

            final scripts = await serverServices.getScripts();
            
            emit(ServerConnectedState(scripts));
            log("Server Connected");
          } else {
            emit(ServerDisconnectedState());
            log("Server Not Conneceted");
          }
        } catch (e) {
          log(e.toString());
        }
      },
    );
  }
}
