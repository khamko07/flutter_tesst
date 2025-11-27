/// Represents a single to-do item with a title, description, and completion status.
class Todo {
  /// Unique identifier for the to-do item.
  final String id;

  /// Title of the to-do item.
  final String title;

  /// Optional description providing more details about the to-do.
  final String description;

  /// Whether the to-do item has been completed.
  final bool isCompleted;

  /// Timestamp when the to-do was created.
  final DateTime createdAt;

  /// Creates a new [Todo] instance.
  const Todo({
    required this.id,
    required this.title,
    this.description = '',
    this.isCompleted = false,
    required this.createdAt,
  });

  /// Creates a copy of this [Todo] with the given fields replaced.
  Todo copyWith({
    String? id,
    String? title,
    String? description,
    bool? isCompleted,
    DateTime? createdAt,
  }) {
    return Todo(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      isCompleted: isCompleted ?? this.isCompleted,
      createdAt: createdAt ?? this.createdAt,
    );
  }

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
    return other is Todo &&
        other.id == id &&
        other.title == title &&
        other.description == description &&
        other.isCompleted == isCompleted &&
        other.createdAt == createdAt;
  }

  @override
  int get hashCode {
    return Object.hash(id, title, description, isCompleted, createdAt);
  }

  @override
  String toString() {
    return 'Todo(id: $id, title: $title, description: $description, '
        'isCompleted: $isCompleted, createdAt: $createdAt)';
  }
}
