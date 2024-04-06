import 'dart:async';

import 'package:bloc_concurrency/bloc_concurrency.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_innowise_pokemon/model/poke_list_part.dart';
import 'package:my_innowise_pokemon/model/poke_page.dart';
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
    on<PokeEvent>(
      _onPokeEvent,
      transformer: throttleDroppable(throttleDuration),
    );
  }

  Future<void> _onPokeEvent(
    PokeEvent event,
    Emitter<PokeState> emit,
  ) async {
    if (state.hasReachedMax) {
      return;
    }
    try {
      if (state.status == PokeStatus.initial) {
        final pokePage = await pokemonRepository.getPokemonPage();
        return emit(state.copyWith(
          status: PokeStatus.success,
          hasReachedMax: false,
          pokePage: pokePage,
        ));
      }
    } catch (e) {
      emit(state.copyWith(status: PokeStatus.failure));
    }
  }
}
