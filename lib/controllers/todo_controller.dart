import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';

import 'package:getx_to_do_app/models/todo_model.dart';

class TodoController extends GetxController {
  var todos = RxList<Todo>();

  @override
  void onInit() {
    List? storedTodos = GetStorage().read<List>('todos');

    if (storedTodos != null) {
      todos = RxList(storedTodos.map((e) => Todo.fromJson(e)).toList());
    }
    ever(todos, (_) {
      GetStorage().write('todos', todos.toList());
    });
    super.onInit();
  }
}
