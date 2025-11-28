import 'package:flutter/material.dart';
import 'package:flutter_hooks/flutter_hooks.dart';

class DropDownMenu extends HookWidget {
  final List<String> scripts;
  final void Function(String?) onSelected;

  const DropDownMenu({
    super.key,
    required this.scripts,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {

    return DropdownMenu<String>(
      hintText: "Select a script",
      requestFocusOnTap: false,
      initialSelection: "",
      enableSearch: false,
      trailingIcon: Icon(
        Icons.keyboard_arrow_down_sharp,
        size: 20,
      ),
      selectedTrailingIcon: Icon(
        Icons.keyboard_arrow_up_sharp,
        size: 20,
      ),
      inputDecorationTheme: InputDecorationTheme(
        filled: true,
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).colorScheme.onSurface.withValues(alpha: 0.1),
            width: 0.6,
          ),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).colorScheme.primary.withValues(alpha: 1), width: 0.6),
        ),
      ),
      dropdownMenuEntries: [
        for (String script in scripts)
          DropdownMenuEntry<String>(
            label: script,
            value: script,
          ),
      ],
      onSelected: onSelected,
      //menuHeight: 200,
    );
  }
}
