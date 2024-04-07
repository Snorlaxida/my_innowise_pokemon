import 'package:dio/dio.dart';
import 'package:my_innowise_pokemon/model/poke_page.dart';
import 'package:my_innowise_pokemon/model/pokemon_details.dart';

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

  Future<PokemonDetails> getPokemonDetails(int pokemonId) async {
    final uri = Uri.https(baseUrl, 'api/v2/pokemon/$pokemonId');

    try {
      final response = await client.getUri(uri);
      final json = response.data;
      return PokemonDetails.fromJson(json);
    } catch (e) {
      rethrow;
    }
  }
}
