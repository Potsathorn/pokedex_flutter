// Package imports:
import 'package:dartz/dartz.dart';
import 'package:dio/dio.dart';

// Project imports:
import 'package:pokedex_flutter/core/error/exception.dart';
import 'package:pokedex_flutter/core/error/failure.dart';
import 'package:pokedex_flutter/core/network/network_info.dart';
import 'package:pokedex_flutter/data/datasource/remote/pokemon_datasource.dart';
import 'package:pokedex_flutter/domain/entity/pokedex_entity.dart';
import 'package:pokedex_flutter/domain/entity/pokemon_entity.dart';
import 'package:pokedex_flutter/domain/repository/pokemon_repository.dart';

class PokemonRepositoryImpl implements PokemonRepository {
  final PokemonRemoteDataSource _pokemonRemoteDataSource;
  final NetworkInfo _networkInfo;
  PokemonRepositoryImpl(this._pokemonRemoteDataSource, this._networkInfo);
  @override
  Future<Either<Failure, PokedexEntity>> getAllPokemon(
      {required int limit, required int offset}) async {
    var isConnected = await _networkInfo.isConnected;
    if (isConnected) {
      try {
        var response = await _pokemonRemoteDataSource.getAllPokemon(
            limit: limit, offset: offset);
        return Right(response.toEntity());
      } on ServerException {
        return const Left(ServerFailure('Server failure'));
      } on DioException catch (e) {
        return Left(ServerFailure(e.message.toString()));
      }
    } else {
      return const Left(ServerFailure('Failed to connect to the network'));
    }
  }

  @override
  Future<Either<Failure, PokemonEntity>> getPokemonByID(
      {required String id}) async {
    var isConnected = await _networkInfo.isConnected;
    if (isConnected) {
      try {
        var response = await _pokemonRemoteDataSource.getPokemonByID(id: id);
        return Right(response.toEntity());
      } on ServerException {
        return const Left(ServerFailure('Server failure'));
      } on DioException catch (e) {
        return Left(ServerFailure(e.message.toString()));
      }
    } else {
      return const Left(ServerFailure('Failed to connect to the network'));
    }
  }
}
