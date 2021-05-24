import 'package:equatable/equatable.dart';
import 'package:uuid/uuid.dart';

class Todo extends Equatable {
  final String id;
  final String title;
  final String description;
  final bool isComplete;

  Todo({String id, this.title, this.description, this.isComplete})
      : this.id = id ?? Uuid().v4();

  Todo copyWith({String title, String description, bool isComplete}) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isComplete: isComplete ?? this.isComplete,
    );
  }

  factory Todo.fromJson(Map<String, dynamic> json) => Todo(
        id: json["id"],
        title: json["title"],
        description: json["description"],
        isComplete: json["isComplete"],
      );

  Map<String, dynamic> toJson() => {
        "id": id,
        "title": title,
        "description": description,
        "isComplete": isComplete,
      };

  @override
  List<Object> get props => [id, title, description, isComplete];
}
