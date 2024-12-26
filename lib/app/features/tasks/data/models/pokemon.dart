import 'package:app_test/app/features/tasks/data/models/ability.dart';
import 'package:app_test/app/features/tasks/data/models/kind.dart';
import 'package:app_test/app/features/tasks/data/models/move.dart';
import 'package:app_test/app/features/tasks/data/models/specie.dart';
import 'package:app_test/app/features/tasks/data/models/sprite.dart';
import 'package:app_test/app/features/tasks/data/models/stat.dart';

class Pokemon {
  Pokemon(
      {this.abilities,
      this.baseExperience,
      this.forms,
      this.height,
      this.id,
      this.moves,
      this.name,
      this.order,
      this.species,
      this.sprites,
      this.stats,
      this.types,
      this.weight,
      this.favorite});

  List<PokemonAbility>? abilities;
  int? baseExperience;
  List<PokemonSpecies>? forms;
  int? height;
  int? id;
  List<PokemonMove>? moves;
  String? name;
  int? order;
  PokemonSpecies? species;
  PokemonSprites? sprites;
  List<PokemonStat>? stats;
  List<PokemonType>? types;
  int? weight;
  bool? favorite;

  factory Pokemon.fromJson(Map<String, dynamic> json) => Pokemon(
      abilities: List<PokemonAbility>.from(
          json["abilities"].map((x) => PokemonAbility.fromJson(x))),
      baseExperience: json["base_experience"],
      forms: List<PokemonSpecies>.from(
          json["forms"].map((x) => PokemonSpecies.fromJson(x))),
      height: json["height"],
      id: json["id"],
      moves: List<PokemonMove>.from(
          json["moves"].map((x) => PokemonMove.fromJson(x))),
      name: json["name"],
      order: json["order"],
      species: PokemonSpecies.fromJson(json["species"]),
      sprites: PokemonSprites.fromJson(json["sprites"]),
      stats: List<PokemonStat>.from(
          json["stats"].map((x) => PokemonStat.fromJson(x))),
      types: List<PokemonType>.from(
          json["types"].map((x) => PokemonType.fromJson(x))),
      weight: json["weight"],
      favorite: false);

  Map<String, dynamic> toJson() => {
        "abilities": List<dynamic>.from(abilities!.map((x) => x.toJson())),
        "base_experience": baseExperience,
        "forms": List<dynamic>.from(forms!.map((x) => x.toJson())),
        "height": height,
        "id": id,
        "moves": List<dynamic>.from(moves!.map((x) => x.toJson())),
        "name": name,
        "order": order,
        "species": species!.toJson(),
        "sprites": sprites!.toJson(),
        "stats": List<dynamic>.from(stats!.map((x) => x.toJson())),
        "types": List<dynamic>.from(types!.map((x) => x.toJson())),
        "weight": weight,
        "favorite": favorite
      };
}
