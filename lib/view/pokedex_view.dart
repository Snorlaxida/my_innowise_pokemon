import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_innowise_pokemon/bloc/poke_bloc.dart';
import 'package:my_innowise_pokemon/cubit/nav_cubit.dart';

class PokedexView extends StatefulWidget {
  const PokedexView({super.key});

  @override
  State<PokedexView> createState() => _PokedexViewState();
}

class _PokedexViewState extends State<PokedexView> {
  final scrollController = ScrollController();

  @override
  void initState() {
    scrollController.addListener(_onScroll);
    super.initState();
  }

  void _onScroll() {
    if (_isBottom) {
      context.read<PokeBloc>().add((LoadPokemonsEvent()));
    }
  }

  bool get _isBottom {
    if (!scrollController.hasClients) return false;
    final maxScroll = scrollController.position.maxScrollExtent;
    final currentScroll = scrollController.offset;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  void dispose() {
    scrollController
      ..removeListener(_onScroll)
      ..dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Pokedex'),
      ),
      body: BlocBuilder<PokeBloc, PokeState>(
        builder: (context, state) {
          switch (state.status) {
            case PokeStatus.initial:
              return const Center(child: CircularProgressIndicator());
            case PokeStatus.offline:
              break;
            case PokeStatus.failure:
              return const Center(child: Text('Failed to load pokemons!'));
            case PokeStatus.success:
              if (state.pokeList.isEmpty) {
                return const Center(child: Text('No pokemons'));
              }
              return ListView.builder(
                itemBuilder: (BuildContext context, int index) {
                  return index >= state.pokeList.length
                      ? const Padding(
                          padding: EdgeInsets.symmetric(vertical: 30),
                          child: Center(child: CircularProgressIndicator()),
                        )
                      : ListTile(
                          title:
                              Center(child: Text(state.pokeList[index].name)),
                          onTap: () {
                            context
                                .read<NavCubit>()
                                .showPokemonDetails(state.pokeList[index].id);
                          },
                        );
                },
                itemCount: state.hasReachedMax
                    ? state.pokeList.length
                    : state.pokeList.length + 1,
                controller: scrollController,
              );
          }
          return ListView();
        },
      ),
    );
  }
}
