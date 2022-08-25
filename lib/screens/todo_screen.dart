import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:getx_to_do_app/controllers/todo_controller.dart';
import 'package:getx_to_do_app/models/todo_model.dart';

class TodoScreen extends StatelessWidget {
  TodoScreen({Key? key, this.index}) : super(key: key);

  final TodoController todoController = Get.find();

  final int? index;

  @override
  Widget build(BuildContext context) {
    String? text = '';

    if (index != null) {
      text = todoController.todos[index!].text;
    }
    TextEditingController textEditingController =
        TextEditingController(text: text);
    return Scaffold(
      body: SafeArea(
          minimum: const EdgeInsets.all(12),
          child: Column(
            children: [
              Expanded(
                  child: TextField(
                controller: textEditingController,
                decoration: const InputDecoration(
                    hintText: 'What do you want to accomplish?',
                    border: InputBorder.none,
                    focusedBorder: InputBorder.none),
                style: const TextStyle(fontSize: 25.0),
                keyboardType: TextInputType.multiline,
                maxLines: 999,
              )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: () => Get.back(),
                    style: ElevatedButton.styleFrom(primary: Colors.red),
                    child: const Text('Cancel'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      if (index == null) {
                        todoController.todos
                            .add(Todo(text: textEditingController.text));
                        textEditingController.clear();
                      } else {
                        var editing = todoController.todos[index!];
                        editing.text = textEditingController.text;
                        todoController.todos[index!] = editing;
                      }

                      Get.back();
                    },
                    style: ElevatedButton.styleFrom(primary: Colors.green),
                    child: Text(index == null ? 'Add' : 'Edit'),
                  )
                ],
              )
            ],
          )),
    );
  }
}
