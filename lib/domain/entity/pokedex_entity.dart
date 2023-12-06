// Project imports:
import 'package:pokedex_flutter/data/model/pokedex_model.dart';

class PokedexEntity {
  int? count;
  String? next;
  String? previous;
  List<ShortDetail>? results;

  PokedexEntity({
    this.count,
    this.next,
    this.previous,
    this.results,
  });
}
