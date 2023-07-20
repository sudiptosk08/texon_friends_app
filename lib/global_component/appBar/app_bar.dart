import 'package:flutter/material.dart';
import 'package:friends_app/utils/styles/k_colors.dart';
import 'package:friends_app/utils/styles/k_text_style.dart';

class KAppBar extends StatelessWidget {
  final String? title;
  final bool checkTitle;
  final List<Widget>? actions;
  final Widget? leading;
  const KAppBar({
    this.title,
    this.checkTitle = false,
    this.actions,
    this.leading,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: KColor.bluegrey,
      automaticallyImplyLeading: false,
      centerTitle: true,
      title: Text('$title',
          style: KTextStyle.subtitle1.copyWith(color: KColor.black)),
      elevation: 0,
      leading: leading,
      actions: actions,
    );
  }
}
