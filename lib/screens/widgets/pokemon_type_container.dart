import 'package:flutter/material.dart';

import '../../models/pokemon_type.dart';
import '../type_colors.dart';

class PokemonTypeContainer extends StatelessWidget {
  const PokemonTypeContainer({
    Key? key,
    required this.type,
    this.size = 16,
  }) : super(key: key);
  final PokemonType type;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      constraints: BoxConstraints(
        maxHeight: size,
        minWidth: size * 3,
      ),
      padding: EdgeInsets.all(2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        color: pokemonTypeColors[type.id]!.withOpacity(0.6),
      ),
      child: Text(
        type.label.toUpperCase(),
        maxLines: 1,
      ),
    );
  }
}
