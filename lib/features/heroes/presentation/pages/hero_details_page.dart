part of '../../heroes.dart';

class _Constants {
  static const double cardElevation = 10;
  static const double totalStats = 6;
  static const double avatarSpreadRadius = 5;
  static const double avatarBlurRadius = 5;
}

class _ColorRanges {
  static const int redRangeStart = 0;
  static const int orangeRangeStart = 20;
  static const int yellowRangeStart = 40;
  static const int blueRangeStart = 60;
  static const int greenRangeStart = 80;
}

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
          elevation: _Constants.cardElevation,
          child: Padding(
            padding: const EdgeInsets.all(defaultPadding),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Center(
                  child: Hero(
                    tag: heroModel.id.toString(),
                    child: Container(
                      decoration: BoxDecoration(
                        boxShadow: [
                          BoxShadow(
                            color: _getAverageColorFromStats(),
                            spreadRadius: _Constants.avatarSpreadRadius,
                            blurRadius: _Constants.avatarBlurRadius,
                          ),
                        ],
                      ),
                      child: AvatarView(
                        url: heroModel.imageUrl,
                        width: heroDetailsImageWidth,
                        useDecoration: false,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(top: defaultPadding),
                  child: Text(
                    heroModel.fullName.isNotEmpty ? heroModel.fullName : heroModel.name ?? '',
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
                Text(
                  '(${heroModel.publisher})',
                  style: Theme.of(context).textTheme.titleMedium,
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
              ),
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
      (totalStats / _Constants.totalStats).truncate(),
    );
  }

  Color _getColorByStat(int stat) {
    if (stat.isBetween(
      from: _ColorRanges.redRangeStart,
      to: _ColorRanges.orangeRangeStart,
    )) {
      return Colors.red;
    } else if (stat.isBetween(
      from: _ColorRanges.orangeRangeStart,
      to: _ColorRanges.yellowRangeStart,
    )) {
      return Colors.orange;
    } else if (stat.isBetween(
      from: _ColorRanges.yellowRangeStart,
      to: _ColorRanges.blueRangeStart,
    )) {
      return Colors.yellow;
    } else if (stat.isBetween(
      from: _ColorRanges.blueRangeStart,
      to: _ColorRanges.greenRangeStart,
    )) {
      return Colors.blue;
    } else {
      return Colors.green;
    }
  }
}
