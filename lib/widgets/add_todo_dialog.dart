import 'package:flutter/material.dart';

/// A dialog for adding or editing a to-do item.
///
/// Returns a [Map] with 'title' and 'description' keys if the user
/// submits the form, or null if the dialog is cancelled.
class AddTodoDialog extends StatefulWidget {
  /// Initial title value for editing existing to-do.
  final String initialTitle;

  /// Initial description value for editing existing to-do.
  final String initialDescription;

  /// Whether this is an edit dialog (true) or add dialog (false).
  final bool isEditing;

  /// Creates an [AddTodoDialog] widget.
  const AddTodoDialog({
    super.key,
    this.initialTitle = '',
    this.initialDescription = '',
    this.isEditing = false,
  });

  @override
  State<AddTodoDialog> createState() => _AddTodoDialogState();
}

class _AddTodoDialogState extends State<AddTodoDialog> {
  late final TextEditingController _titleController;
  late final TextEditingController _descriptionController;
  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    _titleController = TextEditingController(text: widget.initialTitle);
    _descriptionController = TextEditingController(text: widget.initialDescription);
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  void _submitForm() {
    if (_formKey.currentState?.validate() ?? false) {
      Navigator.of(context).pop({
        'title': _titleController.text.trim(),
        'description': _descriptionController.text.trim(),
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text(widget.isEditing ? 'Edit To-Do' : 'Add To-Do'),
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(
                labelText: 'Title',
                hintText: 'Enter to-do title',
                border: OutlineInputBorder(),
              ),
              validator: (value) {
                if (value == null || value.trim().isEmpty) {
                  return 'Please enter a title';
                }
                return null;
              },
              textInputAction: TextInputAction.next,
              autofocus: true,
            ),
            const SizedBox(height: 16),
            TextFormField(
              controller: _descriptionController,
              decoration: const InputDecoration(
                labelText: 'Description (optional)',
                hintText: 'Enter description',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
              textInputAction: TextInputAction.done,
              onFieldSubmitted: (_) => _submitForm(),
            ),
          ],
        ),
      ),
      actions: [
        TextButton(
          onPressed: () => Navigator.of(context).pop(),
          child: const Text('Cancel'),
        ),
        ElevatedButton(
          onPressed: _submitForm,
          child: Text(widget.isEditing ? 'Save' : 'Add'),
        ),
      ],
    );
  }
}

/// Shows the add/edit to-do dialog and returns the result.
Future<Map<String, String>?> showAddTodoDialog(
  BuildContext context, {
  String initialTitle = '',
  String initialDescription = '',
  bool isEditing = false,
}) {
  return showDialog<Map<String, String>>(
    context: context,
    builder: (context) => AddTodoDialog(
      initialTitle: initialTitle,
      initialDescription: initialDescription,
      isEditing: isEditing,
    ),
  );
}
