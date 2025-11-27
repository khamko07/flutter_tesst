# Flutter To-Do App

A simple, clean, and functional To-Do application built with Flutter.

## Features

- ✅ Add new to-do items with title and optional description
- ✅ Mark to-do items as complete/incomplete
- ✅ Edit existing to-do items
- ✅ Delete individual to-do items
- ✅ Clear all completed items at once
- ✅ View statistics (total, pending, completed)
- ✅ Material Design 3 with light and dark theme support
- ✅ State management using Provider

## Project Structure

```
lib/
├── main.dart                    # App entry point
├── models/
│   └── todo.dart                # To-do data model
├── providers/
│   └── todo_provider.dart       # State management
├── screens/
│   └── home_screen.dart         # Main to-do list screen
└── widgets/
    ├── add_todo_dialog.dart     # Dialog for adding/editing todos
    └── todo_item.dart           # Individual to-do item widget
```

## Getting Started

### Prerequisites

- [Flutter SDK](https://flutter.dev/docs/get-started/install) (version 3.0.0 or higher)
- A code editor (VS Code, Android Studio, or IntelliJ)

### Installation

1. Clone the repository:
   ```bash
   git clone https://github.com/khamko07/flutter_tesst.git
   cd flutter_tesst
   ```

2. Install dependencies:
   ```bash
   flutter pub get
   ```

3. Run the app:
   ```bash
   flutter run
   ```

### Running Tests

```bash
flutter test
```

## Usage

1. **Add a to-do**: Tap the floating action button (+) to open the add dialog
2. **Complete a to-do**: Tap the checkbox to mark an item as complete
3. **Edit a to-do**: Tap on a to-do item to edit it
4. **Delete a to-do**: Tap the delete icon on any item
5. **Clear completed**: Use the sweep icon in the app bar to remove all completed items

## Dependencies

- [provider](https://pub.dev/packages/provider) - State management
- [flutter_lints](https://pub.dev/packages/flutter_lints) - Recommended lints for Flutter apps

## Screenshots

The app features:
- A clean material design interface
- Empty state with helpful instructions
- Statistics bar showing total, pending, and completed counts
- Card-based to-do items with checkboxes
- Confirmation dialogs for destructive actions

## License

This project is open source and available under the MIT License.