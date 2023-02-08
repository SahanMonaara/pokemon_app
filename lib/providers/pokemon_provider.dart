import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:pokemon_app/models/models.dart';
import 'package:pokemon_app/services/pokemon_service.dart';
import '../helpers/app_logger.dart';
import '../network/net_result.dart';

class PokemonProvider with ChangeNotifier {
  bool isDataLoading = false;
  bool isDetailDataLoading = false;
  List<Pokemon> pokemonList = [];
  Pokemon ? currentPokemon;
  List<String> favouriteList = [];

  /// It changes the value of isDataLoading to the value of the parameter status and
  /// then notifies all the listeners.
  ///
  /// Args:
  ///   status (bool): The status of the data loading.
  changeDataLoadingStatus(bool status) {
    isDataLoading = status;
    notifyListeners();
  }

  /// It changes the loading status of the detail data.
  ///
  /// Args:
  ///   status (bool): The status of the loading.
  changeDetailDataLoadingStatus(bool status) {
    isDetailDataLoading = status;
    notifyListeners();
  }


  Future<Result> getPokemonList() async {
    Result result = await PokemonService().fetchPokemonList();
    if (result.exception == null) {
      pokemonList.clear();
      pokemonList.addAll(result.result);
      Log.debug("------pokemonList length--${pokemonList.length}");
      isDataLoading = false;
    }
    notifyListeners();
    return result;
  }


  Future<Result> getPokemonDetails(String id) async {
    Result result = await PokemonService().fetchPokemonDetails(id);
    if (result.exception == null) {
      isDetailDataLoading = false;
    }
    currentPokemon = result.result;
    notifyListeners();
    return result;
  }
}
