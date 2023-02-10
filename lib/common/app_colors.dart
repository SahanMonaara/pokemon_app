import 'package:flutter/material.dart';

/// > This class contains static methods that return a color
class AppColors {
  static const Color shadowColor = Color(0XFF3A5DA8);
  static const Color black = Color(0XFF000000);
  static const Color bgColor = Colors.white;
  static const Color pokemonTypeFireColor = Color(0XFFf19066);
  static const Color pokemonTypeGrassColor = Colors.lightGreen;
  static const Color pokemonTypePoisonColor = Colors.deepPurple;
  static const Color pokemonTypeFlyingColor = Colors.lightBlueAccent;
  static const Color pokemonTypeWaterColor = Colors.blueAccent;
  static const Color pokemonTypeBugColor = Color(0xFF4F6921);
  static const Color pokemonTypeNormalColor = Color(0xFF5F1939);
  static const Color pokemonTypeFightingColor = Color(0xFF9F6457);
  static const Color pokemonTypeElectricColor = Color(0xFFECEA39);
  static const Color pokemonTypeFairyColor = Color(0xFFD189E0);
  static const Color pokemonTypePsychicColor = Color(0xFFC14FEA);
  static const Color pokemonTypeGroundColor = Color(0xFF998030);
  static const Color pokemonTypeRockColor = Color(0xFF51490C);
  static const Color pokemonTypeSteelColor = Color(0xFF7E7E7A);
  static const Color pokemonTypeDarkColor = Color(0xFF282222);
  static const Color pokemonTypeDragonColor = Color(0xFF4926A7);
  static const Color pokemonTypeGhostColor = Color(0xFF464564);
  static const Color pokemonTypeIceColor = Color(0xFFA6D0F1);
}

/// A map of pokemon types to their colors.
Map<String, Color> pokemonTypeColors = {
  'fire': AppColors.pokemonTypeFireColor,
  'grass': AppColors.pokemonTypeGrassColor,
  'water': AppColors.pokemonTypeWaterColor,
  'bug': AppColors.pokemonTypeBugColor,
  'flying': AppColors.pokemonTypeFlyingColor,
  'poison': AppColors.pokemonTypePoisonColor,
  'electric': AppColors.pokemonTypeElectricColor,
  'fighting': AppColors.pokemonTypeFightingColor,
  'normal': AppColors.pokemonTypeNormalColor,
  'ground': AppColors.pokemonTypeGroundColor,
  'rock': AppColors.pokemonTypeRockColor,
  'psychic': AppColors.pokemonTypePsychicColor,
  'fairy': AppColors.pokemonTypeFairyColor,
  'steel': AppColors.pokemonTypeSteelColor,
  'ghost': AppColors.pokemonTypeGhostColor,
  'dragon': AppColors.pokemonTypeDragonColor,
  'dark': AppColors.pokemonTypeDarkColor,
  'ice': AppColors.pokemonTypeIceColor,
};