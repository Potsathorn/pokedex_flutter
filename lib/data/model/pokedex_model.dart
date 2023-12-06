// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:pokedex_flutter/domain/entity/pokedex_entity.dart';

part 'pokedex_model.g.dart';

@JsonSerializable()
class PokedexModel {
  @JsonKey(name: "count")
  int? count;
  @JsonKey(name: "next")
  String? next;
  @JsonKey(name: "previous")
  String? previous;
  @JsonKey(name: "results")
  List<ShortDetail>? results;

  PokedexModel({
    this.count,
    this.next,
    this.previous,
    this.results,
  });

  PokedexEntity toEntity() => PokedexEntity(
      count: count, next: next, previous: previous, results: results);

  factory PokedexModel.fromJson(Map<String, dynamic> json) =>
      _$PokedexModelFromJson(json);

  Map<String, dynamic> toJson() => _$PokedexModelToJson(this);
}

@JsonSerializable()
class ShortDetail {
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "url")
  String? url;

  ShortDetail({
    this.name,
    this.url,
  });

  factory ShortDetail.fromJson(Map<String, dynamic> json) =>
      _$ShortDetailFromJson(json);

  Map<String, dynamic> toJson() => _$ShortDetailToJson(this);
}
