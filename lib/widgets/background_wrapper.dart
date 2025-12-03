import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class BackgroundWrapper extends StatelessWidget {
  final Widget child;
  const BackgroundWrapper({
    super.key,
    required this.child,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            //color: Colors.transparent,
            image: DecorationImage(
              image: AssetImage("assets/images/riiple.jpg"),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            //color: Colors.transparent,
            image: DecorationImage(
              image: AssetImage("assets/images/robot.png"),
              fit: BoxFit.contain,
              scale: 4,
            ),
          ),
        ),
        child,
      ],
    );
  }
}
