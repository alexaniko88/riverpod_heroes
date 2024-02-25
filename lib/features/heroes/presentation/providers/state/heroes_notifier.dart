part of '../../../heroes.dart';

enum SortType {
  name,
  combat,
  durability,
  intelligence,
  power,
  speed,
  strength,
}

@riverpod
class HeroesNotifier extends _$HeroesNotifier {
  @override
  HeroesState build(HeroesRepository repository) => const HeroesState(
        heroes: [],
        filteredHeroes: [],
        status: HeroesStatus.initial,
      );

  Future<void> getAllHeroes() async {
    state = const HeroesState(
      heroes: [],
      filteredHeroes: [],
      status: HeroesStatus.loading,
    );
    final response = await repository.getAllHeroes();
    state = await response.fold(
      (heroes) {
        final sortedHeroes = _sortBy(heroes: heroes, sortType: SortType.name);
        return HeroesState(
          heroes: sortedHeroes,
          filteredHeroes: [...sortedHeroes],
          status: HeroesStatus.success,
        );
      },
      (failure) => HeroesState(
        heroes: [],
        filteredHeroes: [],
        status: HeroesStatus.error,
        failure: failure,
      ),
    );
  }

  void sortByType(SortType sortType) {
    final heroes = state.heroes;
    state = HeroesState(
      heroes: heroes,
      filteredHeroes: _sortBy(heroes: heroes, sortType: sortType),
      status: HeroesStatus.success,
    );
  }

  List<HeroModel> _sortBy({
    required List<HeroModel> heroes,
    required SortType sortType,
  }) {
    return List.from(heroes)
      ..sort((a, b) {
        int compare;
        switch (sortType) {
          case SortType.intelligence:
            compare = b.intelligence.compareTo(a.intelligence);
            break;
          case SortType.name:
            compare = a.name != null && b.name != null ? a.name!.compareTo(b.name!) : 0;
            break;
          case SortType.combat:
            compare = b.combat.compareTo(a.combat);
            break;
          case SortType.durability:
            compare = b.durability.compareTo(a.durability);
            break;
          case SortType.power:
            compare = b.power.compareTo(a.power);
            break;
          case SortType.speed:
            compare = b.speed.compareTo(a.speed);
            break;
          case SortType.strength:
            compare = b.strength.compareTo(a.strength);
            break;
        }
        if (sortType != SortType.name && compare == 0 && a.name != null && b.name != null) {
          compare = a.name!.compareTo(b.name!);
        }
        return compare;
      });
  }

  void filterHeroes(String publisher) {
    final heroes = state.heroes;
    state = HeroesState(
      heroes: heroes,
      filteredHeroes:
          publisher != allPublishers ? heroes.where((hero) => hero.publisher == publisher).toList() : heroes,
      status: HeroesStatus.success,
    );
  }

  List<String> getAllPublishers() {
    final response =
        state.heroes.map((hero) => hero.publisher.trim()).where((publisher) => publisher.isNotEmpty).toSet().toList();
    return response..insert(0, allPublishers);
  }
}
