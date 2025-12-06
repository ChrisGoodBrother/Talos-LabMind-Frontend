import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class AgentCreator extends HookWidget {
  const AgentCreator({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final nameController = useTextEditingController();
    final roleController = useTextEditingController();
    final descriptionController = useTextEditingController();

    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        color: Color.fromARGB(148, 0, 0, 0),
        child: Center(
          child: Column(
            children: [
              Text(
                "Create Your Agent",
                style: TextStyle(color: Colors.white),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: "Give a name",
                    border: OutlineInputBorder(),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: roleController,
                  decoration: InputDecoration(
                    hintText: "Give a role",
                    border: OutlineInputBorder(),
                  ),
                  minLines: 1,
                  maxLines: 3,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TextFormField(
                  controller: descriptionController,
                  decoration: InputDecoration(
                    hintText: "Give a short description",
                    border: OutlineInputBorder(),
                  ),
                  minLines: 1,
                  maxLines: 1,
                  keyboardType: TextInputType.multiline,
                  textInputAction: TextInputAction.newline,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
