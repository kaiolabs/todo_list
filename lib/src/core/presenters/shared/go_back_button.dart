// ignore_for_file: unused_local_variable

import 'package:flutter/material.dart';
import 'package:todo_list/src/core/presenters/shared/alert_dialog_pattern.dart';
import 'package:todo_list/src/core/presenters/theme/color_outlet.dart';

class GoBackButton extends StatelessWidget {
  final Function()? onPressed;

  const GoBackButton({
    super.key,
    this.onPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 80,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Material(
        borderRadius: BorderRadius.circular(25),
        child: InkWell(
          borderRadius: BorderRadius.circular(25),
          onTap: onPressed ??
              () {
                final confirmaPop =
                    alertDialogPattern(context, 'Request', 'You didn\'t complete the order, do you want to leave anyway?').then((value) {
                  if (value) {
                    onPressed;
                    Navigator.pop(context);
                  }
                });
              },
          child: Row(
            children: const [
              SizedBox(
                width: 22,
                child: Icon(
                  Icons.arrow_back_ios_new,
                  color: Color(0xFF333333),
                  size: 25,
                ),
              ),
              Padding(
                padding: EdgeInsets.only(right: 10, top: 10, bottom: 10),
                child: Text(
                  'Go back',
                  style: TextStyle(
                    color: ColorOutlet.colorDarkPurple,
                    fontSize: 12,
                    fontFamily: 'TTNorms_Medium',
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
