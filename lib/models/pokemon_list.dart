import 'dart:convert';

import 'package:pokemon_app/models/results.dart';

class PokemonList {
  int? count;
  String? next;
  List<Results>? results;

  PokemonList({this.count, this.next, this.results});

  PokemonList.fromJson(Map<String, dynamic> json) {
    count = json['count'];
    next = json['next'];
    if (json['results'] != null) {
      results = <Results>[];
      json['results'].forEach((v) {
        results!.add(Results.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['count'] = count;
    data['next'] = next;
    if (results != null) {
      data['results'] = results!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}
