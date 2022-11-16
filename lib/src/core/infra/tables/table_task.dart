import 'package:sqflite/sqflite.dart';
import 'package:todo_list/src/core/infra/enums/db_types_variables.dart';

// O aplicativo deve ser capaz de criar tarefas que contenham titulo, descrição e uma data de expiração.

class TabelaTask {
  static Future createTable(Database db) async {
    await db.execute('''CREATE TABLE TASKS (
        ID ${DBTypesVariables.idType},
        TITLE ${DBTypesVariables.varcharType},
        DESCRIPTION ${DBTypesVariables.varcharType},
        STATUS ${DBTypesVariables.varcharType},
        DATEEXPIRATION ${DBTypesVariables.dateType},
        DATECREATION ${DBTypesVariables.dateType},
        CATEGORY ${DBTypesVariables.varcharType},
        PRIORITY ${DBTypesVariables.varcharType},
        FAVORITE ${DBTypesVariables.booleanType}
      )''');
  }
}
