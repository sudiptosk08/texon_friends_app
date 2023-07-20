import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:friends_app/global_component/appBar/app_bar.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:friends_app/utils/styles/k_size.dart';
import 'package:friends_app/utils/styles/k_text_style.dart';
import 'package:friends_app/scr/features/friend_details_screen/view/component/button_widget.dart';

import '../../../../utils/styles/k_colors.dart';

class DetailsAbout extends ConsumerStatefulWidget {
  DetailsAbout({
    required this.id,
    required this.img,
    required this.title,
    required this.firstName,
    required this.lastName,
    required this.city,
    required this.state,
    required this.country,
    required this.contactNumber,
    required this.email,
    required this.password,
  });
  int? id;
  final String? img;
  final String? title;
  final String? firstName;
  final String? lastName;
  final String? city;
  final String? state;
  final String? country;
  final String? contactNumber;
  final String? email;
  final String? password;

  @override
  ConsumerState createState() => _DetailsAboutState();
}

class _DetailsAboutState extends ConsumerState<DetailsAbout> {
  int index = 0;

  Future<void>? _launched;

  Future<void> _launchInBrowser(Uri url) async {
    if (!await launchUrl(
      url,
      mode: LaunchMode.externalApplication,
    )) {
      throw Exception('Could not launch $url');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: KColor.appBackground,
      appBar: PreferredSize(
        preferredSize: const Size.fromHeight(50),
        child: KAppBar(
          title: "Details",
          leading: IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(
              Icons.arrow_back_ios,
              color: KColor.black,
              size: 20,
            ),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Container(
              height: KSize.getHeight(context, 80),
              width: MediaQuery.of(context).size.width,
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    transform: GradientRotation(2.089),
                    end: Alignment.bottomCenter,
                    colors: [
                      KColor.bluegrey,
                      KColor.bluegrey,
                    ],
                  ),
                  borderRadius: const BorderRadius.only(
                      bottomLeft: Radius.circular(25),
                      bottomRight: Radius.circular(25))),
            ),
            Transform.translate(
              offset: Offset(0, KSize.getHeight(context, -80)),
              child: Container(
                margin: const EdgeInsets.all(20),
                width: MediaQuery.of(context).size.width,
                height: KSize.getHeight(context, 230),
                decoration: BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.5),
                      blurRadius: 10,
                      offset: const Offset(4, 8), // Shadow position
                    ),
                  ],
                  color: KColor.appBackground,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(KSize.getHeight(context, 4)),
                    topRight: Radius.circular(
                      KSize.getHeight(context, 4),
                    ),
                  ),
                ),
                child: Stack(children: [
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 2),
                    child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Container(
                            height: 90,
                            decoration: BoxDecoration(
                                color: KColor.grey100,
                                border: Border(
                                    bottom: BorderSide(
                                        color: KColor.grey.withOpacity(0.3),
                                        width: 0.6))),
                          ),
                        ]),
                  ),
                  Positioned(
                    top: 20,
                    left: 95,
                    child: Container(
                      decoration: BoxDecoration(
                        border: Border.all(
                            color: KColor.grey.withOpacity(0.3), width: 0.6),
                        shape: BoxShape.circle,
                        color: KColor.white,
                      ),
                      child: Container(
                        height: KSize.getHeight(context, 120),
                        width: KSize.getWidth(context, 120),
                        margin: const EdgeInsets.all(3),
                        decoration: BoxDecoration(
                          image: DecorationImage(
                            image: NetworkImage("${widget.img}"),
                            fit: BoxFit.cover,
                          ),
                          shape: BoxShape.circle,
                          color: KColor.white,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 15,
                    child: SizedBox(
                      width: MediaQuery.of(context).size.width * 0.89,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          ButtonWidget(
                            text: 'user',
                            icon: Icons.person,
                            onClicked: () => setState(() => index = 0),
                          ),
                          ButtonWidget(
                            text: 'phone',
                            icon: Icons.phone,
                            onClicked: () => setState(() => index = 1),
                          ),
                          ButtonWidget(
                            text: 'email',
                            icon: Icons.email,
                            onClicked: () => setState(() => index = 2),
                          ),
                          ButtonWidget(
                            text: 'password',
                            icon: Icons.password,
                            onClicked: () => setState(() => index = 3),
                          ),
                          ButtonWidget(
                            text: 'address',
                            icon: Icons.location_on,
                            onClicked: () => setState(() => index = 4),
                          ),
                        ],
                      ),
                    ),
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
      floatingActionButton: buildActionButton(),
    );
  }

  Widget buildActionButton() {
    switch (index) {
      case 0:
        return buildUserWidget();
      case 1:
        return buildPhoneWidget();
      case 2:
        return buildMailWidget();
      case 3:
        return buildPasswordWidget();
      case 4:
      default:
        return buildAddressWidget();
    }
  }

  Widget buildUserWidget() => SizedBox(
      width: double.infinity,
      height: KSize.getHeight(context, 400),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Icon(
            Icons.person,
            size: 25,
          ),
          Text(
            "Hi , My name is ",
            style: KTextStyle.bodyText1.copyWith(color: KColor.grey400),
          ),
          Text(
            "${widget.title} ${widget.firstName} ${widget.lastName}",
            style: KTextStyle.headline4,
          )
        ],
      ));

  Widget buildPhoneWidget() => SizedBox(
      width: double.infinity,
      height: KSize.getHeight(context, 400),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Icon(
            Icons.phone,
            size: 25,
          ),
          Text(
            "Contact with me",
            style: KTextStyle.bodyText1.copyWith(color: KColor.grey400),
          ),
          Text(
            "${widget.contactNumber}",
            style: KTextStyle.headline4,
          )
        ],
      ));

  Widget buildMailWidget() => GestureDetector(
        onTap: () => setState(() {
          final Uri emailLaunchUri = Uri(
            scheme: 'mailto',
            path: '${widget.email}',
          );
          _launched = launchUrl(emailLaunchUri);
        }),
        child: SizedBox(
            width: double.infinity,
            height: KSize.getHeight(context, 400),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const Icon(
                  Icons.mail_rounded,
                  color: KColor.errorRedText,
                  size: 25,
                ),
                Text(
                  "E-mail address is",
                  style: KTextStyle.bodyText1.copyWith(color: KColor.grey400),
                ),
                Text(
                  "${widget.email}",
                  style: KTextStyle.headline4,
                )
              ],
            )),
      );
  Widget buildPasswordWidget() => SizedBox(
      width: double.infinity,
      height: KSize.getHeight(context, 400),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Icon(
            Icons.remove_red_eye,
            size: 25,
          ),
          Text(
            "My Password is",
            style: KTextStyle.bodyText1.copyWith(color: KColor.grey400),
          ),
          Text(
            "${widget.password}",
            style: KTextStyle.headline4,
          )
        ],
      ));
  Widget buildAddressWidget() => SizedBox(
      width: double.infinity,
      height: KSize.getHeight(context, 400),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          const Icon(
            Icons.location_city,
            size: 25,
          ),
          Text(
            "My Address is",
            style: KTextStyle.bodyText1.copyWith(color: KColor.grey400),
          ),
          Text(
            "${widget.city} ,${widget.state} ,${widget.country}",
            style: KTextStyle.headline4,
          )
        ],
      ));
}
