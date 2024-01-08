


class Todo {
  String id;
  String title;
  String description;
  DateTime time;
  bool isCompleted;
  Todo(
      {required this.id,
        required this.title,
        required this.description,
        required this.time,
        required this.isCompleted,
      });

  factory Todo.fromJson(Map<String, Object?> json) {
    return Todo(
      id: json["id"] as String,
      title: json["title"] as String,
      description: json["description"] as String,
      time: DateTime.parse(json["time"] as String),
      isCompleted: json["isCompleted"] as bool,
    );
  }

  Map<String, Object> toJson() => {
    "id": id,
    "title": title,
    "description": description,
    "time": time.toIso8601String(),
    "isCompleted": isCompleted,
  };

  @override
  int get hashCode => Object.hash(id, title, isCompleted);

  @override
  bool operator ==(Object other) {
    return other is Todo &&
        other.title == title &&
        other.id == id && time == other.time &&
        other.isCompleted == isCompleted;
  }

  @override
  String toString() {
    return "$id. title: $title, desc: $description $time ";
  }
}