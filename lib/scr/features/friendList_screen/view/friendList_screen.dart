// ignore_for_file: file_names
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:friends_app/global_component/appBar/app_bar.dart';
import 'package:friends_app/scr/features/friendList_screen/controller/get_friendList_controller.dart';
import 'package:friends_app/scr/features/friendList_screen/state/friend_list_state.dart';
import 'package:friends_app/utils/styles/k_colors.dart';
import 'package:friends_app/scr/features/friendList_screen/view/component/friendList_card.dart';
import 'package:friends_app/scr/features/friend_details_screen/view/friend_details_screen.dart';
import 'package:nb_utils/nb_utils.dart';

import '../model/get_friend_list_model.dart';


class FriendListScreen extends StatefulWidget {
  const FriendListScreen({super.key});

  @override
  State<FriendListScreen> createState() => _FriendListScreenState();
}

class _FriendListScreenState extends State<FriendListScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(50),
        child: KAppBar(
          title: "Friends List",
        ),
      ),
      backgroundColor: KColor.white,
      body: Consumer(builder: (context, ref, _) {
        final friendListState = ref.watch(friendListProvider);
        final List<Result> friendList =
            friendListState is FriendSuccessState
                ? friendListState.userModel!.results
                : [];
        // final Uri telegram = Uri.parse("$telegramUrl");
        // final Uri whatsApp = Uri.parse('$whatsappUrl');
        // final Uri emailLaunchUri = Uri(
        //   scheme: 'mailto',
        //   path: '$email',
        // );
        return SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
            child: Column(
              children: [
                ListView.builder(
                  physics: const BouncingScrollPhysics(
                      decelerationRate: ScrollDecelerationRate.fast),
                  shrinkWrap: true,
                  itemCount: friendList.length,
                  itemBuilder: (ctx, index) {
                    return FriendListCard(
                      img: friendList[index].picture.large,
                      id:  friendList[index].id.value.toInt(),
                      title:  friendList[index].name.title,
                      firstName:  friendList[index].name.first,
                      lastName: friendList[index].name.last,
                      country:  friendList[index].location.country,
                      add: () {
                       
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>  DetailsAbout(
                                img: friendList[index].picture.large,
                                id: friendList[index].id.value.toInt(),
                                title: friendList[index].name.title,
                                firstName: friendList[index].name.first,
                                lastName: friendList[index].name.last,
                                country: friendList[index].location.country,
                                city: friendList[index].location.city,
                                state: friendList[index].location.state,
                                contactNumber:  friendList[index].cell,
                                email:  friendList[index].email,
                                password: friendList[index].login.password,
                              ),
                            ));
                      },
                    );
                  },
                ),
              ],
            ),
          ),
        );
      }),
    );
  }
}
