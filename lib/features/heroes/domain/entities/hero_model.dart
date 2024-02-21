
part of '../../heroes.dart';

@freezed
class HeroModel with _$HeroModel {
  const factory HeroModel({
    int? id,
    String? name,
    String? slug,
    AppearanceModel? appearanceModel,
    BiographyModel? biographyModel,
    PowerStatsModel? powerStatsModel,
    HeroImagesModel? heroImagesModel,
  }) = _HeroModel;

  factory HeroModel.fromJson(Map<String, dynamic> json) =>
      _$HeroModelFromJson(json);
}

@freezed
class AppearanceModel with _$AppearanceModel{
  const factory AppearanceModel({
    String? gender,
    String? race,
    String? eyeColor,
    String? hairColor,
  }) = _AppearanceModel;

  factory AppearanceModel.fromJson(Map<String, dynamic> json) =>
      _$AppearanceModelFromJson(json);

}

@freezed
class BiographyModel with _$BiographyModel{
  const factory BiographyModel({
    String? fullName,
    String? alterEgos,
    String? placeOfBirth,
    String? firstAppearance,
    String? publisher,
    String? alignment,
  }) = _BiographyModel;

  factory BiographyModel.fromJson(Map<String, dynamic> json) =>
      _$BiographyModelFromJson(json);
}

@freezed
class PowerStatsModel with _$PowerStatsModel{
  const factory PowerStatsModel({
    int? intelligence,
    int? strength,
    int? speed,
    int? durability,
    int? power,
    int? combat,
  }) = _PowerStatsModel;

  factory PowerStatsModel.fromJson(Map<String, dynamic> json) =>
      _$PowerStatsModelFromJson(json);
}

@freezed
class HeroImagesModel with _$HeroImagesModel{
  const factory HeroImagesModel({
    String? xs,
    String? sm,
    String? md,
    String? lg,
  }) = _HeroImagesModel;

  factory HeroImagesModel.fromJson(Map<String, dynamic> json) =>
      _$HeroImagesModelFromJson(json);
}
