import 'package:flutter/material.dart';
import 'package:todo_list/src/modules/base/controllers/base_controller.dart';
import 'package:todo_list/src/modules/base/controllers/preferences_theme.dart';

import '../../../../core/presenters/theme/font_family_outlet.dart';
import '../../../../core/presenters/theme/size_outlet.dart';

class TopBar extends StatefulWidget {
  final String title;
  final bool? isBackButton;
  final BaseController? controller;
  final Function()? filterPressed;
  const TopBar({
    super.key,
    required this.title,
    this.isBackButton = false,
    this.controller,
    this.filterPressed,
  });

  @override
  State<TopBar> createState() => _TopBarState();
}

class _TopBarState extends State<TopBar> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(SizeOutlet.paddingSizeDefault),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          widget.isBackButton!
              ? IconButton(
                  icon: const Icon(
                    Icons.arrow_back_ios,
                  ),
                  onPressed: () {
                    widget.controller!.selectedIndex.value = 0;
                    widget.controller!.pageController.jumpToPage(0);
                  },
                )
              : IconButton(
                  icon: const Icon(Icons.filter_list),
                  onPressed: widget.filterPressed ?? () {},
                ),
          Text(
            widget.title,
            style: const TextStyle(
              fontSize: SizeOutlet.textSizeSmall2,
              fontFamily: FontFamilyOutlet.defaultFontFamilyLight,
            ),
          ),
          ValueListenableBuilder(
            valueListenable: PreferencesTheme.brightness,
            builder: (context, value, child) => IconButton(
              icon: Icon(
                value == Brightness.light ? Icons.dark_mode_outlined : Icons.wb_sunny,
              ),
              onPressed: () {
                PreferencesTheme.toggleTema();
              },
            ),
          ),
        ],
      ),
    );
  }
}
