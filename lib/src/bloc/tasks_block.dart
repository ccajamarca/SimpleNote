import 'dart:async';
import 'package:flutter_basics/src/provider/db_provider.dart';

class TasksBlock {

  static final TasksBlock _singleton = new TasksBlock._internal();

  factory TasksBlock() {
    return _singleton;
  }

  TasksBlock._internal() {
    getTasks();
  }

  final _tasksController = StreamController<List<TaskModel>>.broadcast();

  Stream<List<TaskModel>> get tasksStream => _tasksController.stream;

  dispose() {
    _tasksController?.close();
  }

  getTasks() async {
    _tasksController.sink.add(await DBProvider.db.getTasks());
  }

  addnNewTask(TaskModel newTask) async {
    await DBProvider.db.newScan(newTask);
    getTasks();
  }

  updateTask(TaskModel task) async {
    await DBProvider.db.updateTask(task);
    getTasks();
  }

  updateIsCompleted(int complete, int taskId ) async {
    await DBProvider.db.updateIsCompleted(complete, taskId);
    getTasks();
  }

  deleteTask(int id) async {
    await DBProvider.db.deleteTask(id);
    getTasks();
  }

  deleteAllTasks() async {
    await DBProvider.db.deleteAll();
    getTasks();
  }

}