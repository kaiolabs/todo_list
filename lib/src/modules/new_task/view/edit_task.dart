import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:todo_list/src/core/presenters/functions/functions.dart';
import 'package:todo_list/src/core/presenters/shared/input_field.dart';
import 'package:todo_list/src/core/presenters/theme/color_outlet.dart';
import 'package:todo_list/src/core/repositories/db.dart';
import 'package:todo_list/src/modules/base/controllers/base_controller.dart';
import 'package:todo_list/src/modules/new_task/controller/task_controller.dart';
import 'package:todo_list/src/modules/new_task/models/task.dart';
import 'package:todo_list/src/modules/new_task/view/edit_task_bottom_bar.dart';

import '../../../core/presenters/shared/alert_dialog_pattern.dart';
import '../../../core/presenters/shared/button_simple.dart';
import '../../../core/presenters/shared/show_category.dart';
import '../../../core/presenters/shared/show_priority.dart';
import '../../../core/presenters/shared/snack_bar_messenger.dart';
import '../../../core/presenters/theme/font_family_outlet.dart';
import '../../../core/presenters/theme/size_outlet.dart';

class EditTaskView extends StatefulWidget {
  final TaskController taskController;
  final BaseController baseController;
  final Task task;

  const EditTaskView({super.key, required this.taskController, required this.task, required this.baseController});

  @override
  State<EditTaskView> createState() => _EditTaskViewState();
}

class _EditTaskViewState extends State<EditTaskView> {
  @override
  void initState() {
    super.initState();
    Future.delayed(Duration.zero, () {
      widget.taskController.titleController.text = Functions.upperCaseFirstLetter(widget.task.title);
      widget.taskController.descriptionController.text = widget.task.description;
      widget.taskController.categoryController.value = widget.task.category;
      widget.taskController.priorityController.value = widget.task.priority;
      widget.taskController.dateController.text = widget.task.dateExpiration;
    });
  }

  updateLists() {
    if (widget.task.status == 'done') {
      DB.getTasksDone().then((value) {
        widget.baseController.tasksDone.value = value;
      });
    } else if (widget.task.status == 'pending') {
      DB.getTasks().then((value) {
        widget.baseController.tasksAll.value = value;
      });
    }
  }

  GlobalKey<FormState> formKeyEdit = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: EditTaskBottomBar(
        task: widget.task,
        formKeyEdit: formKeyEdit,
        baseController: widget.baseController,
        taskController: widget.taskController,
      ),
      body: WillPopScope(
        onWillPop: () async {
          return await alertDialogPattern(
            context,
            'Deseja voltar?',
            'As informações não salvas serão perdidas, deseja continuar?',
            onConfirm: () {
              Modular.to.pop();
              Modular.to.pop();
            },
          );
        },
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.only(left: SizeOutlet.paddingSizeDefault, right: SizeOutlet.paddingSizeDefault),
            child: SingleChildScrollView(
              physics: const BouncingScrollPhysics(),
              child: Form(
                key: formKeyEdit,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(top: SizeOutlet.paddingSizeDefault, bottom: SizeOutlet.paddingSizeDefault),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          IconButton(
                            icon: const Icon(Icons.arrow_back),
                            onPressed: () {
                              alertDialogPattern(
                                context,
                                'Deseja voltar?',
                                'As informações não salvas serão perdidas, deseja continuar?',
                                onConfirm: () {
                                  Modular.to.pop();
                                  Modular.to.pop();
                                },
                              );
                            },
                          ),
                          const Text(
                            'Editar tarefa',
                            style: TextStyle(
                              fontSize: SizeOutlet.textSizeSmall2,
                              fontFamily: FontFamilyOutlet.defaultFontFamilyLight,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.delete_outline),
                            // popup menu
                            onPressed: () {
                              alertDialogPattern(
                                context,
                                'Deseja excluir a tarefa?',
                                'A tarefa será excluída permanentemente, deseja continuar?',
                                onConfirm: () async {
                                  await DB.deleteTask(widget.task.id!);
                                  updateLists();
                                  Modular.to.pop();
                                  Modular.to.pop();
                                  snackBarMessenger(
                                    context: context,
                                    message: 'Tarefa excluída com sucesso!',
                                    duration: 3,
                                    color: ColorOutlet.colorPrimaryLight,
                                  );
                                },
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.8,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                  top: SizeOutlet.paddingSizeHuge,
                                  bottom: SizeOutlet.paddingSizeMassive,
                                ),
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.only(right: SizeOutlet.paddingSizeMedium),
                                      child: ValueListenableBuilder<String>(
                                        valueListenable: widget.taskController.priorityController,
                                        builder: (context, value, child) {
                                          return ButtonSimple(
                                            text: 'Prioridade',
                                            icon: SvgPicture.asset('assets/images/flag.svg',
                                                width: SizeOutlet.iconSizeDefault, color: ColorOutlet.colorPrimary),
                                            controller: widget.taskController.priorityController,
                                            onPressed: () {
                                              showPriority(priorityController: widget.taskController.priorityController, context: context);
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                    ValueListenableBuilder(
                                      valueListenable: widget.taskController.categoryController,
                                      builder: (context, value, child) {
                                        return ButtonSimple(
                                          text: 'Categoria',
                                          icon: SvgPicture.asset(
                                            'assets/images/tag.svg',
                                            width: SizeOutlet.iconSizeDefault,
                                            color: ColorOutlet.colorPrimary,
                                          ),
                                          controller: widget.taskController.categoryController,
                                          onPressed: () {
                                            showCategory(categoryController: widget.taskController.categoryController, context: context);
                                          },
                                        );
                                      },
                                    ),
                                  ],
                                ),
                              ),
                              const Padding(
                                padding: EdgeInsets.only(
                                  bottom: SizeOutlet.paddingSizeSmall,
                                ),
                                child: Text(
                                  'Título',
                                  style: TextStyle(
                                    fontSize: SizeOutlet.textSizeMicro2,
                                    fontFamily: FontFamilyOutlet.defaultFontFamilyLight,
                                  ),
                                ),
                              ),
                              InputField(
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                controller: widget.taskController.titleController,
                                hintText: 'Título',
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Campo obrigatório';
                                  }
                                  return null;
                                },
                              ),
                              const Padding(
                                padding: EdgeInsets.only(
                                  top: SizeOutlet.paddingSizeMedium,
                                  bottom: SizeOutlet.paddingSizeSmall,
                                ),
                                child: Text(
                                  'Descrição',
                                  style: TextStyle(
                                    fontSize: SizeOutlet.textSizeMicro2,
                                    fontFamily: FontFamilyOutlet.defaultFontFamilyLight,
                                  ),
                                ),
                              ),
                              InputField(
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                controller: widget.taskController.descriptionController,
                                hintText: 'Descrição',
                              ),
                              const Padding(
                                padding: EdgeInsets.only(
                                  top: SizeOutlet.paddingSizeMedium,
                                  bottom: SizeOutlet.paddingSizeSmall,
                                ),
                                child: Text(
                                  'Data de expiração',
                                  style: TextStyle(
                                    fontSize: SizeOutlet.textSizeMicro2,
                                    fontFamily: FontFamilyOutlet.defaultFontFamilyLight,
                                  ),
                                ),
                              ),
                              InputField(
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                controller: widget.taskController.dateController,
                                hintText: 'Data de expiração',
                                dateMode: true,
                                suffixIcon: Icons.calendar_today,
                                validator: (value) {
                                  if (value.isEmpty) {
                                    return 'Por favor, insira uma data';
                                  }
                                  return null;
                                },
                              ),
                            ],
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
