import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/todo_provider.dart';
import '../widgets/todo_item.dart';
import '../widgets/add_todo_dialog.dart';

/// The main home screen that displays the list of to-do items.
class HomeScreen extends StatelessWidget {
  /// Creates a [HomeScreen] widget.
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('To-Do App'),
        centerTitle: true,
        actions: [
          Consumer<TodoProvider>(
            builder: (context, todoProvider, child) {
              if (todoProvider.completedCount > 0) {
                return IconButton(
                  icon: const Icon(Icons.delete_sweep),
                  tooltip: 'Clear completed',
                  onPressed: () => _showClearCompletedDialog(context, todoProvider),
                );
              }
              return const SizedBox.shrink();
            },
          ),
        ],
      ),
      body: Consumer<TodoProvider>(
        builder: (context, todoProvider, child) {
          if (todoProvider.todos.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.checklist,
                    size: 80,
                    color: Colors.grey,
                  ),
                  SizedBox(height: 16),
                  Text(
                    'No to-dos yet!',
                    style: TextStyle(
                      fontSize: 18,
                      color: Colors.grey,
                    ),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Tap the + button to add one',
                    style: TextStyle(
                      color: Colors.grey,
                    ),
                  ),
                ],
              ),
            );
          }

          return Column(
            children: [
              // Stats bar
              Container(
                padding: const EdgeInsets.all(16),
                color: Theme.of(context).colorScheme.surfaceContainerHighest,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    _buildStatItem(
                      context,
                      'Total',
                      todoProvider.todos.length.toString(),
                      Colors.blue,
                    ),
                    _buildStatItem(
                      context,
                      'Pending',
                      todoProvider.pendingCount.toString(),
                      Colors.orange,
                    ),
                    _buildStatItem(
                      context,
                      'Completed',
                      todoProvider.completedCount.toString(),
                      Colors.green,
                    ),
                  ],
                ),
              ),
              // To-do list
              Expanded(
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 8),
                  itemCount: todoProvider.todos.length,
                  itemBuilder: (context, index) {
                    final todo = todoProvider.todos[index];
                    return TodoItem(
                      todo: todo,
                      onToggle: () => todoProvider.toggleTodoStatus(todo.id),
                      onDelete: () => _showDeleteConfirmation(
                        context,
                        todoProvider,
                        todo.id,
                        todo.title,
                      ),
                      onTap: () => _showEditDialog(context, todoProvider, todo),
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _showAddDialog(context),
        tooltip: 'Add To-Do',
        child: const Icon(Icons.add),
      ),
    );
  }

  Widget _buildStatItem(
    BuildContext context,
    String label,
    String value,
    Color color,
  ) {
    return Column(
      children: [
        Text(
          value,
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }

  Future<void> _showAddDialog(BuildContext context) async {
    final result = await showAddTodoDialog(context);
    if (result != null && context.mounted) {
      context.read<TodoProvider>().addTodo(
            result['title']!,
            description: result['description'] ?? '',
          );
    }
  }

  Future<void> _showEditDialog(
    BuildContext context,
    TodoProvider todoProvider,
    todo,
  ) async {
    final result = await showAddTodoDialog(
      context,
      initialTitle: todo.title,
      initialDescription: todo.description,
      isEditing: true,
    );
    if (result != null) {
      todoProvider.updateTodo(
        todo.id,
        title: result['title']!,
        description: result['description'] ?? '',
      );
    }
  }

  Future<void> _showDeleteConfirmation(
    BuildContext context,
    TodoProvider todoProvider,
    String id,
    String title,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete To-Do'),
        content: Text('Are you sure you want to delete "$title"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      todoProvider.removeTodo(id);
    }
  }

  Future<void> _showClearCompletedDialog(
    BuildContext context,
    TodoProvider todoProvider,
  ) async {
    final confirmed = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Clear Completed'),
        content: Text(
          'Are you sure you want to remove all ${todoProvider.completedCount} completed items?',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.of(context).pop(true),
            style: ElevatedButton.styleFrom(
              backgroundColor: Colors.red,
              foregroundColor: Colors.white,
            ),
            child: const Text('Clear'),
          ),
        ],
      ),
    );
    if (confirmed == true) {
      todoProvider.clearCompleted();
    }
  }
}
