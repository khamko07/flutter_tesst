/// Represents a single Todo item.
class Todo {
  final String id;
  final String title;
  final bool isDone;

  Todo({
    required this.id,
    required this.title,
    this.isDone = false,
  });

  /// Creates a copy of this Todo with optionally modified fields.
  Todo copyWith({
    String? id,
    String? title,
    bool? isDone,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      isDone: isDone ?? this.isDone,
    );
  }

  /// Converts the Todo to a JSON map for storage.
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'isDone': isDone,
    };
  }

  /// Creates a Todo from a JSON map.
  factory Todo.fromJson(Map<String, dynamic> json) {
    return Todo(
      id: json['id'] as String,
      title: json['title'] as String,
      isDone: json['isDone'] as bool? ?? false,
    );
  }
}
