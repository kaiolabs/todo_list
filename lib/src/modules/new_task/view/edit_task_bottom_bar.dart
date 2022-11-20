import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:todo_list/src/modules/base/controllers/base_controller.dart';
import 'package:todo_list/src/modules/new_task/controller/task_controller.dart';
import 'package:todo_list/src/modules/new_task/models/task.dart';

import '../../../core/presenters/shared/button_pattern.dart';
import '../../../core/presenters/shared/button_pattern_out.dart';
import '../../../core/presenters/shared/snack_bar_messenger.dart';
import '../../../core/presenters/theme/color_outlet.dart';
import '../../../core/presenters/theme/size_outlet.dart';
import '../../../core/repositories/db.dart';

class EditTaskBottomBar extends StatelessWidget {
  final GlobalKey<FormState> formKeyEdit;
  final Task task;
  final BaseController baseController;
  final TaskController taskController;
  const EditTaskBottomBar({
    super.key,
    required this.formKeyEdit,
    required this.task,
    required this.baseController,
    required this.taskController,
  });

  @override
  Widget build(BuildContext context) {
    updateLists() {
      if (task.status == 'done') {
        DB.getTasksDone().then((value) {
          baseController.tasksDone.value = value;
        });
      } else if (task.status == 'pending') {
        DB.getTasks().then((value) {
          baseController.tasksAll.value = value;
        });
      }
    }

    return Padding(
      padding: const EdgeInsets.only(
        left: SizeOutlet.paddingSizeDefault,
        right: SizeOutlet.paddingSizeDefault,
        bottom: SizeOutlet.paddingSizeDefault,
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.45,
            child: ButtonPatternOut(
              lebel: 'Concluir tarefa',
              onPressed: () {
                if (formKeyEdit.currentState!.validate()) {
                  DB.taskChecker(taskController.titleController.text).then((value) {
                    DB.getIdTaskByTitle(taskController.titleController.text.toLowerCase()).then((valueIdByTitle) {
                      if (value && valueIdByTitle != task.id) {
                        snackBarMessenger(
                          context: context,
                          message: 'Tarefa já cadastrada',
                          duration: 2,
                          color: ColorOutlet.colorPrimaryLight,
                        );
                      } else {
                        DB.updateTask(
                          Task(
                            id: task.id,
                            title: taskController.titleController.text.toLowerCase(),
                            description: taskController.descriptionController.text,
                            dateExpiration: taskController.dateController.text,
                            dateCreation: task.dateCreation,
                            priority: taskController.priorityController.value,
                            category: taskController.categoryController.value,
                            status: 'done',
                          ),
                        );
                        updateLists();
                        Modular.to.pop();
                        snackBarMessenger(
                          context: context,
                          message: 'Tarefa concluída com sucesso',
                          duration: 3,
                          color: ColorOutlet.colorPrimaryLight,
                        );
                      }
                    });
                  });
                }
              },
            ),
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width * 0.45,
            child: ButtonPattern(
              label: 'Salvar',
              onPressed: () async {
                if (formKeyEdit.currentState!.validate()) {
                  DB.taskChecker(taskController.titleController.text).then((value) {
                    DB.getIdTaskByTitle(taskController.titleController.text.toLowerCase()).then((valueIdByTitle) {
                      if (value && valueIdByTitle != task.id) {
                        snackBarMessenger(
                          context: context,
                          message: 'Tarefa já existe',
                          duration: 2,
                          color: ColorOutlet.colorPrimaryLight,
                        );
                      } else {
                        DB.updateTask(
                          Task(
                            id: task.id,
                            title: taskController.titleController.text.toLowerCase(),
                            description: taskController.descriptionController.text,
                            dateExpiration: taskController.dateController.text,
                            dateCreation: task.dateCreation,
                            priority: taskController.priorityController.value,
                            category: taskController.categoryController.value,
                            status: task.status,
                          ),
                        );
                        updateLists();
                        Modular.to.pop();
                        snackBarMessenger(
                          context: context,
                          message: 'Tarefa atualizada com sucesso',
                          duration: 3,
                          color: ColorOutlet.colorPrimaryLight,
                        );
                      }
                    });
                  });
                }
              },
            ),
          ),
        ],
      ),
    );
  }
}
