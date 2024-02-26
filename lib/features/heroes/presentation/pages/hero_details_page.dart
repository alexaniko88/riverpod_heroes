part of '../../heroes.dart';
class HeroDetailsPage extends StatelessWidget {
  final HeroModel heroModel;

  const HeroDetailsPage({
    super.key,
    required this.heroModel,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => context.pop(),
      child: Center(
        child: Card(
          margin: const EdgeInsets.all(defaultPadding),
          elevation: cardElevation,
          child: Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Hero(
                    tag: heroModel.id.toString(),
                    child: AvatarView(
                      url: heroModel.imageUrl,
                      width: heroDetailsImageWidth,
                      useDecoration: false,
                    ).animate().boxShadow(
                      duration: 500.ms,
                      begin: BoxShadow(
                        color: _getAverageColorFromStats().withOpacity(0.2),
                        spreadRadius: avatarSpreadRadius,
                        blurRadius: avatarBlurRadius,
                      ),
                      end: BoxShadow(
                        color: _getAverageColorFromStats(),
                        spreadRadius: avatarSpreadRadius,
                        blurRadius: avatarBlurRadius,
                      ),
                      curve: Curves.easeInToLinear,
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: defaultPadding),
                  child: Text(
                    heroModel.fullName.isNotEmpty ? heroModel.fullName : heroModel.name ?? '',
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ).animate().moveX(
                        duration: 200.ms,
                        begin: -MediaQuery.of(context).size.width / 2,
                        end: 0,
                        curve: Curves.easeInToLinear,
                      ),
                ),
                Text(
                  '(${heroModel.publisher})',
                  style: Theme.of(context).textTheme.titleMedium,
                ).animate().moveX(
                      duration: 200.ms,
                      begin: -MediaQuery.of(context).size.width / 2,
                      end: 0,
                      delay: 200.ms,
                      curve: Curves.easeInToLinear,
                    ),
                Padding(
                  padding: const EdgeInsets.only(top: defaultPadding * 3),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          _buildStatistic(
                            label: context.loc.power,
                            stat: heroModel.power,
                          ),
                          _buildStatistic(
                            label: context.loc.speed,
                            stat: heroModel.speed,
                            left: false,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          _buildStatistic(
                            label: context.loc.strength,
                            stat: heroModel.strength,
                          ),
                          _buildStatistic(
                            label: context.loc.intelligence,
                            stat: heroModel.intelligence,
                            left: false,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          _buildStatistic(
                            label: context.loc.durability,
                            stat: heroModel.durability,
                          ),
                          _buildStatistic(
                            label: context.loc.combat,
                            stat: heroModel.combat,
                            left: false,
                          ),
                        ],
                      ),
                    ],
                  ),
                ).animate().scaleXY(
                  duration: 500.ms,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildStatistic({
    required String label,
    required int stat,
    bool left = true,
  }) {
    return Builder(builder: (context) {
      return Expanded(
        child: Container(
          decoration: left
              ? const BoxDecoration(
                  border: Border(
                    right: BorderSide(
                      width: 1,
                      color: Colors.grey,
                    ),
                  ),
                )
              : null,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Padding(
                padding: left ? EdgeInsets.zero : const EdgeInsets.only(left: defaultPadding),
                child: Text(
                  '$label:',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(
                  right: defaultPadding,
                ),
                child: Text(
                  stat.toString(),
                  style: Theme.of(context).textTheme.titleMedium?.copyWith(
                        color: _getColorByStat(stat),
                      ),
                ),
              ).animate().flip(delay: 500.ms, duration: 500.ms),
            ],
          ),
        ),
      );
    });
  }

  Color _getAverageColorFromStats() {
    final totalStats = heroModel.strength +
        heroModel.speed +
        heroModel.intelligence +
        heroModel.durability +
        heroModel.combat +
        heroModel.power;
    return _getColorByStat(
      (totalStats / totalStats).truncate(),
    );
  }

  Color _getColorByStat(int stat) {
    if (stat.isBetween(
      from: ColorRanges.redRangeStart,
      to: ColorRanges.orangeRangeStart,
    )) {
      return Colors.red;
    } else if (stat.isBetween(
      from: ColorRanges.orangeRangeStart,
      to: ColorRanges.yellowRangeStart,
    )) {
      return Colors.orange;
    } else if (stat.isBetween(
      from: ColorRanges.yellowRangeStart,
      to: ColorRanges.blueRangeStart,
    )) {
      return Colors.yellow;
    } else if (stat.isBetween(
      from: ColorRanges.blueRangeStart,
      to: ColorRanges.greenRangeStart,
    )) {
      return Colors.blue;
    } else {
      return Colors.green;
    }
  }
}
