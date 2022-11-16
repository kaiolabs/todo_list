import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:todo_list/src/core/presenters/theme/color_outlet.dart';
import 'package:todo_list/src/modules/base/controllers/preferences_theme.dart';

import '../theme/font_family_outlet.dart';
import '../theme/size_outlet.dart';

class ButtonSimple extends StatefulWidget {
  final String text;
  final SvgPicture icon;
  final ValueNotifier<String> controller;
  final Function() onPressed;
  const ButtonSimple({super.key, required this.text, required this.icon, required this.controller, required this.onPressed});

  @override
  State<ButtonSimple> createState() => _ButtonSimpleState();
}

class _ButtonSimpleState extends State<ButtonSimple> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(SizeOutlet.borderRadiusSizeNormal),
      onTap: () {
        widget.onPressed();
      },
      child: Container(
        height: 80,
        width: MediaQuery.of(context).size.width * 0.43,
        decoration: BoxDecoration(
          color: PreferencesTheme.brightness.value == Brightness.light ? Colors.white : Colors.grey[850],
          borderRadius: BorderRadius.circular(SizeOutlet.borderRadiusSizeNormal),
          boxShadow: [
            BoxShadow(
              color: PreferencesTheme.brightness.value == Brightness.light ? Colors.grey[300]! : ColorOutlet.colorShadow,
              spreadRadius: 2,
              blurRadius: 5,
              offset: const Offset(0, 3), // changes position of shadow
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.only(top: SizeOutlet.paddingSizeSmall, bottom: SizeOutlet.paddingSizeSmall),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: SizeOutlet.paddingSizeMedium),
                child: widget.icon,
              ),
              Padding(
                padding: const EdgeInsets.only(left: SizeOutlet.paddingSizeMedium),
                child: Row(
                  children: [
                    Text(
                      '${widget.text}:',
                      style: const TextStyle(
                        fontSize: SizeOutlet.textSizeMicro1,
                        fontFamily: FontFamilyOutlet.defaultFontFamilyLight,
                      ),
                    ),
                    Text(
                      ' ${widget.controller.value}',
                      style: const TextStyle(
                        fontSize: SizeOutlet.textSizeMicro1,
                        color: ColorOutlet.colorPrimary,
                        fontFamily: FontFamilyOutlet.defaultFontFamilyLight,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
