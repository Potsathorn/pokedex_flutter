// Package imports:
import 'package:json_annotation/json_annotation.dart';

// Project imports:
import 'package:pokedex_flutter/domain/entity/pokemon_entity.dart';

part 'pokemon_model.g.dart';

@JsonSerializable()
class PokemonModel {
  @JsonKey(name: "abilities")
  List<Ability>? abilities;
  @JsonKey(name: "base_experience")
  dynamic baseExperience;
  @JsonKey(name: "forms")
  List<Species>? forms;
  @JsonKey(name: "game_indices")
  List<dynamic>? gameIndices;
  @JsonKey(name: "height")
  int? height;
  @JsonKey(name: "held_items")
  List<dynamic>? heldItems;
  @JsonKey(name: "id")
  int? id;
  @JsonKey(name: "is_default")
  bool? isDefault;
  @JsonKey(name: "location_area_encounters")
  String? locationAreaEncounters;
  @JsonKey(name: "moves")
  List<Move>? moves;
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "order")
  int? order;
  @JsonKey(name: "past_abilities")
  List<dynamic>? pastAbilities;
  @JsonKey(name: "past_types")
  List<dynamic>? pastTypes;
  @JsonKey(name: "species")
  Species? species;
  @JsonKey(name: "sprites")
  Sprites? sprites;
  @JsonKey(name: "stats")
  List<Stat>? stats;
  @JsonKey(name: "types")
  List<Type>? types;
  @JsonKey(name: "weight")
  int? weight;

  PokemonModel({
    this.abilities,
    this.baseExperience,
    this.forms,
    this.gameIndices,
    this.height,
    this.heldItems,
    this.id,
    this.isDefault,
    this.locationAreaEncounters,
    this.moves,
    this.name,
    this.order,
    this.pastAbilities,
    this.pastTypes,
    this.species,
    this.sprites,
    this.stats,
    this.types,
    this.weight,
  });

  PokemonEntity toEntity() => PokemonEntity(
        abilities: abilities,
        baseExperience: baseExperience,
        forms: forms,
        gameIndices: gameIndices,
        height: height,
        heldItems: heldItems,
        id: id,
        isDefault: isDefault,
        locationAreaEncounters: locationAreaEncounters,
        moves: moves,
        name: name,
        order: order,
        pastAbilities: pastAbilities,
        pastTypes: pastTypes,
        species: species,
        sprites: sprites,
        stats: stats,
        types: types,
        weight: weight,
      );

  factory PokemonModel.fromJson(Map<String, dynamic> json) =>
      _$PokemonModelFromJson(json);

  Map<String, dynamic> toJson() => _$PokemonModelToJson(this);
}

@JsonSerializable()
class Ability {
  @JsonKey(name: "ability")
  Species? ability;
  @JsonKey(name: "is_hidden")
  bool? isHidden;
  @JsonKey(name: "slot")
  int? slot;

  Ability({
    this.ability,
    this.isHidden,
    this.slot,
  });

  factory Ability.fromJson(Map<String, dynamic> json) =>
      _$AbilityFromJson(json);

  Map<String, dynamic> toJson() => _$AbilityToJson(this);
}

@JsonSerializable()
class Species {
  @JsonKey(name: "name")
  String? name;
  @JsonKey(name: "url")
  String? url;

  Species({
    this.name,
    this.url,
  });

  factory Species.fromJson(Map<String, dynamic> json) =>
      _$SpeciesFromJson(json);

  Map<String, dynamic> toJson() => _$SpeciesToJson(this);
}

@JsonSerializable()
class Move {
  @JsonKey(name: "move")
  Species? move;
  @JsonKey(name: "version_group_details")
  List<VersionGroupDetail>? versionGroupDetails;

  Move({
    this.move,
    this.versionGroupDetails,
  });

  factory Move.fromJson(Map<String, dynamic> json) => _$MoveFromJson(json);

  Map<String, dynamic> toJson() => _$MoveToJson(this);
}

