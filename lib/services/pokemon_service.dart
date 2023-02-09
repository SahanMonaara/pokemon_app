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

  /// It fetches the list of launches from the SpaceX API.
  ///
  /// Returns:
  ///   Result object
  Future<NetResult> fetchPokemonList() async {
    NetResult result = NetResult();
    try {
      var net = Net(
        url: URL.GET_POKEMON_LIST,
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

  /// It fetches the launch details from the server.
  ///
  /// Args:
  ///   id (String): The id of the launch you want to fetch details for.
  ///
  /// Returns:
  ///   Result object
  Future<NetResult> fetchPokemonDetails(String id) async {
    NetResult result = NetResult();
    try {
      var net = Net(
          url: URL.GET_POKEMON_DETAILS,
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
