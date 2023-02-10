import 'dart:convert';

import '../helpers/app_logger.dart';
import '../models/pokemon_list.dart';
import '../models/single_pokemon.dart';
import '../network/net_exception.dart';
import '../network/net.dart';
import '../network/net_result.dart';
import '../network/net_url.dart';

class PokemonService {
  static final PokemonService _singleton = PokemonService._internal();

  factory PokemonService() {
    return _singleton;
  }

  PokemonService._internal();


  /// It fetches the list of pokemons from the server.
  ///
  /// Returns:
  ///   NetResult
  Future<NetResult> fetchPokemonList() async {
    NetResult result = NetResult();
    try {
      var net = Net(
        url: URL.getPokemonListURL,
        method: NetMethod.get,
      );

      result = await net.perform();
      Log.debug("result is **** ${result.netResult}");

      if (result.exception == null && result.netResult != "") {
        result.netResult = PokemonList.fromJson(jsonDecode(result.netResult));
      }
      return result;
    } catch (err) {
      Log.err("$err");
      result.exception = NetException(
          message: CommonMessages.ENDPOINT_NOT_FOUND,
          messageId: CommonMessageId.UNAUTHORIZED,
          code: ExceptionCode.CODE_000);
      return result;
    }
  }


  /// It fetches the pokemon details from the server.
  ///
  /// Args:
  ///   id (String): The id of the pokemon you want to fetch details for.
  ///
  /// Returns:
  ///   NetResult
  Future<NetResult> fetchPokemonDetails(String id) async {
    NetResult result = NetResult();
    try {
      var net = Net(
          url: URL.getPokemonDetailsURL,
          method: NetMethod.get,
          pathParam: {'{id}': id});

      result = await net.perform();
      Log.debug("result is **** ${result.netResult}");

      if (result.exception == null && result.netResult != "") {
        var data = json.decode(result.netResult);
        result.netResult = SinglePokemon.fromJson(data);
      }
      return result;
    } catch (err) {
      Log.err("$err");
      result.exception = NetException(
          message: CommonMessages.ENDPOINT_NOT_FOUND,
          messageId: CommonMessageId.UNAUTHORIZED,
          code: ExceptionCode.CODE_000);
      return result;
    }
  }
}
