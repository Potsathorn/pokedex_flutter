// ignore_for_file: depend_on_referenced_packages

// Package imports:
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

// Project imports:
import 'package:pokedex_flutter/domain/entity/pokedex_entity.dart';
import 'package:pokedex_flutter/domain/entity/pokemon_entity.dart';
import 'package:pokedex_flutter/domain/usecase/pokedex_usecase.dart';
import 'package:pokedex_flutter/domain/usecase/pokemon_usecase.dart';
import 'package:pokedex_flutter/utils/helper.dart';

part 'pokemon_event.dart';
part 'pokemon_state.dart';

class PokemonBloc extends Bloc<PokemonEvent, PokemonState> {
  final PokedexUsecase _pokedexUsecase;
  final PokemonUsecase _pokemonUscase;

  PokemonBloc(this._pokedexUsecase, this._pokemonUscase)
      : super(PokemonInitial()) {
    on<GetAllEvent>((event, emit) async {
      emit(LoadingState());

      await _pokedexUsecase
          .execute(event.pokedexParam)
          .then((value) => value.fold((failure) {
                emit(FailureState(message: failure.message));
              }, (data) {
                emit(PokedexHasData(pokedex: data));
              }));
    });

    on<GetByIDEvent>((event, emit) async {
      int? previous;
      int? next;
      emit(LoadingState());
      await _pokedexUsecase
          .execute(PokedexParam(limit: 1, offset: event.pokemonParam.id - 1))
          .then((value) => value.fold((failure) {
                emit(FailureState(message: failure.message));
              }, (data) {
                if (data.previous != null) {
                  previous = Helper.extractOffsetFromUrl(data.previous!);
                }
                if (data.next != null) {
                  next = Helper.extractOffsetFromUrl(data.next!);
                }
              }));

      await _pokemonUscase.execute(event.pokemonParam).then((value) =>
          value.fold((failure) {
            emit(FailureState(message: failure.message));
          }, (data) {
            emit(PokemonHasData(next: next, previous: previous, pokemon: data));
          }));
    });

    on<LoadMoreEvent>((event, emit) async {
      if (state is PokedexHasData) {
        final currentState = state as PokedexHasData;
        final currentPokedex = currentState.pokedex.results;
        final nextOffset =
            Helper.extractOffsetFromUrl(currentState.pokedex.next!);

        emit(LoadMoreState());
        await _pokedexUsecase
            .execute(PokedexParam(limit: 20, offset: nextOffset))
            .then((value) => value.fold(
                  (failure) {
                    emit(FailureState(message: failure.message));
                  },
                  (newData) {
                    final newPokedex = [
                      ...currentPokedex!,
                      ...newData.results!
                    ];
                    newData.results = newPokedex;

                    emit(PokedexHasData(pokedex: newData));
                  },
                ));
      }
    });
  }
}
