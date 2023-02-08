extension StringExtension on String {
  String formatPokemonDescription() {
    String copy = this;
    final replaces = {
      '\n': ' ',
      '\f': ' ',
      'POKéMON': 'Pokémon',
    };
    replaces.forEach((key, value) {
      copy = copy.replaceAll(key, value);
    });
    return copy;
  }
}
