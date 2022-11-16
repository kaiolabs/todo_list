import 'package:flutter_modular/flutter_modular.dart';
import 'package:todo_list/src/modules/base/controllers/base_controller.dart';
import 'package:todo_list/src/modules/base/views/base_view.dart';
import 'package:todo_list/src/modules/new_task/controller/task_controller.dart';

class BaseModule extends Module {
  @override
  List<Bind> get binds => [
        Bind.lazySingleton((i) => BaseController()),
        Bind.lazySingleton((i) => TaskController()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (_, args) => BaseView(
            controller: Modular.get<BaseController>(),
            taskController: Modular.get<TaskController>(),
          ),
        ),
      ];
}
