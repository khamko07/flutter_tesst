import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/providers/todo_provider.dart';

void main() {
  group('TodoProvider Tests', () {
    late TodoProvider provider;

    setUp(() {
      provider = TodoProvider();
    });

    test('initial state should have empty todos list', () {
      expect(provider.todos, isEmpty);
      expect(provider.completedCount, 0);
      expect(provider.pendingCount, 0);
    });

    test('addTodo should add a new todo item', () {
      provider.addTodo('Test Todo');

      expect(provider.todos.length, 1);
      expect(provider.todos.first.title, 'Test Todo');
      expect(provider.todos.first.description, '');
      expect(provider.todos.first.isCompleted, false);
    });

    test('addTodo should add a todo with description', () {
      provider.addTodo('Test Todo', description: 'Test Description');

      expect(provider.todos.length, 1);
      expect(provider.todos.first.title, 'Test Todo');
      expect(provider.todos.first.description, 'Test Description');
    });

    test('removeTodo should remove the specified todo', () {
      provider.addTodo('Todo 1');
      provider.addTodo('Todo 2');
      final todoId = provider.todos.first.id;

      provider.removeTodo(todoId);

      expect(provider.todos.length, 1);
      expect(provider.todos.first.title, 'Todo 2');
    });

    test('removeTodo should do nothing for non-existent id', () {
      provider.addTodo('Test Todo');

      provider.removeTodo('non-existent-id');

      expect(provider.todos.length, 1);
    });

    test('toggleTodoStatus should toggle completion status', () {
      provider.addTodo('Test Todo');
      final todoId = provider.todos.first.id;

      expect(provider.todos.first.isCompleted, false);

      provider.toggleTodoStatus(todoId);
      expect(provider.todos.first.isCompleted, true);

      provider.toggleTodoStatus(todoId);
      expect(provider.todos.first.isCompleted, false);
    });

    test('toggleTodoStatus should do nothing for non-existent id', () {
      provider.addTodo('Test Todo');

      provider.toggleTodoStatus('non-existent-id');

      expect(provider.todos.first.isCompleted, false);
    });

    test('updateTodo should update title and description', () {
      provider.addTodo('Original Title', description: 'Original Description');
      final todoId = provider.todos.first.id;

      provider.updateTodo(
        todoId,
        title: 'Updated Title',
        description: 'Updated Description',
      );

      expect(provider.todos.first.title, 'Updated Title');
      expect(provider.todos.first.description, 'Updated Description');
    });

    test('updateTodo should do nothing for non-existent id', () {
      provider.addTodo('Test Todo');

      provider.updateTodo(
        'non-existent-id',
        title: 'Updated',
        description: 'Updated',
      );

      expect(provider.todos.first.title, 'Test Todo');
    });

    test('completedCount should return correct count', () {
      provider.addTodo('Todo 1');
      provider.addTodo('Todo 2');
      provider.addTodo('Todo 3');

      provider.toggleTodoStatus(provider.todos[0].id);
      provider.toggleTodoStatus(provider.todos[2].id);

      expect(provider.completedCount, 2);
      expect(provider.pendingCount, 1);
    });

    test('clearCompleted should remove all completed todos', () {
      provider.addTodo('Todo 1');
      provider.addTodo('Todo 2');
      provider.addTodo('Todo 3');

      provider.toggleTodoStatus(provider.todos[0].id);
      provider.toggleTodoStatus(provider.todos[2].id);

      provider.clearCompleted();

      expect(provider.todos.length, 1);
      expect(provider.todos.first.title, 'Todo 2');
      expect(provider.completedCount, 0);
    });

    test('clearCompleted should do nothing when no completed todos', () {
      provider.addTodo('Todo 1');
      provider.addTodo('Todo 2');

      provider.clearCompleted();

      expect(provider.todos.length, 2);
    });

    test('todos getter should return unmodifiable list', () {
      provider.addTodo('Test Todo');

      expect(() => provider.todos.add(provider.todos.first), throwsUnsupportedError);
    });
  });
}
