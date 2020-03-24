
import 'dart:convert';

TaskModel taskModelFromJson(String str) => TaskModel.fromJson(json.decode(str));

String taskModelToJson(TaskModel data) => json.encode(data.toJson());

class TaskModel {
    int id;
    String title;
    String description;
    int isCompleted;

    TaskModel({
        this.id,
        this.title,
        this.description,
        this.isCompleted,
    }) {
      if (this.isCompleted == null) {
        this.isCompleted = 0;
      }
    }

    factory TaskModel.fromJson(Map<String, dynamic> json) => TaskModel(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        isCompleted: json["is_completed"],
    );

    Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "is_completed": isCompleted,
    };
}