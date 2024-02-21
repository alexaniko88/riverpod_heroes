part of '../../heroes.dart';

final heroesDataSourceProvider = Provider.family<HeroesDatasource, NetworkService>(
  (_, networkService) => HeroesRemoteDatasource(networkService),
);

final heroesRepositoryProvider = Provider<HeroesRepository>(
  (ref) {
    final NetworkService networkService = ref.watch(networkServiceProvider);
    final HeroesDatasource dataSource = ref.watch(heroesDataSourceProvider(networkService));
    return HeroesRepositoryImpl(dataSource);
  },
);
