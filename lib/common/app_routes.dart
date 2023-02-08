import 'package:flutter/material.dart';
import 'package:pokemon_app/screens/pokemon_detail/pokemon_detail_screen.dart';
import 'package:pokemon_app/screens/pokemon_list_screen.dart';

import '../screens/splash_screen.dart';

/// It's a map of route names to widget builders
class AppRoutes {
  static final Map<String, WidgetBuilder> _routes = {
    SplashScreen.routeName: (ctx) => const SplashScreen(),
    PokemonListScreen.routeName: (ctx) => const PokemonListScreen(),
    PokemonDetailScreen.routeName: (ctx) => const PokemonDetailScreen()
  };

  static get routes => _routes;
}
