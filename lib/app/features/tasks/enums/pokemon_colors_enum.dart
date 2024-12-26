import 'package:flutter/animation.dart';

enum PokemonColors {
  normal(
    'normal',
    Color(0xffa8a878),
    Color(0xff000000),
  ),
  grass(
    'grass',
    Color(0xff78c850),
    Color(0xffffffff),
  ),
  ground(
    'ground',
    Color(0xffe0c068),
    Color(0xff000000),
  ),
  fighting(
    'fighting',
    Color(0xffc03028),
    Color(0xffffffff),
  ),
  rock(
    'rock',
    Color(0xffb8a038),
    Color(0xff000000),
  ),
  steel(
    'steel',
    Color(0xffb8b8d0),
    Color(0xff000000),
  ),
  fire(
    'fire',
    Color(0xfff08030),
    Color(0xffffffff),
  ),
  electric(
    'electric',
    Color(0xfff8d030),
    Color(0xff000000),
  ),
  flying(
    'flying',
    Color(0xffa890f0),
    Color(0xff000000),
  ),
  psychic(
    'psychic',
    Color(0xfff85888),
    Color(0xffffffff),
  ),
  bug(
    'bug',
    Color(0xffa8b820),
    Color(0xff000000),
  ),
  dragon(
    'dragon',
    Color(0xff7038f8),
    Color(0xffffffff),
  ),
  water(
    'water',
    Color(0xff6890f0),
    Color(0xffffffff),
  ),
  ice(
    'ice',
    Color(0xff98d8d8),
    Color(0xff000000),
  ),
  poison(
    'poison',
    Color(0xff705848),
    Color(0xffffffff),
  ),
  dark(
    'dark',
    Color(0xff705898),
    Color(0xffffffff),
  ),
  ghost(
    'ghost',
    Color(0xffffaec9),
    Color(0xff000000),
  ),
  fairy(
    'fairy',
    Color(0xffe0c068),
    Color(0xff000000),
  );

  const PokemonColors(this.code, this.color, this.contrastColor);
  final String code;
  final Color color;
  final Color contrastColor;

  Color get colorValue => color;
  Color get contrastColorValue => contrastColor;
}

extension PokemonColorExtension on PokemonColors {
  Color getColor(data) {
    return PokemonColors.values.firstWhere((element) => element == data).color;
  }

  Color getContrastColor(data) {
    return PokemonColors.values
        .firstWhere((element) => element == data)
        .contrastColor;
  }
}
