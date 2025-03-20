import 'package:flutter/material.dart';
import 'package:intern/core/utils/image_constant.dart';
import 'package:intern/widgets/custom_image_view.dart';
import '../core/app_export.dart';

enum BottomBarEnum {
  Image77, Image99, Image100, Image88,
  home2, manage2, post2, user2,
  home3, manage3, post3, user3,
  home4, manage4, post4, user4,
  home, manage, post, user,
}

class CustomBottomBar extends StatefulWidget {
  final Function(BottomBarEnum)? onChanged;
  final int? userId; // Add userId parameter

  CustomBottomBar({this.onChanged, this.userId});

  @override
  CustomBottomBarState createState() => CustomBottomBarState();
}

class CustomBottomBarState extends State<CustomBottomBar> {
  int selectedIndex = 0;

  List<BottomMenuModel> getBottomMenuList(String? route) {
    if (route == null) {
      return [];
    }

    switch (route) {
      case '/homepage_screen':
        return [
          BottomMenuModel(icon: ImageConstant.home, activeIcon: ImageConstant.home, type: BottomBarEnum.home),
          BottomMenuModel(icon: ImageConstant.manage, activeIcon: ImageConstant.manage, type: BottomBarEnum.manage),
          BottomMenuModel(icon: ImageConstant.post, activeIcon: ImageConstant.post, type: BottomBarEnum.post),
          BottomMenuModel(icon: ImageConstant.user, activeIcon: ImageConstant.user, type: BottomBarEnum.user),
        ];
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
    }

    return [];
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
            offset: const Offset(0, 4),
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
            // Pass userId as an argument when navigating
            Navigator.pushNamed(
              context,
              route,
              arguments: {'userId': widget.userId},
            );
          }

          widget.onChanged?.call(selectedType);
        },
      ),
    );
  }

  String getRouteForType(BottomBarEnum type) {
    switch (type) {
      case BottomBarEnum.Image88:
      case BottomBarEnum.user2:
      case BottomBarEnum.user3:
      case BottomBarEnum.user4:
      case BottomBarEnum.user:
        return '/personal_screen';

      case BottomBarEnum.Image100:
      case BottomBarEnum.post:
      case BottomBarEnum.post2:
      case BottomBarEnum.post3:
      case BottomBarEnum.post4:
        return '/post_screen';

      case BottomBarEnum.Image99:
      case BottomBarEnum.manage2:
      case BottomBarEnum.manage:
      case BottomBarEnum.manage3:
      case BottomBarEnum.manage4:
        return '/my_cart_screen';

      case BottomBarEnum.Image77:
      case BottomBarEnum.home:
      case BottomBarEnum.home2:
      case BottomBarEnum.home3:
      case BottomBarEnum.home4:
        return '/homepage_screen';

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
