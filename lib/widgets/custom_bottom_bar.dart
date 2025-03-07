import 'package:flutter/material.dart';
import 'package:intern/core/utils/image_constant.dart';
import 'package:intern/widgets/custom_image_view.dart';
import '../core/app_export.dart';

enum BottomBarEnum {
  Image7, Image9, Image10, Image8,
  home2, manage2, post2, user2,
  home3, manage3, post3, user3,
  home4, manage4, post4, user4,
}

class CustomBottomBar extends StatefulWidget {
  final Function(BottomBarEnum)? onChanged;

  CustomBottomBar({this.onChanged});

  @override
  CustomBottomBarState createState() => CustomBottomBarState();
}

class CustomBottomBarState extends State<CustomBottomBar> {
  int selectedIndex = 0;

  List<BottomMenuModel> getBottomMenuList(String? route) {
    switch (route) {
      case '/my_cart_screen':
        return [
          BottomMenuModel(icon: ImageConstant.home2, activeIcon: ImageConstant.home2, type: BottomBarEnum.home2),
          BottomMenuModel(icon: ImageConstant.manage2, activeIcon: ImageConstant.manage2, type: BottomBarEnum.manage2),
          BottomMenuModel(icon: ImageConstant.post4, activeIcon: ImageConstant.post4, type: BottomBarEnum.post4),
          BottomMenuModel(icon: ImageConstant.user2, activeIcon: ImageConstant.user2, type: BottomBarEnum.user2),
        ];
      case '/post_screen':
        return [
          BottomMenuModel(icon: ImageConstant.home3, activeIcon: ImageConstant.home3, type: BottomBarEnum.home3),
          BottomMenuModel(icon: ImageConstant.manage3, activeIcon: ImageConstant.manage3, type: BottomBarEnum.manage3),
          BottomMenuModel(icon: ImageConstant.post3, activeIcon: ImageConstant.post3, type: BottomBarEnum.post3),
          BottomMenuModel(icon: ImageConstant.user2, activeIcon: ImageConstant.user2, type: BottomBarEnum.user2),
        ];
      case '/personal_screen':
        return [
          BottomMenuModel(icon: ImageConstant.home4, activeIcon: ImageConstant.home4, type: BottomBarEnum.home4),
          BottomMenuModel(icon: ImageConstant.manage2, activeIcon: ImageConstant.manage2, type: BottomBarEnum.manage2),
          BottomMenuModel(icon: ImageConstant.post4, activeIcon: ImageConstant.post4, type: BottomBarEnum.post4),
          BottomMenuModel(icon: ImageConstant.user4, activeIcon: ImageConstant.user4, type: BottomBarEnum.user4),
        ];
      default:
        return [
          BottomMenuModel(icon: ImageConstant.imgImage7, activeIcon: ImageConstant.imgImage7, type: BottomBarEnum.Image7),
          BottomMenuModel(icon: ImageConstant.imgImage9, activeIcon: ImageConstant.imgImage9, type: BottomBarEnum.Image9),
          BottomMenuModel(icon: ImageConstant.imgImage10, activeIcon: ImageConstant.imgImage10, type: BottomBarEnum.Image10),
          BottomMenuModel(icon: ImageConstant.imgImage8, activeIcon: ImageConstant.imgImage8, type: BottomBarEnum.Image8),
        ];
    }
  }

  @override
  Widget build(BuildContext context) {
    String? currentRoute = ModalRoute.of(context)?.settings.name;
    List<BottomMenuModel> bottomMenuList = getBottomMenuList(currentRoute);

    selectedIndex = bottomMenuList.indexWhere(
          (menu) => getRouteForType(menu.type) == currentRoute,
    );
    if (selectedIndex == -1) selectedIndex = 0;

    return Container(
      decoration: BoxDecoration(
        color: theme.colorScheme.primaryContainer,
        borderRadius: BorderRadius.circular(33.h),
        boxShadow: [
          BoxShadow(
            color: appTheme.black900.withOpacity(0.25),
            spreadRadius: 2.h,
            blurRadius: 2.h,
            offset: Offset(0, 4),
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
            label: '',
          );
        }),
        onTap: (index) {
          setState(() {
            selectedIndex = index;
          });

          BottomBarEnum selectedType = bottomMenuList[index].type;
          String route = getRouteForType(selectedType);
          if (route.isNotEmpty) {
            Navigator.pushNamed(context, route);
          }

          widget.onChanged?.call(selectedType);
        },
      ),
    );
  }

  String getRouteForType(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Image8:
      case BottomBarEnum.user2:
      case BottomBarEnum.user3:
      case BottomBarEnum.user4:
        return '/personal_screen';

      case BottomBarEnum.Image10:
      case BottomBarEnum.post2:
      case BottomBarEnum.post3:
      case BottomBarEnum.post4:
        return '/post_screen';

      case BottomBarEnum.Image9:
      case BottomBarEnum.manage2:
      case BottomBarEnum.manage3:
      case BottomBarEnum.manage4:
        return '/my_cart_screen';

      case BottomBarEnum.Image7:
      case BottomBarEnum.home2:
      case BottomBarEnum.home3:
      case BottomBarEnum.home4:
        return '/product_card_screen';

      default:
        return '';
    }
  }
}

class BottomMenuModel {
  BottomMenuModel({
    required this.icon,
    required this.activeIcon,
    required this.type,
  });

  final String icon;
  final String activeIcon;
  final BottomBarEnum type;
}
