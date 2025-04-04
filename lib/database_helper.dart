import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseHelper {
  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  Future<Database> _initDatabase() async {
    String path = join(await getDatabasesPath(), 'app_database.db');
    return await openDatabase(
      path,
      version: 1,
      onCreate: (db, version) async {
        await db.execute('''
          CREATE TABLE users (
            id INTEGER PRIMARY KEY AUTOINCREMENT,
            name TEXT NOT NULL,
            email TEXT NOT NULL UNIQUE,
            phone TEXT NOT NULL,
            emergency_name TEXT,
            emergency_phone TEXT,
            password TEXT NOT NULL,
            certificate TEXT,
            photo TEXT
          )
        ''');
      },
    );
  }

  // Registro de usuario
  Future<int> registerUser(Map<String, dynamic> user) async {
    final db = await database;
    return await db.insert('users', user);
  }

  // Obtener usuario por correo y contraseña
  Future<Map<String, dynamic>?> getUser(String email, String password) async {
    final db = await database;
    var result = await db.query(
      'users',
      where: 'email = ? AND password = ?',
      whereArgs: [email, password],
    );
    if (result.isNotEmpty) {
      return result.first; // Retorna el primer usuario encontrado
    }
    return null; // Si no hay coincidencias, devuelve null
  }
}

