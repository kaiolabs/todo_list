import 'package:flutter/cupertino.dart';
import 'package:todo_list/src/core/repositories/db.dart';

import '../../new_task/models/task.dart';

class BaseController extends ChangeNotifier {
  ValueNotifier<int> selectedIndex = ValueNotifier<int>(0);
  PageController pageController = PageController();

  ValueNotifier<List<Task>> tasksAll = ValueNotifier<List<Task>>([]);
  ValueNotifier<List<Task>> tasksDone = ValueNotifier<List<Task>>([]);
  ValueNotifier<List<Task>> tasksFavorite = ValueNotifier<List<Task>>([]);
  TextEditingController controllerSearcHome = TextEditingController();
  TextEditingController controllerSearcDone = TextEditingController();
  TextEditingController controllerSearcFavorite = TextEditingController();

  ValueNotifier<String> controllerDropDownCategoryHome = ValueNotifier<String>('');
  ValueNotifier<String> controllerDropDownPriorityHome = ValueNotifier<String>('');

  ValueNotifier<String> controllerDropDownCategoryDone = ValueNotifier<String>('');
  ValueNotifier<String> controllerDropDownPriorityDone = ValueNotifier<String>('');

  ValueNotifier<String> controllerDropDownCategoryFavorite = ValueNotifier<String>('');
  ValueNotifier<String> controllerDropDownPriorityFavorite = ValueNotifier<String>('');

  searchTaskDone() {
    DB
        .searchTask(
      category: controllerDropDownCategoryDone.value,
      priority: controllerDropDownPriorityDone.value,
      title: controllerSearcDone.text.toLowerCase(),
      status: 'done',
    )
        .then((value) {
      tasksDone.value = value;
    });
  }

  searchTaskAll() {
    DB
        .searchTask(
      title: controllerSearcHome.text.toLowerCase(),
      category: controllerDropDownCategoryHome.value,
      priority: controllerDropDownPriorityHome.value,
      status: 'pending',
    )
        .then((value) {
      tasksAll.value = value;
    });
  }

  searchTaskFavorite() {
    DB
        .searchTask(
      title: controllerSearcFavorite.text.toLowerCase(),
      category: controllerDropDownCategoryFavorite.value,
      priority: controllerDropDownPriorityFavorite.value,
      favorite: '1',
    )
        .then((value) {
      tasksFavorite.value = value;
    });
  }
}
