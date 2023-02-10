import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_app/common/app_colors.dart';
import 'package:pokemon_app/common/custom_text_styles.dart';
import 'package:pokemon_app/models/types.dart';

import '../../models/single_pokemon.dart';
import '../widgets/media_widget.dart';
import '../widgets/pokemon_stats_widget.dart';
import '../widgets/pokemon_type_container.dart';

class PokemonDetailScreen extends StatefulWidget {
  static const routeName = '/pokemon-detail-screen';
  final SinglePokemon? pokemon;

  const PokemonDetailScreen({
    Key? key,
    this.pokemon,
  }) : super(key: key);

  @override
  PokemonDetailScreenState createState() => PokemonDetailScreenState();
}

class PokemonDetailScreenState extends State<PokemonDetailScreen> {
  @override
  Widget build(BuildContext context) {
    return Material(
      child: Stack(
        children: [
          Hero(
            tag: 'pokemon/${widget.pokemon!.id}/type/container',
            child: Container(
              decoration: BoxDecoration(
                  gradient: LinearGradient(
                begin: Alignment.topRight,
                end: Alignment.bottomLeft,
                colors: [
                  pokemonTypeColors[widget.pokemon!.types?.first.type?.name] ??
                      Colors.white,
                  pokemonTypeColors[widget.pokemon!.types?.first.type?.name]!
                      .withOpacity(0.4),
                ],
              )),
            ),
          ),
          CustomScrollView(
            slivers: [
              SliverAppBar(
                backgroundColor:
                    pokemonTypeColors[widget.pokemon!.types?.first.type?.name],
                elevation: 0,
                pinned: true,
                leading: InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Icon(
                      Icons.arrow_back,
                      color: AppColors.black,
                    )),
                title: Text(
                  widget.pokemon!.name!.toUpperCase(),
                  style: CustomTextStyles.titleStyle(),
                ),
              ),
              _buildImage(widget.pokemon!),
              _buildContent(widget.pokemon!),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildImage(SinglePokemon pokemon) {
    return SliverToBoxAdapter(
      child: Hero(
        tag: 'pokemon/image/${pokemon.id}',
        child: Container(
          margin: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            color: Colors.white.withOpacity(0.1),
            shape: BoxShape.circle,
            image: DecorationImage(
              image: const AssetImage('assets/pokemon-ball.png'),
              colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.2),
                BlendMode.dstIn,
              ),
              scale: 0.25,
            ),
          ),
          child: CachedNetworkImage(
            imageUrl:
                pokemon.sprites?.other?.officialArtwork?.frontDefault ?? '',
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  Widget _buildContent(SinglePokemon pokemon) {
    return SliverToBoxAdapter(
      child: ClipRect(
        child: BackdropFilter(
          filter: ImageFilter.blur(
            sigmaY: 6,
            sigmaX: 6,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              _buildName(pokemon),
              _buildDescription(pokemon),
              _buildMedia(pokemon),
              PokemonBaseStats(pokemon),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildName(SinglePokemon pokemon) {
    final shortDescription = pokemon.species?.url?.toUpperCase();
    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.white.withOpacity(0.1), width: 2),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  (pokemon.species?.name ?? pokemon.name)!.toUpperCase(),
                  style: CustomTextStyles.titleStyle(),
                ),
                Visibility(
                  visible: shortDescription?.isNotEmpty == true,
                  child: Text(
                    shortDescription ?? '',
                    style:CustomTextStyles.subTitleStyle()
                  ),
                ),
              ],
            ),
          ),
          Column(
            children: pokemon.types!.map(_buildTypeContainer).toList(),
          )
        ],
      ),
    );
  }

  Widget _buildTypeContainer(Types type) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 4,
      ),
      child: PokemonTypeContainer(
        type: type,
        size: 30,
      ),
    );
  }

  Widget _buildDescription(SinglePokemon pokemon) {
    final description = pokemon.forms?.first.name ?? '';
    return Visibility(
      visible: description.isNotEmpty == true,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Description',
              style:CustomTextStyles.titleStyle()),
            const SizedBox(
              height: 10,
            ),
            Text(
              description,
              style: CustomTextStyles.subTitleStyle()
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMedia(SinglePokemon pokemon) {
    final sprites = [
      pokemon.sprites?.frontDefault,
      pokemon.sprites?.other?.dreamWorld?.frontDefault,
      pokemon.sprites?.other?.home?.frontDefault,
    ]..removeWhere(
        (element) => element == null,
      );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Text(
            'Media',
            style: CustomTextStyles.titleStyle()
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        SizedBox(
          height: 100,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            children:
                sprites.map((sprite) => buildMediaContainer(sprite)).toList(),
          ),
        )
      ],
    );
  }

  Widget buildMediaContainer(String? media) {
    return Visibility(
      visible: media != null,
      child: Container(
        margin: const EdgeInsets.only(right: 20),
        child: AspectRatio(
          aspectRatio: 1,
          child: MediaWidget(
            media: media!,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
