import 'package:pokemon_app/models/dream_world.dart';
import 'package:pokemon_app/models/home.dart';

class GenerationVii {
  DreamWorld? icons;
  Home? ultraSunUltraMoon;

  GenerationVii({this.icons, this.ultraSunUltraMoon});

  GenerationVii.fromJson(Map<String, dynamic> json) {
    icons = json['icons'] != null ? DreamWorld.fromJson(json['icons']) : null;
    ultraSunUltraMoon = json['ultra-sun-ultra-moon'] != null
        ? Home.fromJson(json['ultra-sun-ultra-moon'])
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    if (icons != null) {
      data['icons'] = icons!.toJson();
    }
    if (ultraSunUltraMoon != null) {
      data['ultra-sun-ultra-moon'] = ultraSunUltraMoon!.toJson();
    }
    return data;
  }
}
