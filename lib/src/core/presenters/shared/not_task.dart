import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../theme/color_outlet.dart';
import '../theme/font_family_outlet.dart';
import '../theme/size_outlet.dart';

class NotTask extends StatelessWidget {
  const NotTask({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: SizeOutlet.paddingSizeMassive * 1.5),
      child: Column(
        children: [
          SvgPicture.asset(
            'assets/images/checklist-rafiki_1.svg',
            width: SizeOutlet.imageSizeMassive,
          ),
          const Text(
            'What do you want to do today?',
            style: TextStyle(
              fontSize: SizeOutlet.textSizeSmall1,
              fontFamily: FontFamilyOutlet.defaultFontFamilyLight,
            ),
          ),
          const Padding(
            padding: EdgeInsets.all(SizeOutlet.paddingSizeSmall),
            child: Text(
              'Tap + to add your tasks',
              style: TextStyle(
                color: ColorOutlet.colorPrimaryLight,
                fontSize: SizeOutlet.textSizeMicro2,
                fontFamily: FontFamilyOutlet.defaultFontFamilyLight,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
