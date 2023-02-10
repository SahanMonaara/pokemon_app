/// It contains all the URLs that we will be using in our app
class URL {
  static String serverUrl = "https://pokeapi.co/api/v2";

  static String getPokemonListURL = "$serverUrl/pokemon?limit=151&offset=0";

  static String getPokemonDetailsURL = "$serverUrl/pokemon/{id}";

}
