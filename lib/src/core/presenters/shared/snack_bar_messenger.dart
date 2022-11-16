import 'package:flutter/material.dart';

/// ### SnackBarMessenger Componente feito por Kaio Rodrigues | 20/10/2022 | Projeto externo - direitos de uso reservados.
/// - Github do criador: https://github.com/kaiolabs
/// - Documentação do componente:
/// - [ message ] Mensagem a ser exibida
/// - [ color ] Cor do fundo sa snackBar
/// - [ context ] Contexto da tela atual
/// - [ duration ] Duração da snackBar
snackBarMessenger({
  String? message = '',
  Color? color = Colors.transparent,
  int? duration = 2,
  double? borderRadius = 10,
  required BuildContext context,
}) {
  return ScaffoldMessenger.of(context).showSnackBar(
    SnackBar(
      content: Text(message!),
      duration: Duration(seconds: duration!),
      behavior: SnackBarBehavior.floating,
      dismissDirection: DismissDirection.horizontal,
      elevation: 5,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.all(Radius.circular(borderRadius!))),
      backgroundColor: color,
    ),
  );
}
