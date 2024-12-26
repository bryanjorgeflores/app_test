import 'package:app_test/app/features/tasks/data/models/specie.dart';

class PokemonAbility {
  PokemonAbility({
    this.ability,
    this.isHidden,
    this.slot,
  });

  PokemonSpecies? ability;
  bool? isHidden;
  int? slot;

  factory PokemonAbility.fromJson(Map<String, dynamic> json) => PokemonAbility(
        ability: PokemonSpecies.fromJson(json["ability"]),
        isHidden: json["is_hidden"],
        slot: json["slot"],
      );

  Map<String, dynamic> toJson() => {
        "ability": ability?.toJson(),
        "is_hidden": isHidden,
        "slot": slot,
      };
}
