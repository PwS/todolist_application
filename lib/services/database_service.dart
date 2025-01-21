import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:todolist_application/models/task.dart';

class DatabaseService {
  static Database? _db;

  //Singleton
  static final DatabaseService instance = DatabaseService._constructor();

  final String _taskTableName = 'tasks';
  final String _tasksIdColumnName = 'id';
  final String _tasksContentColumnName = 'content';
  final String _tasksStatusColumnName = 'status';

  DatabaseService._constructor();

  Future<Database> get database async {
    if (_db != null) return _db!;
    _db = await getDatabase();
    return _db!;
  }

  Future<Database> getDatabase() async {
    final databaseDirPath = await getDatabasesPath();
    final databasePath = join(databaseDirPath, "master_db.db");
    final database = await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) {
        db.execute('''
      CREATE TABLE  $_taskTableName(
      $_tasksIdColumnName INTEGER PRIMARY KEY,
      $_tasksContentColumnName TEXT NOT NULL,
      $_tasksStatusColumnName INTEGER NOT NULL
      )
      ''');
      },
    );
    return database;
  }

  void addTask(
    String content,
  ) async {
    final db = await database;
    await db.insert(_taskTableName,
        {_tasksContentColumnName: content, _tasksStatusColumnName: 0});
  }

  Future<List<Task>> getTasks() async {
    final db = await database;
    final data = await db.query(_taskTableName);
    List<Task> tasks = data.map((e) => Task.fromJson(e)).toList();
    return tasks;
  }

  void updateTaskStatus(int id, int status) async {
    final db = await database;
    await db.update(_taskTableName, {_tasksStatusColumnName: status},
        where: '$_tasksIdColumnName = ?', whereArgs: [id]);
  }

  void deleteTask(int id) async {
    final db = await database;
    await db.delete(_taskTableName,
        where: '$_tasksIdColumnName = ?', whereArgs: [id]);
  }
}
