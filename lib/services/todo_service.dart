import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';
import '../models/todo.dart';

/// Service class for managing Todo data persistence using shared_preferences.
class TodoService {
  static const String _todosKey = 'todos';

  /// Loads all todos from shared_preferences.
  Future<List<Todo>> loadTodos() async {
    final prefs = await SharedPreferences.getInstance();
    final todosJson = prefs.getString(_todosKey);
    
    if (todosJson == null || todosJson.isEmpty) {
      return [];
    }

    try {
      final List<dynamic> todosList = jsonDecode(todosJson);
      return todosList
          .map((json) => Todo.fromJson(json as Map<String, dynamic>))
          .toList();
    } catch (e) {
      // If JSON parsing fails due to corrupted data, format changes,
      // or invalid structure, return empty list to allow app to continue
      return [];
    }
  }

  /// Saves all todos to shared_preferences.
  Future<void> saveTodos(List<Todo> todos) async {
    final prefs = await SharedPreferences.getInstance();
    final todosJson = jsonEncode(todos.map((todo) => todo.toJson()).toList());
    await prefs.setString(_todosKey, todosJson);
  }
}
