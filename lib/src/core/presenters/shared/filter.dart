import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:todo_list/src/core/presenters/shared/show_category.dart';
import 'package:todo_list/src/core/presenters/shared/show_priority.dart';

import '../theme/font_family_outlet.dart';
import '../theme/size_outlet.dart';
import 'button_pattern.dart';
import 'button_pattern_out.dart';

filter({
  required ValueNotifier<String> controllerDropDownCategory,
  required ValueNotifier<String> controllerDropDownPriority,
  required BuildContext context,
  required Function() onPressedFilterApply,
}) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        insetPadding: const EdgeInsets.symmetric(horizontal: SizeOutlet.paddingSizeMassive),
        contentPadding: const EdgeInsets.symmetric(horizontal: SizeOutlet.paddingSizeDefault),
        buttonPadding: const EdgeInsets.symmetric(horizontal: SizeOutlet.paddingSizeDefault),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(SizeOutlet.borderRadiusSizeMedium),
        ),
        title: const Text(
          'Filter',
          style: TextStyle(
            fontFamily: FontFamilyOutlet.defaultFontFamilyMedium,
          ),
        ),
        content: Padding(
          padding: const EdgeInsets.symmetric(vertical: SizeOutlet.paddingSizeMedium),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisSize: MainAxisSize.min,
            children: [
              ValueListenableBuilder(
                valueListenable: controllerDropDownPriority,
                builder: (context, value, child) => Padding(
                  padding: const EdgeInsets.only(bottom: SizeOutlet.paddingSizeDefault, top: SizeOutlet.paddingSizeSmall),
                  child: ButtonPattern(
                    lebel: 'Priority  [ ${controllerDropDownPriority.value} ]',
                    onPressed: () {
                      showPriority(
                        priorityController: controllerDropDownPriority,
                        context: context,
                        exibVazio: true,
                      );
                    },
                  ),
                ),
              ),
              ValueListenableBuilder(
                valueListenable: controllerDropDownCategory,
                builder: (context, value, child) => ButtonPattern(
                  lebel: 'Category  [ ${controllerDropDownCategory.value} ]',
                  onPressed: () {
                    showCategory(
                      categoryController: controllerDropDownCategory,
                      context: context,
                      exibVazio: true,
                    );
                  },
                ),
              ),
            ],
          ),
        ),
        actions: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.32,
                height: 50,
                child: ButtonPatternOut(
                  lebel: 'Cancel',
                  onPressed: () {
                    Modular.to.pop();
                  },
                ),
              ),
              SizedBox(
                width: MediaQuery.of(context).size.width * 0.32,
                height: 50,
                child: ButtonPattern(
                  lebel: 'Apply',
                  onPressed: () {
                    onPressedFilterApply();
                    Modular.to.pop();
                  },
                ),
              )
            ],
          )
        ],
      );
    },
  );
}
