import 'package:flutter/material.dart';
import 'package:intern/core/app_export.dart';
import 'package:intern/core/utils/image_constant.dart';
import 'package:intern/widgets/custom_image_view.dart';
import 'package:intern/routes/app_routes.dart'; // Import AppRoutes
import 'package:shared_preferences/shared_preferences.dart'; // Import SharedPreferences

enum BottomBarEnum { image7, image9, image10, image8 }

// ignore_for_file: must_be_immutable
class CustomBottomBar extends StatefulWidget {
  CustomBottomBar({super.key, this.onChanged});

  Function(BottomBarEnum)? onChanged;

  @override
  CustomBottomBarState createState() => CustomBottomBarState();
}

class CustomBottomBarState extends State<CustomBottomBar> {
  int selectedIndex = 0;

  @override
  void initState() {
    super.initState();
    _loadSelectedIndex();
  }

  _loadSelectedIndex() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    setState(() {
      selectedIndex = prefs.getInt('selectedIndex') ?? 0;
    });
  }

  _saveSelectedIndex(int index) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setInt('selectedIndex', index);
  }

  List<BottomMenuModel> bottomMenuList = [
    BottomMenuModel(
      icon: ImageConstant.imgImage7,
      activeIcon: ImageConstant.imgImage7,
      type: BottomBarEnum.image7,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgImage9,
      activeIcon: ImageConstant.imgImage9,
      type: BottomBarEnum.image9,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgImage10,
      activeIcon: ImageConstant.imgImage10,
      type: BottomBarEnum.image10,
    ),
    BottomMenuModel(
      icon: ImageConstant.imgImage8,
      activeIcon: ImageConstant.imgImage8,
      type: BottomBarEnum.image8,
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
                  opacity: selectedIndex == index ? 1.0 : 0.3,
                  child: CustomImageView(
                    imagePath: bottomMenuList[index].icon,
                    height: 30.h,
                    width: 32.h,
                    color: selectedIndex == index ? Color(0xFF0047AB) : null,
                  ),
                ),
                activeIcon: CustomImageView(
                  imagePath: bottomMenuList[index].activeIcon,
                  height: 30.h,
                  width: 32.h,
                  color: Color(0xFF0047AB),
                ),
                label: '');
          }),
          onTap: (index) {
            setState(() {
              selectedIndex = index;
              _saveSelectedIndex(index);
              widget.onChanged?.call(bottomMenuList[index].type);

              // Điều hướng đến màn hình tương ứng
              switch (bottomMenuList[index].type) {
                case BottomBarEnum.image7:
                  Navigator.pushNamedAndRemoveUntil(
                      context, AppRoutes.homeScreen, (route) => false);
                  break;
                case BottomBarEnum.image9:
                  Navigator.pushNamedAndRemoveUntil(
                      context, AppRoutes.favoriteScreen, (route) => false);
                  break;
                case BottomBarEnum.image10:
                  Navigator.pushNamedAndRemoveUntil(
                      context, AppRoutes.myCartScreen, (route) => false);
                  break;
                case BottomBarEnum.image8:
                  Navigator.pushNamedAndRemoveUntil(
                      context, AppRoutes.profileScreen, (route) => false);
                  break;
              }
            });
          }),
    );
  }
}

class BottomMenuModel {
  BottomMenuModel(
      {required this.icon, required this.activeIcon, required this.type});

  String icon;
  String activeIcon;
  BottomBarEnum type;
}

class Defaultwidget extends StatelessWidget {
  const Defaultwidget({super.key});

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