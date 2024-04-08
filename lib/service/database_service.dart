import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static const int version = 1;
  static const String dbName = 'Pokemons.db';

  static Future<Database> _getDb() async {
    return openDatabase(
      join(await getDatabasesPath(), dbName),
      onCreate: (db, version) async {
        await db.execute('');
      },
    );
  }
}
