import 'package:flutter/material.dart';
import 'package:pokemon_app/shimmers/shimmer_config.dart';
import 'package:shimmer/shimmer.dart';

class CardShimmer extends StatelessWidget {
  final int itemCount;
  final Axis axis;
  final EdgeInsets padding;
  final bool primary;
  final bool shrinkWrap;

  const CardShimmer(
      {Key? key,
      this.itemCount = 50,
      this.axis = Axis.vertical,
      this.padding = const EdgeInsets.only(right: 10),
      this.primary = false,
      this.shrinkWrap = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomScrollView(
      slivers: [
        SliverGrid(
          gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2,
            crossAxisSpacing: 8,
            mainAxisSpacing: 8,
            childAspectRatio: 0.9,
          ),
          delegate: SliverChildBuilderDelegate(
                (BuildContext context, int index) {
              return Shimmer.fromColors(
                direction: ShimmerConfig.shimmerDirection,
                baseColor: ShimmerConfig.baseColor,
                highlightColor: ShimmerConfig.highlightColor,
                period: ShimmerConfig.period,
                child: Card(
                  clipBehavior: Clip.antiAlias,
                  elevation: 5,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(16),
                  ),
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
                  )
                )
              );
            },
            addSemanticIndexes: true,
            childCount: 50,
          ),
        ),
      ],
    );
  }
}
