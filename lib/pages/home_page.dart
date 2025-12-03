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
import 'package:lab_mind_frontend/widgets/background_wrapper.dart';
import 'package:lab_mind_frontend/widgets/chat_box.dart';
import 'package:lab_mind_frontend/widgets/drop_down_menu.dart';

@RoutePage()
class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final scripts = useState<List<String>>([]);

    String selectedScript = "";

    useEffect(() {
      context.read<ServerBloc>().add(CheckServerConnectionEvent());

      return () {};
    }, []);

    return BackgroundWrapper(
      child: Scaffold(
        backgroundColor: Colors.transparent,
        appBar: const AppBarGB(),
        body: Center(
          child: Container(
            child: Padding(
              padding: const EdgeInsets.only(left: 0, right: 0),
              child: BlocConsumer<ServerBloc, ServerState>(
                listener: (context, state) {
                  if (state is ServerConnectedState) {
                    scripts.value = state.scripts;
                  }
                },
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
                
                  if (state is ServerConnectedState) {
                    return Column(
                      children: [
                        Padding(
                          padding: EdgeInsets.only(top: 30),
                          child: SizedBox(
                            child: Text(
                              SERVER_CONNECTED_STR,
                              style: TextStyle(
                                color: const Color.fromARGB(255, 0, 255, 8),
                              ),
                            ),
                          ),
                        ),
                        DropDownMenu(scripts: scripts.value, onSelected: (value) {
                          selectedScript = value!;
                        },),
                        TextButton(
                          onPressed: () {
                            context.read<AgentChatBloc>().add(AgentChatGetMessagesEvent(selectedScript));
                          },
                          child: Text("Run Script"),
                        ),
                        TextButton(
                          onPressed: () {
                            context.read<AgentChatBloc>().add(AgentChatForceStopScriptEvent());
                          },
                          child: Text("Stop Script"),
                        ),
                        ChatBox(),
                      ],
                    );
                  }
                
                  return Text("error");
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
