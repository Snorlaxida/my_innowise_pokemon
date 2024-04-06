import 'package:dio/dio.dart';
import 'package:my_innowise_pokemon/model/poke_page.dart';

class PokemonRepository {
  Future<PokePage> getPokemonPage({int page = 0}) async {
    const baseUrl = 'pokeapi.co';
    final client = Dio();

    final queryParameters = {
      'limit': '20',
      'offset': (page * 20).toString(),
    };

    final uri = Uri.https(baseUrl, 'api/v2/pokemon', queryParameters);
    final response = await client.getUri(uri);
    final json = response.data;

    return PokePage.fromJson(json);
  }
}
