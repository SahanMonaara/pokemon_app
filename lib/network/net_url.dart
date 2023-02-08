// ignore_for_file: non_constant_identifier_names

/// It contains all the URLs that we will be using in our app
class URL {
  static String SERVER = "https://pokeapi.co/api/v2";

  static String GET_POKEMON_LIST = "$SERVER/pokemon?limit=151&offset=0";

  static String GET_POKEMON_DETAILS = "$SERVER/pokemon/{id}";

}
