# Flutter Todo App

A simple and clean Todo application built with Flutter that persists data using `shared_preferences`.

## Features

- ✅ Display a list of todo items
- ✅ Add new todo items
- ✅ Toggle completed/not completed status
- ✅ Delete todo items
- ✅ Automatic data persistence with shared_preferences

## Project Structure

```
lib/
├── main.dart                    # App entry point
├── models/
│   └── todo.dart               # Todo data model
├── screens/
│   └── todo_list_screen.dart   # Main UI screen
└── services/
    └── todo_service.dart       # Data persistence service
```

## Todo Model

Each Todo item includes:
- `id` - Unique identifier (timestamp-based)
- `title` - The todo text content
- `isDone` - Completion status (boolean)

## How to Run the App

### Prerequisites
- Flutter SDK 3.0 or later
- Dart SDK (included with Flutter)
- An IDE (VS Code, Android Studio, or IntelliJ)

### Steps

1. **Clone the repository:**
   ```bash
   git clone https://github.com/khamko07/flutter_tesst.git
   cd flutter_tesst
   ```

2. **Install dependencies:**
   ```bash
   flutter pub get
   ```

3. **Run the app:**
   ```bash
   # For development
   flutter run
   
   # For specific platform
   flutter run -d chrome    # Web
   flutter run -d android   # Android
   flutter run -d ios       # iOS
   ```

## How shared_preferences Works in This App

### Overview

`shared_preferences` is a Flutter plugin that provides a persistent key-value store for simple data. In this app, it's used to save and load todo items so they persist across app restarts.

### Implementation Details

1. **Data Storage Format:**
   - Todo items are converted to JSON format using `toJson()` method
   - The entire list is serialized as a JSON string
   - Stored under the key `'todos'` in shared_preferences

2. **Saving Data:**
   ```dart
   Future<void> saveTodos(List<Todo> todos) async {
     final prefs = await SharedPreferences.getInstance();
     final todosJson = jsonEncode(todos.map((todo) => todo.toJson()).toList());
     await prefs.setString(_todosKey, todosJson);
   }
   ```

3. **Loading Data:**
   ```dart
   Future<List<Todo>> loadTodos() async {
     final prefs = await SharedPreferences.getInstance();
     final todosJson = prefs.getString(_todosKey);
     // Parse JSON and convert back to Todo objects
   }
   ```

4. **Automatic Persistence:**
   - Every add, toggle, or delete operation triggers `_saveTodos()`
   - Data is loaded automatically when the app starts via `_loadTodos()` in `initState()`

### Storage Location

- **Android:** SharedPreferences (XML file in app's private directory)
- **iOS:** NSUserDefaults
- **Web:** LocalStorage
- **Windows/Linux/macOS:** JSON file in app support directory

## UI Components

- **AppBar:** Displays "Todo App" title
- **TextField:** Input field for new todo items
- **Add Button:** Adds the entered todo to the list
- **ListView:** Displays all todo items with checkboxes
- **Checkbox:** Toggles completion status
- **Delete Button:** Removes todo item from the list

## Dependencies

```yaml
dependencies:
  flutter:
    sdk: flutter
  shared_preferences: ^2.2.2
```

## License

This project is open source and available under the MIT License