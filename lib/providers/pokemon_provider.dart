import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pokemon_app/models/pokemon_list.dart';
import 'package:pokemon_app/services/pokemon_service.dart';
import '../helpers/app_logger.dart';
import '../models/single_pokemon.dart';
import '../network/net_result.dart';

class PokemonProvider with ChangeNotifier {
  bool isDataLoading = false;
  bool isDetailDataLoading = false;
  PokemonList? pokemonList;
  List<SinglePokemon> allPokemon = [];

  /// It changes the value of isDataLoading to the value of the parameter status and
  /// then notifies all the listeners.
  ///
  /// Args:
  ///   status (bool): The status of the data loading.
  changeDataLoadingStatus(bool status) {
    isDataLoading = status;
    notifyListeners();
  }

  Future<NetResult> getPokemonList() async {
    NetResult result = await PokemonService().fetchPokemonList();
    if (result.exception == null) {
      pokemonList = result.netResult;
      pokemonList?.results?.forEach((element) async {
        allPokemon.clear();
        try {
          NetResult result = await PokemonService()
              .fetchPokemonDetails(element.url!.split("/").elementAt(6));
          allPokemon.add(result.netResult);
        } catch (e) {
          Log.debug("Error Loading Data");
        }
      });
      isDataLoading = false;
    }
    notifyListeners();
    return result;
  }
}
