part of '../../../heroes.dart';

@freezed
abstract class HeroesState with _$HeroesState {

  const HeroesState._();

  const factory HeroesState({
    required List<HeroModel> heroes,
    required List<HeroModel> filteredHeroes,
    required HeroesStatus status,
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
