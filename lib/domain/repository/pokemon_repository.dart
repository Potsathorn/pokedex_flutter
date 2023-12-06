// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import 'package:pokedex_flutter/core/error/failure.dart';
import 'package:pokedex_flutter/domain/entity/pokedex_entity.dart';
import 'package:pokedex_flutter/domain/entity/pokemon_entity.dart';

abstract class PokemonRepository {
  Future<Either<Failure, PokemonEntity>> getPokemonByID({required String id});

  Future<Either<Failure, PokedexEntity>> getAllPokemon(
      {required int limit, required int offset});
}
