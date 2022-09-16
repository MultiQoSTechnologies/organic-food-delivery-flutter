import 'dart:async';
import 'dart:math';
import 'package:add_to_cart_animation/add_to_cart_animation.dart';
import 'package:add_to_cart_animation/add_to_cart_icon.dart';
import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:organic_food_app/extensions/dimension_extension.dart';
import 'package:proste_bezier_curve/proste_bezier_curve.dart';
import '../../common/util.dart';
import '../../constant/app_assets.dart';
import '../../constant/font_style.dart';
import '../../constant/message_constant.dart';
import 'package:organic_food_app/lib/circle_list.dart';
import '../../enums/FruitDishSize.dart';
import '../../model/mdl_fruit_item.dart';
import '../../model/mdl_fruits.dart';
import '../../paint/fruits_painter.dart';
import '../../theme/app_color.dart';
import 'dart:ui' as ui;
import 'dart:io' show Platform;

class AddToCartPage extends StatefulWidget {
  const AddToCartPage({Key? key}) : super(key: key);

  @override
  State<AddToCartPage> createState() => _AddToCartPageState();
}

class _AddToCartPageState extends State<AddToCartPage>
    with TickerProviderStateMixin {
  int selectedImageIndex = 0;
  double total = 8.50;
  int fruitDishSizeIndex = 1;
  double circleListHeight = 160;
  Animation<double>? _mainImageAnimation;
  late AnimationController _fruitDishAnimationController;
  GlobalKey<CartIconKey> cartIconKey = GlobalKey<CartIconKey>();
  late Function(GlobalKey) runAddToCardAnimation;
  var _cartQuantityItems = 0;
  final GlobalKey imageGlobalKey = GlobalKey();
  FruitDishSize fruitDishSize = FruitDishSize.medium;
  List<Fruits> fruits = [];
  late List<FruitItemModel> fruitsItemList;
  int fruitLimit = 20;

  @override
  void initState() {
    initAnimations();
    initList();
    super.initState();
  }

  void initList() {
    fruitsItemList = [
      FruitItemModel(
        AssetsImages.icFruit1,
        AssetsImages.icFruit1,
        fruitLimit,
        7,
      ),
      FruitItemModel(
        AssetsImages.icFruit2,
        AssetsImages.icFruit2,
        fruitLimit,
        7,
      ),
      FruitItemModel(
        AssetsImages.icFruit3,
        AssetsImages.icFruit3,
        fruitLimit,
        7,
      ),
      FruitItemModel(
        AssetsImages.icFruit4,
        AssetsImages.icFruit4,
        fruitLimit,
        7,
      ),
      FruitItemModel(
        AssetsImages.icFruit5,
        AssetsImages.icFruit5,
        fruitLimit,
        7,
      ),
      FruitItemModel(
        AssetsImages.icFruit6,
        AssetsImages.icFruit6,
        fruitLimit,
        7,
      ),
      FruitItemModel(
        AssetsImages.icFruit7,
        AssetsImages.icFruit7,
        fruitLimit,
        7,
      ),
      FruitItemModel(
        AssetsImages.icFruit8,
        AssetsImages.icFruit8,
        fruitLimit,
        7,
      ),
      FruitItemModel(
        AssetsImages.icFruit9,
        AssetsImages.icFruit9,
        fruitLimit,
        7,
      ),
      FruitItemModel(
        AssetsImages.icFruit10,
        AssetsImages.icFruit10,
        fruitLimit,
        7,
      ),
      FruitItemModel(
        AssetsImages.icFruit11,
        AssetsImages.icFruit11,
        fruitLimit,
        7,
      ),
      FruitItemModel(
        AssetsImages.icFruit12,
        AssetsImages.icFruit12,
        fruitLimit,
        7,
      ),
      FruitItemModel(
        AssetsImages.icFruit13,
        AssetsImages.icFruit13,
        fruitLimit,
        7,
      ),
    ];
  }

  void initAnimations() {
    _fruitDishAnimationController = AnimationController(
        duration: const Duration(seconds: 3),
        vsync: this,
        value: 0.25,
        lowerBound: 0.25,
        upperBound: 0.5
    );
    _fruitDishAnimationController.forward();
    _mainImageAnimation = CurvedAnimation(
      parent: _fruitDishAnimationController,
      curve: Curves.linear,
    );

  }

  @override
  void dispose() {
    _fruitDishAnimationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // add to cart animation
    return AddToCartAnimation(
      gkCart: cartIconKey,
      rotation: true,
      receiveCreateAddToCardAnimationMethod: (addToCardAnimationMethod) {
        runAddToCardAnimation = addToCardAnimationMethod;
      },
      child: Scaffold(
        backgroundColor: AppColors.appBackground,
        appBar: AppBar(
          automaticallyImplyLeading: false,
          backgroundColor: AppColors.appBackground,
          elevation: 0,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              InkWell(
                onTap: () {
                  Get.back();
                },
                child: CustomCircleBox(
                    color: AppColors.white,
                    height: 45,
                    width: 45,
                    fit: BoxFit.scaleDown,
                    imageName: AssetsImages.icArrowBack,
                    isBorder: false),
              ),
              Text(
                MessageConstant.fruitSalad,
                style: AppFontStyle.boldBahnschriftTextFiled.copyWith(
                  color: AppColors.black,
                ),
              ),
              CustomCircleBox(
                  color: AppColors.white,
                  height: 45,
                  width: 45,
                  fit: BoxFit.scaleDown,
                  imageName: AssetsImages.icBlackHeart,
                  isBorder: false),
            ],
          ),
        ),
        body: Container(
          margin: const EdgeInsets.only(top: 40),
          child: ClipPath(
            clipper: ProsteBezierCurve(
              position: ClipPosition.top,
              list: [
                BezierCurveSection(
                  start: Offset(MediaQuery.of(context).size.width / 3,
                      MediaQuery.of(context).size.height / 10),
                  top: Offset(MediaQuery.of(context).size.width / 3, 0),
                  end: Offset(0, MediaQuery.of(context).size.height / 10),
                ),
              ],
            ),
            child: Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              color: AppColors.white,
              child: Stack(
                // alignment: Alignment.center,
                children: [
                  Positioned(
                    left: -MediaQuery.of(context).size.width / 2,
                    right: -MediaQuery.of(context).size.width / 2,
                    top: MediaQuery.of(context).size.height / 6,
                    child: RotationTransition(
                      turns: _mainImageAnimation!,
                      child: Container(
                        alignment: Alignment.center,
                        key: imageGlobalKey,
                        width: _getFruitDishSize(FruitDishSize.large, context) + 50,
                        height: _getFruitDishSize(FruitDishSize.large, context) + 50,
                        child: TweenAnimationBuilder(
                          tween: Tween<double>(
                            begin: 120,
                            end: _getFruitDishSize(fruitDishSize, context) + 30,
                          ),
                          duration: const Duration(seconds: 1),
                          onEnd: () {},
                          curve: Curves.ease,
                          builder: (BuildContext context, double value,
                              Widget? child) {
                            return Image.asset(
                              AssetsImages.icFruitDishImage,
                              width: value,
                              height: value,
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                  Container(
                    child: Stack(
                      children: [
                        for (Fruits fruit in fruits)
                          FutureBuilder<ui.Image>(
                            future: Future(() async {
                              final ByteData data =
                                  await rootBundle.load(fruit.unitImg);
                              final Completer<ui.Image> completer = Completer();
                              ui.decodeImageFromList(
                                Uint8List.view(data.buffer),
                                (ui.Image img) {
                                  return completer.complete(img);
                                },
                              );
                              return completer.future;
                            }),
                            builder: (context, snapshot) {
                              if (snapshot.hasData) {
                                return TweenAnimationBuilder(
                                  key: ValueKey(fruit.img),
                                  tween: Tween<double>(begin: 0, end: 1),
                                  builder: (context, double value, child) {
                                    return CustomPaint(
                                      painter: FruitsPainter(
                                        deviceWidth: context.width.toInt(),
                                        deviceHeight: context.height.toInt(),
                                        img: snapshot.data!,
                                        value: value,
                                        positions: fruit.positions,
                                        fruitDishSize:
                                            _getFruitDishSize(fruitDishSize, context),
                                        context: context,
                                      ),
                                    );
                                  },
                                  duration: const Duration(milliseconds: 800),
                                  curve: Curves.decelerate,
                                );
                              }
                              return Container();
                            },
                          ),
                      ],
                    ),
                  ),
                  //Circle fruit list
                  Positioned(
                    left: -MediaQuery.of(context).size.width / 2,
                    right: -MediaQuery.of(context).size.width / 2,
                    top: 10,
                    child: _availableFruitsCircleList(),
                  ),
                  //Add to cart container
                  _addToCartContainer()
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _addToCartContainer() {
    return Container(
      alignment: Alignment.bottomCenter,
      margin: const EdgeInsets.only(bottom: 20),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            height: 200,
            width: MediaQuery.of(context).size.width / 6,
          ),
          SingleChildScrollView(
            child: Column(
              children: [
                Row(
                  children: [
                    SvgPicture.asset(
                      AssetsImages.icStar,
                      width: 20.0,
                      height: 20.0,
                    ),
                    const Padding(
                      padding: EdgeInsets.only(top: 3, left: 2),
                      child: Text("4.5",
                          style: AppFontStyle.regularBahnschriftTextFiled),
                    )
                  ],
                ),
                Padding(
                  padding: const EdgeInsets.only(top: 10.0, bottom: 10.0),
                  child: Text(
                    "American Fruit Salad",
                    style: AppFontStyle.boldBahnschriftTextFiled.copyWith(
                      color: AppColors.black,
                    ),
                    textAlign: TextAlign.center,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
                Text(
                  'Healthy Dish',
                  style: AppFontStyle.regularBahnschriftTextFiled.copyWith(
                    color: AppColors.black.withOpacity(0.5),
                  ),
                ),
                AnimatedSwitcher(
                  duration: const Duration(milliseconds: 300),
                  transitionBuilder: (child, animation) {
                    return child;
                  },
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10.0, bottom: 15.0),
                    child: Text(
                      "\$$total",
                      key: UniqueKey(),
                      style: AppFontStyle.boldBahnschriftTextFiled.copyWith(
                        color: AppColors.black,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: _addToCartButton(width: 200),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(left: 15.0, right: 5),
            child: _fruitDishSizeButtons(),
          )
        ],
      ),
    );
  }

  Widget _fruitDishSizeButtons() {
    return Container(
      alignment: Alignment.center,
      height: 180,
      width: MediaQuery.of(context).size.width / 8,
      decoration: const BoxDecoration(
        borderRadius: BorderRadius.all(
          Radius.circular(30),
        ),
        color: AppColors.buttonColor,
      ),
      child: ListView(
        children: [
          _fruitDishSizeButton("S", 0),
          _fruitDishSizeButton("M", 1),
          _fruitDishSizeButton("L", 2),
        ],
      ),
    );
  }

  Widget _fruitDishSizeButton(String buttonText, int index) {
    return InkWell(
      onTap: () {
        setState(() {
          fruitDishSizeIndex = index;
          index == 0
              ? fruitDishSize = FruitDishSize.small
              : index == 1
                  ? fruitDishSize = FruitDishSize.medium
                  : fruitDishSize = FruitDishSize.large;
          total = 8.50;
          _cartQuantityItems = 0;
          cartIconKey.currentState!.runClearCartAnimation();
          fruits.clear();
        });
      },
      child: Container(
        width: 50,
        height: 50,
        margin: const EdgeInsets.all(5),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          color:
              fruitDishSizeIndex == index ? AppColors.black : AppColors.white,
          shape: BoxShape.circle,
          border: Border.all(
            width: 0.7,
            color: AppColors.black.withOpacity(0.15),
          ),
        ),
        child: Text(
          buttonText,
          style: AppFontStyle.regularBahnschriftTextFiled.copyWith(
            color:
                fruitDishSizeIndex == index ? AppColors.white : AppColors.black,
            fontSize: 22.0,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }

  Widget _availableFruitsCircleList() {
    return Container(
      alignment: Alignment.center,
      height: circleListHeight,
      width: double.infinity,
      child: CircleList(
        outerRadius: MediaQuery.of(context).size.width / 1.5,
        outerCircleColor: AppColors.black,
        innerRadius: MediaQuery.of(context).size.width / 2.1,
        origin: const Offset(0, 0),
        showInitialAnimation: true,
        animationSetting: AnimationSetting(
          duration: const Duration(seconds: 3),
        ),
        children: List.generate(fruitsItemList.length, (index) {
          return _customCircleContainer(fruitsItemList[index], index);
        }),
      ),
    );
  }

  Widget _customCircleContainer(FruitItemModel recycleInfo1, int index) {
    return InkWell(
        onTap: () {
          setState(() {
            var recyclerInfoData = fruitsItemList.firstWhere(
              (element) => element.img == recycleInfo1.img,
            );
            selectedImageIndex = fruitsItemList.indexOf(recyclerInfoData);
            total++;
          });
          addFruits(context, fruitsItemList[selectedImageIndex]);
        },
        child: Container(
          width: selectedImageIndex == index ? 60 : 50,
          height: selectedImageIndex == index ? 60 : 50,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: selectedImageIndex == index
                ? AppColors.white
                : AppColors.appBackground,
            shape: BoxShape.circle,
            border: Border.all(
              width: 0.7,
              color: AppColors.black.withOpacity(0.15),
            ),
          ),
          child: Image.asset(
            recycleInfo1.img,
            fit: BoxFit.scaleDown,
          ),
        ));
  }

  Future<void> startAddToCartAnimation() async {
    await runAddToCardAnimation(imageGlobalKey);
    await cartIconKey.currentState!
        .runCartAnimation((++_cartQuantityItems).toString());
  }

  Widget _addToCartButton({double? width}) {
    return InkWell(
      onTap: () async {
        startAddToCartAnimation();
      },
      child: Container(
        width: width,
        padding: const EdgeInsets.only(top: 15.0, bottom: 15.0),
        decoration: const BoxDecoration(
          color: Colors.black,
          borderRadius: BorderRadius.all(
            Radius.circular(35),
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            AddToCartIcon(
              key: cartIconKey,
              icon: SvgPicture.asset(AssetsImages.icCart),
              colorBadge: Colors.grey,
            ),
            const SizedBox(width: 10),
            AnimatedTextKit(
              animatedTexts: [
                WavyAnimatedText(
                  MessageConstant.addToCart,
                  textStyle: AppFontStyle.regularBahnschriftTextFiled.copyWith(
                      color: AppColors.white, fontWeight: FontWeight.w600),
                ),
              ],
              totalRepeatCount: 1,
              repeatForever: false,
              onTap: () async {
                startAddToCartAnimation();
              },
            ),
          ],
        ),
      ),
    );
  }

  void addFruits(BuildContext context, FruitItemModel fruitItemModel) {
    final random = Random.secure();
    final deviceWidth = context.width;
    final calculatedFruitDishSize = _getFruitDishSize(fruitDishSize, context);

    var yAxisReferenceCenterY= 0.0;
    var yAxisReferenceStartingYOfFruitDish= 0.0;
    if (Platform.isAndroid) {
      yAxisReferenceCenterY= 445;
      yAxisReferenceStartingYOfFruitDish= 440;
    } else if (Platform.isIOS) {
      yAxisReferenceCenterY= 435;
      yAxisReferenceStartingYOfFruitDish= 430;
    }

    final centerY = (((context.width < 394) ? 30.toSize(context) : 55.toSize(context)) + (yAxisReferenceCenterY.toSize(context) / 2));
    final startingXofFruitDish = ((deviceWidth / 2) - (calculatedFruitDishSize / 2));
    final startingYOfFruitDish = ((context.width < 394) ? 30.toSize(context) : 55.toSize(context)) + ((yAxisReferenceStartingYOfFruitDish.toSize(context) - calculatedFruitDishSize) / 2);
    final rSquare = (calculatedFruitDishSize - (40.toSize(context))) * (calculatedFruitDishSize - (40.toSize(context))) / 4;

    fruits.add(
      Fruits(
        fruitItemModel.img,
        fruitItemModel.unitImg,
        List.generate(fruitItemModel.limit, (index) {
          late int x, y;
          do {
            x = (startingXofFruitDish +
                    (calculatedFruitDishSize.toInt() *
                        random.nextInt(5000) /
                        5000.0))
                .toInt();
            y = (startingYOfFruitDish +
                    (calculatedFruitDishSize.toInt() *
                        random.nextInt(5000) /
                        5000.0))
                .toInt();
          } while (pow(((deviceWidth - 25) / 2) - x, 2) + pow(centerY - y, 2) >
              rSquare);
          return Pos(x, y, (100 + (random.nextInt(5000) / 100)) / 100.0);
        }),
      ),
    );
    setState(() {});
  }

  double _getFruitDishSize(FruitDishSize size, BuildContext context) {
    switch (size) {
      case FruitDishSize.small:
        return 160.toSize(context);
      case FruitDishSize.medium:
        return 195.toSize(context);
      case FruitDishSize.large:
        return 230.toSize(context);
    }
  }
}
