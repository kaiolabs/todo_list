import 'package:flutter_modular/flutter_modular.dart';
import 'package:todo_list/splash_view.dart';
import 'package:todo_list/src/modules/base/base_module.dart';
import 'package:todo_list/src/modules/new_task/new_task_module.dart';

class AppModule extends Module {
  @override
  List<Bind> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (_, args) => const SplashView()),
        ModuleRoute('/base', module: BaseModule()),
        ModuleRoute('/new_task', module: NewTaskModule()),
      ];
}
