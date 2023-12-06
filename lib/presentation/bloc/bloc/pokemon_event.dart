part of 'pokemon_bloc.dart';

@immutable
sealed class PokemonEvent {}

class GetAllEvent extends PokemonEvent {
  final PokedexParam pokedexParam;

  GetAllEvent({required this.pokedexParam});
}

class GetByIDEvent extends PokemonEvent {
  final PokemonParam pokemonParam;

  GetByIDEvent({required this.pokemonParam});
}

class LoadMoreEvent extends PokemonEvent {}
