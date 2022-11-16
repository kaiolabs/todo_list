// ignore_for_file: avoid_print

import 'dart:io';

import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
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
  static Future<void> setFavorite({required int id, required bool favorite}) async {
    await db!.update(
      'TASKS',
      {'FAVORITE': favorite},
      where: "ID = $id",
    );
    print('favorito: $favorite');
  }

  // chck favorite
  static Future<bool> checkFavorite(int id) async {
    var task = await db!.rawQuery("SELECT * FROM TASKS WHERE ID = $id AND FAVORITE = '1'");
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
