part of '../../heroes.dart';

class HeroesRepositoryImpl implements HeroesRepository {
  const HeroesRepositoryImpl(this.remoteDatasource);

  final HeroesDatasource remoteDatasource;

  @override
  Future<Result<List<HeroModel>, AppException>> getAllHeroes() => remoteDatasource.getAllHeroes();
}
