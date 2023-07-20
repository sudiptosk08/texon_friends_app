import 'package:animate_do/animate_do.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:friends_app/utils/assets/app_assets.dart';
import 'package:friends_app/utils/styles/k_colors.dart';
import 'package:friends_app/utils/styles/k_text_style.dart';
import 'package:friends_app/scr/features/friendList_screen/view/friendList_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Future.delayed(
      const Duration(seconds: 6),
      () {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: ((context) => const FriendListScreen())));
      },
    );
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Scaffold(
        backgroundColor: KColor.white,
        body: Center(
        child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Padding(
              padding: EdgeInsets.only(top: size.height * .1),
              child: Image.asset(
                AssetsPath.connectingVirtual,
                fit: BoxFit.fill,
              )),
          const SizedBox(
            height: 20,
          ),
          Padding(
            padding: const EdgeInsets.all(35.0),
            child: Column(
              children: [
                Text(
                  "Connect With Friends",
                  textAlign: TextAlign.center,
                  style: KTextStyle.headline4
                ),
                FadeInUp(
                  delay: const Duration(milliseconds: 100),
                  child: SizedBox(
                    width: 25,
                    height: 35,
                    child: Center(
                        child: SpinKitFoldingCube(
                      size: 15,
                      itemBuilder: (BuildContext context, int index) {
                        return DecoratedBox(
                          decoration: BoxDecoration(
                            color: KColor.bluegrey,
                          ),
                        );
                      },
                    )),
                  ),
                ),
              ],
            ),
          ),
            Image.asset(
            AssetsPath.splash,
            fit: BoxFit.fill,
          ),
        
        ],
        ),
        ));
  }
}