@JsonSerializable()
class VersionGroupDetail {
  @JsonKey(name: "level_learned_at")
  int? levelLearnedAt;
  @JsonKey(name: "move_learn_method")
  Species? moveLearnMethod;
  @JsonKey(name: "version_group")
  Species? versionGroup;

  VersionGroupDetail({
    this.levelLearnedAt,
    this.moveLearnMethod,
    this.versionGroup,
  });

  factory VersionGroupDetail.fromJson(Map<String, dynamic> json) =>
      _$VersionGroupDetailFromJson(json);

  Map<String, dynamic> toJson() => _$VersionGroupDetailToJson(this);
}

@JsonSerializable()
class GenerationV {
  @JsonKey(name: "black-white")
  Sprites? blackWhite;

  GenerationV({
    this.blackWhite,
  });

  factory GenerationV.fromJson(Map<String, dynamic> json) =>
      _$GenerationVFromJson(json);

  Map<String, dynamic> toJson() => _$GenerationVToJson(this);
}

@JsonSerializable()
class GenerationIv {
  @JsonKey(name: "diamond-pearl")
  Sprites? diamondPearl;
  @JsonKey(name: "heartgold-soulsilver")
  Sprites? heartgoldSoulsilver;
  @JsonKey(name: "platinum")
  Sprites? platinum;

  GenerationIv({
    this.diamondPearl,
    this.heartgoldSoulsilver,
    this.platinum,
  });

  factory GenerationIv.fromJson(Map<String, dynamic> json) =>
      _$GenerationIvFromJson(json);

  Map<String, dynamic> toJson() => _$GenerationIvToJson(this);
}

@JsonSerializable()
class Versions {
  @JsonKey(name: "generation-i")
  GenerationI? generationI;
  @JsonKey(name: "generation-ii")
  GenerationIi? generationIi;
  @JsonKey(name: "generation-iii")
  GenerationIii? generationIii;
  @JsonKey(name: "generation-iv")
  GenerationIv? generationIv;
  @JsonKey(name: "generation-v")
  GenerationV? generationV;
  @JsonKey(name: "generation-vi")
  Map<String, Home>? generationVi;
  @JsonKey(name: "generation-vii")
  GenerationVii? generationVii;
  @JsonKey(name: "generation-viii")
  GenerationViii? generationViii;

  Versions({
    this.generationI,
    this.generationIi,
    this.generationIii,
    this.generationIv,
    this.generationV,
    this.generationVi,
    this.generationVii,
    this.generationViii,
  });

  factory Versions.fromJson(Map<String, dynamic> json) =>
      _$VersionsFromJson(json);

  Map<String, dynamic> toJson() => _$VersionsToJson(this);
}

@JsonSerializable()
class Sprites {
  @JsonKey(name: "back_default")
  dynamic backDefault;
  @JsonKey(name: "back_female")
  dynamic backFemale;
  @JsonKey(name: "back_shiny")
  dynamic backShiny;
  @JsonKey(name: "back_shiny_female")
  dynamic backShinyFemale;
  @JsonKey(name: "front_default")
  String? frontDefault;
  @JsonKey(name: "front_female")
  dynamic frontFemale;
  @JsonKey(name: "front_shiny")
  dynamic frontShiny;
  @JsonKey(name: "front_shiny_female")
  dynamic frontShinyFemale;
  @JsonKey(name: "other")
  Other? other;
  @JsonKey(name: "versions")
  Versions? versions;
  @JsonKey(name: "animated")
  Sprites? animated;

  Sprites({
    this.backDefault,
    this.backFemale,
    this.backShiny,
    this.backShinyFemale,
    this.frontDefault,
    this.frontFemale,
    this.frontShiny,
    this.frontShinyFemale,
    this.other,
    this.versions,
    this.animated,
  });

  factory Sprites.fromJson(Map<String, dynamic> json) =>
      _$SpritesFromJson(json);

  Map<String, dynamic> toJson() => _$SpritesToJson(this);
}

