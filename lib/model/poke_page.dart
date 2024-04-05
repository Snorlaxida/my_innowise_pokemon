import 'package:my_innowise_pokemon/model/poke_list_part.dart';

class PokePage {
  final bool hasNext;
  final List<PokeListPart> pokeList;

  PokePage({required this.hasNext, required this.pokeList});

  factory PokePage.fromJson(Map<String, dynamic> json) {
    final hasNext = json['next'];
    final pokeList = (json['results'] as List)
        .map((json) => PokeListPart.fromJson(json))
        .toList();
    return PokePage(hasNext: hasNext, pokeList: pokeList);
  }
}