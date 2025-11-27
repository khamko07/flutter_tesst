import 'package:flutter/foundation.dart';
import '../models/todo.dart';

/// A provider class that manages the state of to-do items.
///
/// Uses [ChangeNotifier] to notify listeners when the to-do list changes.
class TodoProvider extends ChangeNotifier {
  final List<Todo> _todos = [];
  int _idCounter = 0;

  /// Returns an unmodifiable list of all to-do items.
  List<Todo> get todos => List.unmodifiable(_todos);

  /// Returns the count of completed to-do items.
  int get completedCount => _todos.where((todo) => todo.isCompleted).length;

  /// Returns the count of pending (incomplete) to-do items.
  int get pendingCount => _todos.where((todo) => !todo.isCompleted).length;

  /// Generates a unique ID combining timestamp and counter.
  String _generateId() {
    _idCounter++;
    return '${DateTime.now().millisecondsSinceEpoch}_$_idCounter';
  }

  /// Adds a new to-do item with the given [title] and optional [description].
  void addTodo(String title, {String description = ''}) {
    final todo = Todo(
      id: _generateId(),
      title: title,
      description: description,
      createdAt: DateTime.now(),
    );
    _todos.add(todo);
    notifyListeners();
  }

  /// Removes the to-do item with the given [id].
  void removeTodo(String id) {
    _todos.removeWhere((todo) => todo.id == id);
    notifyListeners();
  }

  /// Toggles the completion status of the to-do item with the given [id].
  void toggleTodoStatus(String id) {
    final index = _todos.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      _todos[index] = _todos[index].copyWith(
        isCompleted: !_todos[index].isCompleted,
      );
      notifyListeners();
    }
  }

  /// Updates the to-do item with the given [id] with new [title] and [description].
  void updateTodo(String id, {required String title, required String description}) {
    final index = _todos.indexWhere((todo) => todo.id == id);
    if (index != -1) {
      _todos[index] = _todos[index].copyWith(
        title: title,
        description: description,
      );
      notifyListeners();
    }
  }

  /// Clears all completed to-do items from the list.
  void clearCompleted() {
    _todos.removeWhere((todo) => todo.isCompleted);
    notifyListeners();
  }
}
