import 'package:flutter/material.dart';
import 'package:pokemon_app/models/single_pokemon.dart';
import 'package:pokemon_app/providers/pokemon_provider.dart';
import 'package:pokemon_app/screens/widgets/pokemon_card.dart';
import 'package:provider/provider.dart';
import '../common/app_assets.dart';
import '../common/custom_text_styles.dart';
import '../network/net_exception.dart';
import '../network/net_result.dart';
import '../shimmers/card_shimmer.dart';

class PokemonListScreen extends StatefulWidget {
  static const routeName = '/pokemon-list-screen';

  const PokemonListScreen({
    Key? key,
  }) : super(key: key);

  @override
  PokemonListScreenState createState() => PokemonListScreenState();
}

class PokemonListScreenState extends State<PokemonListScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }
  getLaunchesList({int? page}) async {
      NetResult result = await Provider.of<PokemonProvider>(
          context, listen: false).getPokemonList();
      if (result.exception != null) {
        if (result.exception!.messageId == CommonMessageId.UNAUTHORIZED) {
          return;
        }
    }
  }

  /// It refreshes the list of launches.
  Future<void> onRefresh() async {
    await getLaunchesList();
  }

  Widget _buildPokemonGrid(List<SinglePokemon>? allPokemon) {
    return SliverPadding(
      padding: const EdgeInsets.all(12),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          crossAxisSpacing: 8,
          mainAxisSpacing: 8,
          childAspectRatio: 0.9,
        ),
        delegate: SliverChildBuilderDelegate(
          (BuildContext context, int index) {
            final pokemon = allPokemon[index];
            return IndexedSemantics(
                index: index,
                child: PokemonCard(key: ValueKey(index), pokemon: pokemon));
          },
          addSemanticIndexes: true,
          childCount: allPokemon!.length,
        ),
      ),
    );
  }

  _buildHeader() {
    return SliverAppBar(
      centerTitle: true,
      backgroundColor: Colors.white,
      title: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 110.0),
        child: Image.asset(AppAssets.logo),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return RefreshIndicator(
      onRefresh:onRefresh ,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Consumer<PokemonProvider>(builder: (context, pokemonProvider, _) {
          if (pokemonProvider.isDataLoading) {
            return const Padding(
                padding: EdgeInsets.fromLTRB(20, 20, 20, 20),
                child: Center(child: CardShimmer()));
          }
          if (pokemonProvider.pokemonList?.results?.length == null) {
            return  Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 20),
                child: Text('No data',style: CustomTextStyles.regularStyle()),
              ),
            );
          }
          return CustomScrollView(
            semanticChildCount: pokemonProvider.pokemonList?.results?.length,
            slivers: [
              _buildHeader(),
              _buildPokemonGrid(pokemonProvider.allPokemon)
            ],
          );
        }),
      ),
    );
  }
}
