part of '../../../heroes.dart';

@freezed
abstract class HeroesState with _$HeroesState {

  const HeroesState._();

  const factory HeroesState({
    @Default([]) List<HeroModel> heroes,
    @Default([]) List<HeroModel> filteredHeroes,
    @Default(HeroesStatus.initial) HeroesStatus status,
    AppException? failure,
  }) = _HeroesState;

  List<String> getAllPublishers() {
    final response =
        heroes.map((hero) => hero.publisher.trim()).where((publisher) => publisher.isNotEmpty).toSet().toList();
    return response..insert(0, allPublishers);
  }
}

enum HeroesStatus {
  initial,
  loading,
  success,
  error,
}
