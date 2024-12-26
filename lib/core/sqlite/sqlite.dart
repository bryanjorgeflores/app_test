import 'dart:convert';
import 'dart:io';

import 'package:app_test/app/features/tasks/domain/entities/task.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class SQLiteHelper {
  static const String _tableName = 'tasks';
  static const String _columnId = 'id';
  static const String _columnData = 'data';

  static final SQLiteHelper _instance = SQLiteHelper._internal();
  SQLiteHelper._internal();
  factory SQLiteHelper() => _instance;

  Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  static Future<Database> _initDatabase() async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, 'tasks.db');

    final parentDir = Directory(dbPath);
    if (!await parentDir.exists()) {
      await parentDir.create(recursive: true);
    }

    final dataBase = await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE $_tableName (
            $_columnId INTEGER PRIMARY KEY,
            $_columnData TEXT
          )
        ''');
      },
    );

    return dataBase;
  }

  Future<List<TodoTask>> getTasks() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query(_tableName);
    List<TodoTask> result = [];

    for (var map in maps) {
      Map<String, dynamic> chunk = jsonDecode(map['data']);
      result.add(TodoTask.fromJson(chunk));
    }

    return result;
  }

  Future<int> insertTask(TodoTask task) async {
    final db = await database;
    return await db.insert(
      _tableName,
      {
        _columnId: task.id,
        _columnData: jsonEncode(task.toJson()),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<int> deleteTask(TodoTask task) async {
    final db = await database;
    return await db.delete(
      _tableName,
      where: '$_columnId = ?',
      whereArgs: [task.id],
    );
  }

  Future<int> updateTask(TodoTask task) async {
    final db = await database;
    final rowsAffected = await db.update(
      _tableName,
      {
        _columnData: jsonEncode(task.toJson()),
      },
      where: '$_columnId = ?',
      whereArgs: [task.id],
    );

    return rowsAffected;
  }
}
