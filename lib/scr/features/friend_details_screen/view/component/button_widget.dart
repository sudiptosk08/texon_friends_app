import 'package:flutter/material.dart';
import 'package:friends_app/utils/styles/k_colors.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final VoidCallback onClicked;
  final IconData? icon;

  const ButtonWidget({
    Key? key,
    required this.text,
    required this.onClicked,
    required this.icon,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) => ElevatedButton(
        style: ElevatedButton.styleFrom(
          minimumSize: const Size(25, 40),
          backgroundColor: KColor.bluegrey,
          shape: const StadiumBorder(),
        ),
        onPressed: onClicked,
        child: FittedBox(
          child: Column(
            children: [
              Icon(icon),
            ],
          ),
        ),
      );
}
