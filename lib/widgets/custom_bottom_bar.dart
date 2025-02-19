import 'package:flutter/material.dart';
import 'package:intern/core/utils/image_constant.dart';
import 'package:intern/widgets/custom_image_view.dart';
import '../core/app_export.dart';

enum BottomBarEnum { Image7, Image9, Image10, Image8 }

// ignore_for_file: must_be_immutable
class CustomBottomBar extends StatefulWidget {
  CustomBottomBar({this.onChanged});

  Function(BottomBarEnum)? onChanged;

  @override
  CustomBottomBarState createState() => CustomBottomBarState();
}


// ignore_for_file: must_be_immutable
class CustomBottomBarState extends State<CustomBottomBar> {
  int selectedIndex = 0;
  List<BottomMenuModel> bottomMenuList = [
    BottomMenuModel(
      icon: ImageConstant.imgImage7,
      activeIcon: ImageConstant.imgImage7,
      type: BottomBarEnum.Image7,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgImage9,
      activeIcon: ImageConstant.imgImage9,
      type: BottomBarEnum.Image9,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgImage10,
      activeIcon: ImageConstant.imgImage10,
      type: BottomBarEnum.Image10,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgImage8,
      activeIcon: ImageConstant.imgImage8,
      type: BottomBarEnum.Image8,
    )
  ];

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(
          33.h,
        ),
        boxShadow: [
          BoxShadow(
            color: appTheme.black900.withOpacity(
              0.25,
            ),
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: Offset(
              0,
              4,
            ),
          )
        ],
      ),
      child: BottomNavigationBar(
        backgroundColor: Colors.transparent,
        showSelectedLabels: false,
        showUnselectedLabels: false,
        selectedFontSize: 0,
        elevation: 0,
        currentIndex: selectedIndex,
        type: BottomNavigationBarType.fixed,
        items: List.generate(bottomMenuList.length, (index) {
          return BottomNavigationBarItem(
              icon: Opacity(
                opacity: 0.3,
                child: CustomImageView(
                  imagePath: bottomMenuList[index].icon,
                  height: 30.h,
                  width: 32.h,
                ),
              ),
              activeIcon: CustomImageView(
                imagePath: bottomMenuList[index].activeIcon,
                height: 30.h,
                width: 32.h,
              ),
              label: '');
        }),
        onTap: (index) {
          selectedIndex = index;
          widget.onChanged?.call(bottomMenuList[index].type);
          setState(() {});
        },
      ),
    );
  }
}

// ignore_for_file: must_be_immutable
class BottomMenuModel {
  BottomMenuModel(
      {required this.icon, required this.activeIcon, required this.type});

  String icon;
  String activeIcon;
  BottomBarEnum type;
}

class Defaultwidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Color(0xffffffff),
      padding: EdgeInsets.all(10),
      child: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Please replace the respective Widget here',
              style: TextStyle(
                fontSize: 18,
              ),
            )
          ],
        ),
      ),
    );
  }
}
