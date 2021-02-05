import 'package:deneme_f/database/favorite.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DbHelper {
  static Database _db;
  Future<Database> get db async {
    if (_db != null) return _db;
    _db = await initDb();
    return _db;
  }

  initDb() async {
    var dbFolder = await getDatabasesPath();
    String path = join(dbFolder, "Favorite.db");

    return await openDatabase(path, onCreate: _onCreate, version: 1);
  }

  Future<void> _onCreate(Database db, int version) async {
    await db.execute(
        "CREATE TABLE Favorite(id INTEGER PRIMARY KEY AUTOINCREMENT,firebaseId INTEGER)");
  }

  Future<List<Favorite>> getFavorite() async {
    var dbClient = await db;
    var result = await dbClient.query("Favorite");
    return result.map((e) => Favorite.fromMap(e)).toList();
  }

  Future<int> insertFavorite(Favorite favorite) async {
    var dbClient = await db;
    return await dbClient.insert("Favorite", favorite.toMap());
  }

  Future<int> deleteFavorite(Favorite favorite) async {
    var dbClient = await db;
    return await dbClient.delete("Favorite",
        where: "firebaseId=?", whereArgs: [favorite.firebaseId]);
  }
}
