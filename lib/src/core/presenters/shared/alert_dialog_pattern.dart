import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:todo_list/src/core/presenters/theme/color_outlet.dart';
import 'package:todo_list/src/core/presenters/theme/size_outlet.dart';

import '../theme/font_family_outlet.dart';

alertDialogPattern(
  context,
  String title,
  String content, {
  bool? exitMode = false,
  bool confirmMode = false,
  ValueNotifier<bool>? isConfirmed,
  Function()? onConfirm,
  bool? markdownMode = false,
}) {
  return showGeneralDialog(
    context: context,
    pageBuilder: (context, animation, secondaryAnimation) {
      // animação de entrada
      const begin = Offset(0.0, 1.0);
      const end = Offset.zero;
      const curve = Curves.ease;
      final tween = Tween(begin: begin, end: end).chain(CurveTween(curve: curve));
      return SlideTransition(
        position: animation.drive(tween),
        child: AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(SizeOutlet.borderRadiusSizeMedium),
          ),
          title: Text(
            title,
            style: const TextStyle(
              fontSize: 18,
              fontFamily: FontFamilyOutlet.defaultFontFamilyMedium,
            ),
          ),
          content: Container(
            constraints: BoxConstraints(
              maxHeight: MediaQuery.of(context).size.height * 0.6,
              maxWidth: MediaQuery.of(context).size.width * 0.8,
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Visibility(
                  visible: !markdownMode!,
                  child: Text(
                    content,
                    style: const TextStyle(
                      fontFamily: 'TTNorms_Regular',
                    ),
                  ),
                ),
                SizedBox(
                  width: MediaQuery.of(context).size.width * 0.8,
                  height: MediaQuery.of(context).size.height * 0.6,
                  child: Visibility(
                    visible: markdownMode,
                    child: Markdown(
                      padding: const EdgeInsets.all(0),
                      physics: const BouncingScrollPhysics(),
                      softLineBreak: true,
                      data: content,
                      styleSheet: MarkdownStyleSheet(
                        p: const TextStyle(
                          fontFamily: 'TTNorms_Regular',
                        ),
                        h2: const TextStyle(
                          fontFamily: 'TTNorms_Medium',
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actions: [
            Visibility(
              visible: !confirmMode,
              child: TextButton(
                onPressed: () {
                  Modular.to.pop(context);
                },
                child: const Text(
                  'Cancelar',
                  style: TextStyle(
                    color: ColorOutlet.colorPrimaryLight,
                    fontFamily: FontFamilyOutlet.defaultFontFamilyMedium,
                  ),
                ),
              ),
            ),
            Visibility(
              visible: !confirmMode,
              child: TextButton(
                onPressed: () async {
                  exitMode! ? SystemNavigator.pop() : null;
                  isConfirmed != null ? isConfirmed.value = true : null;
                  onConfirm != null ? onConfirm() : null;
                },
                child: const Text(
                  'Confirmar',
                  style: TextStyle(
                    color: ColorOutlet.colorPrimaryLight,
                    fontFamily: FontFamilyOutlet.defaultFontFamilyMedium,
                  ),
                ),
              ),
            ),
            Visibility(
              visible: confirmMode,
              child: TextButton(
                onPressed: () async {
                  exitMode! ? SystemNavigator.pop() : null;
                  Modular.to.pop(context);
                },
                child: const Text(
                  'OK',
                  style: TextStyle(
                    color: ColorOutlet.colorPrimaryLight,
                    fontFamily: FontFamilyOutlet.defaultFontFamilyMedium,
                  ),
                ),
              ),
            ),
          ],
        ),
      );
    },
  );
}
