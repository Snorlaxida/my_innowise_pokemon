import 'package:dio/dio.dart';
import 'package:flutter/services.dart';
import 'package:my_innowise_pokemon/model/poke_page.dart';
import 'package:my_innowise_pokemon/model/pokemon_details.dart';
import 'package:my_innowise_pokemon/service/database_service.dart';

const baseUrl = 'pokeapi.co';

class PokemonRepository {
  final client = Dio();
  Future<PokePage> getPokemonPage({int startWith = 0}) async {
    final queryParameters = {
      'limit': '20',
      'offset': startWith.toString(),
    };

    final uri = Uri.https(baseUrl, 'api/v2/pokemon', queryParameters);
    final response = await client.getUri(uri);
    final json = response.data;

    return PokePage.fromJson(json);
  }

  Future<PokePage> getPokemonPageFromDb() async {
    final cachedPokemons = await DatabaseService.getAllPokeListParts();
    return PokePage(hasNext: false, pokeList: cachedPokemons);
  }

  Future<PokemonDetails> getPokemonDetails(int pokemonId) async {
    final uri = Uri.https(baseUrl, 'api/v2/pokemon/$pokemonId');
    final pokemonDetail = await DatabaseService.getPokemonDetails(pokemonId);
    if (pokemonDetail != null) {
      return pokemonDetail;
    }
    try {
      final response = await client.getUri(uri);
      final json = response.data;
      json['sprites']['other']['official-artwork']['front_default'] =
          await _convertImageUrlToUint8List(
              json['sprites']['other']['official-artwork']['front_default']);
      await DatabaseService.addPokemon(PokemonDetails.fromJson(json));
      return PokemonDetails.fromJson(json);
    } catch (e) {
      rethrow;
    }
  }
}

Future<Uint8List> _convertImageUrlToUint8List(String url) async {
  final bundle = NetworkAssetBundle(Uri.parse(url));
  final data = (await bundle.load(url)).buffer.asUint8List();
  return data;
}
