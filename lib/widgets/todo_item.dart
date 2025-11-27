import 'package:flutter/material.dart';
import '../models/todo.dart';

/// A widget that displays a single to-do item.
///
/// Shows the title, description (if available), and a checkbox to toggle
/// completion status. Also provides an option to delete the item.
class TodoItem extends StatelessWidget {
  /// The to-do item to display.
  final Todo todo;

  /// Callback when the completion status is toggled.
  final VoidCallback onToggle;

  /// Callback when the delete button is pressed.
  final VoidCallback onDelete;

  /// Callback when the item is tapped for editing.
  final VoidCallback? onTap;

  /// Creates a [TodoItem] widget.
  const TodoItem({
    super.key,
    required this.todo,
    required this.onToggle,
    required this.onDelete,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 4),
      child: ListTile(
        leading: Checkbox(
          value: todo.isCompleted,
          onChanged: (_) => onToggle(),
        ),
        title: Text(
          todo.title,
          style: TextStyle(
            decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
            color: todo.isCompleted ? Colors.grey : null,
          ),
        ),
        subtitle: todo.description.isNotEmpty
            ? Text(
                todo.description,
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
                style: TextStyle(
                  decoration: todo.isCompleted ? TextDecoration.lineThrough : null,
                  color: todo.isCompleted ? Colors.grey : null,
                ),
              )
            : null,
        trailing: IconButton(
          icon: const Icon(Icons.delete_outline, color: Colors.red),
          onPressed: onDelete,
        ),
        onTap: onTap,
      ),
    );
  }
}
