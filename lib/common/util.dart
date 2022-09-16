import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:like_button/like_button.dart';

import '../constant/app_assets.dart';
import '../theme/app_color.dart';

class CustomBox extends StatelessWidget {
  double? height;
  double? width;
  Widget child;
  double radius;

  // bool isShadow;

  CustomBox(
      {this.height,
      this.width,
      required this.child,
      required this.radius,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: width,
      height: height,
      clipBehavior: Clip.hardEdge,
      // margin: EdgeInsets.only(left: 20,right: 20),
      decoration: BoxDecoration(
        color: AppColors.white,
        borderRadius: BorderRadius.all(Radius.circular(radius)),
        boxShadow: [
          BoxShadow(
            color: AppColors.boxShadow.withOpacity(0.10),
            blurRadius: 5.0,
          ),
        ],
      ),
      child: child,
    );
  }
}

class CustomCircleBox extends StatelessWidget {
  double width;
  double height;
  BoxFit? fit;
  Color? color;
  String imageName;
  bool isBorder;
  Gradient? gradientColor;

  CustomCircleBox(
      {required this.height,
      required this.width,
      this.fit,
      this.color,
      required this.imageName,
      required this.isBorder,
      this.gradientColor,
      Key? key})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: height,
      width: width,
      clipBehavior: Clip.hardEdge,
      decoration: BoxDecoration(
        color: color,
        gradient: gradientColor,
        shape: BoxShape.circle,
        border: isBorder == true
            ? Border.all(
                width: 1.5,
                color: AppColors.black,
              )
            : null,
      ),
      child: imageName != AssetsImages.icBlackHeart
          ? imageName.contains("svg")
              ? SvgPicture.asset(
                  imageName,
                  fit: BoxFit.scaleDown,
                )
              : Image.asset(
                  imageName,
                  fit: BoxFit.scaleDown,
                )
          : const LikeButton(
              size: 25,
            ),
    );
  }
}
