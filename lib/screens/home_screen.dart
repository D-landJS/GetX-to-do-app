import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_to_do_app/controllers/todo_controller.dart';
import 'package:getx_to_do_app/models/todo_model.dart';
import 'package:getx_to_do_app/screens/todo_screen.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final TodoController todoController = Get.put(TodoController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('GetX Todo List')),
      floatingActionButton: FloatingActionButton(
        onPressed: (() {
          Get.to(TodoScreen());
        }),
        child: const Icon(Icons.add),
      ),
      body: Obx(() => ListView.separated(
            itemBuilder: (context, index) => !todoController.todos[index].done
                ? ListTile(
                    title: Text(
                      todoController.todos[index].text!,
                      style: todoController.todos[index].done
                          ? const TextStyle(
                              color: Colors.red,
                              decoration: TextDecoration.lineThrough)
                          : TextStyle(
                              color:
                                  Theme.of(context).textTheme.bodyText1!.color),
                    ),
                    onTap: () => Get.to(TodoScreen(
                      index: index,
                    )),
                    leading: Checkbox(
                      value: todoController.todos[index].done,
                      onChanged: (v) {
                        var changed = todoController.todos[index];
                        changed.done = v!;
                        todoController.todos[index] = changed;
                      },
                    ),
                    trailing: const Icon(Icons.chevron_right),
                  )
                : Dismissible(
                    key: UniqueKey(),
                    onDismissed: (direction) {
                      Todo? removed = todoController.todos[index];
                      todoController.todos.removeAt(index);
                      Get.snackbar('Task removed',
                          'The task  "${removed.text}" was successfuly removed',
                          mainButton: TextButton(
                              child: const Text('Undo'),
                              onPressed: () {
                                if (removed == null) {
                                  return;
                                }
                                todoController.todos.insert(index, removed!);
                                removed = null;
                                if (Get.isSnackbarOpen) {
                                  Get.back();
                                }
                              }));
                    },
                    child: ListTile(
                      title: Text(
                        todoController.todos[index].text!,
                        style: todoController.todos[index].done
                            ? const TextStyle(
                                color: Colors.red,
                                decoration: TextDecoration.lineThrough)
                            : TextStyle(
                                color: Theme.of(context)
                                    .textTheme
                                    .bodyText1!
                                    .color),
                      ),
                      onTap: () => Get.to(TodoScreen(
                        index: index,
                      )),
                      leading: Checkbox(
                        value: todoController.todos[index].done,
                        onChanged: (v) {
                          var changed = todoController.todos[index];
                          changed.done = v!;
                          todoController.todos[index] = changed;
                        },
                      ),
                      trailing: const Icon(Icons.chevron_right),
                    ),
                  ),
            separatorBuilder: (_, __) => const Divider(),
            itemCount: todoController.todos.length,
          )),
    );
  }
}
