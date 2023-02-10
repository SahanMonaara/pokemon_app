

import 'package:pokemon_app/models/generation/generation_colors.dart';
import 'package:pokemon_app/models/official_artwork.dart';

class GenerationIii {
  OfficialArtwork? emerald;
  FireredLeafgreen? fireRedLeafGreen;
  FireredLeafgreen? rubySapphire;

  GenerationIii({this.emerald, this.fireRedLeafGreen, this.rubySapphire});

  GenerationIii.fromJson(Map<String, dynamic> json) {
    emerald = json['emerald'] != null
        ? OfficialArtwork.fromJson(json['emerald'])
        : null;
    fireRedLeafGreen = json['firered-leafgreen'] != null
        ? FireredLeafgreen.fromJson(json['firered-leafgreen'])
        : null;
    rubySapphire = json['ruby-sapphire'] != null
        ? FireredLeafgreen.fromJson(json['ruby-sapphire'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (emerald != null) {
      data['emerald'] = emerald!.toJson();
    }
    if (fireRedLeafGreen != null) {
      data['firered-leafgreen'] = fireRedLeafGreen!.toJson();
    }
    if (rubySapphire != null) {
      data['ruby-sapphire'] = rubySapphire!.toJson();
    }
    return data;
  }
}
