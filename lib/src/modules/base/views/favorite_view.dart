import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:todo_list/src/core/presenters/shared/filter.dart';
import 'package:todo_list/src/core/repositories/db.dart';
import 'package:todo_list/src/modules/base/controllers/base_controller.dart';
import 'package:todo_list/src/modules/base/views/components/top_bar.dart';
import 'package:todo_list/src/modules/new_task/controller/task_controller.dart';

import '../../../core/presenters/functions/functions.dart';
import '../../../core/presenters/shared/card_task.dart';
import '../../../core/presenters/shared/input_field.dart';
import '../../../core/presenters/shared/not_task.dart';
import '../../../core/presenters/theme/size_outlet.dart';
import '../../new_task/view/edit_task.dart';

class FavoriteView extends StatefulWidget {
  final BaseController controller;
  final TaskController taskController;
  const FavoriteView({super.key, required this.controller, required this.taskController});

  @override
  State<FavoriteView> createState() => _FavoriteViewState();
}

class _FavoriteViewState extends State<FavoriteView> {
  @override
  void initState() {
    super.initState();
    DB.getTaskFavorite().then((value) {
      widget.controller.tasksFavorite.value = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TopBar(
          title: 'Favorite Tasks',
          filterPressed: () {
            filter(
              context: context,
              controllerDropDownCategory: widget.controller.controllerDropDownCategoryFavorite,
              controllerDropDownPriority: widget.controller.controllerDropDownPriorityFavorite,
              onPressedFilterApply: () {
                widget.controller.searchTaskFavorite();
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
                label: 'Search',
                onChanged: (value) {
                  widget.controller.searchTaskAll();
                },
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height * 0.61,
                child: ValueListenableBuilder(
                  valueListenable: widget.controller.tasksFavorite,
                  builder: (context, value, child) => widget.controller.tasksFavorite.value.isNotEmpty
                      ? ListView.builder(
                          physics: const BouncingScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: widget.controller.tasksFavorite.value.length,
                          padding: const EdgeInsets.only(top: SizeOutlet.paddingSizeExtraLarge),
                          itemBuilder: (context, index) {
                            return CardTask(
                              id: widget.controller.tasksFavorite.value[index].id!,
                              title: Functions.upperCaseFirstLetter(widget.controller.tasksFavorite.value[index].title),
                              description: widget.controller.tasksFavorite.value[index].description,
                              date: Functions.daysLeft(widget.controller.tasksFavorite.value[index].dateExpiration).toString(),
                              priority: widget.controller.tasksFavorite.value[index].priority,
                              category: widget.controller.tasksFavorite.value[index].category,
                              status: widget.controller.tasksFavorite.value[index].status,
                              baseController: widget.controller,
                              onTap: () async {
                                await Modular.to.push(
                                  MaterialPageRoute(
                                    builder: (context) => EditTaskView(
                                      task: widget.controller.tasksFavorite.value[index],
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
