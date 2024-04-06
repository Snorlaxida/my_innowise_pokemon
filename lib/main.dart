import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_innowise_pokemon/bloc/poke_bloc.dart';
import 'package:my_innowise_pokemon/repository/pokemon_repository.dart';
import 'package:my_innowise_pokemon/view/pokedex_view.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
          appBarTheme: const AppBarTheme(color: Colors.red, centerTitle: true)),
      home: RepositoryProvider(
        create: (context) => PokemonRepository(),
        child: BlocProvider(
          create: (context) =>
              PokeBloc(pokemonRepository: context.read<PokemonRepository>())
                ..add(LoadPokemonsEvent()),
          child: const PokedexView(),
        ),
      ),
    );
  }
}
