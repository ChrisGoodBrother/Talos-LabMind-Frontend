import 'package:flutter/material.dart';
import 'package:lab_mind_frontend/utils/constants/constant_strings.dart';
import 'package:lab_mind_frontend/utils/styles/colors.dart';

class AppBarGB extends StatelessWidget implements PreferredSizeWidget {
  const AppBarGB({super.key});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      title: Text(MAIN_TITLE_STR),
      leading: const Image(image: AssetImage('assets/images/agent.jpg')),
      backgroundColor: Color.fromARGB(255, 0, 89, 255),
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
      flexibleSpace: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              MyColors.appBarColor1,
              MyColors.appBarColor2,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(kToolbarHeight);
}
