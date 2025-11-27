import 'package:auto_route/annotations.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:lab_mind_frontend/bloc/server_bloc.dart';
import 'package:lab_mind_frontend/bloc/server_event.dart';
import 'package:lab_mind_frontend/bloc/server_state.dart';
import 'package:lab_mind_frontend/utils/constants/constant_strings.dart';

@RoutePage()
class HomePage extends HookWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final List<DropdownMenuItem> scripts = [];

    useEffect(() {
      context.read<ServerBloc>().add(CheckServerConnectionEvent());

      return () {};
    }, []);

    return Scaffold(
      appBar: AppBar(
        title: Text(MAIN_TITLE_STR),
        backgroundColor: Color.fromARGB(255, 0, 89, 255),
      ),

      body: Center(
        child: Padding(
          padding: const EdgeInsets.only(left: 100, right: 100),
          child: Column(
            children: [
              BlocBuilder<ServerBloc, ServerState>(
                builder: (context, state) {
                  if (state is ServerConnectedState) {
                    for (var script in state.scripts) {
                      scripts.add(
                        DropdownMenuItem(
                          value: script,
                          child: Text(script),
                        ),
                      );
                    }

                    return Padding(
                      padding: EdgeInsets.only(top: 50),
                      child: SizedBox(
                        child: Text(SERVER_CONNECTED_STR),
                      ),
                    );
                  }

                  if (state is ServerDisconnectedState) {
                    return Padding(
                      padding: EdgeInsets.only(top: 50),
                      child: SizedBox(
                        child: Text(
                          SERVER_NOT_CONNECTED_STR,
                        ),
                      ),
                    );
                  }

                  return Container();
                },
              ),

              DropdownButton(
                items: scripts,
                hint: Text("Choose a script"),
                onChanged: (value) {
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
