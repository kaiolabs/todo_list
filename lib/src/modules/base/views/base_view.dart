import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:todo_list/src/core/presenters/shared/alert_dialog_pattern.dart';
import 'package:todo_list/src/core/presenters/theme/color_outlet.dart';
import 'package:todo_list/src/core/repositories/db.dart';
import 'package:todo_list/src/modules/base/controllers/base_controller.dart';
import 'package:todo_list/src/modules/base/views/components/pattern_bottom_navigation_bar.dart';
import 'package:todo_list/src/modules/base/views/done_view.dart';
import 'package:todo_list/src/modules/base/views/favorite_view.dart';
import 'package:todo_list/src/modules/base/views/home_view.dart';
import 'package:todo_list/src/modules/new_task/controller/task_controller.dart';

class BaseView extends StatefulWidget {
  final BaseController controller;
  final TaskController taskController;

  const BaseView({super.key, required this.controller, required this.taskController});

  @override
  State<BaseView> createState() => _FavoritesViewState();
}

class _FavoritesViewState extends State<BaseView> {
  @override
  void initState() {
    super.initState();
    DB.getTasks().then((value) {
      widget.controller.tasksAll.value = value;
    });
    DB.getTasksDone().then((value) {
      widget.controller.tasksDone.value = value;
    });
    DB.getTaskFavorite().then((value) {
      widget.controller.tasksFavorite.value = value;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButtonLocation: FloatingActionButtonLocation.endDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: ColorOutlet.colorPrimary,
        child: const Icon(
          Icons.add,
        ),
        onPressed: () {
          Modular.to.pushNamed('/new_task/');
        },
      ),
      bottomNavigationBar: PatternBottomNavigationBar(controller: widget.controller),
      body: WillPopScope(
        onWillPop: () async {
          return await alertDialogPattern(
            context,
            'Sair',
            'Você realmente quer sair?',
            exitMode: true,
          );
        },
        child: SafeArea(
            child: PageView(
          controller: widget.controller.pageController,
          physics: const BouncingScrollPhysics(),
          onPageChanged: (index) {
            widget.controller.selectedIndex.value = index;
          },
          children: [
            SingleChildScrollView(child: HomeView(controller: widget.controller, taskController: widget.taskController)),
            SingleChildScrollView(child: DoneView(controller: widget.controller, taskController: widget.taskController)),
            SingleChildScrollView(child: FavoriteView(controller: widget.controller, taskController: widget.taskController)),
            // SingleChildScrollView(child: SettingsView(controller: widget.controller)),
          ],
        )),
      ),
    );
  }
}
