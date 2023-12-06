// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import 'package:pokedex_flutter/core/error/failure.dart';
import 'package:pokedex_flutter/core/usecase/usecase.dart';
import 'package:pokedex_flutter/domain/entity/pokedex_entity.dart';
import 'package:pokedex_flutter/domain/repository/pokemon_repository.dart';

class PokedexUsecase extends UseCase<PokedexEntity, PokedexParam> {
  final PokemonRepository _pokemonRepository;
  PokedexUsecase(this._pokemonRepository);

  @override
  Future<Either<Failure, PokedexEntity>> execute(PokedexParam params) {
    return _pokemonRepository.getAllPokemon(
        limit: params.limit, offset: params.offset);
  }
}

class PokedexParam {
  final int limit;
  final int offset;

  PokedexParam({required this.limit, required this.offset});
}
