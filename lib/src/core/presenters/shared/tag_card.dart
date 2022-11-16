import 'package:flutter/material.dart';

import '../theme/color_outlet.dart';
import '../theme/font_family_outlet.dart';
import '../theme/size_outlet.dart';

class TagCard extends StatelessWidget {
  final String title;
  final Widget icon;
  final Color? color;
  const TagCard({
    super.key,
    required this.title,
    required this.icon,
    this.color = ColorOutlet.colorPrimaryLight,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: const BorderRadius.all(Radius.circular(SizeOutlet.borderRadiusSizeSmall)),
        border: Border.fromBorderSide(BorderSide(color: color!)),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: SizeOutlet.paddingSizeSmall,
          vertical: SizeOutlet.paddingSizeMicro,
        ),
        child: Row(
          children: [
            Padding(
              padding: const EdgeInsets.only(right: SizeOutlet.paddingSizeMicro),
              child: icon,
            ),
            Text(
              title,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                color: color,
                fontFamily: FontFamilyOutlet.defaultFontFamilyLight,
                fontSize: SizeOutlet.textSizeMicro1,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
