import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_innowise_pokemon/model/poke_list_part.dart';
import 'package:my_innowise_pokemon/repository/pokemon_repository.dart';
import 'package:stream_transform/stream_transform.dart';

part 'poke_event.dart';
part 'poke_state.dart';

const throttleDuration = Duration(milliseconds: 100);

EventTransformer<E> throttleDroppable<E>(Duration duration) {
  return (events, mapper) {
    return droppable<E>().call(events.throttle(duration), mapper);
  };
}

class PokeBloc extends Bloc<PokeEvent, PokeState> {
  final PokemonRepository pokemonRepository;

  PokeBloc({required this.pokemonRepository}) : super(const PokeState()) {
    on<LoadPokemonsEvent>(
      _onLoadPokemonsEvent,
      transformer: throttleDroppable(throttleDuration),
    );
    on<NoInternetEvent>(
      _onNoInternetEvent,
    );
  }

  Future<void> _onLoadPokemonsEvent(
    PokeEvent event,
    Emitter<PokeState> emit,
  ) async {
    try {
      if (state.status == PokeStatus.initial) {
        final pokePage = await pokemonRepository.getPokemonPage();
        return emit(state.copyWith(
          status: PokeStatus.success,
          hasReachedMax: !pokePage.hasNext,
          pokeList: pokePage.pokeList,
        ));
      }
      if (state.hasReachedMax) {
        return;
      }
      final pokePage = await pokemonRepository.getPokemonPage(
        startWith: state.pokeList.length,
      );
      return pokePage.hasNext
          ? emit(state.copyWith(
              status: PokeStatus.success,
              hasReachedMax: false,
              pokeList: List.of(state.pokeList)..addAll(pokePage.pokeList!),
            ))
          : emit(state.copyWith(hasReachedMax: true));
    } catch (e) {
      emit(state.copyWith(status: PokeStatus.failure));
    }
  }

  Future<void> _onNoInternetEvent(
    PokeEvent event,
    Emitter<PokeState> emit,
  ) async {
    try {
      final pokePage = await pokemonRepository.getPokemonPageFromDb();
      return emit(state.copyWith(
        status: PokeStatus.offline,
        hasReachedMax: false,
        pokeList: pokePage.pokeList,
      ));
    } catch (e) {
      emit(state.copyWith(status: PokeStatus.failure));
    }
  }
}
