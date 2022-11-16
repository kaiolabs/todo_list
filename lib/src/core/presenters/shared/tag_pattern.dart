import 'package:flutter/material.dart';

import '../../../modules/base/controllers/preferences_theme.dart';
import '../theme/color_outlet.dart';
import '../theme/font_family_outlet.dart';
import '../theme/size_outlet.dart';

class TagPattern extends StatelessWidget {
  final String title;
  final Function()? onPressed;
  final icon;
  final Color color;
  const TagPattern({super.key, required this.title, required this.onPressed, required this.icon, required this.color});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(SizeOutlet.paddingSizeSmall),
      child: InkWell(
        borderRadius: BorderRadius.circular(SizeOutlet.borderRadiusSizeSmall),
        onTap: onPressed ?? () {},
        child: Container(
          width: 75,
          height: 75,
          decoration: BoxDecoration(
            color: color,
            borderRadius: BorderRadius.circular(SizeOutlet.borderRadiusSizeSmall),
            boxShadow: [
              BoxShadow(
                color: PreferencesTheme.brightness.value == Brightness.light ? Colors.grey[400]! : ColorOutlet.colorShadow,
                spreadRadius: 0,
                blurRadius: 10,
                offset: const Offset(0, 3), // changes position of shadow
              ),
            ],
          ),
          child: Padding(
            padding: const EdgeInsets.all(1),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                icon,
                Visibility(
                  visible: title.isNotEmpty,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: SizeOutlet.paddingSizeSmall),
                    child: Text(
                      title,
                      style: TextStyle(
                        fontSize: SizeOutlet.textSizeMicro1,
                        fontFamily: FontFamilyOutlet.defaultFontFamilyLight,
                        color: Theme.of(context).textTheme.bodyText1!.color,
                      ),
                    ),
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
