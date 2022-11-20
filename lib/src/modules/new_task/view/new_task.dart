import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:todo_list/src/core/presenters/shared/input_field.dart';
import 'package:todo_list/src/core/presenters/theme/color_outlet.dart';
import 'package:todo_list/src/modules/base/controllers/base_controller.dart';
import 'package:todo_list/src/modules/new_task/models/task.dart';

import '../../../core/presenters/shared/alert_dialog_pattern.dart';
import '../../../core/presenters/shared/button_pattern.dart';
import '../../../core/presenters/shared/button_simple.dart';
import '../../../core/presenters/shared/show_category.dart';
import '../../../core/presenters/shared/show_priority.dart';
import '../../../core/presenters/shared/snack_bar_messenger.dart';
import '../../../core/presenters/theme/font_family_outlet.dart';
import '../../../core/presenters/theme/size_outlet.dart';
import '../../../core/repositories/db.dart';

class NewTaskView extends StatefulWidget {
  final BaseController baseController;
  const NewTaskView({
    super.key,
    required this.baseController,
  });

  @override
  State<NewTaskView> createState() => _NewTaskViewState();
}

class _NewTaskViewState extends State<NewTaskView> {
  GlobalKey<FormState> formKeyNewTask = GlobalKey<FormState>();
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  ValueNotifier<String> priorityController = ValueNotifier<String>('0');
  ValueNotifier<String> categoryController = ValueNotifier<String>('Comum');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.only(
          left: SizeOutlet.paddingSizeDefault,
          right: SizeOutlet.paddingSizeDefault,
          bottom: SizeOutlet.paddingSizeDefault,
        ),
        child: ButtonPattern(
          label: 'Salvar',
          onPressed: () {
            if (formKeyNewTask.currentState!.validate()) {
              DB.taskChecker(titleController.text).then((value) async {
                if (value) {
                  snackBarMessenger(
                    context: context,
                    message: 'Já existe uma tarefa com esse nome',
                    duration: 3,
                    color: ColorOutlet.colorPrimaryLight,
                  );
                } else {
                  await DB.addTask(
                    Task(
                      title: titleController.text.toLowerCase(),
                      description: descriptionController.text,
                      dateExpiration: dateController.text,
                      dateCreation: DateFormat('dd/MM/yyyy').format(DateTime.now()),
                      priority: priorityController.value,
                      category: categoryController.value,
                      status: 'pending',
                    ),
                  );
                  DB.getTasks().then((value) {
                    widget.baseController.tasksAll.value = value;
                  });
                  Modular.to.pop();
                  setState(() {});
                  snackBarMessenger(
                    context: context,
                    message: 'Tarefa cadastrada com sucesso',
                    duration: 3,
                    color: ColorOutlet.colorPrimaryLight,
                  );
                }
              });
            }
          },
        ),
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
                key: formKeyNewTask,
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
                            'Nova tarefa',
                            style: TextStyle(
                              fontSize: SizeOutlet.textSizeSmall2,
                              fontFamily: FontFamilyOutlet.defaultFontFamilyLight,
                            ),
                          ),
                          IconButton(
                            icon: const Icon(Icons.more_vert),
                            onPressed: () {},
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
                                        valueListenable: priorityController,
                                        builder: (context, value, child) {
                                          return ButtonSimple(
                                            text: 'Prioridade',
                                            icon: SvgPicture.asset(
                                              'assets/images/flag.svg',
                                              width: SizeOutlet.iconSizeDefault,
                                              color: ColorOutlet.colorPrimary,
                                            ),
                                            controller: priorityController,
                                            onPressed: () {
                                              showPriority(priorityController: priorityController, context: context);
                                            },
                                          );
                                        },
                                      ),
                                    ),
                                    ValueListenableBuilder(
                                      valueListenable: categoryController,
                                      builder: (context, value, child) {
                                        return ButtonSimple(
                                          text: 'Categoria',
                                          icon: SvgPicture.asset(
                                            'assets/images/tag.svg',
                                            width: SizeOutlet.iconSizeDefault,
                                            color: ColorOutlet.colorPrimary,
                                          ),
                                          controller: categoryController,
                                          onPressed: () {
                                            showCategory(categoryController: categoryController, context: context);
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
                                controller: titleController,
                                hintText: 'Nome da tarefa',
                                validator: (value) {
                                  if (value == null || value.isEmpty) {
                                    return 'Please enter some text';
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
                                controller: descriptionController,
                                hintText: 'Descrição da tarefa',
                              ),
                              const Padding(
                                padding: EdgeInsets.only(
                                  top: SizeOutlet.paddingSizeMedium,
                                  bottom: SizeOutlet.paddingSizeSmall,
                                ),
                                child: Text(
                                  'Data expiração da tarefa',
                                  style: TextStyle(
                                    fontSize: SizeOutlet.textSizeMicro2,
                                    fontFamily: FontFamilyOutlet.defaultFontFamilyLight,
                                  ),
                                ),
                              ),
                              InputField(
                                autovalidateMode: AutovalidateMode.onUserInteraction,
                                controller: dateController,
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
