import 'package:flutter_test/flutter_test.dart';
import 'package:todo_app/models/todo.dart';

void main() {
  group('Todo Model Tests', () {
    test('should create a Todo with required fields', () {
      final now = DateTime.now();
      final todo = Todo(
        id: '1',
        title: 'Test Todo',
        createdAt: now,
      );

      expect(todo.id, '1');
      expect(todo.title, 'Test Todo');
      expect(todo.description, '');
      expect(todo.isCompleted, false);
      expect(todo.createdAt, now);
    });

    test('should create a Todo with all fields', () {
      final now = DateTime.now();
      final todo = Todo(
        id: '1',
        title: 'Test Todo',
        description: 'Test Description',
        isCompleted: true,
        createdAt: now,
      );

      expect(todo.id, '1');
      expect(todo.title, 'Test Todo');
      expect(todo.description, 'Test Description');
      expect(todo.isCompleted, true);
      expect(todo.createdAt, now);
    });

    test('copyWith should create a copy with updated fields', () {
      final now = DateTime.now();
      final todo = Todo(
        id: '1',
        title: 'Original Title',
        description: 'Original Description',
        isCompleted: false,
        createdAt: now,
      );

      final updatedTodo = todo.copyWith(
        title: 'Updated Title',
        isCompleted: true,
      );

      expect(updatedTodo.id, '1');
      expect(updatedTodo.title, 'Updated Title');
      expect(updatedTodo.description, 'Original Description');
      expect(updatedTodo.isCompleted, true);
      expect(updatedTodo.createdAt, now);
    });

    test('copyWith should preserve original values when not specified', () {
      final now = DateTime.now();
      final todo = Todo(
        id: '1',
        title: 'Test Todo',
        description: 'Test Description',
        isCompleted: false,
        createdAt: now,
      );

      final copiedTodo = todo.copyWith();

      expect(copiedTodo.id, todo.id);
      expect(copiedTodo.title, todo.title);
      expect(copiedTodo.description, todo.description);
      expect(copiedTodo.isCompleted, todo.isCompleted);
      expect(copiedTodo.createdAt, todo.createdAt);
    });

    test('equality should work correctly', () {
      final now = DateTime.now();
      final todo1 = Todo(
        id: '1',
        title: 'Test',
        createdAt: now,
      );
      final todo2 = Todo(
        id: '1',
        title: 'Test',
        createdAt: now,
      );
      final todo3 = Todo(
        id: '2',
        title: 'Test',
        createdAt: now,
      );

      expect(todo1, equals(todo2));
      expect(todo1, isNot(equals(todo3)));
    });

    test('hashCode should be consistent', () {
      final now = DateTime.now();
      final todo1 = Todo(
        id: '1',
        title: 'Test',
        createdAt: now,
      );
      final todo2 = Todo(
        id: '1',
        title: 'Test',
        createdAt: now,
      );

      expect(todo1.hashCode, equals(todo2.hashCode));
    });

    test('toString should return a readable string', () {
      final now = DateTime.now();
      final todo = Todo(
        id: '1',
        title: 'Test',
        description: 'Desc',
        isCompleted: false,
        createdAt: now,
      );

      final str = todo.toString();
      expect(str, contains('id: 1'));
      expect(str, contains('title: Test'));
      expect(str, contains('description: Desc'));
      expect(str, contains('isCompleted: false'));
    });
  });
}
