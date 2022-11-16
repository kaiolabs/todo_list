import 'package:flutter/material.dart';
import 'package:todo_list/src/modules/new_task/models/task.dart';

class TaskController extends ChangeNotifier {
  TextEditingController titleController = TextEditingController();
  TextEditingController descriptionController = TextEditingController();
  TextEditingController dateController = TextEditingController();
  ValueNotifier<String> priorityController = ValueNotifier<String>('0');
  ValueNotifier<String> categoryController = ValueNotifier<String>('Common');
  Task task = Task();
}
