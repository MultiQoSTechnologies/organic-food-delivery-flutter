
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/route_manager.dart';

import '../constant/app_assets.dart';
import '../constant/font_style.dart';
import '../constant/message_constant.dart';
import '../route/app_route.dart';
import '../theme/app_color.dart';

class LandingPage extends StatefulWidget {
  const LandingPage({Key? key}) : super(key: key);

  @override
  State<LandingPage> createState() => _LandingPageState();
}

class _LandingPageState extends State<LandingPage> with TickerProviderStateMixin {
  ///* Initialize All Animation Controller and Variables.*///
  late final AnimationController _controller = AnimationController(
    duration: const Duration(seconds: 40),
    vsync: this,
  )..repeat(reverse: false);

  late final Animation<double> _animation;
  late AnimationController controller;

  late final AnimationController controller1 = AnimationController(
    duration: const Duration(milliseconds: 2000),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<double> animation1 = CurvedAnimation(
    parent: controller1,
    curve: Curves.fastOutSlowIn,
  );

  late final AnimationController controller2 = AnimationController(
    duration: const Duration(seconds: 3),
    vsync: this,
  )..repeat(reverse: true);
  late final Animation<Offset> _offsetAnimation = Tween<Offset>(
    begin: const Offset(0.0, -0.10),
    end: const Offset(0.0, 0.13),
  ).animate(CurvedAnimation(
    parent: controller2,
    curve: Curves.decelerate,
  ));

  ///*  All Animation are Called in Initial State.*///
  @override
  void initState() {
    _animation = CurvedAnimation(
      parent: _controller,
      curve: Curves.linear,
    );
    controller = AnimationController(
        duration: const Duration(milliseconds: 700), vsync: this);
    controller.repeat(reverse: true);
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
    controller1.dispose();
    controller2.dispose();
    controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.black,
      body: SafeArea(
        child: Stack(
          children: [
            SizedBox(
              height: double.infinity,
              width: double.infinity,
              child: Image.asset(
                AssetsImages.startBackground,
                fit: BoxFit.cover,
              ),
            ),

            ///* Add Rotation Animation.*///
            Positioned(
              bottom: -80,
              left: -80,
              child: SizedBox(
                height: MediaQuery.of(context).size.height / 2.2,
                width: MediaQuery.of(context).size.height / 2.2,
                child: RotationTransition(
                  turns: _animation,
                  child: Container(
                      alignment: Alignment.bottomLeft,
                      child: Image.asset(
                        AssetsImages.icPlat,
                        fit: BoxFit.cover,
                      )),
                ),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ///* Add SlideTransition Animation.*///
                SlideTransition(
                  position: _offsetAnimation,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 5.0),
                    child: Text(
                      MessageConstant.createYourOwnTest,
                      style: AppFontStyle.boldDancingScriptTextFiled
                          .copyWith(color: AppColors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Container(

                  margin:
                      const EdgeInsets.only(left: 10.0, right: 10.0, top: 15.0),
                  alignment: Alignment.center,
                  child: Text(
                    MessageConstant.description,
                    maxLines: 2,
                    style: AppFontStyle.regularBahnschriftTextFiled
                        .copyWith(color: AppColors.white, fontSize: 22.0),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),

                ///*Add ScaleTransition(Bounce) Animation In Arrow Forword Button.*///
                InkWell(
                  splashColor: Colors.transparent,
                  highlightColor: Colors.transparent,
                  onTap: () {
                    Get.toNamed(Routes.homePage);
                  },
                  child: Container(
                    height: 130,
                    width: 110,
                    padding: const EdgeInsets.all(15),
                    margin: const EdgeInsets.only(top: 10.0),
                    alignment: Alignment.centerRight,
                    decoration: BoxDecoration(
                      image: DecorationImage(
                        image: Image.asset(AssetsImages.icArrowText).image,
                      ),
                    ),
                    child: ScaleTransition(
                      scale: animation1,
                      child: SvgPicture.asset(
                        AssetsImages.icArrowForward,
                        fit: BoxFit.scaleDown,
                        width: 55,
                        height: 55,
                      ),
                    ),
                  ),
                ),
                const Spacer()
              ],
            )
          ],
        ),
      ),
    );
  }
}
