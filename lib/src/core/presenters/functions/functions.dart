import 'package:flutter/material.dart';

class Functions {
  static String upperCaseFirstLetter(String text) {
    return text[0].toUpperCase() + text.substring(1);
  }

  static int daysLeft(String date) {
    // a data vira no formato de dd/mm/yyyy
    final List<String> dateList = date.split('/');
    final DateTime dateExpiration = DateTime(int.parse(dateList[2]), int.parse(dateList[1]), int.parse(dateList[0]));
    final DateTime dateNow = DateTime.now();
    final int daysLeft = dateExpiration.difference(dateNow).inDays;
    return daysLeft;
  }

  // detectar a categoria e retorna o iconData correspondente
  static IconData categoryIcon(String category) {
    switch (category) {
      case 'Common':
        return Icons.check_box_outline_blank;
      case 'Grocery':
        return Icons.lunch_dining_outlined;
      case 'Work':
        return Icons.work_outline;
      case 'Sport':
        return Icons.fitness_center_outlined;
      case 'Design':
        return Icons.grid_view_outlined;
      case 'School':
        return Icons.school_outlined;
      case 'Social':
        return Icons.groups_outlined;
      default:
        return Icons.check_box_outline_blank;
    }
  }

  static dateExpiration(DateTime date) {
    return date.difference(DateTime.now()).inDays;
  }
}
