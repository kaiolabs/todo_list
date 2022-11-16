import 'package:flutter_modular/flutter_modular.dart';
import 'package:todo_list/src/modules/base/controllers/base_controller.dart';
import 'package:todo_list/src/modules/new_task/view/new_task.dart';

class NewTaskModule extends Module {
  @override
  List<Bind> get binds => [
  ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (_, args) => NewTaskView(
            baseController: Modular.get<BaseController>(),
          ),
        ),
      ];
}
