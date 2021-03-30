import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';
import 'Mascota.dart';

class DatabaseHelper{
  DatabaseHelper._();

  static const databaseName = 'mascotas.db';
  static final DatabaseHelper instance = DatabaseHelper._();
  static Database _database;

  Future<Database> get database async{
    if (_database == null){
      return await initializeDatabase();
    }
    return _database;
  }

  initializeDatabase() async{
    return await openDatabase(join(await getDatabasesPath(), databaseName),
        version: 1, onCreate: (Database db, int version) async {
          await db.execute(
              "CREATE TABLE mascota(id INTEGER PRIMARY KEY AUTOINCREMENT NOT NULL, Nombre TEXT, Edad TEXT, Vacunado TEXT)");
        });
  }

  insertMascota(Mascota mascota) async {
    final db = await database;
    var res = await db.insert(Mascota.TABLENAME, mascota.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
    return res;
  }

  updateMascota(Mascota mascota) async{
    final db = await database;
    await db.update(Mascota.TABLENAME, mascota.toMap(),
        where: 'id = ?',
        whereArgs: [mascota.id],
      conflictAlgorithm: ConflictAlgorithm.replace
    );
  }
}