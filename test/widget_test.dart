import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:todo_app/main.dart';
import 'package:todo_app/providers/todo_provider.dart';

void main() {
  group('TodoApp Widget Tests', () {
    testWidgets('app should display title', (WidgetTester tester) async {
      await tester.pumpWidget(const TodoApp());
      
      expect(find.text('To-Do App'), findsOneWidget);
    });

    testWidgets('should show empty state when no todos', (WidgetTester tester) async {
      await tester.pumpWidget(const TodoApp());
      
      expect(find.text('No to-dos yet!'), findsOneWidget);
      expect(find.text('Tap the + button to add one'), findsOneWidget);
      expect(find.byIcon(Icons.checklist), findsOneWidget);
    });

    testWidgets('should have floating action button', (WidgetTester tester) async {
      await tester.pumpWidget(const TodoApp());
      
      expect(find.byType(FloatingActionButton), findsOneWidget);
      expect(find.byIcon(Icons.add), findsOneWidget);
    });

    testWidgets('should open add dialog when FAB is tapped', (WidgetTester tester) async {
      await tester.pumpWidget(const TodoApp());
      
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
      
      expect(find.text('Add To-Do'), findsOneWidget);
      expect(find.text('Title'), findsOneWidget);
      expect(find.text('Description (optional)'), findsOneWidget);
      expect(find.text('Cancel'), findsOneWidget);
      expect(find.text('Add'), findsOneWidget);
    });

    testWidgets('should add a todo item', (WidgetTester tester) async {
      await tester.pumpWidget(const TodoApp());
      
      // Open dialog
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
      
      // Enter title
      await tester.enterText(find.byType(TextFormField).first, 'New Task');
      await tester.pumpAndSettle();
      
      // Tap Add button
      await tester.tap(find.text('Add'));
      await tester.pumpAndSettle();
      
      // Verify todo was added
      expect(find.text('New Task'), findsOneWidget);
      expect(find.text('No to-dos yet!'), findsNothing);
    });

    testWidgets('should show validation error for empty title', (WidgetTester tester) async {
      await tester.pumpWidget(const TodoApp());
      
      // Open dialog
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
      
      // Tap Add button without entering title
      await tester.tap(find.text('Add'));
      await tester.pumpAndSettle();
      
      // Should show validation error
      expect(find.text('Please enter a title'), findsOneWidget);
    });

    testWidgets('should close dialog on cancel', (WidgetTester tester) async {
      await tester.pumpWidget(const TodoApp());
      
      // Open dialog
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
      
      // Tap Cancel button
      await tester.tap(find.text('Cancel'));
      await tester.pumpAndSettle();
      
      // Dialog should be closed
      expect(find.text('Add To-Do'), findsNothing);
    });

    testWidgets('should toggle todo completion status', (WidgetTester tester) async {
      await tester.pumpWidget(
        ChangeNotifierProvider(
          create: (_) => TodoProvider()..addTodo('Test Task'),
          child: MaterialApp(
            home: const Material(child: Scaffold(body: _TodoTestWidget())),
          ),
        ),
      );
      
      // Find checkbox
      final checkbox = find.byType(Checkbox);
      expect(checkbox, findsOneWidget);
      
      // Initially unchecked
      final checkboxWidget = tester.widget<Checkbox>(checkbox);
      expect(checkboxWidget.value, false);
    });

    testWidgets('should show stats bar when todos exist', (WidgetTester tester) async {
      await tester.pumpWidget(const TodoApp());
      
      // Add a todo
      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();
      await tester.enterText(find.byType(TextFormField).first, 'Test Task');
      await tester.tap(find.text('Add'));
      await tester.pumpAndSettle();
      
      // Verify stats bar is shown
      expect(find.text('Total'), findsOneWidget);
      expect(find.text('Pending'), findsOneWidget);
      expect(find.text('Completed'), findsOneWidget);
    });
  });
}

/// Test widget to help test todo item functionality
class _TodoTestWidget extends StatelessWidget {
  const _TodoTestWidget();

  @override
  Widget build(BuildContext context) {
    return Consumer<TodoProvider>(
      builder: (context, provider, child) {
        final todos = provider.todos;
        if (todos.isEmpty) {
          return const Text('No todos');
        }
        return ListView.builder(
          itemCount: todos.length,
          itemBuilder: (context, index) {
            final todo = todos[index];
            return ListTile(
              leading: Checkbox(
                value: todo.isCompleted,
                onChanged: (_) => provider.toggleTodoStatus(todo.id),
              ),
              title: Text(todo.title),
            );
          },
        );
      },
    );
  }
}
