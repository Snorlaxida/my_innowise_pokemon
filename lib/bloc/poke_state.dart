part of 'poke_bloc.dart';

enum PokeStatus { initial, success, failure, offline }

final class PokeState extends Equatable {
  const PokeState({
    this.status = PokeStatus.initial,
    this.pokeList = const <PokeListPart>[],
    this.hasReachedMax = false,
  });

  final PokeStatus status;
  final List<PokeListPart> pokeList;
  final bool hasReachedMax;

  PokeState copyWith({
    PokeStatus? status,
    List<PokeListPart>? pokeList,
    bool? hasReachedMax,
  }) {
    return PokeState(
      status: status ?? this.status,
      pokeList: pokeList ?? this.pokeList,
      hasReachedMax: hasReachedMax ?? this.hasReachedMax,
    );
  }

  @override
  String toString() {
    return '''PostState { status: $status, hasReachedMax: $hasReachedMax, posts: ${pokeList.length} }''';
  }

  @override
  List<Object> get props => [status, pokeList, hasReachedMax];
}
