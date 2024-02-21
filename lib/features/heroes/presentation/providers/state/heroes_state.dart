part of '../../../heroes.dart';

@freezed
abstract class HeroesState with _$HeroesState {
  const factory HeroesState( {
    required List<HeroModel> heroes,
    required HeroesStatus status,
    AppException? failure,
  }) = _HeroesState;
}

enum HeroesStatus {
  initial,
  loading,
  success,
  error,
}