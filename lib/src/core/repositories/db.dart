// ignore_for_file: avoid_print

import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo_list/src/core/infra/tables/table_settings.dart';
import 'package:todo_list/src/core/infra/tables/table_task.dart';
import 'package:todo_list/src/modules/new_task/models/task.dart';

class DB {
  static const String databaseName = "todo_list.db";
  static Database? db;

  static Database? _database;

  get database async {
    if (_database != null) return _database;

    return await initizateDb();
  }

  static Future<Database> initizateDb() async {
    final databasePath = await getDatabasesPath();
    final path = join(databasePath, databaseName);
    var exists = await databaseExists(path);

    if (!exists) {
      try {
        await Directory(dirname(path)).create(recursive: true);
      } on FileSystemException catch (e) {
        print(e.toString());
      }
      await openDatabase(
        path,
        version: 1,
      );
    }
    db = await openDatabase(path, readOnly: false);

    return db ??
        await openDatabase(
          path,
          version: 1,
          onCreate: (Database db, int version) async {
            await createTables(db);
          },
        );
  }

  static Future<void> createTables(Database database) async {}

  static Future<void> createTableTask() async {
    await TabelaTask.createTable(db!);
  }

  static Future<void> createTableSettings() async {
    await TabelaSettings.createTable(db!);
  }

  // get DARKMODE  from SETTINGS
  static Future<bool> getDarkMode() async {
    var table = await db!.query('SETTINGS', columns: ['DARKMODE']);
    return table[0]['DARKMODE'] == 1 ? true : false;
  }

  // set DARKMODE  from SETTINGS
  static Future<void> setDarkMode(bool darkMode) async {
    await db!.update(
      'SETTINGS',
      {'DARKMODE': darkMode ? 1 : 0},
      where: 'ID = ?',
      whereArgs: [1],
    );
  }

  // init SETTINGS
  static Future<void> initSettings() async {
    // verifica quntos registros tem na tabela SETTINGS
    var table = await db!.query('SETTINGS');
    // se não tiver nenhum registro, insere um registro com os valores padrões
    if (table.isEmpty) {
      await db!.insert(
        'SETTINGS',
        {
          'ID': 1,
          'TERMS': 0,
          'LOGGED': 0,
          'DARKMODE': 0,
          'USERNAME': '',
        },
      );
    }
  }

  // get LOGGED from SETTINGS

  static Future<bool> getLogged() async {
    var table = await db!.query('SETTINGS', columns: ['LOGGED']);
    return table[0]['LOGGED'] == 1 ? true : false;
  }

  // set LOGGED from SETTINGS

  static Future<void> setLogged(bool logged) async {
    await db!.update(
      'SETTINGS',
      {'LOGGED': logged ? 1 : 0},
      where: 'ID = ?',
      whereArgs: [1],
    );
  }

  // set TERMS and USERNAME from SETTINGS

  static Future<void> setTermsAndUsername(bool terms, String username) async {
    await db!.update(
      'SETTINGS',
      {'TERMS': terms ? 1 : 0, 'USERNAME': username},
      where: 'ID = ?',
      whereArgs: [1],
    );
  }

  // verificar se tabela existe
  static Future<bool> tableChecker(String nameTable) async {
    var table = await db!.rawQuery("SELECT name FROM sqlite_master WHERE type='table' AND name='$nameTable'");
    return table.isNotEmpty; // retorna true se a tabela existe
  }

  static Future<void> addTask(Task task) async {
    await db!.insert('TASKS', task.toJson());
  }

  static Future<bool> taskChecker(String title) async {
    var task = await db!.rawQuery("SELECT * FROM TASKS WHERE TITLE = '${title.toLowerCase()}'");
    return task.isNotEmpty; // retorna true se a tarefa existe
  }

  // pegar todas as tarefas
  static Future<List<Task>> getTasks() async {
    final List<Map<String, dynamic>> maps = await db!.query(
      'TASKS',
      where: 'STATUS != ?',
      whereArgs: ['done'],
    );
    return List.generate(maps.length, (i) {
      return Task.fromJson(maps[i]);
    });
  }

  // pegar todas as tarefas com status done
  static Future<List<Task>> getTasksDone() async {
    final List<Map<String, dynamic>> maps = await db!.query(
      'TASKS',
      where: 'STATUS = ?',
      whereArgs: ['done'],
    );
    return List.generate(maps.length, (i) {
      return Task.fromJson(maps[i]);
    });
  }

  // getTaskBy favorite
  static Future<List<Task>> getTaskFavorite() async {
    final List<Map<String, dynamic>> maps = await db!.query(
      'TASKS',
      where: 'FAVORITE = ?',
      whereArgs: ['1'],
    );
    return List.generate(maps.length, (i) {
      return Task.fromJson(maps[i]);
    });
  }

  // set favorite
  static Future<void> setFavorite({required String title, required bool favorite}) async {
    await db!.update(
      'TASKS',
      {'FAVORITE': favorite ? 1 : 0},
      where: 'TITLE = ?',
      whereArgs: [title],
    );
  }

  // chck favorite
  static Future<bool> checkFavorite(String title) async {
    var task = await db!.rawQuery("SELECT * FROM TASKS WHERE TITLE = '${title.toLowerCase()}' AND FAVORITE = '1'");
    return task.isNotEmpty; // retorna true se a tarefa existe
  }

  // searchTaskDone
  static Future<List<Task>> searchTask(
      {String? title = '', String? priority = '', String? category = '', String? status = '', String? favorite = ''}) async {
    String where = '';

    if (title!.isNotEmpty) {
      where += '${where == '' ? '' : ' AND '}TITLE LIKE \'%$title%\'';
    }
    if (priority!.isNotEmpty) {
      where += '${where == '' ? '' : ' AND '}PRIORITY = \'$priority\'';
    }
    if (category!.isNotEmpty) {
      where += '${where == '' ? '' : ' AND '}CATEGORY = \'$category\'';
    }
    if (status!.isNotEmpty) {
      where += '${where == '' ? '' : ' AND '}STATUS = \'$status\'';
    }
    if (favorite!.isNotEmpty) {
      where += '${where == '' ? '' : ' AND '}FAVORITE = \'$favorite\'';
    }

    final List<Map<String, dynamic>> maps = await db!.query(
      'TASKS',
      where: where,
    );
    return List.generate(maps.length, (i) {
      return Task.fromJson(maps[i]);
    });
  }

  // update task
  static Future<void> updateTask(Task task) async {
    await db!.update(
      'TASKS',
      task.toJson(),
      where: "ID = ${task.id}",
    );
    print('Tarefa atualizada com sucesso!');
  }

  // deleteTask
  static Future<void> deleteTask(int id) async {
    await db!.delete(
      'TASKS',
      where: "ID = $id",
    );
    print('Tarefa deletada com sucesso!');
  }

  // get id task by title
  static Future<int> getIdTaskByTitle(String title) async {
    final List<Map<String, dynamic>> maps = await db!.query('TASKS', where: "TITLE = ?", whereArgs: [title]);
    return maps.isEmpty ? 0 : maps[0]['ID'];
  }

//  final directory = await getExternalStorageDirectory();
  // fazer o backup do banco de dados
  static Future<void> backupDatabase() async {}
}
