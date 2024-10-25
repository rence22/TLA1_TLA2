import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../providers/task_provider.dart';

class TaskScreen extends ConsumerWidget {
  final titleController = TextEditingController();

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final tasks = ref.watch(taskProvider);
    final taskService = ref.read(taskProvider.notifier);

    return Scaffold(
      appBar: AppBar(title: Text('Task Manager')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  final task = tasks[index];
                  return ListTile(
                    title: Text(task.title),
                    trailing: IconButton(
                      icon: Icon(Icons.delete),
                      onPressed: () => taskService.deleteTask(task.id),
                    ),
                  );
                },
              ),
            ),
            TextField(
              controller: titleController,
              decoration: InputDecoration(labelText: 'Task Title'),
            ),
            SizedBox(height: 10),
            ElevatedButton(
              onPressed: () {
                if (titleController.text.isNotEmpty) {
                  taskService.addTask(titleController.text);
                  titleController.clear();
                }
              },
              child: Text('Add Task'),
            ),
          ],
        ),
      ),
    );
  }
}
