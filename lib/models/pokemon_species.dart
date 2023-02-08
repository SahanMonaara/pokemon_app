import 'package:pokemon_app/models/flavor_text.dart';

class PokemonSpecies {
  final int? baseHappiness;
  final int? captureRate;
  final String name;
  final List<VersionableValue<String>>? flavorTexts;
  final String? genera;
  final String id;

  PokemonSpecies({
    this.baseHappiness,
    this.captureRate,
    required this.id,
    required this.name,
    required this.flavorTexts,
    required this.genera,
  });
}
