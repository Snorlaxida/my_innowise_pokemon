import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_innowise_pokemon/model/pokemon_details.dart';
import 'package:my_innowise_pokemon/repository/pokemon_repository.dart';

class PokemonDetailsCubit extends Cubit<PokemonDetails?> {
  PokemonDetailsCubit() : super(null);

  final _pokemonRepository = PokemonRepository();

  void getPokemonDetails(int pokemonId) async {
    final pokemonInfo = await _pokemonRepository.getPokemonDetails(pokemonId);

    emit(PokemonDetails(
      pokemonId: pokemonInfo.pokemonId,
      name: pokemonInfo.name,
      imageUrl: pokemonInfo.imageUrl,
      types: pokemonInfo.types,
      height: pokemonInfo.height,
      weight: pokemonInfo.weight,
    ));
  }

  void clearPokemonDetails() => emit(null);
}
