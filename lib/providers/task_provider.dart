import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../models/task_model.dart';

class TaskService extends StateNotifier<List<Task>> {
  TaskService() : super([]);

  void addTask(String title) {
    final newTask = Task(id: DateTime.now().toString(), title: title);
    state = [...state, newTask];
  }

  void deleteTask(String id) {
    state = state.where((task) => task.id != id).toList();
  }
}

final taskProvider = StateNotifierProvider<TaskService, List<Task>>((ref) {
  return TaskService();
});
