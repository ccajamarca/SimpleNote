import 'package:flutter/material.dart';
import 'package:flutter_basics/src/bloc/tasks_block.dart';
import 'package:flutter_basics/src/provider/db_provider.dart';

class AddNote extends StatefulWidget {
  @override
  _AddNoteState createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {

  var textCtrlTitle = TextEditingController();
  var textCtrlDescription = TextEditingController();
  String appBarTitle = "New Task";

  final tasksBlock = new TasksBlock();

  @override
  Widget build(BuildContext context) {

    final TaskModel itemTask = ModalRoute.of(context).settings.arguments;
    
    if (itemTask != null) {
      setState(() {
        textCtrlTitle.text = itemTask.title;
        textCtrlDescription.text = itemTask.description;
        appBarTitle = "Edit Task";
      });
    }

    return Scaffold(
      appBar: AppBar(
        title: Text(appBarTitle),
      ),
      body: _createNote(itemTask),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.done),
        onPressed: () => addOrUpdateTask(itemTask)
      ),
    );
  }

  Widget _createNote(TaskModel task){
    return ListView(
      padding: EdgeInsets.all(16.0),
      children: <Widget>[
        TextField(
          decoration: InputDecoration(
            hintText: 'Title',
            labelText: 'Title',
          ),
          controller: textCtrlTitle,
        ),
        TextField(
          decoration: InputDecoration(
            hintText: 'Enter your new task here',
            labelText: 'Enter your new task here'
          ),
          controller: textCtrlDescription,
        )
      ],
    );
  }

  void addOrUpdateTask(TaskModel itemTask) {
    if (itemTask != null) {
      final newTask = TaskModel(
        id: itemTask.id, 
        title: textCtrlTitle.text, 
        description: textCtrlDescription.text 
      );   
      tasksBlock.updateTask(newTask);
      Navigator.pushReplacementNamed(context, '/'); 
    } 
    else {
      final newTask = TaskModel(
        title: textCtrlTitle.text, 
        description: textCtrlDescription.text
      );   
      tasksBlock.addnNewTask(newTask);
      Navigator.pushReplacementNamed(context, '/');
    }
  }

}