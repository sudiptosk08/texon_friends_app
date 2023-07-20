import 'package:friends_app/constant/base_state.dart';

import '../model/get_friend_list_model.dart';

class FriendSuccessState extends SuccessState {
  final UserModel? userModel;

  const FriendSuccessState(this.userModel);
}
