import 'package:app_test/app/features/tasks/data/models/specie.dart';

class PokemonMove {
  PokemonMove({
    this.move,
  });

  PokemonSpecies? move;

  factory PokemonMove.fromJson(Map<String, dynamic> json) => PokemonMove(
        move: PokemonSpecies.fromJson(json["move"]),
      );

  Map<String, dynamic> toJson() => {
        "move": move?.toJson(),
      };
}
