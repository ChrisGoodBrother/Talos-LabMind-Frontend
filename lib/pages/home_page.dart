import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lab_mind_frontend/bloc/agent_scripts_bloc/agent_chat_bloc.dart';
import 'package:lab_mind_frontend/bloc/agent_scripts_bloc/agent_chat_event.dart';
import 'package:lab_mind_frontend/bloc/server_connection_bloc/server_bloc.dart';
import 'package:lab_mind_frontend/bloc/server_connection_bloc/server_event.dart';
import 'package:lab_mind_frontend/bloc/server_connection_bloc/server_state.dart';
import 'package:lab_mind_frontend/utils/constants/constant_strings.dart';
import 'package:lab_mind_frontend/utils/styles/colors.dart';
import 'package:lab_mind_frontend/widgets/app_bar.dart';
import 'package:lab_mind_frontend/widgets/chat_box.dart';

@RoutePage()
class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<String> scripts = [];

    String selectedScript = "coder_reviewer.py";

    useEffect(() {
      context.read<ServerBloc>().add(CheckServerConnectionEvent());

      return () {};
    }, []);

    return Scaffold(
      appBar: const AppBarGB(),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              MyColors.backgroundColor1,
              MyColors.backgroundColor2,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
        child: Center(
          child: Padding(
            padding: const EdgeInsets.only(left: 100, right: 100),
            child: Column(
              children: [
                BlocBuilder<ServerBloc, ServerState>(
                  builder: (context, state) {
                    if (state is ServerConnectingState) {
                      return Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: SizedBox(
                          child: Text(
                            SERVER_CONNECTING_STR,
                            style: TextStyle(
                              color: Colors.yellow,
                            ),
                          ),
                        ),
                      );
                    }

                    if (state is ServerConnectedState) {
                      for (var script in state.scripts) {
                        scripts.add(script);
                      }

                      return Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: SizedBox(
                          child: Text(
                            SERVER_CONNECTED_STR,
                            style: TextStyle(
                              color: const Color.fromARGB(255, 0, 255, 8),
                            ),
                          ),
                        ),
                      );
                    }

                    if (state is ServerDisconnectedState) {
                      return Padding(
                        padding: EdgeInsets.only(top: 30),
                        child: SizedBox(
                          child: Text(
                            SERVER_NOT_CONNECTED_STR,
                            style: TextStyle(
                              color: const Color.fromARGB(255, 255, 0, 0),
                            ),
                          ),
                        ),
                      );
                    }

                    return Container();
                  },
                ),
                DropdownButtonFormField<String>(
                  items: scripts.map(
                    (option) => DropdownMenuItem<String>(
                      value: option,
                      child: Text(option),
                    )).toList(),
                  decoration: InputDecoration(
                    labelText: "Select a script",
                    border: OutlineInputBorder(),
                  ),
                  onChanged: (value) {
                    selectedScript = value!;
                  },
                  validator: (value) {
                    if(value == null) {
                      return "Select";
                    }
                    return null;
                  },
                ),
                TextButton(
                  onPressed: () {
                    context.read<AgentChatBloc>().add(AgentChatGetMessagesEvent(selectedScript));
                  },
                  child: Text("Run Script"),
                ),
                ChatBox(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
