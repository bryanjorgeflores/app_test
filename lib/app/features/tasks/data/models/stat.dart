import 'package:app_test/app/features/tasks/data/models/specie.dart';

class PokemonStat {
  PokemonStat({
    this.baseStat,
    this.effort,
    this.stat,
  });

  int? baseStat;
  int? effort;
  PokemonSpecies? stat;

  factory PokemonStat.fromJson(Map<String, dynamic> json) => PokemonStat(
        baseStat: json["base_stat"],
        effort: json["effort"],
        stat: PokemonSpecies.fromJson(json["stat"]),
      );

  Map<String, dynamic> toJson() => {
        "base_stat": baseStat,
        "effort": effort,
        "stat": stat?.toJson(),
      };
}
