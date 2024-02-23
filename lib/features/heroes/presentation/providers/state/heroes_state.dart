part of '../../../heroes.dart';

@freezed
abstract class HeroesState with _$HeroesState {
  const factory HeroesState( {
    required List<HeroModel> heroes,
    required List<HeroModel> filteredHeroes,
    required HeroesStatus status,
    AppException? failure,
  }) = _HeroesState;
}

enum HeroesStatus {
  loading,
  success,
  error,
}