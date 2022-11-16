import 'package:flutter/material.dart';
import 'package:todo_list/src/core/presenters/theme/color_outlet.dart';
import 'package:todo_list/src/core/presenters/theme/size_outlet.dart';

class ButtonPatternOut extends StatelessWidget {
  final String lebel;
  final Color? color;
  final String? fontFamily;
  final Function()? onPressed;
  const ButtonPatternOut({
    super.key,
    required this.lebel,
    required this.onPressed,
    this.color = ColorOutlet.colorPrimary,
    this.fontFamily = 'TTNorms_Medium',
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(SizeOutlet.borderRadiusSizeNormal)),
      ),
      child: InkWell(
        onTap: onPressed ?? () {},
        borderRadius: BorderRadius.circular(SizeOutlet.borderRadiusSizeNormal),
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: 56,
          alignment: Alignment.center,
          decoration: BoxDecoration(
            border: Border.all(color: color!),
            borderRadius: const BorderRadius.all(Radius.circular(SizeOutlet.borderRadiusSizeNormal)),
          ),
          child: Text(
            lebel,
            style: TextStyle(
              fontSize: 16,
              fontFamily: 'TTNorms_Medium',
              color: color,
            ),
          ),
        ),
      ),
    );
  }
}
