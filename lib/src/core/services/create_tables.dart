import 'package:todo_list/src/core/repositories/db.dart';

class CreateTables {
  static taks() async {
    final userDados = await DB.tableChecker('TASKS');
    if (userDados == false) {
      await DB.createTableTask();
    }
  }

  static settings() async {
    final userDados = await DB.tableChecker('SETTINGS');
    if (userDados == false) {
      await DB.createTableSettings();
    }
  }

  static createTables() async {
    await taks();
    await settings();
  }
}
