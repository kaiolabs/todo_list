import 'package:flutter/material.dart';
import 'package:todo_list/src/core/presenters/theme/color_outlet.dart';
import 'package:todo_list/src/core/presenters/theme/size_outlet.dart';

class ButtonPattern extends StatelessWidget {
  final String lebel;
  final Color? color;
  final Color? textColor;
  final String? fontFamily;
  final Function()? onPressed;
  const ButtonPattern({
    super.key,
    required this.lebel,
    required this.onPressed,
    this.color = ColorOutlet.colorPrimary,
    this.textColor = Colors.white,
    this.fontFamily = 'TTNorms_Medium',
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.of(context).size.width,
      height: 56,
      child: Material(
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.all(Radius.circular(SizeOutlet.borderRadiusSizeNormal)),
        ),
        color: color,
        child: InkWell(
          onTap: onPressed ?? () {},
          child: Center(
            child: Text(
              lebel,
              style: TextStyle(
                fontSize: 16,
                fontFamily: 'TTNorms_Medium',
                color: textColor,
              ),
            ),
          ),
        ),
      ),
    );
  }
}
