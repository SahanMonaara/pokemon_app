import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:pokemon_app/common/string_extension.dart';

import '../../models/media/media.dart';
import '../../models/pokemon.dart';
import '../../models/pokemon_type.dart';
import '../widgets/media_container.dart';
import '../widgets/pokemon_type_container.dart';

class PokemonDetailScreen extends StatefulWidget {
  static const routeName = '/pokemon-detail-screen';
  const PokemonDetailScreen({
    Key? key,
  }) : super(key: key);

  @override
  _PokemonDetailScreenState createState() => _PokemonDetailScreenState();
}

class _PokemonDetailScreenState extends State<PokemonDetailScreen> {

  @override
  Widget build(BuildContext context) {
    return Text("Detail Page");
    // return StreamBuilder<Pokemon>(
    //   stream: bloc.stream,
    //   initialData: bloc.pokemon,
    //   builder: (context, snapshot) {
    //     if (snapshot.hasData) {
    //       final pokemon = snapshot.data!;
    //       return Material(
    //         child: Stack(
    //           children: [
    //             Hero(
    //               tag: 'pokemon/${pokemon.id}/type/container',
    //               child: Container(
    //                 decoration:  const BoxDecoration(color: Colors.amber),
    //               ),
    //             ),
    //             CustomScrollView(
    //               slivers: [
    //                 SliverAppBar(
    //                   backgroundColor: Colors.transparent,
    //                   elevation: 0,
    //                   pinned: true,
    //                   title: Text(pokemon.name!.toUpperCase()),
    //                 ),
    //                 _buildImage(pokemon),
    //                 _buildContent(pokemon),
    //               ],
    //             ),
    //           ],
    //         ),
    //       );
    //     }else{
    //       return const Scaffold();
    //     }
    //   },
    // );
  }


  Widget _buildImage(Pokemon pokemon) {
    return SliverToBoxAdapter(
      child: Hero(
        tag: 'pokemon/image/${pokemon.id}',
        child: Container(
          margin: const EdgeInsets.all(30),
          decoration: BoxDecoration(
            border: Border.all(
              color: Colors.white.withOpacity(0.1),
              width: 8,
            ),
            color: Colors.white.withOpacity(0.1),
            shape: BoxShape.circle,
            image: DecorationImage(
              image: const AssetImage('assets/pokeball.png'),
              colorFilter: ColorFilter.mode(
                Colors.white.withOpacity(0.05),
                BlendMode.dstIn,
              ),
              scale: 0.25,
            ),
          ),
          child: CachedNetworkImage(
            imageUrl: pokemon.sprites?.artwork?.frontDefault?.url ?? '',
            fit: BoxFit.fill,
          ),
        ),
      ),
    );
  }

  Widget _buildContent(Pokemon pokemon) {
    return SliverToBoxAdapter(
      child: Container(
        color: Theme.of(context).colorScheme.surface.withOpacity(0.2),
        child: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaY: 6,
              sigmaX: 6,
            ),
            child: Container(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _buildName(pokemon),
                  _buildDescription(pokemon),
                  _buildMedia(pokemon),
                  const SizedBox(height: 200,)
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildName(Pokemon pokemon) {
    final shortDescription = pokemon.species?.genera?.toUpperCase();
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
                ),
                Visibility(
                  visible: shortDescription?.isNotEmpty == true,
                  child: Text(
                    shortDescription ??'',
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w200,
                      height: 1.4,
                    ),
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

  Widget _buildTypeContainer(PokemonType type) {
    return Container(
      margin: const EdgeInsets.symmetric(
        vertical: 4,
      ),
      child: PokemonTypeContainer(
        type: type,
        size: 20,
      ),
    );
  }

  Widget _buildDescription(Pokemon pokemon) {
    final description = pokemon.species?.flavorTexts?.first.value;
    return Visibility(
      visible: description?.isNotEmpty == true,
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Description',
              style: TextStyle(
                color:
                    Theme.of(context).colorScheme.onSurface,
                fontSize: 22,
                fontWeight: FontWeight.w800,
                height: 1.4,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              description!.formatPokemonDescription(),
              style: TextStyle(
                color:
                    Theme.of(context).colorScheme.onSurface,
                fontWeight: FontWeight.w100,
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildMedia(Pokemon pokemon) {
    final sprites = [
      pokemon.sprites?.defaultMedia,
      pokemon.sprites?.dreamWorld,
      pokemon.sprites?.home,
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
            style: TextStyle(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.75),
              fontSize: 20,
              fontWeight: FontWeight.w500,
              height: 1.4,
            ),
          ),
        ),
        const SizedBox(
          height: 10,
        ),
        Container(
          height: 100,
          child: ListView(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            scrollDirection: Axis.horizontal,
            children: sprites
                .map((sprite) => buildMediaContainer(sprite?.frontDefault))
                .toList(),
          ),
        )
      ],
    );
  }

  Widget buildMediaContainer(Media? media) {
    return Visibility(
      visible: media?.url != null,
      child: Container(
        margin: const EdgeInsets.only(right: 20),
        child: AspectRatio(
          aspectRatio: 1,
          child: MediaContainer(
            media: media!,
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }
}
