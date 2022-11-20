import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:todo_list/src/core/presenters/functions/functions.dart';
import 'package:todo_list/src/core/presenters/shared/card_task.dart';
import 'package:todo_list/src/core/presenters/shared/filter.dart';
import 'package:todo_list/src/core/presenters/shared/not_task.dart';
import 'package:todo_list/src/core/repositories/db.dart';
import 'package:todo_list/src/modules/base/controllers/base_controller.dart';
import 'package:todo_list/src/modules/base/views/components/top_bar.dart';
import 'package:todo_list/src/modules/new_task/controller/task_controller.dart';
import 'package:todo_list/src/modules/new_task/view/edit_task.dart';

import '../../../core/presenters/shared/input_field.dart';
import '../../../core/presenters/theme/size_outlet.dart';

class HomeView extends StatefulWidget {
  final BaseController controller;
  final TaskController taskController;
  const HomeView({super.key, required this.controller, required this.taskController});

  @override
  State<HomeView> createState() => _HomeViewState();
}

class _HomeViewState extends State<HomeView> {
  @override
  void initState() {
    super.initState();
    DB.getTasks().then((value) {
      widget.controller.tasksAll.value = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TopBar(
          title: 'Tarefas',
          filterPressed: () {
            filter(
              context: context,
              controllerDropDownCategory: widget.controller.controllerDropDownCategoryHome,
              controllerDropDownPriority: widget.controller.controllerDropDownPriorityHome,
              onPressedFilterApply: () {
                widget.controller.searchTaskAll();
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
                controller: widget.controller.controllerSearcHome,
                label: 'Pesquisar',
                onChanged: (value) {
                  widget.controller.searchTaskAll();
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.61,
                child: ValueListenableBuilder(
                  valueListenable: widget.controller.tasksAll,
                  builder: (context, value, child) => widget.controller.tasksAll.value.isNotEmpty
                      ? ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: widget.controller.tasksAll.value.length,
                          padding: const EdgeInsets.only(top: SizeOutlet.paddingSizeExtraLarge),
                          itemBuilder: (context, index) {
                            return CardTask(
                              id: widget.controller.tasksAll.value[index].id!,
                              title: Functions.upperCaseFirstLetter(widget.controller.tasksAll.value[index].title),
                              description: widget.controller.tasksAll.value[index].description,
                              date: Functions.daysLeft(widget.controller.tasksAll.value[index].dateExpiration).toString(),
                              priority: widget.controller.tasksAll.value[index].priority,
                              category: widget.controller.tasksAll.value[index].category,
                              status: widget.controller.tasksAll.value[index].status,
                              baseController: widget.controller,
                              isFavorited: ValueNotifier<bool>(widget.controller.tasksAll.value[index].favorite),
                              onTap: () async {
                                await Modular.to.push(
                                  MaterialPageRoute(
                                    builder: (context) => EditTaskView(
                                      task: widget.controller.tasksAll.value[index],
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
