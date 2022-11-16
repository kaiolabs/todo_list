import 'package:todo_list/src/core/repositories/db.dart';

class CreateTables {
  static taks() async {
    final userDados = await DB.tableChecker('TASKS');
    if (userDados == false) {
      await DB.createTableTask();
    }
  }

  static createTables() async {
    await taks();
  }
}
