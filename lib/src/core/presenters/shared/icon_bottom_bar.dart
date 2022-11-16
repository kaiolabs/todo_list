import 'package:flutter/material.dart';
import 'package:todo_list/src/core/presenters/theme/color_outlet.dart';
import 'package:todo_list/src/core/presenters/theme/font_family_outlet.dart';
import 'package:todo_list/src/core/presenters/theme/size_outlet.dart';
import 'package:todo_list/src/modules/base/controllers/preferences_theme.dart';

class IconBottomBar extends StatelessWidget {
  final IconData iconButton;
  final String lebel;
  final bool isSelected;
  final Function()? onTap;
  const IconBottomBar({
    super.key,
    required this.iconButton,
    required this.lebel,
    required this.isSelected,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(left: 10, right: 10, top: 7, bottom: 7),
      child: Column(
        children: [
          SizedBox(
            width: SizeOutlet.iconSizeLarge,
            height: SizeOutlet.iconSizeLarge,
            child: IconButton(
              padding: const EdgeInsets.all(0),
              onPressed: onTap ?? () {},
              icon: Icon(
                size: 27,
                iconButton,
                color: isSelected
                    ? ColorOutlet.colorPrimaryLight
                    : PreferencesTheme.brightness.value == Brightness.light
                        ? ColorOutlet.colorGrey
                        : Colors.white,
              ),
            ),
          ),
          Text(
            lebel,
            style: TextStyle(
              fontSize: 12,
              color: isSelected
                  ? ColorOutlet.colorPrimaryLight
                  : PreferencesTheme.brightness.value == Brightness.light
                      ? ColorOutlet.colorGrey
                      : Colors.white,
              fontFamily: FontFamilyOutlet.defaultFontFamilyLight,
            ),
          ),
        ],
      ),
    );
  }
}
