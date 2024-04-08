import 'package:flutter/foundation.dart';

class PokemonDetails {
  final int pokemonId;
  final Uint8List image;
  final String name;
  final List<String> types;
  final int height;
  final int weight;

  PokemonDetails(
      {required this.pokemonId,
      required this.image,
      required this.name,
      required this.types,
      required this.height,
      required this.weight});

  factory PokemonDetails.fromJson(Map<String, dynamic> json) {
    final pokemonId = json['id'];
    final name = json['name'];
    final image = json['sprites']['other']['official-artwork']['front_default'];
    final types = (json['types'] as List)
        .map((e) => e['type']['name'] as String)
        .toList();
    final height = json['height'];
    final weight = json['weight'];

    return PokemonDetails(
      pokemonId: pokemonId,
      image: image,
      name: name,
      types: types,
      height: height,
      weight: weight,
    );
  }
}
