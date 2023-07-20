// ignore_for_file: must_be_immutable, file_names

import 'package:flutter/material.dart';
import 'package:friends_app/global_component/buttons/custom_button.dart';
import 'package:friends_app/utils/extension/extension.dart';
import 'package:friends_app/utils/styles/k_colors.dart';
import 'package:friends_app/utils/styles/k_size.dart';
import 'package:friends_app/utils/styles/k_text_style.dart';

class FriendListCard extends StatefulWidget {
  int? id;
  final String? img;
  final String? title;
  final String? firstName;
  final String? lastName;
  final String? country;
  final VoidCallback? add;

  FriendListCard({
    required this.img,
    required this.id,
    this.title,
    this.firstName,
    this.lastName,
    this.country,
    this.add,
    Key? key,
  }) : super(key: key);

  @override
  State<FriendListCard> createState() => _FriendListCardState();
}

class _FriendListCardState extends State<FriendListCard> {
  int count = 0;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          //padding: const EdgeInsets.all(8),
          margin: const EdgeInsets.only(bottom: 4),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              color: KColor.white,
              border:
                  Border.all(color: KColor.grey.withOpacity(0.4), width: 0.4)),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              SizedBox(
                width: context.screenWidth * 0.27,
                height: context.screenHeight * 0.13,
                child: Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: ClipRRect(
                    borderRadius: const BorderRadius.all(
                      Radius.circular(4),
                    ),
                    child: Image.network(
                      '${widget.img}',
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(6.0),
                child: SizedBox(
                  width: KSize.getWidth(context, 220),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            Icons.person,
                            color: KColor.bluegrey,
                          ),
                          Text(
                            '${widget.title} ${widget.firstName} ${widget.lastName}',
                            maxLines: 2,
                            style: KTextStyle.bodyText1
                                .copyWith(color: KColor.black),
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Icon(
                            Icons.location_on,
                            color: KColor.bluegrey,
                          ),
                          Text('${widget.country}',
                              style: KTextStyle.bodyText1),
                        ],
                      ),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 0.0, right: 8.0),
                        child: CustomButton(
                            width: KSize.getWidth(context, 200),
                            height: 35,
                            color: KColor.bluegrey,
                            name: "More About",
                            onTap: widget.add),
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 40),
            ],
          ),
        ),
      ],
    );
  }
}
