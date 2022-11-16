import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';

import '../../../core/presenters/shared/tag_pattern.dart';
import '../../../core/presenters/theme/color_outlet.dart';
import '../../../core/presenters/theme/font_family_outlet.dart';
import '../../../core/presenters/theme/size_outlet.dart';
import '../../../modules/base/controllers/preferences_theme.dart';

showCategory({required ValueNotifier<String> categoryController, required BuildContext context, bool? exibVazio = false}) {
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
                      'Category',
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
                            categoryController.value = '';
                            Modular.to.pop();
                          },
                          title: '',
                        )
                      : const SizedBox(),
                  TagPattern(
                    color: PreferencesTheme.brightness.value == Brightness.light ? Colors.white : Colors.grey[900]!,
                    icon: const Icon(Icons.check_box_outline_blank, color: ColorOutlet.colorPrimary),
                    title: 'Common',
                    onPressed: () {
                      categoryController.value = 'Common';
                      Modular.to.pop();
                    },
                  ),
                  TagPattern(
                    color: PreferencesTheme.brightness.value == Brightness.light ? Colors.white : Colors.grey[900]!,
                    icon: const Icon(Icons.lunch_dining_outlined, color: ColorOutlet.colorPrimary),
                    title: 'Grocery',
                    onPressed: () {
                      categoryController.value = 'Grocery';
                      Modular.to.pop();
                    },
                  ),
                  TagPattern(
                    color: PreferencesTheme.brightness.value == Brightness.light ? Colors.white : Colors.grey[900]!,
                    icon: const Icon(Icons.work_outline, color: ColorOutlet.colorPrimary),
                    title: 'Work',
                    onPressed: () {
                      categoryController.value = 'Work';
                      Modular.to.pop();
                    },
                  ),
                  TagPattern(
                    color: PreferencesTheme.brightness.value == Brightness.light ? Colors.white : Colors.grey[900]!,
                    icon: const Icon(Icons.fitness_center_outlined, color: ColorOutlet.colorPrimary),
                    title: 'Sport',
                    onPressed: () {
                      categoryController.value = 'Sport';
                      Modular.to.pop();
                    },
                  ),
                  TagPattern(
                    color: PreferencesTheme.brightness.value == Brightness.light ? Colors.white : Colors.grey[900]!,
                    icon: const Icon(Icons.grid_view_outlined, color: ColorOutlet.colorPrimary),
                    title: 'Design',
                    onPressed: () {
                      categoryController.value = 'Design';
                      Modular.to.pop();
                    },
                  ),
                  TagPattern(
                    color: PreferencesTheme.brightness.value == Brightness.light ? Colors.white : Colors.grey[900]!,
                    icon: const Icon(Icons.school_outlined, color: ColorOutlet.colorPrimary),
                    title: 'School',
                    onPressed: () {
                      categoryController.value = 'School';
                      Modular.to.pop();
                    },
                  ),
                  TagPattern(
                    color: PreferencesTheme.brightness.value == Brightness.light ? Colors.white : Colors.grey[900]!,
                    icon: const Icon(Icons.groups_outlined, color: ColorOutlet.colorPrimary),
                    title: 'Social',
                    onPressed: () {
                      categoryController.value = 'Social';
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
