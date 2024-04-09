part of 'poke_bloc.dart';

sealed class PokeEvent extends Equatable {
  @override
  List<Object> get props => [];
}

final class LoadPokemonsEvent extends PokeEvent {}

final class NoInternetEvent extends PokeEvent {}
