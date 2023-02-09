import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:pokemon_app/screens/pokemon_detail/pokemon_detail_screen.dart';
import 'package:pokemon_app/screens/widgets/pokemon_type_container.dart';
import 'package:provider/provider.dart';
import '../../common/app_colors.dart';
import '../../models/single_pokemon.dart';
import '../../models/types.dart';
import '../../providers/pokemon_provider.dart';

class PokemonCard extends StatefulWidget {
  final SinglePokemon pokemon;

  const PokemonCard({
    Key? key,
    required this.pokemon,
  }) : super(key: key);

  @override
  State<PokemonCard> createState() => _PokemonCardState();
}

class _PokemonCardState extends State<PokemonCard> {
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 5,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      child: InkWell(
        onTap: _onCardTapped,
        child:
            Consumer<PokemonProvider>(builder: (context, pokemonProvider, _) {
          if (pokemonProvider.allPokemon.isNotEmpty) {
            return buildCard(widget.pokemon);
          }
          return buildLoading();
        }),
      ),
    );
  }

  Widget buildCard(SinglePokemon pokemon) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Stack(
            children: [
              Hero(
                tag: 'pokemon/${pokemon.id}/type/container',
                child: Container(
                  decoration: BoxDecoration(
                      color: pokemonTypeColors[pokemon.types?.first.type?.name]!
                          .withOpacity(0.5)),
                ),
              ),
              Hero(
                tag: 'pokemon/image/${pokemon.id}',
                child: Container(
                  width: double.infinity,
                  padding: const EdgeInsets.all(10),
                  clipBehavior: Clip.antiAlias,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: const AssetImage('assets/pokemon-ball.png'),
                      colorFilter: ColorFilter.mode(
                        Colors.white.withOpacity(0.03),
                        BlendMode.dstIn,
                      ),
                      scale: 0.2,
                    ),
                  ),
                  child: CachedNetworkImage(
                    imageUrl:
                        pokemon.sprites?.other?.officialArtwork?.frontDefault ??
                            '',
                  ),
                ),
              ),
            ],
          ),
        ),
        Container(
          decoration: BoxDecoration(
            color: Theme.of(context).colorScheme.surface,
          ),
          child: Container(
            constraints:
                const BoxConstraints(minHeight: kMinInteractiveDimension),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Hero(
                          tag: 'pokemon/label/${pokemon.id}',
                          child: Material(
                            color: Colors.transparent,
                            child: Text(
                              (pokemon.species?.name ?? pokemon.name)
                                  .toString()
                                  .toUpperCase(),
                              style: const TextStyle(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                              maxLines: 1,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ),
                        ),
                        Text(
                          pokemon.species?.name ?? '',
                          style: TextStyle(
                            color: Theme.of(context)
                                .colorScheme
                                .onSurface
                                .withOpacity(0.8),
                            fontWeight: FontWeight.w300,
                            fontSize: 11,
                            height: 1.4,
                          ),
                          maxLines: 1,
                          overflow: TextOverflow.ellipsis,
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    width: 2,
                  ),
                  // Column(
                  //   mainAxisAlignment: MainAxisAlignment.start,
                  //   children:
                  //       pokemon.types.map(buildTypeContainer).toList() ?? [],
                  // )
                ],
              ),
            ),
          ),
        )
      ],
    );
  }

  Widget buildLoading() {
    return Column();
  }

  Widget buildTypeContainer(Types type) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 1),
      child: PokemonTypeContainer(type: type),
    );
  }

  void _onCardTapped() {
    Navigator.of(context).push(
      MaterialPageRoute(builder: (context) {
        return PokemonDetailScreen(
          pokemon: widget.pokemon,
        );
      }),
    );
  }
}
