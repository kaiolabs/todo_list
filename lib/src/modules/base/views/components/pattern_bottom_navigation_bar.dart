import 'package:flutter/material.dart';
import 'package:todo_list/src/core/presenters/shared/icon_bottom_bar.dart';
import 'package:todo_list/src/modules/base/controllers/preferences_theme.dart';

import '../../controllers/base_controller.dart';

class PatternBottomNavigationBar extends StatelessWidget {
  final BaseController controller;
  const PatternBottomNavigationBar({super.key, required this.controller});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 65,
      child: BottomAppBar(
        shape: const CircularNotchedRectangle(),
        notchMargin: 8,
        child: SizedBox(
          height: 56,
          child: Padding(
            padding: const EdgeInsets.only(left: 16, right: 16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ValueListenableBuilder(
                  valueListenable: PreferencesTheme.brightness,
                  builder: (context, value, child) => ValueListenableBuilder(
                    valueListenable: controller.selectedIndex,
                    builder: (context, value, child) {
                      return SizedBox(
                        width: MediaQuery.of(context).size.width * 0.75,
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            IconBottomBar(
                              iconButton: Icons.home_outlined,
                              lebel: 'Home',
                              isSelected: controller.selectedIndex.value == 0,
                              onTap: () {
                                controller.selectedIndex.value = 0;
                                controller.pageController.jumpToPage(0);
                              },
                            ),
                            IconBottomBar(
                              iconButton: Icons.library_add_check_outlined,
                              lebel: 'Done',
                              isSelected: controller.selectedIndex.value == 1,
                              onTap: () {
                                controller.selectedIndex.value = 1;
                                controller.pageController.jumpToPage(1);
                              },
                            ),
                            IconBottomBar(
                              iconButton: Icons.favorite_border_outlined,
                              lebel: 'Favorites',
                              isSelected: controller.selectedIndex.value == 2,
                              onTap: () {
                                controller.selectedIndex.value = 2;
                                controller.pageController.jumpToPage(2);
                              },
                            ),
                            IconBottomBar(
                              iconButton: Icons.settings_outlined,
                              lebel: 'Settings',
                              isSelected: controller.selectedIndex.value == 3,
                              onTap: () {
                                controller.selectedIndex.value = 3;
                                controller.pageController.jumpToPage(3);
                              },
                            ),
                          ],
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
