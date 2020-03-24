import 'package:flutter/material.dart';
import 'package:flutter_basics/src/bloc/tasks_block.dart';
import 'package:flutter_basics/src/models/task_model.dart';
import 'package:flutter_basics/src/widgets/task_widget.dart';

class HomePage extends StatelessWidget {

  final tasksBlock = new TasksBlock();

  @override
  Widget build(BuildContext context) {

    tasksBlock.getTasks();

    return Scaffold(
      appBar: AppBar(
        title: Text('SimpleNote'),
        leading: IconButton(
          icon: Icon(Icons.menu), 
          onPressed: (){}
        ),
        actions: <Widget>[
          IconButton(
            icon: Icon(Icons.search), 
            onPressed: (){}
          ),
          IconButton(
            icon: Icon(Icons.filter_list), 
            onPressed: (){}
          ),
        ],
      ),
      body: _listCards(context),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        backgroundColor: Theme.of(context).primaryColor,
        onPressed: () => Navigator.pushNamed(context, 'addnote')
      ),
    );
  }

  Widget _listCards(BuildContext context) {
    return StreamBuilder(
      stream: tasksBlock.tasksStream,
      builder: (BuildContext context, AsyncSnapshot<List<TaskModel>> snapshot) {
        if (!snapshot.hasData) {
          return Center(
            child: CircularProgressIndicator(),
          );
        }

        final tasks = snapshot.data;

        if (tasks.length == 0) {
          return Center(
            child: Container(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  CircleAvatar(
                    radius: 48.0,
                    backgroundColor: Colors.blue[200],
                    child: Icon(Icons.assignment_late, size: 48.0),
                  ),
                  SizedBox(height: 16.0),
                  Text("You have no tasks!")
                ],
              )
            ) ,
          );
        }

        return ListView.builder(
          itemCount: tasks.length,
          itemBuilder: (context, i) => TaskWidget(
            id: tasks[i].id, 
            title: tasks[i].title, 
            description: tasks[i].description,
            isComplete: tasks[i].isCompleted
          )
        );
      }
    );
  }
}