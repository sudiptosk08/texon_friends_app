// ignore_for_file: avoid_print

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:friends_app/constant/base_state.dart';
import 'package:friends_app/scr/features/friendList_screen/model/get_friend_list_model.dart';
import 'package:friends_app/scr/features/friendList_screen/state/friend_list_state.dart';

import '../../../../network_utils/api.dart';
import '../../../../network_utils/network_utils.dart';

/// Providers

final friendListProvider =
    StateNotifierProvider<GetFriendListController, BaseState>(
  (ref) => GetFriendListController(ref: ref),
);

/// Controllers

class GetFriendListController extends StateNotifier<BaseState> {
  final Ref? ref;

  GetFriendListController({this.ref}) : super(const InitialState());
  UserModel? getFriendListModel;

  Future fetchFriendList() async {
    state = const LoadingState();
    dynamic responseBody;
    try {
      responseBody = await Network.handleResponse(
        await Network.getRequest(API.user),
      );
      if (responseBody != null) {
        getFriendListModel =
            UserModel.fromJson(responseBody);
        state = FriendSuccessState(getFriendListModel);
        print("fetch friend List state");
        print("$responseBody");
      } else {
        state = const ErrorState();
      }
    } catch (error, stackTrace) {
      print("error = $error");
      print("error = $stackTrace");
      state = const ErrorState();
    }
  }
}
