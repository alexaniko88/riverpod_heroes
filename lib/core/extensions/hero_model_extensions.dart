part of '../core.dart';

extension HeroModelExtensions on HeroModel {
  String get imageUrl => heroImagesModel?.sm ?? '';

  String get fullName => biographyModel?.fullName ?? '';

  String get publisher => biographyModel?.publisher ?? '';

  int get combat => powerStatsModel?.combat ?? 0;

  int get durability => powerStatsModel?.durability ?? 0;

  int get intelligence => powerStatsModel?.intelligence ?? 0;

  int get power => powerStatsModel?.power ?? 0;

  int get speed => powerStatsModel?.speed ?? 0;

  int get strength => powerStatsModel?.strength ?? 0;
}