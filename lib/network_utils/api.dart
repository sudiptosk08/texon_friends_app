
import 'package:friends_app/constant/app_mode.dart';

class API {
  static const live = 'https://randomuser.me/'; // Live Production  URL
  static const test = 'https://randomuser.me/'; // Live Staging API URL
  static const base = AppMode.PRODUCTION_MODE ? live : test;

  // //

  static const user = 'api?results=10';
 
}
