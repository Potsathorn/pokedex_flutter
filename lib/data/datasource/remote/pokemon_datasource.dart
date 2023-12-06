// Package imports:
import 'package:dio/dio.dart';

// Project imports:
import 'package:pokedex_flutter/core/error/exception.dart';
import 'package:pokedex_flutter/data/model/pokedex_model.dart';
import 'package:pokedex_flutter/data/model/pokemon_model.dart';

abstract class PokemonRemoteDataSource {
  Future<PokemonModel> getPokemonByID({required String id});

  Future<PokedexModel> getAllPokemon({required int limit, required int offset});
}

class PokemonRemoteDatasourceImpl implements PokemonRemoteDataSource {
  final Dio _dio;

  PokemonRemoteDatasourceImpl(this._dio);
  @override
  Future<PokedexModel> getAllPokemon(
      {required int limit, required int offset}) async {
    final response = await _dio.get('/pokemon/?limit=$limit&offset=$offset');
    if (response.statusCode == 200) {
      return PokedexModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }

  @override
  Future<PokemonModel> getPokemonByID({required String id}) async {
    final response = await _dio.get('/pokemon/$id');
    if (response.statusCode == 200) {
      return PokemonModel.fromJson(response.data);
    } else {
      throw ServerException();
    }
  }
}