@JsonSerializable()
class GenerationI {
  @JsonKey(name: "red-blue")
  RedBlue? redBlue;
  @JsonKey(name: "yellow")
  RedBlue? yellow;

  GenerationI({
    this.redBlue,
    this.yellow,
  });

  factory GenerationI.fromJson(Map<String, dynamic> json) =>
      _$GenerationIFromJson(json);

  Map<String, dynamic> toJson() => _$GenerationIToJson(this);
}

@JsonSerializable()
class RedBlue {
  @JsonKey(name: "back_default")
  dynamic backDefault;
  @JsonKey(name: "back_gray")
  dynamic backGray;
  @JsonKey(name: "back_transparent")
  dynamic backTransparent;
  @JsonKey(name: "front_default")
  dynamic frontDefault;
  @JsonKey(name: "front_gray")
  dynamic frontGray;
  @JsonKey(name: "front_transparent")
  dynamic frontTransparent;

  RedBlue({
    this.backDefault,
    this.backGray,
    this.backTransparent,
    this.frontDefault,
    this.frontGray,
    this.frontTransparent,
  });

  factory RedBlue.fromJson(Map<String, dynamic> json) =>
      _$RedBlueFromJson(json);

  Map<String, dynamic> toJson() => _$RedBlueToJson(this);
}

@JsonSerializable()
class GenerationIi {
  @JsonKey(name: "crystal")
  Crystal? crystal;
  @JsonKey(name: "gold")
  Gold? gold;
  @JsonKey(name: "silver")
  Gold? silver;

  GenerationIi({
    this.crystal,
    this.gold,
    this.silver,
  });

  factory GenerationIi.fromJson(Map<String, dynamic> json) =>
      _$GenerationIiFromJson(json);

  Map<String, dynamic> toJson() => _$GenerationIiToJson(this);
}

@JsonSerializable()
class Crystal {
  @JsonKey(name: "back_default")
  dynamic backDefault;
  @JsonKey(name: "back_shiny")
  dynamic backShiny;
  @JsonKey(name: "back_shiny_transparent")
  dynamic backShinyTransparent;
  @JsonKey(name: "back_transparent")
  dynamic backTransparent;
  @JsonKey(name: "front_default")
  dynamic frontDefault;
  @JsonKey(name: "front_shiny")
  dynamic frontShiny;
  @JsonKey(name: "front_shiny_transparent")
  dynamic frontShinyTransparent;
  @JsonKey(name: "front_transparent")
  dynamic frontTransparent;

  Crystal({
    this.backDefault,
    this.backShiny,
    this.backShinyTransparent,
    this.backTransparent,
    this.frontDefault,
    this.frontShiny,
    this.frontShinyTransparent,
    this.frontTransparent,
  });

  factory Crystal.fromJson(Map<String, dynamic> json) =>
      _$CrystalFromJson(json);

  Map<String, dynamic> toJson() => _$CrystalToJson(this);
}

@JsonSerializable()
class Gold {
  @JsonKey(name: "back_default")
  dynamic backDefault;
  @JsonKey(name: "back_shiny")
  dynamic backShiny;
  @JsonKey(name: "front_default")
  dynamic frontDefault;
  @JsonKey(name: "front_shiny")
  dynamic frontShiny;
  @JsonKey(name: "front_transparent")
  dynamic frontTransparent;

  Gold({
    this.backDefault,
    this.backShiny,
    this.frontDefault,
    this.frontShiny,
    this.frontTransparent,
  });

  factory Gold.fromJson(Map<String, dynamic> json) => _$GoldFromJson(json);

  Map<String, dynamic> toJson() => _$GoldToJson(this);
}

@JsonSerializable()
class GenerationIii {
  @JsonKey(name: "emerald")
  OfficialArtwork? emerald;
  @JsonKey(name: "firered-leafgreen")
  Gold? fireredLeafgreen;
  @JsonKey(name: "ruby-sapphire")
  Gold? rubySapphire;

  GenerationIii({
    this.emerald,
    this.fireredLeafgreen,
    this.rubySapphire,
  });

