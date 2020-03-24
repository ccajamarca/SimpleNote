import 'package:flutter/material.dart';
import 'package:flutter_basics/src/bloc/tasks_block.dart';
import 'package:flutter_basics/src/models/task_model.dart';

class TaskWidget extends StatefulWidget {

  final int id;
  final String title;
  final String description;
  final int isComplete;

  TaskWidget({
    Key key,
    this.id,
    this.title, 
    this.description,
    this.isComplete,
  }) : super(key: key);

  @override
  _TaskWidgetState createState() => _TaskWidgetState();
}

class _TaskWidgetState extends State<TaskWidget> {

  bool isCompletedTask;
  final tasksBlok = new TasksBlock();

  @override
  Widget build(BuildContext context) {

    isCompletedTask = widget.isComplete != 0;

    return Dismissible(
      key: UniqueKey(),
      background: Container(
        alignment: Alignment.centerRight,
        padding: EdgeInsets.only(right: 32.0),
        color: Colors.red,
        child: Text("HIDE", style: TextStyle(
          color: Colors.white, 
          fontSize: 16.0,
          fontWeight: FontWeight.w500
        )
        ),
      ),
      onDismissed: (direction) => tasksBlok.deleteTask(widget.id),
      child: Card(
        child: ListTile(
          leading: CircleAvatar(
            backgroundColor: Color.fromRGBO(255, 255, 255, 0.0),
            child: IconButton(
              icon: isCompletedTask ? Icon(Icons.check_box) : Icon(Icons.check_box_outline_blank), 
              onPressed: () => _handleTaskCompleted()
            ),
          ),
          title: Text(
            widget.title,
            style: TextStyle(decoration: isCompletedTask  ? TextDecoration.lineThrough : null)
          ),
          subtitle: Text("${widget.id}: ${widget.description}"),
          trailing: IconButton(
            icon: Icon(Icons.edit), 
            onPressed: () {
              Navigator.pushNamed(
                context, 'addnote', 
                arguments: TaskModel(id: widget.id, title: widget.title, description: widget.description)
              );
            }
          )
        ),
      ),
    );
  }

  void _handleTaskCompleted() {
    setState(() {
      isCompletedTask = !isCompletedTask;
      int completeTask = isCompletedTask ? 1 : 0;
      tasksBlok.updateIsCompleted(completeTask, widget.id);
    });
  }

}