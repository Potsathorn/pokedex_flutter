// Package imports:
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dio/dio.dart';
import 'package:get_it/get_it.dart';

// Project imports:
import 'package:pokedex_flutter/config/base_url.dart';
import 'package:pokedex_flutter/core/network/network_info.dart';
import 'package:pokedex_flutter/core/util/dio_interceptor.dart';
import 'package:pokedex_flutter/data/datasource/remote/pokemon_datasource.dart';
import 'package:pokedex_flutter/data/repository/pokemon_repository_impl.dart';
import 'package:pokedex_flutter/domain/repository/pokemon_repository.dart';
import 'package:pokedex_flutter/domain/usecase/pokedex_usecase.dart';
import 'package:pokedex_flutter/domain/usecase/pokemon_usecase.dart';
import 'package:pokedex_flutter/presentation/bloc/bloc/pokemon_bloc.dart';

final locator = GetIt.instance;

init() async {
  //bloc provider
  locator.registerFactory(() => PokemonBloc(locator(), locator()));

  //usecase
  locator.registerFactory(() => PokedexUsecase(locator()));
  locator.registerFactory(() => PokemonUsecase(locator()));

  //repository
  locator.registerLazySingleton<PokemonRepository>(
      () => PokemonRepositoryImpl(locator(), locator()));

  //datasource
  locator.registerLazySingleton<PokemonRemoteDataSource>(
      () => PokemonRemoteDatasourceImpl(locator()));

  //network
  locator.registerLazySingleton<NetworkInfo>(() => NetworkInfoImpl(locator()));

  //dio
  locator.registerLazySingleton(() {
    final dio = Dio()
      ..interceptors.add(DioInterceptor(locator()))
      ..options.connectTimeout = const Duration(seconds: 30)
      ..options.sendTimeout = const Duration(seconds: 30)
      ..options.receiveTimeout = const Duration(seconds: 30);

    return dio;
  });

  //base url
  locator.registerLazySingleton(() => BaseUrlConfig());

  //internet connection
  locator.registerLazySingleton(() => Connectivity());
}
