part of '../../heroes.dart';
abstract class HeroesRepository {
  Future<List<Hero>> getAllHeroes();

  Future<Hero> getHeroDetails(String id);
}