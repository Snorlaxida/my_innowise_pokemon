import 'package:my_innowise_pokemon/model/poke_list_part.dart';
import 'package:my_innowise_pokemon/model/pokemon_details.dart';
import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class DatabaseService {
  static const int version = 1;
  static const String dbName = 'Pokemons.db';

  static Future<Database> _getDb() async {
    return openDatabase(
      join(await getDatabasesPath(), dbName),
      onCreate: (db, version) async {
        await db.execute('''
        CREATE TABLE "pokemon" (
          "id"	INTEGER UNIQUE,
          "name"	TEXT,
          "types"	TEXT,
          "image"	BLOB,
          "height"	INTEGER,
          "weight"	INTEGER,
          PRIMARY KEY("id")
        );
        ''');
      },
      version: version,
    );
  }

  static Future<int> addPokemon(PokemonDetails pokemonDetails) async {
    final db = await _getDb();
    return await db.insert("pokemon", pokemonDetails.toJson());
  }

  static Future<int> addPokemonListPart(PokeListPart pokeListPart) async {
    final db = await _getDb();
    return await db.insert("pokemon", pokeListPart.toJson(),
        conflictAlgorithm: ConflictAlgorithm.replace);
  }

  static Future<int> updatePokemon(PokemonDetails pokemonDetails) async {
    final db = await _getDb();
    return await db.update(
      "pokemon",
      pokemonDetails.toJson(),
      where: 'id = ?',
      whereArgs: [pokemonDetails.pokemonId],
    );
  }

  static Future<int> deletePokemon(PokemonDetails pokemonDetails) async {
    final db = await _getDb();
    return await db.delete(
      "pokemon",
      where: 'id = ?',
      whereArgs: [pokemonDetails.pokemonId],
    );
  }

  static Future<int> deleteAllPokemons() async {
    final db = await _getDb();
    return await db.delete(
      "pokemon",
    );
  }

  static Future<List<PokemonDetails>?> getAllPokemons() async {
    final db = await _getDb();

    final List<Map<String, dynamic>> maps = await db.query('pokemon');
    if (maps.isEmpty) {
      return null;
    }

    return List.generate(
        maps.length, (index) => PokemonDetails.fromDbJson(maps[index]));
  }

  static Future<PokemonDetails?> getPokemonDetails(int id) async {
    final db = await _getDb();

    final List<Map<String, dynamic>> pokemonDetailsJson = await db.query(
      'pokemon',
      where: 'id = ?',
      whereArgs: [id],
    );
    if (pokemonDetailsJson.isEmpty ||
        PokemonDetails.fromDbJson(pokemonDetailsJson[0]).image == null) {
      return null;
    }

    return PokemonDetails.fromDbJson(pokemonDetailsJson[0]);
  }

  static Future<List<PokeListPart>?> getAllPokeListParts() async {
    final db = await _getDb();

    final List<Map<String, dynamic>> maps = await db.query('pokemon');
    if (maps.isEmpty) {
      return null;
    }

    return List.generate(
        maps.length, (index) => PokeListPart.fromDbJson(maps[index]));
  }
}
