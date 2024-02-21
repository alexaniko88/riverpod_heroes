
part of '../../heroes.dart';

class HeroesRepositoryImpl implements HeroesRepository {
  const HeroesRepositoryImpl(this.remoteDatasource);

  final HeroesDatasource remoteDatasource;

  @override
  Future<Result<List<HeroModel>, AppException>> getAllHeroes() {
    return remoteDatasource.getAllHeroes();
  }

  @override
  Future<HeroModel> getHeroDetails(String id) {
    // TODO: implement getHeroDetails
    throw UnimplementedError();
  }

  
}
