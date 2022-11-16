import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:todo_list/app_module.dart';
import 'package:todo_list/app_widget.dart';
import 'package:todo_list/src/core/repositories/db.dart';
import 'package:todo_list/src/core/services/create_tables.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await DB.initizateDb();
  await CreateTables.createTables();
  Modular.to.addListener(() {
    debugPrint('Modular.to: ${Modular.to}');
  });

  runApp(
    ModularApp(module: AppModule(), child: const AppWidget()),
  );
}
