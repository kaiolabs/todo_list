import 'package:sqflite/sqflite.dart';
import 'package:todo_list/src/core/infra/enums/db_types_variables.dart';

class TabelaSettings {
  static Future createTable(Database db) async {
    await db.execute('''CREATE TABLE SETTINGS (
       ID ${DBTypesVariables.idType},
       DARKMODE ${DBTypesVariables.booleanType},
       USERNAME ${DBTypesVariables.varcharType},
       TERMS ${DBTypesVariables.booleanType},
       LOGGED ${DBTypesVariables.booleanType}
      )''');
  }
}
