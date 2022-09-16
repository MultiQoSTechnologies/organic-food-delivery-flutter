import 'package:flutter/material.dart';
import 'package:flutter_staggered_animations/flutter_staggered_animations.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../../common/util.dart';
import '../../constant/app_assets.dart';
import '../../constant/font_style.dart';
import '../../constant/message_constant.dart';
import '../../model/mdl_salad_categories.dart';
import '../../model/mdl_trending_categories.dart';
import '../../route/app_route.dart';
import '../../theme/app_color.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool _showShimmer = false;

  @override
  void initState() {
    // Hide shimmer after 2 seconds
    Future.delayed(const Duration(seconds: 2)).then((value) {
      setState(() {
        _showShimmer = true;
      });
    });
    super.initState();
  }

  List<MDLSaladCategories> saladCategoriesList = [
    MDLSaladCategories(imageUrl: AssetsImages.icCategoriesFruitSalad, name: "Fruit Salad"),
    MDLSaladCategories(
        imageUrl: AssetsImages.icCategoriesVegetableSalad, name: "Vegetable Salad"),
    MDLSaladCategories(
        imageUrl: AssetsImages.icCategoriesAvocadoDish, name: "Avocado Dish"),
  ];

  List<MDLTrendingCategories> trendingSaladCategoriesList = [
    MDLTrendingCategories(
        imageUrl: AssetsImages.icMustTryDishImage, name: "American Fruit Salad",dishType: "Healthy Dish", dishTypeImage: AssetsImages.icAmericanDishIcon),
    MDLTrendingCategories(
        imageUrl: AssetsImages.icMustTryDishImage, name: "Cheese Vegetarian",dishType: "Italian Dish", dishTypeImage: AssetsImages.icItalianDishIcon),
    MDLTrendingCategories(
        imageUrl: AssetsImages.icMustTryDishImage, name: "American Fruit Salad",dishType: "Healthy Dish", dishTypeImage: AssetsImages.icAmericanDishIcon),
    MDLTrendingCategories(
        imageUrl: AssetsImages.icMustTryDishImage, name: "Cheese Vegetarian",dishType: "Italian Dish", dishTypeImage: AssetsImages.icItalianDishIcon),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.appBackground,
      appBar: AppBar(
        automaticallyImplyLeading: false,
        backgroundColor: AppColors.appBackground,
        elevation: 0,
        title: Padding(
          padding: const EdgeInsets.only(left: 5.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                MessageConstant.fruitSalad,
                style: AppFontStyle.regularBahnschriftTextFiled.copyWith(
                    color: AppColors.black.withOpacity(0.4), fontSize: 16),
              ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: SvgPicture.asset(AssetsImages.icLocation,fit: BoxFit.scaleDown,),
                  ),
                  Text(
                    MessageConstant.mulberryStreetUS,
                    style: AppFontStyle.regularBahnschriftTextFiled.copyWith(
                      color: AppColors.black,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 15.0),
            child: CustomCircleBox(
                color: AppColors.white,
                height: 50,
                width: 50,
                fit: BoxFit.scaleDown,
                imageName: AssetsImages.icProfile,
                isBorder: false),
          )
        ],
      ),
      body: SingleChildScrollView(
        ///* Added Shimmer Animation in Loading State.*///
        child: _showShimmer == false
            ? Shimmer.fromColors(
                loop: 5,
                baseColor: AppColors.appBackground,
                highlightColor: AppColors.white,
                child: _mainContainer())
            : _mainContainer(),
      ),
    );
  }

  Widget _mainContainer() {
    return AnimationLimiter(
      child: Column(
        children: AnimationConfiguration.toStaggeredList(
          duration: const Duration(milliseconds: 375),

          ///* Add SlideAnimation and FadeInAnimation Animation.*///
          childAnimationBuilder: (widget) => SlideAnimation(
            horizontalOffset: 50.0,
            child: FadeInAnimation(
              child: widget,
            ),
          ),
          children: [
            Container(
              height: 60,
              margin: const EdgeInsets.only(
                  top: 35.0, bottom: 35.0, left: 20.0, right: 20.0),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                border: Border.all(
                    width: 0.7, color: AppColors.black.withOpacity(0.15)),
                color: AppColors.appBackground,
                borderRadius: const BorderRadius.all(
                  Radius.circular(40),
                ),
              ),
              child: TextField(
                // focusNode: _searchController,
                decoration: InputDecoration(
                  contentPadding: const EdgeInsets.all(15),
                  suffixIcon: Padding(
                    padding: const EdgeInsets.only(right: 5.0),
                    child: CustomCircleBox(
                        color: AppColors.black,
                        height: 50,
                        width: 50,
                        fit: BoxFit.scaleDown,
                        imageName: AssetsImages.icSearch,
                        isBorder: false),
                  ),
                  isDense: true,
                  hintText: MessageConstant.searchYourFood,
                  hintStyle: AppFontStyle.regularBahnschriftTextFiled
                      .copyWith(fontSize: 16),
                  fillColor: AppColors.white,
                  border: InputBorder.none,
                ),
              ),
            ),
            Padding(
              padding:
                  const EdgeInsets.only(left: 20.0, right: 20.0, bottom: 35.0),
              child: _customListHeaderRow(
                showSeeAll: false,
                name: MessageConstant.categories,
              ),
            ),
            SizedBox(
              height: 150,
              child: ListView.builder(
                padding: const EdgeInsets.only(left: 20.0),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: saladCategoriesList.length,
                itemBuilder: (BuildContext context, int index) {
                  return _saladCategoriesTile(saladCategoriesList[index]);
                },
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                  left: 20.0, right: 20.0, top: 35.0, bottom: 25.0),
              child: _customListHeaderRow(
                showSeeAll: true,
                name: MessageConstant.mustTry,
              ),
            ),
            Container(
              height: 360,
              margin: const EdgeInsets.only(bottom: 15.0),
              child: ListView.builder(
                padding: const EdgeInsets.only(left: 20.0),
                scrollDirection: Axis.horizontal,
                shrinkWrap: true,
                itemCount: trendingSaladCategoriesList.length,
                itemBuilder: (BuildContext context, int index) {
                  return _trendingSaladCategoriesListTile(
                      trendingSaladCategoriesList[index]);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _customListHeaderRow({required bool showSeeAll, required String name}) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 15.0),
          child: Text(
            name,
            style: AppFontStyle.boldBahnschriftTextFiled.copyWith(
              color: AppColors.black,
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
        ),
        showSeeAll == true
            ? Text(
                MessageConstant.seeall,
                style: AppFontStyle.regularBahnschriftTextFiled.copyWith(
                  color: AppColors.black.withOpacity(0.5),
                ),
              )
            : Container(),
      ],
    );
  }

  Widget _saladCategoriesTile(MDLSaladCategories mdlSaladCategories) {
    return Padding(
      padding: const EdgeInsets.only(right: 20.0),
      child: InkWell(
        splashColor: Colors.transparent,
        highlightColor: Colors.transparent,
        onTap: () {
          Get.toNamed(Routes.addToCartPage);
        },
        child: CustomBox(
          radius: 20,
          width: 110,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              SvgPicture.asset(mdlSaladCategories.imageUrl),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Text(
                  mdlSaladCategories.name,
                  style: AppFontStyle.regularBahnschriftTextFiled.copyWith(
                      color: AppColors.black,
                      fontSize: 16,
                      fontWeight: FontWeight.w600),
                  textAlign: TextAlign.center,
                  maxLines: 2,
                  overflow: TextOverflow.ellipsis,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _trendingSaladCategoriesListTile(MDLTrendingCategories listviewInfo) {
    return InkWell(
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      onTap: () {
        Get.toNamed(Routes.addToCartPage);
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 20.0),
        child: CustomBox(
          radius: 30,
          width: 295,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                margin: const EdgeInsets.all(10.0),
                height: 200,
                clipBehavior: Clip.hardEdge,
                decoration: const BoxDecoration(
                  color: AppColors.black,
                  borderRadius: BorderRadius.all(
                    Radius.circular(20.0),
                  ),
                ),
                child: Stack(
                  alignment: Alignment.topRight,
                  children: [
                    Image.asset(
                      listviewInfo.imageUrl,
                      fit: BoxFit.cover,
                    ),
                    Positioned(
                      right: 15,
                      top: 15,
                      child: CustomCircleBox(
                          gradientColor: LinearGradient(
                            end: Alignment.bottomLeft,
                            begin: Alignment.topRight,
                            colors: <Color>[
                              const Color(0xffF1F1F1).withOpacity(0.45),
                              const Color(0xffF1F1F1).withOpacity(0.30),
                            ],
                          ),
                          height: 30,
                          width: 30,
                          fit: BoxFit.scaleDown,
                          imageName: AssetsImages.icHeart,
                          isBorder: false),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    top: 15.0, bottom: 5.0, left: 15.0, right: 15.0),
                child: Text(
                  listviewInfo.name,
                  style: AppFontStyle.boldBahnschriftTextFiled.copyWith(
                    color: AppColors.black,
                  ),
                  textAlign: TextAlign.center,
                  maxLines: 1,
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(left: 15.0, right: 15.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        listviewInfo.dishType,
                        style:
                            AppFontStyle.regularBahnschriftTextFiled.copyWith(
                          color: AppColors.black.withOpacity(0.5),
                        ),
                      ),
                    ),
                    SvgPicture.asset(
                      AssetsImages.icStar,
                      fit: BoxFit.scaleDown,
                      width: 20.0,
                      height: 20.0,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    const Padding(
                      padding:  EdgeInsets.only(top: 4.0),
                      child:  Text("4.5",
                          style: AppFontStyle.regularBahnschriftTextFiled),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                    left: 15.0, right: 15.0, top: 0.0, bottom: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    CustomCircleBox(
                        color: AppColors.white,
                        height: 45,
                        width: 45,
                        fit: BoxFit.scaleDown,
                        imageName: listviewInfo.dishTypeImage,
                        isBorder: false),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 10.0, right: 10.0),
                        child: Text(
                          MessageConstant.seeall,
                          style:
                              AppFontStyle.regularBahnschriftTextFiled.copyWith(
                            color: AppColors.black.withOpacity(0.5),
                          ),
                        ),
                      ),
                    ),
                    Container(
                      alignment: Alignment.center,
                      margin: const EdgeInsets.only(top:12),
                      child: SvgPicture.asset(
                        AssetsImages.icArrow,
                        // fit: BoxFit.contain,
                        height: 50,width: 10,
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
