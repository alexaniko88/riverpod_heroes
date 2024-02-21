part of '../../../heroes.dart';

class HeroesNotifier extends StateNotifier<HeroesState> {
  HeroesNotifier({
    required this.repository,
  }) : super(const HeroesState(status: HeroesStatus.initial, heroes: []));

  final HeroesRepository repository;

  Future<void> getAllHeroes() async {
    state = HeroesState(status: HeroesStatus.loading, heroes: state.heroes);
    final response = await repository.getAllHeroes();
    state = await response.fold(
      (heroes) => HeroesState(heroes: heroes, status: HeroesStatus.success),
      (failure) => HeroesState(heroes: state.heroes, status: HeroesStatus.error, failure: failure),
    );
  }
}
