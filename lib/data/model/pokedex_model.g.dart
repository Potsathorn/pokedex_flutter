// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'pokedex_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

PokedexModel _$PokedexModelFromJson(Map<String, dynamic> json) => PokedexModel(
      count: json['count'] as int?,
      next: json['next'] as String?,
      previous: json['previous'] as String?,
      results: (json['results'] as List<dynamic>?)
          ?.map((e) => ShortDetail.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$PokedexModelToJson(PokedexModel instance) =>
    <String, dynamic>{
      'count': instance.count,
      'next': instance.next,
      'previous': instance.previous,
      'results': instance.results,
    };

ShortDetail _$ShortDetailFromJson(Map<String, dynamic> json) => ShortDetail(
      name: json['name'] as String?,
      url: json['url'] as String?,
    );

Map<String, dynamic> _$ShortDetailToJson(ShortDetail instance) =>
    <String, dynamic>{
      'name': instance.name,
      'url': instance.url,
    };
