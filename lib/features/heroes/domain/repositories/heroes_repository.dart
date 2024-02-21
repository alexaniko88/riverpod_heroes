part of '../../heroes.dart';

abstract class HeroesRepository {
  Future<Result<List<HeroModel>, AppException>> getAllHeroes();

  Future<HeroModel> getHeroDetails(String id);
}
