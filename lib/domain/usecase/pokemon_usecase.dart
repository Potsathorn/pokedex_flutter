// Package imports:
import 'package:dartz/dartz.dart';

// Project imports:
import 'package:pokedex_flutter/core/error/failure.dart';
import 'package:pokedex_flutter/core/usecase/usecase.dart';
import 'package:pokedex_flutter/domain/entity/pokemon_entity.dart';
import 'package:pokedex_flutter/domain/repository/pokemon_repository.dart';

class PokemonUsecase extends UseCase<PokemonEntity, PokemonParam> {
  final PokemonRepository _pokemonRepository;

  PokemonUsecase(this._pokemonRepository);

  @override
  Future<Either<Failure, PokemonEntity>> execute(PokemonParam params) {
    return _pokemonRepository.getPokemonByID(id: params.id.toString());
  }
}

class PokemonParam {
  final int id;

  PokemonParam({required this.id});
}
