part of '../../heroes.dart';

@riverpod
HeroesDatasource heroesDataSource(HeroesDataSourceRef ref, NetworkService networkService) {
  return HeroesRemoteDatasource(networkService);
}

@riverpod
HeroesRepository heroesRepository(HeroesRepositoryRef ref) {
  final NetworkService networkService = ref.watch(networkServiceProvider);
  final HeroesDatasource dataSource = ref.watch(heroesDataSourceProvider(networkService));
  return HeroesRepositoryImpl(dataSource);
}
