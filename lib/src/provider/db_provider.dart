import 'dart:io';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path_provider/path_provider.dart';
import 'package:flutter_basics/src/models/task_model.dart';
export 'package:flutter_basics/src/models/task_model.dart';

class DBProvider {

  static Database _database;
  static final DBProvider db = DBProvider._();
  
  DBProvider._();

  Future<Database> get database async {
    if ( _database != null) return _database;
    _database = await initDB();
    return _database;
  }

  initDB() async {
    Directory documentsDirectory = await getApplicationSupportDirectory();
    final path = join(documentsDirectory.path, 'tasksDB.db');

    return await openDatabase(
      path,
      version: 1,
      onOpen: (db) {},
      onCreate: (Database db, int version) async {
        await db.execute(
          'CREATE TABLE Tasks ('
            ' id INTEGER PRIMARY KEY,'
            ' title TEXT,'
            ' description TEXT,'
            ' is_completed INTEGER' 
          ')'
        );
      }
    );
  }

  newTaskRaw(TaskModel newTask) async {
    final db = await database;
    final res = await db.rawInsert(
      "INSERT INTO Tasks (id, title, description, is_completed) "
      "VALUES ( ${ newTask.id }, '${ newTask.title }', '${ newTask.description}', ${0}}"
      );
      return res;
  }

  newScan(TaskModel newTask) async {
    final db = await database;
    final res = await db.insert('Tasks', newTask.toJson());
    return res;
  }

  Future<TaskModel> getTaskId(int id) async {
    final db = await database;
    final res = await db.query('Tasks', where: 'id = ?', whereArgs: [id]);
    return res.isNotEmpty ? TaskModel.fromJson(res.first) : null;
  }

  Future<List<TaskModel>> getTasks() async {
    final db = await database;
    final res = await db.query('Tasks');
    List<TaskModel> list = res.isNotEmpty 
                              ? res.map((c) => TaskModel.fromJson(c)).toList()
                              : [];
    return list;
  }

  Future<List<TaskModel>> getTasksCompleted(int isCompleted) async {
    final db = await database;
    final res = await db.rawQuery("SELECT * FROM Tasks WHERE is_completed = $isCompleted");
    List<TaskModel> list = res.isNotEmpty 
                              ? res.map((c) => TaskModel.fromJson(c)).toList()
                              : [];
    return list;
  }

  Future<int> updateTask(TaskModel newTask) async {
    final db = await database;
    final res = await db.update('Tasks', newTask.toJson(), where: 'id = ?', whereArgs: [newTask.id]);
    return res;
  }

  Future<int> updateIsCompleted(int complete, int taskId) async {
    final db = await database;
    final res = await db.rawUpdate('UPDATE Tasks SET is_completed = ? WHERE id = ?', [complete, taskId]);
    return res;
  }

  Future<int> deleteTask(int id) async {
    final db = await database;
    final res = await db.delete('Tasks', where: 'id = ?', whereArgs: [id]);
    return res;
  }

  Future<int> deleteAll() async {
    final db = await database;
    final res = await db.rawDelete('DELETE FROM Tasks');  
    return res;
  }
  
}