import 'package:flutter/material.dart';
import 'package:lab_mind_frontend/utils/constants/constant_strings.dart';

class AppBarGB extends StatelessWidget implements PreferredSizeWidget {
  const AppBarGB({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(
        MAIN_TITLE_STR,
        style: TextStyle(
          color: Colors.white
        ),
      ),
      backgroundColor: Colors.transparent,
      centerTitle: true,
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 15, left: 15),
          child: Icon(
            Icons.compass_calibration_outlined,
            color: Colors.green,
          ),
        ),
      ],
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
