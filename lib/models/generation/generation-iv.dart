

import 'package:pokemon_app/models/generation/generation_colors.dart';

class GenerationIv {
  DiamondPearl? diamondPearl;
  DiamondPearl? heartGoldSoulSilver;
  DiamondPearl? platinum;

  GenerationIv({this.diamondPearl, this.heartGoldSoulSilver, this.platinum});

  GenerationIv.fromJson(Map<String, dynamic> json) {
    diamondPearl = json['diamond-pearl'] != null
        ? DiamondPearl.fromJson(json['diamond-pearl'])
        : null;
    heartGoldSoulSilver = json['heartgold-soulsilver'] != null
        ? DiamondPearl.fromJson(json['heartgold-soulsilver'])
        : null;
    platinum = json['platinum'] != null
        ? DiamondPearl.fromJson(json['platinum'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (diamondPearl != null) {
      data['diamond-pearl'] = diamondPearl!.toJson();
    }
    if (heartGoldSoulSilver != null) {
      data['heartgold-soulsilver'] = heartGoldSoulSilver!.toJson();
    }
    if (platinum != null) {
      data['platinum'] = platinum!.toJson();
    }
    return data;
  }
}
