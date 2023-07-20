import 'package:flutter/material.dart';
import 'package:friends_app/utils/styles/k_text_style.dart';


class CustomButton extends StatelessWidget {
  const CustomButton(
      {super.key,
      required this.name,
      required this.onTap,
      required this.width,
      required this.height,
      required this.color});
  final String name;
  final double width;
  final double height;
  final Color color;
  final VoidCallback? onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        decoration:
            BoxDecoration(color: color, borderRadius: BorderRadius.circular(8)),
        child: Center(
          child: Text(
            name,
            style: KTextStyle.bodyText1,
          ),
        ),
      ),
    );
  }
}
