import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../../../core/presenters/shared/tag_pattern.dart';
import '../../../core/presenters/theme/color_outlet.dart';
import '../../../core/presenters/theme/font_family_outlet.dart';
import '../../../core/presenters/theme/size_outlet.dart';
import '../../../modules/base/controllers/preferences_theme.dart';

showPriority({required ValueNotifier<String> priorityController, required BuildContext context, bool? exibVazio = false}) {
  List<String> priorityList = ['1', '2', '3', '4', '5', '6', '7', '8', '9', '10'];
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        contentPadding: const EdgeInsets.all(5),
        titlePadding: const EdgeInsets.only(top: 10, left: 15),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SizeOutlet.borderRadiusSizeMedium),
        ),
        content: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(
                  top: SizeOutlet.paddingSizeDefault,
                  bottom: SizeOutlet.paddingSizeDefault,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: const [
                    Text(
                      'Priority',
                      style: TextStyle(
                        fontSize: SizeOutlet.textSizeSmall2,
                        fontFamily: FontFamilyOutlet.defaultFontFamilyLight,
                      ),
                    ),
                  ],
                ),
              ),
              Wrap(
                children: [
                  exibVazio!
                      ? TagPattern(
                          icon: const Icon(
                            Icons.close,
                            color: ColorOutlet.colorPrimary,
                          ),
                          color: PreferencesTheme.brightness.value == Brightness.light ? Colors.white : Colors.grey[900]!,
                          onPressed: () {
                            priorityController.value = '';
                            Modular.to.pop();
                          },
                          title: '',
                        )
                      : const SizedBox(),
                  for (var i = 0; i < priorityList.length; i++)
                    TagPattern(
                      color: PreferencesTheme.brightness.value == Brightness.light ? Colors.white : Colors.grey[900]!,
                      icon: SvgPicture.asset(
                        'assets/images/flag.svg',
                        width: SizeOutlet.iconSizeDefault,
                        color: ColorOutlet.colorPrimary,
                      ),
                      title: priorityList[i],
                      onPressed: () {
                        priorityController.value = priorityList[i];
                        Modular.to.pop();
                      },
                    ),
                ],
              ),
            ],
          ),
        ),
      );
    },
  );
}
