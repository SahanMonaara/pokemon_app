import 'package:flutter/material.dart';
import 'package:pokemon_app/models/single_pokemon.dart';
import 'package:pokemon_app/models/stats.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class PokemonBaseStats extends StatefulWidget {
  final SinglePokemon pokemon;

  const PokemonBaseStats(this.pokemon, {super.key});

  @override
  State<PokemonBaseStats> createState() => _PokemonBaseStatsState();
}

class _PokemonBaseStatsState extends State<PokemonBaseStats> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        mainAxisSize: MainAxisSize.max,
        children: <Widget>[
          const Text(
            'Statistics',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w800,
              height: 1.4,
            ),
          ),
          buildStats(widget.pokemon.stats),
        ],
      ),
    );
  }

  Widget buildStats(List<Stats>? stats) {
    return ListView.builder(
      scrollDirection: Axis.vertical,
      itemCount: stats?.length,
      shrinkWrap: true,
      itemBuilder: (context, index) {
        return Padding(
          padding: const EdgeInsets.all(10.0),
          child: Stat(
              label: stats![index].stat?.name?.toUpperCase(),
              value: stats[index].baseStat),
        );
      },
    );
  }
}

class Stat extends StatelessWidget {
  final String? label;
  final int? value;

  const Stat({
    super.key,
    required this.label,
    required this.value,
  });

  @override
  Widget build(BuildContext context) {
    final currentProgress = value! / 6;
    return Row(
      mainAxisSize: MainAxisSize.max,
      children: <Widget>[
        Expanded(
          flex: 2,
          child: Text(
            label!,
            style: TextStyle(
                color: Theme.of(context)
                    .textTheme
                    .caption!
                    .color!
                    .withOpacity(0.6)),
          ),
        ),
        Expanded(
          flex: 1,
          child: Text('$value'),
        ),
        Expanded(
          flex: 5,
          child: StepProgressIndicator(
            totalSteps: 100,
            currentStep: currentProgress.toInt(),
            size: 8,
            padding: 0,
            roundedEdges: const Radius.circular(10),
            selectedGradientColor: const LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.red, Colors.red],
            ),
            unselectedGradientColor: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [Colors.grey.shade50, Colors.grey.shade50],
            ),
          ),
        ),
      ],
    );
  }
}
