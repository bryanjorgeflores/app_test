class PokemonSpecies {
  PokemonSpecies({
    this.name,
    this.url,
  });

  String? name;
  String? url;

  factory PokemonSpecies.fromJson(Map<String, dynamic> json) => PokemonSpecies(
        name: json["name"],
        url: json["url"],
      );

  Map<String, dynamic> toJson() => {
        "name": name,
        "url": url,
      };
}
