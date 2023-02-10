import 'package:flutter/material.dart';
import '../../common/app_colors.dart';
import '../../common/custom_text_styles.dart';
import '../../models/types.dart';

class PokemonTypeContainer extends StatelessWidget {
  const PokemonTypeContainer({
    Key? key,
    required this.type,
    this.size = 16,
  }) : super(key: key);
  final Types type;
  final double size;

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      constraints: BoxConstraints(
        maxHeight: size,
        minWidth: size * 3,
      ),
      padding: const EdgeInsets.all(2),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        color: pokemonTypeColors[type.type!.name]!.withOpacity(0.5),
      ),
      child: Text(
        type.type!.name!.toUpperCase(),
        maxLines: 1,
        style: CustomTextStyles.regularStyle(),
      ),
    );
  }
}
