import 'package:newsjet/models/news_link.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseService {
  static Database? _db;
  static final DatabaseService instance = DatabaseService._constructor();

  DatabaseService._constructor();

  Future<Database> get database async {
    if (_db != null) {
      return _db!;
    }
    _db = await getDatabase();
    return _db!;
  }

  Future<Database> getDatabase() async {
    final databaseDirectoryPath = await getDatabasesPath();
    final databasePath = join(databaseDirectoryPath, "news_db.db");

    final database = await openDatabase(
      databasePath,
      version: 1,
      onCreate: (db, version) => {
        db.execute('''
        CREATE TABLE $tableName (
          $idColumn INTEGER PRIMARY KEY,
          $titleColumn TEXT NOT NULL,
          $summaryColumn TEXT,
          $linkColumn TEXT NOT NULL
        )
        ''')
      },
    );

    return database;
  }

  Future<void> insertNewsLink(NewsLink newsLink) async {
    final db = await database;
    await db.insert(tableName, newsLink.toMap(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  Future<List<NewsLink>> getNewsLinks() async {
    final db = await database;

    final List<Map<String, Object?>> linkMaps = await db.query(tableName);

    return [
      for (final {
            idColumn: id as int,
            titleColumn: title as String,
            summaryColumn: summary as String?,
            linkColumn: link as String
          } in linkMaps)
        NewsLink(id: id, title: title, summary: summary, link: link),
    ];
  }

  Future<void> deleteNewsLink(int id) async {
    final db = await database;
    await db.delete(tableName, where: "id = ?", whereArgs: [id]);
  }
}
