// Flutter imports:
import 'package:flutter/material.dart';

class AppColors {
  static const Color primaryColor = Color(0xfff8bc15);
  static const Color background = Color(0xff262d4c);
  static const Color backgroundSecondary = Color(0xff343d64);
  static const Color textPrimary = Colors.white;
  static const Color textSecondary = Color(0xffe4e3e4);
}

class PokemonTypeColors {
  static const Color normalType = Color(0xffa8a879);
  static const Color fireType = Color(0xfff08030);
  static const Color waterType = Color(0xff6890f0);
  static const Color electricType = Color(0xfff8d030);
  static const Color grassType = Color(0xff78c850);
  static const Color iceType = Color(0xff98d8d8);
  static const Color fightingType = Color(0xffc03028);
  static const Color poisonType = Color(0xffa040a0);
  static const Color groundType = Color(0xffe0c068);
  static const Color flyingType = Color(0xffa890f0);
  static const Color psychicType = Color(0xfff85888);
  static const Color bugType = Color(0xffa8b820);
  static const Color rockType = Color(0xffb8a038);
  static const Color ghostType = Color(0xff705898);
  static const Color dragonType = Color(0xff7038f8);
  static const Color darkType = Color(0xff705848);
  static const Color steelType = Color(0xffb8b8d0);
  static const Color fairyType = Color(0xffee99ac);

  static Color get(String type) {
    switch (type.toLowerCase()) {
      case 'normal':
        return PokemonTypeColors.normalType;
      case 'fire':
        return PokemonTypeColors.fireType;
      case 'water':
        return PokemonTypeColors.waterType;
      case 'electric':
        return PokemonTypeColors.electricType;
      case 'grass':
        return PokemonTypeColors.grassType;
      case 'ice':
        return PokemonTypeColors.iceType;
      case 'fighting':
        return PokemonTypeColors.fightingType;
      case 'poison':
        return PokemonTypeColors.poisonType;
      case 'ground':
        return PokemonTypeColors.groundType;
      case 'flying':
        return PokemonTypeColors.flyingType;
      case 'psychic':
        return PokemonTypeColors.psychicType;
      case 'bug':
        return PokemonTypeColors.bugType;
      case 'rock':
        return PokemonTypeColors.rockType;
      case 'ghost':
        return PokemonTypeColors.ghostType;
      case 'dragon':
        return PokemonTypeColors.dragonType;
      case 'dark':
        return PokemonTypeColors.darkType;
      case 'steel':
        return PokemonTypeColors.steelType;
      case 'fairy':
        return PokemonTypeColors.fairyType;
      default:
        return const Color(0xFFECF4FF);
    }
  }
}
