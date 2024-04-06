part of 'poke_bloc.dart';

enum PokeStatus { initial, success, failure, offline }

final class PokeState extends Equatable {
  const PokeState({
    this.status = PokeStatus.initial,
    this.pokePage = const PokePage(hasNext: false, pokeList: <PokeListPart>[]),
    this.hasReachedMax = false,
  });

  final PokeStatus status;
  final PokePage pokePage;
  final bool hasReachedMax;

  PokeState copyWith({
    PokeStatus? status,
    PokePage? pokePage,
    bool? hasReachedMax,
  }) {
    return PokeState(
      status: status ?? this.status,
      pokePage: pokePage ?? this.pokePage,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status, hasReachedMax: $hasReachedMax, posts: ${pokePage.pokeList.length} }''';
  }

  @override
  List<Object> get props => [status, pokePage, hasReachedMax];
}