  factory GenerationIii.fromJson(Map<String, dynamic> json) =>
      _$GenerationIiiFromJson(json);

  Map<String, dynamic> toJson() => _$GenerationIiiToJson(this);
}

@JsonSerializable()
class OfficialArtwork {
  @JsonKey(name: "front_default")
  String? frontDefault;
  @JsonKey(name: "front_shiny")
  String? frontShiny;

  OfficialArtwork({
    this.frontDefault,
    this.frontShiny,
  });

  factory OfficialArtwork.fromJson(Map<String, dynamic> json) =>
      _$OfficialArtworkFromJson(json);

  Map<String, dynamic> toJson() => _$OfficialArtworkToJson(this);
}

@JsonSerializable()
class Home {
  @JsonKey(name: "front_default")
  dynamic frontDefault;
  @JsonKey(name: "front_female")
  dynamic frontFemale;
  @JsonKey(name: "front_shiny")
  dynamic frontShiny;
  @JsonKey(name: "front_shiny_female")
  dynamic frontShinyFemale;

  Home({
    this.frontDefault,
    this.frontFemale,
    this.frontShiny,
    this.frontShinyFemale,
  });

  factory Home.fromJson(Map<String, dynamic> json) => _$HomeFromJson(json);

  Map<String, dynamic> toJson() => _$HomeToJson(this);
}

@JsonSerializable()
class GenerationVii {
  @JsonKey(name: "icons")
  DreamWorld? icons;
  @JsonKey(name: "ultra-sun-ultra-moon")
  Home? ultraSunUltraMoon;

  GenerationVii({
    this.icons,
    this.ultraSunUltraMoon,
  });

  factory GenerationVii.fromJson(Map<String, dynamic> json) =>
      _$GenerationViiFromJson(json);

  Map<String, dynamic> toJson() => _$GenerationViiToJson(this);
}

@JsonSerializable()
class DreamWorld {
  @JsonKey(name: "front_default")
  dynamic frontDefault;
  @JsonKey(name: "front_female")
  dynamic frontFemale;

  DreamWorld({
    this.frontDefault,
    this.frontFemale,
  });

  factory DreamWorld.fromJson(Map<String, dynamic> json) =>
      _$DreamWorldFromJson(json);

  Map<String, dynamic> toJson() => _$DreamWorldToJson(this);
}

@JsonSerializable()
class GenerationViii {
  @JsonKey(name: "icons")
  DreamWorld? icons;

  GenerationViii({
    this.icons,
  });

  factory GenerationViii.fromJson(Map<String, dynamic> json) =>
      _$GenerationViiiFromJson(json);

  Map<String, dynamic> toJson() => _$GenerationViiiToJson(this);
}

@JsonSerializable()
class Other {
  @JsonKey(name: "dream_world")
  DreamWorld? dreamWorld;
  @JsonKey(name: "home")
  Home? home;
  @JsonKey(name: "official-artwork")
  OfficialArtwork? officialArtwork;

  Other({
    this.dreamWorld,
    this.home,
    this.officialArtwork,
  });

  factory Other.fromJson(Map<String, dynamic> json) => _$OtherFromJson(json);

  Map<String, dynamic> toJson() => _$OtherToJson(this);
}

@JsonSerializable()
class Stat {
  @JsonKey(name: "base_stat")
  int? baseStat;
  @JsonKey(name: "effort")
  int? effort;
  @JsonKey(name: "stat")
  Species? stat;

  Stat({
    this.baseStat,
    this.effort,
    this.stat,
  });

  factory Stat.fromJson(Map<String, dynamic> json) => _$StatFromJson(json);

  Map<String, dynamic> toJson() => _$StatToJson(this);
}

@JsonSerializable()
class Type {
  @JsonKey(name: "slot")
  int? slot;
  @JsonKey(name: "type")
  Species? type;

  Type({
    this.slot,
    this.type,
  });

  factory Type.fromJson(Map<String, dynamic> json) => _$TypeFromJson(json);

  Map<String, dynamic> toJson() => _$TypeToJson(this);
}
