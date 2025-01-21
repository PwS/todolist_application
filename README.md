# To-Do List Application

This is a simple To-Do List application built using Flutter. The app uses **SQLite** for local data storage, enabling users to add, update, and delete tasks persistently.

## Features
- **Add Tasks**: Create new tasks with ease.
- **Update Tasks**: Modify existing task details.
- **Delete Tasks**: Remove tasks from the list.
- **Persistent Storage**: Tasks are stored locally using SQLite, ensuring data is saved even after closing the app.

## Folder Structure
The project follows a structured organization for maintainability:

```
├───models
├───pages
└───services
```

### **1. models**
Contains data models representing the structure of the task. For example:
- `task.dart`: Defines the Task object with attributes like `id`, `content`, and `status`.

### **2. pages**
Includes the UI components for the application. For example:
- `home_page.dart`: The main page where the task list is displayed and adding or edit the task.

### **3. services**
Handles database interactions and business logic. For example:
- `database_service.dart`: Manages SQLite database operations such as creating, reading, updating, and deleting tasks.

## Technologies Used
- **Flutter**: Framework for building cross-platform apps.
- **SQLite**: Local database solution using the `sqflite` package.
- **Dart**: Programming language for Flutter.

## Setup and Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/yourusername/todolist_application.git
   ```

2. Navigate to the project directory:
   ```bash
   cd todolist_application
   ```

3. Install dependencies:
   ```bash
   flutter pub get
   ```

4. Run the app:
   ```bash
   flutter run
   ```

## Dependencies
The app uses the following dependencies:
- `flutter`: Core Flutter framework.
- `sqflite`: SQLite plugin for Flutter.
- `path`: For managing file paths.

Add them to your `pubspec.yaml`:
```yaml
dependencies:
  flutter:
    sdk: flutter
  sqflite: any
  path: any
```

## Screenshots
*(Add screenshots of your app here to showcase the UI and functionality.)*

## Future Improvements
- Add task categories.
- Implement task reminders.
- Enhance UI with animations.

## License
This project is licensed under the MIT License. See the [LICENSE](LICENSE) file for details.
