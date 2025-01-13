import 'package:flutter/material.dart';

class AudioControlIcons extends StatelessWidget {
  final void Function() func;
  final IconData icon;
  final double size;
  final Color iconColor;
  const AudioControlIcons(
      {super.key,
      required this.func,
      required this.icon,
      required this.size,
      required this.iconColor});

  @override
  Widget build(BuildContext context) {
    return IconButton(
        onPressed: func,
        icon: Icon(
          icon,
          size: size,
          color: iconColor,
        ));
  }
}