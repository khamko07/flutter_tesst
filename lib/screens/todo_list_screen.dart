import 'package:flutter/material.dart';
import '../models/todo.dart';
import '../services/todo_service.dart';

/// Main screen displaying the Todo list with add, toggle, and delete functionality.
class TodoListScreen extends StatefulWidget {
  const TodoListScreen({super.key});

  @override
  State<TodoListScreen> createState() => _TodoListScreenState();
}

class _TodoListScreenState extends State<TodoListScreen> {
  final TodoService _todoService = TodoService();
  final TextEditingController _textController = TextEditingController();
  List<Todo> _todos = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _loadTodos();
  }

  @override
  void dispose() {
    _textController.dispose();
    super.dispose();
  }

  /// Loads todos from shared_preferences on app start.
  Future<void> _loadTodos() async {
    final todos = await _todoService.loadTodos();
    setState(() {
      _todos = todos;
      _isLoading = false;
    });
  }

  /// Saves todos to shared_preferences.
  Future<void> _saveTodos() async {
    await _todoService.saveTodos(_todos);
  }

  /// Adds a new todo item.
  void _addTodo() {
    final title = _textController.text.trim();
    if (title.isEmpty) return;

    // Use timestamp + microseconds for better uniqueness
    final timestamp = DateTime.now();
    final newTodo = Todo(
      id: '${timestamp.millisecondsSinceEpoch}_${timestamp.microsecond}',
      title: title,
    );

    setState(() {
      _todos.add(newTodo);
    });
    _textController.clear();
    _saveTodos();
  }

  /// Toggles the completion status of a todo item.
  void _toggleTodo(String id) {
    setState(() {
      _todos = _todos.map((todo) {
        if (todo.id == id) {
          return todo.copyWith(isDone: !todo.isDone);
        }
        return todo;
      }).toList();
    });
    _saveTodos();
  }

  /// Deletes a todo item.
  void _deleteTodo(String id) {
    setState(() {
      _todos.removeWhere((todo) => todo.id == id);
    });
    _saveTodos();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Todo App'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Input section
          Padding(
            padding: const EdgeInsets.all(16.0),
            child: Row(
              children: [
                Expanded(
                  child: TextField(
                    controller: _textController,
                    decoration: const InputDecoration(
                      hintText: 'Enter a new todo...',
                      border: OutlineInputBorder(),
                      contentPadding: EdgeInsets.symmetric(
                        horizontal: 16.0,
                        vertical: 12.0,
                      ),
                    ),
                    onSubmitted: (_) => _addTodo(),
                  ),
                ),
                const SizedBox(width: 12.0),
                ElevatedButton(
                  onPressed: _addTodo,
                  style: ElevatedButton.styleFrom(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 24.0,
                      vertical: 16.0,
                    ),
                  ),
                  child: const Text('Add'),
                ),
              ],
            ),
          ),
          // Todo list section
          Expanded(
            child: _isLoading
                ? const Center(child: CircularProgressIndicator())
                : _todos.isEmpty
                    ? const Center(
                        child: Text(
                          'No todos yet. Add one above!',
                          style: TextStyle(
                            fontSize: 16.0,
                            color: Colors.grey,
                          ),
                        ),
                      )
                    : ListView.builder(
                        itemCount: _todos.length,
                        itemBuilder: (context, index) {
                          final todo = _todos[index];
                          return Card(
                            margin: const EdgeInsets.symmetric(
                              horizontal: 16.0,
                              vertical: 4.0,
                            ),
                            child: ListTile(
                              leading: Checkbox(
                                value: todo.isDone,
                                onChanged: (_) => _toggleTodo(todo.id),
                              ),
                              title: Text(
                                todo.title,
                                style: TextStyle(
                                  decoration: todo.isDone
                                      ? TextDecoration.lineThrough
                                      : TextDecoration.none,
                                  color: todo.isDone
                                      ? Theme.of(context).disabledColor
                                      : Theme.of(context)
                                          .textTheme
                                          .bodyLarge
                                          ?.color,
                                ),
                              ),
                              trailing: IconButton(
                                icon: const Icon(
                                  Icons.delete,
                                  color: Colors.red,
                                ),
                                onPressed: () => _deleteTodo(todo.id),
                              ),
                            ),
                          );
                        },
                      ),
          ),
        ],
      ),
    );
  }
}
