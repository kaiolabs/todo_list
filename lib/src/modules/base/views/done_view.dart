import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:todo_list/src/core/presenters/shared/card_task.dart';
import 'package:todo_list/src/core/presenters/shared/input_field.dart';
import 'package:todo_list/src/core/presenters/shared/not_task.dart';
import 'package:todo_list/src/core/repositories/db.dart';
import 'package:todo_list/src/modules/base/controllers/base_controller.dart';
import 'package:todo_list/src/modules/base/views/components/top_bar.dart';
import 'package:todo_list/src/modules/new_task/controller/task_controller.dart';
import 'package:todo_list/src/modules/new_task/view/edit_task.dart';

import '../../../core/presenters/functions/functions.dart';
import '../../../core/presenters/shared/filter.dart';
import '../../../core/presenters/theme/size_outlet.dart';

class DoneView extends StatefulWidget {
  final BaseController controller;
  final TaskController taskController;
  const DoneView({super.key, required this.controller, required this.taskController});

  @override
  State<DoneView> createState() => _DoneViewState();
}

class _DoneViewState extends State<DoneView> {
  @override
  void initState() {
    super.initState();
    DB.getTasksDone().then((value) {
      widget.controller.tasksDone.value = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TopBar(
          title: 'Tarefas concluídas',
          filterPressed: () {
            filter(
              context: context,
              controllerDropDownCategory: widget.controller.controllerDropDownCategoryDone,
              controllerDropDownPriority: widget.controller.controllerDropDownPriorityDone,
              onPressedFilterApply: () {
                widget.controller.searchTaskDone();
              },
            );
          },
        ),
        Padding(
          padding: const EdgeInsets.only(
              left: SizeOutlet.paddingSizeDefault,
              right: SizeOutlet.paddingSizeDefault,
              top: SizeOutlet.paddingSizeDefault,
              bottom: SizeOutlet.paddingSizeMedium),
          child: Column(
            children: [
              InputField(
                controller: widget.controller.controllerSearcDone,
                label: 'Pesquisar',
                onChanged: (value) {
                  widget.controller.searchTaskDone();
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.61,
                child: ValueListenableBuilder(
                  valueListenable: widget.controller.tasksDone,
                  builder: (context, value, child) => widget.controller.tasksDone.value.isNotEmpty
                      ? ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: widget.controller.tasksDone.value.length,
                          padding: const EdgeInsets.only(top: SizeOutlet.paddingSizeExtraLarge),
                          itemBuilder: (context, index) {
                            return CardTask(
                              id: widget.controller.tasksDone.value[index].id!,
                              title: Functions.upperCaseFirstLetter(widget.controller.tasksDone.value[index].title),
                              description: widget.controller.tasksDone.value[index].description,
                              date: Functions.daysLeft(widget.controller.tasksDone.value[index].dateExpiration).toString(),
                              priority: widget.controller.tasksDone.value[index].priority,
                              category: widget.controller.tasksDone.value[index].category,
                              status: widget.controller.tasksDone.value[index].status,
                              baseController: widget.controller,
                              isFavorited: ValueNotifier<bool>(widget.controller.tasksDone.value[index].favorite),
                              onTap: () {
                                Modular.to.push(
                                  MaterialPageRoute(
                                    builder: (context) => EditTaskView(
                                      task: widget.controller.tasksDone.value[index],
                                      taskController: widget.taskController,
                                      baseController: widget.controller,
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                        )
                      : const NotTask(),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
