import 'package:flutter/material.dart';
import 'package:pokemon_app/screens/widgets/pokemon_card.dart';
import '../models/api_resource.dart';
import '../models/pokedex.dart';

class PokemonListScreen extends StatefulWidget {

  static const routeName = '/pokemon-list-screen';
  const PokemonListScreen({
    Key? key,
  }) : super(key: key);

  @override
  _PokemonListScreenState createState() => _PokemonListScreenState();
}

class _PokemonListScreenState extends State<PokemonListScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Widget _buildPokemonGrid(List<APIResource> data) {
    return SliverPadding(
      padding: EdgeInsets.all(12),
      sliver: SliverGrid(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 0.9,
        ),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            final pokemon = data[index];
            return IndexedSemantics(
                index: index,
                child: PokemonCard(
                    key: ValueKey(index), pokemonID: pokemon.id.toString()));
          },
          addSemanticIndexes: true,
          childCount: data.length,
        ),
      ),
    );
  }

  _buildHeader(Pokedex pokedex) {
    return SliverToBoxAdapter(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Text(pokedex.name,
                style: TextStyle(
                    fontSize: 26, fontWeight: FontWeight.w600, height: 2)),
          ),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: Semantics(
              excludeSemantics: true,
              child: Text(
                pokedex.description,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w300,
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Pokemon'),
      ),
      //   body:   CustomScrollView(
      // semanticChildCount: snapshot.data!.pokemonEntries.length,
      //   slivers: [
      //     _buildHeader(snapshot.data!),
      //     _buildPokemonGrid(snapshot.data!.pokemonEntries)
      //
      // ],
      // ));
    );

    //   StreamBuilder<Pokedex>(
    //     stream: bloc.stream,
    //     initialData: bloc.pokedex,
    //     builder: (context, snapshot) {
    //       if (snapshot.hasData) {
    //
    //       }
    //       if (snapshot.hasError) {
    //         return Container(
    //           child: Text(snapshot.error.toString()),
    //         );
    //       }
    //       return Container(
    //         alignment: Alignment.center,
    //         child: CircularProgressIndicator(),
    //       );
    //     },
    //   ),
    // );
  }
}
