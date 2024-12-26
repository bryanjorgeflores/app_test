class PokemonSprites {
  PokemonSprites(
      {this.backDefault,
      this.backFemale,
      this.backShiny,
      this.backShinyFemale,
      this.frontDefault,
      this.frontFemale,
      this.frontShiny,
      this.frontShinyFemale,
      this.officialArtwork});

  String? backDefault;
  String? backFemale;
  String? backShiny;
  String? backShinyFemale;
  String? frontDefault;
  String? frontFemale;
  String? frontShiny;
  String? frontShinyFemale;
  String? officialArtwork;

  factory PokemonSprites.fromJson(Map<String, dynamic> json) => PokemonSprites(
      backDefault: json["back_default"],
      backFemale: json["back_female"],
      backShiny: json["back_shiny"],
      backShinyFemale: json["back_shiny_female"],
      frontDefault: json["other"]["home"]["front_default"],
      frontFemale: json["other"]["home"]["front_female"],
      frontShiny: json["other"]["home"]["front_shiny"],
      frontShinyFemale: json["other"]["home"]["front_shiny_female"],
      officialArtwork: json["other"]["official-artwork"]["front_default"]);

  Map<String, dynamic> toJson() => {
        "back_default": backDefault,
        "back_female": backFemale,
        "back_shiny": backShiny,
        "back_shiny_female": backShinyFemale,
        "front_default": frontDefault,
        "front_female": frontFemale,
        "front_shiny": frontShiny,
        "front_shiny_female": frontShinyFemale,
        "official-artwork": officialArtwork
      };
}
