import 'package:flutter/cupertino.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:todo_list/src/core/presenters/shared/alert_dialog_pattern.dart';
import 'package:todo_list/src/core/presenters/shared/button_pattern.dart';
import 'package:todo_list/src/core/presenters/theme/font_family_outlet.dart';
import 'package:todo_list/src/core/repositories/db.dart';
import 'package:todo_list/src/modules/base/controllers/base_controller.dart';
import 'package:todo_list/src/modules/base/views/components/top_bar.dart';

import '../../../core/presenters/theme/size_outlet.dart';

class SettingsView extends StatefulWidget {
  final BaseController controller;
  const SettingsView({super.key, required this.controller});

  @override
  State<SettingsView> createState() => _SettingsViewState();
}

class _SettingsViewState extends State<SettingsView> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TopBar(title: 'Settings', controller: widget.controller, isBackButton: true),
        Padding(
          padding: const EdgeInsets.only(
              left: SizeOutlet.paddingSizeLarge,
              right: SizeOutlet.paddingSizeDefault,
              top: SizeOutlet.paddingSizeMassive,
              bottom: SizeOutlet.paddingSizeMedium),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Padding(
                padding: EdgeInsets.only(bottom: SizeOutlet.paddingSizeLarge),
                child: Text(
                  'Backup',
                  style: TextStyle(
                    fontSize: 20,
                    fontFamily: FontFamilyOutlet.defaultFontFamilyMedium,
                  ),
                ),
              ),
              ButtonPattern(
                lebel: 'Full Backup',
                onPressed: () {
                  alertDialogPattern(
                    context,
                    'Full Backup',
                    'Are you sure you want to backup all your data?',
                    onConfirm: () async {
                      print('Full Backup');
                      Modular.to.pop();
                      await DB.backupDatabase();
                    },
                  );
                },
              )
            ],
          ),
        )
      ],
    );
  }
}
