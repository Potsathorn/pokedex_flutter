part of 'pokemon_bloc.dart';

@immutable
sealed class PokemonState {}

final class PokemonInitial extends PokemonState {}

final class PokedexHasData extends PokemonState {
  final PokedexEntity pokedex;

  PokedexHasData({required this.pokedex});
}

final class PokemonHasData extends PokemonState {
  final PokemonEntity pokemon;
  final int? previous;
  final int? next;
  PokemonHasData({this.previous, this.next, required this.pokemon});
}

final class LoadingState extends PokemonState {}

final class LoadMoreState extends PokemonState {}

final class FailureState extends PokemonState {
  final String message;
  FailureState({required this.message});
}
