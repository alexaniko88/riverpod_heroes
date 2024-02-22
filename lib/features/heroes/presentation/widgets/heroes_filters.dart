part of '../../heroes.dart';

class HeroesFilters extends ConsumerStatefulWidget {
  const HeroesFilters({
    super.key,
    required this.publishers,
  });

  final List<String> publishers;

  static void show({
    required BuildContext context,
    required List<String> publishers,
  }) {
    showDialog(
      context: context,
      builder: (context) => HeroesFilters(publishers: publishers),
    );
  }

  @override
  ConsumerState<HeroesFilters> createState() => _HeroesFiltersState();
}

class _HeroesFiltersState extends ConsumerState<HeroesFilters> {
  String dropdownValue = '';
  SortType sortType = SortType.name;

  @override
  void initState() {
    dropdownValue = widget.publishers.first;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text('Publisher: '),
          DropdownButton<String>(
            value: dropdownValue,
            onChanged: (String? newValue) {
              if(newValue != null) {
                ref.read(heroesStateNotifierProvider.notifier).filterHeroes(newValue);
                setState(() {
                  dropdownValue = newValue;
                });
              }
            },
            items: widget.publishers.map<DropdownMenuItem<String>>(
              (String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value == allPublishers ? context.loc.all : value),
                );
              },
            ).toList(),
          ),
          const SizedBox(height: 20),
          const Text("Sort by: "),
          DropdownButton<SortType>(
            value: sortType,
            onChanged: (SortType? newSortType) {
              if (newSortType != null) {
                ref.read(heroesStateNotifierProvider.notifier).sortByType(newSortType);
                setState(() {
                  sortType = newSortType;
                });
              }
            },
            items: SortType.values.map<DropdownMenuItem<SortType>>(
              (SortType value) {
                return DropdownMenuItem<SortType>(
                  value: value,
                  child: Text(value.name),
                );
              },
            ).toList(),
          )
        ],
      ),
    );
  }
}
