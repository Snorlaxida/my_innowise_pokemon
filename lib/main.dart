import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_innowise_pokemon/app_navigator.dart';
import 'package:my_innowise_pokemon/bloc/poke_bloc.dart';
import 'package:my_innowise_pokemon/cubit/internet_cubit.dart';
import 'package:my_innowise_pokemon/cubit/nav_cubit.dart';
import 'package:my_innowise_pokemon/cubit/pokemon_details_cubit.dart';
import 'package:my_innowise_pokemon/repository/pokemon_repository.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
          appBarTheme: const AppBarTheme(color: Colors.red, centerTitle: true)),
      home: MultiRepositoryProvider(
        providers: [
          RepositoryProvider(
            create: (context) => PokemonRepository(),
          ),
          RepositoryProvider(
            create: (context) => PokemonDetailsCubit(),
          ),
        ],
        child: MultiBlocProvider(
          providers: [
            BlocProvider(
              create: (context) => PokeBloc(
                  pokemonRepository: context.read<PokemonRepository>()),
            ),
            BlocProvider(
              create: (context) => NavCubit(
                  pokemonDetailsCubit: context.read<PokemonDetailsCubit>()),
            ),
            BlocProvider(
              create: (context) => InternetCubit(connectivity: Connectivity()),
            ),
          ],
          child: const AppNavigator(),
        ),
      ),
    );
  }
}
